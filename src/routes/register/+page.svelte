<script lang="ts">
  import Logo from "$lib/logo.svelte";
  let email = "";
  let password = "";
  let passwordConfirm = "";

  const emailVerificationRegex = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;

  $: isValid = emailVerificationRegex.test(email) && password.length > 0 && password === passwordConfirm;

  const register = () => {
    console.log("Registering:", email, password, passwordConfirm);
  };
</script>

<!-- Navigation/Header (Same as other pages) -->
<header class="bg-white shadow">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center py-6">
      <div class="flex items-center">
        <a href="/" class="mr-10">
          <Logo class="w-40 h-40" />
        </a>
        <nav class="hidden md:flex space-x-10">
          <a href="/" class="text-base font-medium text-gray-700 hover:text-gray-900">Home</a>
          <a href="/events" class="text-base font-medium text-gray-700 hover:text-gray-900">Events</a>
          <a href="/about" class="text-base font-medium text-gray-700 hover:text-gray-900">About</a>
          <a href="/contact" class="text-base font-medium text-gray-700 hover:text-gray-900">Contact</a>
        </nav>
      </div>
      <div class="hidden md:flex items-center space-x-4">
        <a href="/login" class="text-base font-medium text-gray-700 hover:text-gray-900">Sign In</a>
        <a
          href="/register"
          class="whitespace-nowrap inline-flex items-center justify-center px-6 py-3 border border-transparent rounded-md shadow-sm text-base font-medium text-white bg-indigo-600 hover:bg-indigo-700"
        >
          Register
        </a>
      </div>
    </div>
  </div>
</header>

<!-- Registration Form Section -->
<div class="min-h-screen flex items-center justify-center bg-gradient-to-r from-indigo-500 to-purple-500 px-4">
  <div class="w-full max-w-md bg-white rounded-xl shadow-lg p-8 space-y-6">
    <h1 class="text-3xl font-bold text-center text-gray-800">Register</h1>
    <p class="text-center text-gray-500">Create your new account on Eventify</p>
    <form on:submit|preventDefault={register} class="space-y-4">
      <div>
        <label class="block text-gray-700 mb-1" for="email">Email</label>
        <input
          id="email"
          type="email"
          bind:value={email}
          placeholder="Enter your email"
          class="w-full p-3 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          required
        />
      </div>
      <div>
        <label class="block text-gray-700 mb-1" for="password">Password</label>
        <input
          id="password"
          type="password"
          bind:value={password}
          placeholder="Enter your password"
          class="w-full p-3 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          required
        />
      </div>
      <div>
        <label class="block text-gray-700 mb-1" for="passwordConfirm">Confirm Password</label>
        <input
          id="passwordConfirm"
          type="password"
          bind:value={passwordConfirm}
          placeholder="Confirm your password"
          class="w-full p-3 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-400"
          required
        />
      </div>
      <button
        type="submit"
        class="w-full py-3 bg-indigo-600 text-white font-semibold rounded-lg hover:bg-indigo-700 transition-colors disabled:opacity-50"
        disabled={!isValid}
      >
        Register
      </button>
    </form>
    <div class="text-center">
      <p class="text-gray-500">
        Already have an account?
        <a href="/login" class="text-indigo-600 hover:underline">Sign In</a>
      </p>
    </div>
  </div>
</div>
