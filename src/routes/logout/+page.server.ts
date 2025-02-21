import { invalidateSession, deleteSessionTokenCookie } from "$lib/server/session";
import {  redirect } from "@sveltejs/kit";
import type { Handle } from "@sveltejs/kit"

export const load: Handle = async ({ event, resolve }) => {
  console.log("We logging out!", event)

  if (!event) {
    redirect(302, "/")
  }

  if (!event.locals) {
    redirect(302, "/")
  }

  if (!event.locals.user) {
    redirect(302, "/")
  }
  if (!event.locals.session) {
    redirect(302, "/")
  }

  console.log("We logging out!")
  try {
    console.log("Invalidating session")
    await invalidateSession(event.locals.session.id);
  }
  catch (e) {
    console.log("some error from logout: ", e);
    redirect(505, "/")
  }
  console.log("deleting cookies")
  deleteSessionTokenCookie(event);
  redirect(302, "/");
}