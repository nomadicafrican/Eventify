/**
 * @typedef {Object} LoginResponse
 * @property {boolean} [success] - Indicates successful login.
 * @property {string} [error] - Error message if login fails.
 */

/** @type {import('./$types').Actions} */
export const actions = {
  /**
   * Handles login form submission.
   * @param {import('@sveltejs/kit').RequestEvent} event - The request event.
   * @returns {Promise<LoginResponse>} - Login response object.
   */
  default: async ({ request }) => {
    const formData = await request.formData();
    const username = formData.get("username");
    const password = formData.get("password");

    if (!username || !password) {
      return { error: "Both fields are required." };
    }

    if (username === "admin" && password === "password") {
      return { success: true };
    }

    return { error: "Invalid credentials." };
  },
};
