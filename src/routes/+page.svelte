<script>
  import SearchBar from "../lib/searchBar.svelte";
</script>

<div class="flex justify-between items-center w-full p-4 bg-gray-200">
  <img src="/logo.png" alt="Logo" class="w-10" />
  <button class="bg-gray-300 px-4 py-2 rounded">Sign In, Name</button>
</div>

<div class="flex flex-col items-center justify-center h-screen text-center">
  <div class="flex items-center text-2xl font-bold text-purple-700">
    <img src="/logo.png" alt="Eventify Logo" class="w-20" />
    <span>ventify</span>
  </div>
  
  <SearchBar />
</div>
