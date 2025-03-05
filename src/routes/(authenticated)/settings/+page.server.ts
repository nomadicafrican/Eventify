import type { Actions } from './$types';
import type { PageServerLoad } from './$types';
import { deleteUser, updateUser, updateUserPassword } from '$lib/server/user';
import { error, redirect } from '@sveltejs/kit';
import { getSessionsForUser, invalidateAllSessions, invalidateSession } from '$lib/server/session';

export const actions: Actions = {
  updateProfile: async ({ request, locals }) => {
    const data = await request.formData();
    const name = data.get('name') as string;
    const email = data.get('email') as string;

    if (!locals.user) throw error(401, 'Unauthorized');

    locals.user.username = name;
    locals.user.email = email

    await updateUser(locals.user);

    return { success: true };
  },

  updatePassword: async ({ request, locals }) => {
    const data = await request.formData();
    const newPassword = data.get('newPassword') as string;
    const confirmPassword = data.get('confirmPassword') as string;

    if (newPassword !== confirmPassword) throw error(400, 'Passwords do not match');
    if (!locals.user) throw error(401, 'Unauthorized');

    updateUserPassword(locals.user.id, newPassword)

    return { success: true };
  },

  logoutSession: async ({ request, locals }) => {
    const data = await request.formData();
    const sessionId = data.get('sessionId');

    if (!locals.user) throw error(401, 'Unauthorized');
    if (!sessionId) throw error(400, 'Missing sessionId');
    console.log('deleting sessionId', sessionId)
    invalidateSession(sessionId.toString());

    return { success: true };
  },

  deleteAccount: async ({ locals }) => {
    if (!locals.user || !locals.session) throw error(401, 'Unauthorized');

    await invalidateAllSessions(locals.user.id, locals.session);
    await deleteUser(locals.user.id);

    throw redirect(302, '/logout');
  }
} satisfies Actions;

export const load: PageServerLoad = async ({ locals }) => {
  if (!locals.user || !locals.session) throw error(401, 'Unauthorized');
  const sessionsList = await getSessionsForUser(locals.user.id);

  return {
    user: locals.user,
    curSession: locals.session.id,
    sessions: sessionsList
  }
};

