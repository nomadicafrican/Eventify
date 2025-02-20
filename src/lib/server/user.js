import { sql } from "bun";
// import { decrypt, decryptToString, encrypt, encryptString } from "./encryption";
import { hashPassword } from "./password";
// import { generateRandomRecoveryCode } from "./utils";


/**
 * @typedef {Object} User
 * @property {number} id
 * @property {string} username
 * @property {string} email
 * @property {boolean} emailVerified
 * @property {boolean} registered2FA
 *
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
  const recoveryCode = generateRandomRecoveryCode();
  const encryptedRecoveryCode = encryptString(recoveryCode);
  const row = await sql`
    INSERT INTO user (email, username, password_hash)
    VALUES (${email}, ${username}, ${passwordHash})
    RETURNING user.id
  `;
  if (row === null) {
    throw new Error("Unexpected error");
  }

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

/**
 * @param {number} userId
 * @param {string} password
 * @return {Promise<void>}
 */
export async function updateUserPassword(userId, password) {
  const passwordHash = await hashPassword(password);
  await sql`UPDATE user SET password_hash = ${passwordHash} WHERE id = ${userId}`;
}

/**
 * @param {number} userId
 * @param {string} email
 * @return {Promise<void>}
 */
export async function updateUserEmailAndSetEmailAsVerified(userId, email) {
  await sql`UPDATE user SET email = ${email}, email_verified = 1 WHERE id = ${userId}`;
}

/**
 * @param {number} userId
 * @param {string} email
 * @return {Promise<boolean>}
 */
export async function setUserAsEmailVerifiedIfEmailMatches(userId, email) {
  const result = await sql`UPDATE user SET email_verified = 1 WHERE id = ${userId} AND email = ${email} RETURNING *`;
  return result !== null;
}

/**
 * @param {number} userId
 * @return {Promise<string>}
 */
export async function getUserPasswordHash(userId) {
  const row = await sql`SELECT password_hash FROM user WHERE id = ${userId}`
  if (row === null) {
    throw new Error("Invalid user ID");
  }
  return row.password_hash;
}

/**
 * @param {number} userId
 * @return {Promise<string>}
 */
export async function getUserRecoverCode(userId) {
  const row = await sql`SELECT password_hash FROM user WHERE id = ${userId}`
  if (row === null) {
    throw new Error("Invalid user ID");
  }
  return decryptToString(row[0].password_hash);
}

/**
 * @param {number} userId
 * @return {Promise<Uint8Array | null>}
 */
export async function getUserTOTPKey(userId) {
  const row = await sql`SELECT totp_key FROM user WHERE id = ${userId}`
  if (row === null) {
    throw new Error("Invalid user ID");
  }
  const encrypted = row[0].totp_key;
  if (encrypted === null) {
    return null;
  }
  return decrypt(encrypted);
}


/**
 * @param {number} userId
 * @param {Uint8Array} key
 * @return {Promise<void>}
 */
export async function updateUserTOTPKey(userId, key) {
  const encrypted = encrypt(key);
  await sql`UPDATE user SET totp_key = ${encrypted} WHERE id = ${userId}`
}


/**
 * @param {number} userId
 * @return {Promise<string>}
 */
export async function resetUserRecoveryCode(userId) {
  const recoveryCode = generateRandomRecoveryCode();
  const encrypted = encryptString(recoveryCode);
  await sql`UPDATE user SET recovery_code = ${encrypted} WHERE id = ${userId}`;
  return recoveryCode;
}


/**
 * @param {string} email
 * @return {Promise<User | null>}
 */
export async function getUserFromEmail(email) {
  const row = await sql`SELECT id, email, username, email_verified, IIF(totp_key IS NOT NULL, 1, 0) FROM user WHERE email = ${email}`;
  if (row === null) {
    return null;
  }
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

