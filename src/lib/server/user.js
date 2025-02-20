import { sql } from "bun";
// import { decrypt, decryptToString, encrypt, encryptString } from "./encryption";
import { hashPassword } from "./password";
// import { generateRandomRecoveryCode } from "./utils";

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
  const recoveryCode = generateRandomRecoveryCode();
  const encryptedRecoveryCode = encryptString(recoveryCode);
  const row = sql`
    INSERT INTO user (email, username, password_hash)
    VALUES (${email}, ${username}, ${passwordHash})
    RETURNING user.id
  `;
  if (row === null) {
    throw new Error("Unexpected error");
  }

  /** @type {User} */
  const user = {
    id: row.number(0),
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
  return row[0].password_hash;
}

/**
 * @param {number} userId
 * @return {string}
 */
export function getUserRecoverCode(userId) {
  const row = await sql`SELECT password_hash FROM user WHERE id = ${userId}`
  if (row === null) {
    throw new Error("Invalid user ID");
  }
  return decryptToString(row.bytes(0));
}

export function getUserTOTPKey(userId: number): Uint8Array | null {
  const row = db.queryOne("SELECT totp_key FROM user WHERE id = ?", [userId]);
  if (row === null) {
    throw new Error("Invalid user ID");
  }
  const encrypted = row.bytesNullable(0);
  if (encrypted === null) {
    return null;
  }
  return decrypt(encrypted);
}

export function updateUserTOTPKey(userId: number, key: Uint8Array): void {
  const encrypted = encrypt(key);
  db.execute("UPDATE user SET totp_key = ? WHERE id = ?", [encrypted, userId]);
}

export function resetUserRecoveryCode(userId: number): string {
  const recoveryCode = generateRandomRecoveryCode();
  const encrypted = encryptString(recoveryCode);
  db.execute("UPDATE user SET recovery_code = ? WHERE id = ?", [encrypted, userId]);
  return recoveryCode;
}

export function getUserFromEmail(email: string): User | null {
  const row = db.queryOne(
    "SELECT id, email, username, email_verified, IIF(totp_key IS NOT NULL, 1, 0) FROM user WHERE email = ?",
    [email]
  );
  if (row === null) {
    return null;
  }
  const user: User = {
    id: row.number(0),
    email: row.string(1),
    username: row.string(2),
    emailVerified: Boolean(row.number(3)),
    registered2FA: Boolean(row.number(4))
  };
  return user;
}

export interface User {
  id: number;
  email: string;
  username: string;
  emailVerified: boolean;
  registered2FA: boolean;
}

