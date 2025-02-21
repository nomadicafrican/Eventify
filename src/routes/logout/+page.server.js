import { fail } from "@sveltejs/kit";
import { getUserFromEmail, getUserPasswordHash } from "$lib/server/user";
import { generateSessionToken, createSession, setSessionTokenCookie } from "$lib/server/session";
import { verifyPasswordHash } from "$lib/server/password";

/** @typedef {import('./$types').Actions} Actions */
/** @typedef {import('./$types').PageServerLoad} PageServerLoad */
/** @typedef {import('./$types').RequestEvent} RequestEvent */
/** @typedef {import('$lib/server/user').User} User */

/**
 * @type {Actions} actions
 */
export const actions = {
  default: action
};

/**
 * @param {RequestEvent} event
 */
async function action(event) {
  const formData = await event.request.formData();
  const email = formData.get("email");
  const password = formData.get("password");
  if (typeof email !== "string" || typeof password !== "string") {
    return fail(400, {
      message: "Invalid or missing fields",
      email: ""
    });
  }
  if (email === "" || password === "") {
    return fail(400, {
      message: "Please enter your email and password.",
      email
    });
  }
  /** @isntance {User | null} */
  const user = await getUserFromEmail(email);
  if (user === null) {
    return fail(400, {
      message: "Account does not exist",
      email
    });
  }
  const passwordHash = await getUserPasswordHash(user.id);
  const validPassword = await verifyPasswordHash(passwordHash, password);
  if (!validPassword) {
    return fail(400, {
      message: "Invalid password",
      email
    });
  }
  const sessionToken = generateSessionToken();
  const session = await createSession(sessionToken, user.id);
  setSessionTokenCookie(event, sessionToken, session.expiresAt);
}
