import { encodeBase32LowerCaseNoPadding } from "@oslojs/encoding";
import { getRandomValues } from "node:crypto";
import { sql } from "bun";

/**
 * @typedef {Object} User
 * @property {number} id
 *
 * @typedef {import('@sveltejs/kit').RequestEvent} RequestEvent
 * @typedef {Promise<{ session: Session; user: User}>} ValidSessionResult
 * @typedef {Promise<{ session: null; user: null }>} InvalidSessionResult
 * @typedef { ValidSessionResult | InvalidSessionResult } SessionValidationResult
 *
 * @typedef {Object} Session
 * @property {string} id
 * @property {number} userId
 * @property {Date} expiresAt
 *
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
    userId: userId,
    expiresAt: new Date(Date.now() + 1000 * 60 * 60 * 24 * 30)
  };

  await sql`
    INSERT INTO user_session (id, user_id, expires_at)
    VALUES (${session.id}, ${session.userId}, ${session.expiresAt})
  `;

  return session;
}

/**
 * @param {string} token
 * @return {Promise<SessionValidationResult>}
 */
export async function validateSessionToken(token) {
  hasher.update(new TextEncoder().encode(token))
  const sessionId = hasher.digest("hex");

  const userSession = await sql`
    SELECT
      user_session.id,
      user_session.user_id,
      user_session.expires_at,
      app_user.id AS app_user_id
    FROM user_session
    INNER JOIN app_user ON app_user.id = user_session.user_id
    WHERE user_session.id = ${sessionId}
  `;

  if (userSession.length === 0) {
    return { session: null, user: null };
  }

  /** @type(Session) **/
  const session = {
    id: userSession[0].id,
    userId: userSession[0].user_id,
    expiresAt: userSession[0].expires_at
  };

  const user = ({
    id: Number(userSession[0].app_user_id)
  });

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
  // hasher.update(new TextEncoder().encode(sessionId)); // TODO: I commented this out, if it breaks, uncomment it
  // const sessionIdHashed = hasher.digest("hex");
  const response = await sql`DELETE FROM user_session WHERE id = ${sessionId}`
  console.log(response)
}


/** 
 * @param {Number} userId 
 * @param {Session} currentSession
 * @return {Promise<void>}
 */
export async function invalidateAllSessions(userId, currentSession) {
  console.log("Invalidating all sessions for user", userId);
  await sql`DELETE FROM user_session WHERE user_id = ${userId} AND id <> ${currentSession.id.toString()}`
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


/**
 * @param {number} userId
 * @return {Promise<Array<String>>}
 */
export async function getSessionsForUser(userId) {
  const sessions = await sql`SELECT id FROM user_session WHERE user_id = ${userId}`.values();
  return sessions;
}



