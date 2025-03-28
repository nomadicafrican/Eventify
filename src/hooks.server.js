import { validateSessionToken, setSessionTokenCookie, deleteSessionTokenCookie } from "$lib/server/session";
import { getUserFromId } from "$lib/server/user";
import { connect } from "$lib/server/connect";

/** @typedef {import('@sveltejs/kit').Handle }  Handle */
/** @typedef {import('@sveltejs/kit').ServerInit}  ServerInit */
/** @typedef {import('@sveltejs/kit').ResolveOptions }  ResolveOptions */
/** @typedef {import('@sveltejs/kit').RequestEvent}  RequestEvent */
/** @typedef {import('$lib/server/session').User}  User */

/*
 * @param {User} obj
 * @param {RequestEvent} obj.event
 * @param {Function} obj.resolve
 * @returns {Promise<RequestEvent>}
 */

/**
  * @type {Handle}
  */
export const handle = async ({ event, resolve }) => {
  const token = event.cookies.get("session") ?? null;
  console.log("TOKEN: ", token)
  if (token === null) {
    event.locals.user = null;
    event.locals.session = null;
    return resolve(event);
  }
  const { session, user } = await validateSessionToken(token);
  if (session !== null) {
    setSessionTokenCookie(event, token, session.expiresAt);
  }
  else {
    deleteSessionTokenCookie(event);
  }
  if (user === null) {
    return resolve(event);
  }
  const userObject = await getUserFromId(user.id);

  event.locals.session = session;
  event.locals.user = userObject;
  return resolve(event);
};

/** @type {ServerInit} */
export const init = async () => {
  await connect();
};
