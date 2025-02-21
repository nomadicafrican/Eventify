import { invalidateSession, deleteSessionTokenCookie } from "$lib/server/session";
import {  redirect } from "@sveltejs/kit";
import type { ServerLoad } from "@sveltejs/kit"
// import {goto} from "$app/navigation"

export const load: ServerLoad = async (event) => {
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

  try {
    await invalidateSession(event.locals.session.id);
  }
  catch (e) {
    redirect(505, "/")
  }
  deleteSessionTokenCookie(event);
  redirect(302, "/")
}