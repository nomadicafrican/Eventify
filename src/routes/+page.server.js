import {
  deleteSessionTokenCookie,
  setSessionTokenCookie,
  validateSessionToken
} from "$lib/server/session";
import { fail, redirect } from "@sveltejs/kit";

/**
 * @typedef {import('./$types').Actions} Actions
 * @typedef {import('./$types').PageServerLoad} PageServerLoad
 * @typedef {import('$lib/server/session').Session} Session
 */

/**
 * @type {Actions}
 */
export const actions = {
  /**
   * @param {any} event
   * @returns {Promise<any>}
   */
  default: async (event) => {
    if (event.locals.user === null) {
      throw fail(401);
    }
    // ...
  }
};


/**
 * @type {PageServerLoad}
 * @param {any} event
 * @returns {Promise<{ props: { userId: number } } | { status: number }>}
 */
export const load = async (event) => {
  if (event.locals.user === null) {
    return redirect(401, "/login");
  }

  const token = event.cookies.get("session") ?? null;
  if (token === null) {
    return new Response(null, {
      status: 401
    });
  }

  const { session, user } = await validateSessionToken(token);
  if (session === null) {
    deleteSessionTokenCookie(event);
    return new Response(null, {
      status: 401
    });
  }
  setSessionTokenCookie(event, token, session.expiresAt);
  if (!session.userId) {
    throw redirect(307, '/login');
  }

  // if (someConditionFails) {
  //   throw fail(400, { error: 'Some error message' });
  // }

  return {
    props: { userId: session.userId }
  };

};
