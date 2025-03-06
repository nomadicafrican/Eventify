import { verifyPasswordHash } from "$lib/server/password";
import { createSession, generateSessionToken, setSessionTokenCookie } from "$lib/server/session";
import { getUserFromEmail, getUserPasswordHash } from "$lib/server/user";
import { fail, redirect } from "@sveltejs/kit";

/** @typedef {import('./$types').Actions} Actions */
/** @typedef {import('./$types').PageServerLoad} PageServerLoad */
/** @typedef {import('./$types').RequestEvent} RequestEvent */
/** @typedef {import('$lib/server/user').User} User */
/** @typedef {import('@sveltejs/kit').Handle} Handle */

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
  const ipAddress = event.getClientAddress()
  if (typeof email !== "string" || typeof password !== "string") {
    return fail(400, {
      message: "Invalid or missing fields",
      email
    });
  }
  if (email === "" || password === "") {
    return fail(400, {
      message: "Please enter your email and password.",
      email
    });
  }
  let user;
  try {
    /** @instance {User | null} */
    user = await getUserFromEmail(email);
  }
  catch (error) {
    return fail(500, {
      message: "Account does not exist",
      email
    });
  }
  if (user === null) {
    return fail(400, {
      message: "Invalid email",
      email
    });
  }
  const passwordHash = await getUserPasswordHash(user.id);
  const validPassword = await verifyPasswordHash(passwordHash, password);
  if (!validPassword) {
    return fail(400, {
      message: "Sign in error",
      email
    });
  }
  const sessionToken = generateSessionToken();
  const session = await createSession(sessionToken, user.id, ipAddress);
  setSessionTokenCookie(event, sessionToken, session.expiresAt);
  return redirect(302, "/")
}
