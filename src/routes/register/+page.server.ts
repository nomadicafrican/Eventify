import { createSession, generateSessionToken, setSessionTokenCookie } from "$lib/server/session";
import { redirect, fail } from "@sveltejs/kit";
import { createUser } from "$lib/server/user";
import type { User } from "$lib/server/user";

type Actions = import('./$types').Actions;

export const actions = {
  default: async (event) => {
    const emailVerificationRegex = new RegExp(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
    const formData = await event.request.formData();
    const email = formData.get("email") as string;
    const password = formData.get("password") as string;
    const passwordConfirmation = formData.get("passwordConfirm") as string;
    console.log(email)
    const isValid = emailVerificationRegex.test(email)

    console.log("Havent crashed yet 1")

    if (!isValid) {
      return fail(400, {
        message: "Invalid email address",
      })
    }

    console.log("Havent crashed yet 2")
    if (password !== passwordConfirmation && password.length > 0) {
      return fail(400, {
        message: "Passwords do not match",
      })
    }

    console.log("Havent crashed yet 3")
    let user: User;
    try {
      user = await createUser(email, email, password);
    }
    catch (e) {
      console.log(e)
      return fail(400, {
        message: "User already exists",
      })
    }

    console.log("Havent crashed yet 4")
    const sessionToken = generateSessionToken();
    const session = await createSession(sessionToken, user.id);
    setSessionTokenCookie(event, sessionToken, session.expiresAt);
    console.log("Havent crashed yet 5")
    return redirect(302, "/")
  }
} satisfies Actions;


