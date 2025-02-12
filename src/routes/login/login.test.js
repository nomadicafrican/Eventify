import { test, expect } from "vitest";
import { actions } from "./+page.server.js";

test("should fail if fields are empty", async () => {
  const request = new Request("http://localhost", {
    method: "POST",
    body: new URLSearchParams({}),
  });

  const response = await actions.default({ request });
  expect(response.error).toBe("Both fields are required.");
});

test("should succeed for correct credentials", async () => {
  const request = new Request("http://localhost", {
    method: "POST",
    body: new URLSearchParams({ username: "admin", password: "password" }),
  });

  const response = await actions.default({ request });
  expect(response.success).toBe(true);
});

test("should fail for incorrect credentials", async () => {
  const request = new Request("http://localhost", {
    method: "POST",
    body: new URLSearchParams({ username: "wrong", password: "wrong" }),
  });

  const response = await actions.default({ request });
  expect(response.error).toBe("Invalid credentials.");
});
