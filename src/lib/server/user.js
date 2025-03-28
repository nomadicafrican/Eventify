import { sql } from "bun";
import { hashPassword } from "./password";

/**
 * @typedef {Object} User
 * @property {number} id
 * @property {string} username
 * @property {string} email
 * @property {boolean} emailVerified
 * @property {boolean} registered2FA
 */

/**
 * @param {string} username
 * @return {boolean}
 */
export function verifyUsernameInput(username) {
  return username.length > 3 && username.length < 32 && username.trim() === username;
}

/**
 * @param {string} email
 * @param {string} username
 * @param {string} password
 * @return {Promise<User>}
 */
export async function createUser(email, username, password) {
  const passwordHash = await hashPassword(password);
  const row = await sql`
    INSERT INTO app_user (email, username, password_hash, email_verified, registered_2fa)
    VALUES (${email}, ${username}, ${passwordHash}, true, true)
    RETURNING app_user.id
  `;
  if (row === null) {
    throw new Error("Unexpected error");
  }

  try {
    /** @type {User} */
    const user = {
      id: row[0].id,
      username,
      email,
      emailVerified: false,
      registered2FA: false
    };
    return user;
  }
  catch (e) {
    throw new Error("Unexpected error");
  }
}

/**
 * @param {number} userId
 * @param {string} password
 * @return {Promise<void>}
 */
export async function updateUserPassword(userId, password) {
  const passwordHash = await hashPassword(password);
  await sql`UPDATE app_user SET password_hash = ${passwordHash} WHERE id = ${userId}`;
}

/**
 * @param {number} userId
 * @param {string} email
 * @return {Promise<void>}
 */
export async function updateUserEmailAndSetEmailAsVerified(userId, email) {
  await sql`UPDATE app_user SET email = ${email}, email_verified = 1 WHERE id = ${userId}`;
}

/**
 * @param {number} userId
 * @param {string} email
 * @return {Promise<boolean>}
 */
export async function setUserAsEmailVerifiedIfEmailMatches(userId, email) {
  const result = await sql`UPDATE app_user SET email_verified = 1 WHERE id = ${userId} AND email = ${email} RETURNING *`;
  return result !== null;
}

/**
 * @param {number} userId
 * @return {Promise<string>}
 */
export async function getUserPasswordHash(userId) {
  const row = await sql`SELECT password_hash FROM app_user WHERE id = ${userId}`
  if (row === null) {
    throw new Error("Invalid user ID");
  }
  return row[0].password_hash;
}

/**
 * @param {string} email
 * @return {Promise<User | null>}
 */
export async function getUserFromEmail(email) {
  const row = await sql`SELECT id, email, username, email_verified FROM app_user WHERE email = ${email}`;
  if (row === null) {
    return null;
  }

  try {
    /** @type {User} */
    const user = {
      id: row[0].id,
      email: row[0].email,
      username: row[0].username,
      emailVerified: Boolean(row[0].email_verified),
      registered2FA: Boolean(row[0].registered2FA)
    };
    return user;
  }
  catch (e) {
    throw new Error("Unexpected error");
  }
}

/**
 * @param {number} id
 * @return {Promise<User | null>}
 */
export async function getUserFromId(id) {
  const row = await sql`SELECT id, email, username, email_verified FROM app_user WHERE id = ${id}`;
  if (row === null) {
    return null;
  }

  try {
    /** @type {User} */
    const user = {
      id: row[0].id,
      email: row[0].email,
      username: row[0].username,
      emailVerified: Boolean(row[0].email_verified),
      registered2FA: Boolean(row[0].registered2FA)
    };
    return user;
  }
  catch (e) {
    throw new Error("Unexpected error");
  }
}

/**
 * @param {User} user
 */
export async function updateUser(user) {
  await sql`
    UPDATE app_user
    SET
      email = ${user.email},
      username = ${user.username},
      email_verified = ${user.emailVerified},
      registered_2fa = ${user.registered2FA}
    WHERE id = ${user.id}
    RETURNING id
  `;
}

/**
 * @param {number} userid 
 */
export async function deleteUser(userid) {
  console.log("Deleting user", userid);
  await sql`DELETE FROM app_user WHERE id = ${userid.toString()}`;
}
