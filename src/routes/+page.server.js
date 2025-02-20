import {
  validateSessionToken,
  setSessionTokenCookie,
  deleteSessionTokenCookie
} from "$lib/server/session";
import { fail, redirect } from "@sveltejs/kit";

/**
 * @import { Actions, PageServerLoad } from './$types'
 * @import { Fail, Redirect } from '@svelte/kit'
 */

// Example usage
export function load({ session }) {
  if (!session.user) {
    throw Redirect(307, '/login');
  }

  if (someConditionFails) {
    throw Fail(400, { error: 'Some error message' });
  }

  return {
    props: { user: session.user }
  };
}

/**
 * @type {PageServerLoad}
 * @param {any} event
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

export const load = async (event) => {
  if (event.locals.user === null) {
    return redirect("/login");
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
};
