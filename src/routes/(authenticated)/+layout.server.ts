import type { LayoutServerLoad } from './$types';
import { redirect } from '@sveltejs/kit';

export const load: LayoutServerLoad = async ({ locals, request }) => {
  if (!locals.user) {
    console.log("Redirecting user from: " + request.url + " to: /login");
    return redirect(302, '/login');
  }

  return { user: locals.user };
};
