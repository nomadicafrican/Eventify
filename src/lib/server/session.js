import { encodeBase32LowerCaseNoPadding } from "@oslojs/encoding";
import { getRandomValues } from "node:crypto";
import { sql } from "bun";

/**
 * @typedef {import('@sveltejs/kit').RequestEvent} RequestEvent
 * @typedef {Promise<{ session: Session; user: User }>} ValidSessionResult
 * @typedef {Promise<{ session: null; user: null }>} InvalidSessionResult
 * @typedef { ValidSessionResult | InvalidSessionResult } SessionValidationResult
 *
 * @typedef {Object} Session
 * @property {string} id
 * @property {number} userId
 * @property {Date} expiresAt
 *
 * @typedef {Object} User
 * @property {number} id
 */

/** @access private **/
const hasher = new Bun.CryptoHasher("sha256");

/**
 * @returns {string}
 */
export function generateSessionToken() {
  const bytes = new Uint8Array(20);
  getRandomValues(bytes);
  const token = encodeBase32LowerCaseNoPadding(bytes);
  return token;
}

/**
 * @param {string} token
 * @param {number} userId
 * @return {Promise<Session>}
 */
export async function createSession(token, userId) {
  hasher.update(new TextEncoder().encode(token));
  const sessionId = hasher.digest("hex");

  /** @type {Session} **/
  const session = {
    id: sessionId,
    userId,
    expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * 30)
  };

  await sql`INSERT INTO user_session (id, user_id, expires_at) VALUES (${session.id}, ${session.userId}, ${session.expiresAt})`;
  return session;
}


/**
 * @param {string} token
 * @return {Promise<SessionValidationResult>}
 */
export async function validateSessionToken(token) {
  hasher.update(new TextEncoder().encode(token))
  const sessionId = hasher.digest("hex");
  const row = await sql`
    SELECT
      user_session.id,
      user_session.user_id,
      user_session.expires_at,
      app_user.id
    FROM user_session
    INNER JOIN user ON app_user.id = user_session.user_id
    WHERE id = ${sessionId}
  `;
  if (row === null) {
    return { session: null, user: null };
  }

  /** @type(Session) **/
  const session = {
    id: row.id,
    userId: row.user_id,
    expiresAt: row.expires_at
  };
  /** @type(User) **/
  const user = {
    id: row.id
  };

  if (Date.now() >= session.expiresAt.getTime()) {
    await sql`DELETE FROM user_session WHERE id = ${session.id}`;
    return { session: null, user: null }
  }
  if (Date.now() >= session.expiresAt.getTime() - 1000 * 60 * 60 * 24 * 15) {
    session.expiresAt = new Date(Date.now() + 1000 * 60 * 60 * 24 * 30);
    await sql`
      UPDATE user_session
      SET expires_at = ${session.expiresAt}
      WHERE id = ${session.id}
    `;
  }
  return { session, user };
}



/** 
 * @param {string} sessionId 
 * @return {Promise<void>}
 */
export async function invalidateSession(sessionId) {
  await sql`DELETE FROM user_session WHERE id = ${sessionId}`;
}


/** 
 * @param {number} userId 
 * @return {Promise<void>}
 */
export async function invalidateAllSessions(userId) {
  await sql`DELETE FROM user_session WHERE id = ${userId}`
}


/** 
 * @param {RequestEvent} event 
 * @param {string} token
 * @param {Date} expiresAt 
 * @return {void} 
 */
export function setSessionTokenCookie(event, token, expiresAt) {
  event.cookies.set("session", token, {
    httpOnly: true,
    sameSite: "lax",
    expires: expiresAt,
    path: "/"
  });
}


/** 
 * @param {RequestEvent} event
 * @return {void} 
 */
export function deleteSessionTokenCookie(event) {
  event.cookies.set("session", "", {
    httpOnly: true,
    sameSite: "lax",
    maxAge: 0,
    path: "/"
  });
}
