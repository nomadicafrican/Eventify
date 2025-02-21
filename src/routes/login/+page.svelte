<script>
    import { createEventDispatcher } from "svelte";
  
    export let form;
  
    const dispatch = createEventDispatcher();
  
    let username = "";
    let password = "";
  
    /**
     * Handles form submission.
     */
    async function submit() {
      const response = await form({ username, password });
  
      if (response.error) {
        dispatch("error", response.error);
      } else {
        dispatch("success", response);
      }
    }
  </script>

  <div class="flex min-h-screen items-center justify-center bg-gray-100">
    <form on:submit|preventDefault={submit} class="w-full max-w-md bg-white p-8 rounded-lg shadow-md">
      <h1 class="text-2xl font-semibold text-center text-purple-700">Sign in</h1>
      <p class="text-center text-gray-500 mb-6">Use your Eventify Account</p>
  
      <div class="mb-4">
        <label class="block text-gray-700 font-bold" for="username">Username</label>
        <input
          type="text"
          bind:value={username}
          placeholder="Username Here"
          class="w-full p-3 border rounded-lg focus:ring focus:ring-purple-300"
          id="username"
        />
      </div>
  
      <div class="mb-4">
        <label class="block text-gray-700 font-bold" for="password">Password</label>
        <input
          type="password"
          bind:value={password}
          placeholder="Password Here"
          class="w-full p-3 border rounded-lg focus:ring focus:ring-purple-300"
          id="password"
        />
      </div>
  
      <div class="text-center">
        <button type="submit" class="w-full bg-green-500 text-white py-3 rounded-lg hover:bg-green-600">
          Next
        </button>
      </div>
  
      <p class="mt-4 text-center text-sm text-gray-500">
        Don't have an account? <a href="/signup" class="text-purple-600 hover:underline">Click here</a>
      </p>
    </form>
  </div>
  
