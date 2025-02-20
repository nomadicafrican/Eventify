
/** @access private **/
const hasher = new Bun.CryptoHasher("sha1")

/**
 * @param {string} password
 * @return {Promise<String>}
 */
export async function hashPassword(password) {
  return await Bun.password.hash(password);
}

/**
 * @param {string} hash
 * @param {string} password
 * @return {Promise<boolean>}
 */
export async function verifyPasswordHash(hash, password) {
  return await Bun.password.verify(hash, password);
}

/**
 * @param {string} password
 * @return {Promise<boolean>}
 */
export async function verifyPasswordStrength(password) {
  if (password.length < 8 || password.length > 255) {
    return false;
  }
  hasher.update(new TextEncoder().encode(password));
  const hash = hasher.digest("hex")
  const hashPrefix = hash.slice(0, 5);
  const response = await fetch(`https://api.pwnedpasswords.com/range/${hashPrefix}`);
  const data = await response.text();
  const items = data.split("\n");
  for (const item of items) {
    const hashSuffix = item.slice(0, 35).toLowerCase();
    if (hash === hashPrefix + hashSuffix) {
      return false;
    }
  }
  return true;
}

