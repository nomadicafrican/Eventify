<script lang="ts">
  import Logo from "$lib/logo.svelte";
  import SearchBar from "$lib/searchBar.svelte";
</script>

<!-- Navigation/Header -->
<header class="bg-white shadow">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between items-center py-6">
      <div class="flex items-center">
        <!-- Smaller Nav Logo -->
        <a href="/" class="mr-10">
          <Logo class="w-16 h-16" />
        </a>
        <!-- Navigation Links -->
        <nav class="hidden md:flex space-x-10">
          <a href="/" class="text-base font-medium text-gray-700 hover:text-gray-900">Home</a>
          <a href="/events" class="text-base font-medium text-gray-700 hover:text-gray-900">Events</a>
          <a href="/about" class="text-base font-medium text-gray-700 hover:text-gray-900">About</a>
          <a href="/contact" class="text-base font-medium text-gray-700 hover:text-gray-900">Contact</a>
        </nav>
      </div>
      <!-- Account Links -->
      <div class="hidden md:flex items-center space-x-4">
        <a href="/login" class="text-base font-medium text-gray-700 hover:text-gray-900">
          Sign In
        </a>
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

<!-- Hero Section with a Larger Logo Above the Search Bar -->
<div class="min-h-screen flex flex-col justify-center items-center bg-gradient-to-r from-indigo-500 to-purple-500 px-4">
  <div class="text-center">
    <div class="flex justify-center mb-8">
      <!-- Increase to w-64 h-64 or more if you want it even bigger -->
    </div>
    <h1 class="text-6xl font-bold text-white">Eventify</h1>
    <p class="mt-4 text-2xl text-white max-w-2xl mx-auto">
      Discover and book amazing events near you.
    </p>
    <div class="mt-12 w-full max-w-3xl mx-auto">
      <!-- Larger Search Bar -->
      <SearchBar class="w-full h-20 text-2xl p-4" />
      <!-- Adjust h-20, text-2xl, and p-4 if you want it even bigger -->
    </div>
  </div>
</div>


