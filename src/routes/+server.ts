import "$lib/server/session";
import type { RequestEvent } from "./$types";

export function GET(event: RequestEvent): Promise<Response> {
  if (event.locals.user === null) {
    return Promise.resolve(new Response(null, {
      status: 401
    }));
  }
  console.log("seomthing"); // TODO: finish this
  return Promise.resolve(new Response(null, {
    status: 404
  }));
}

