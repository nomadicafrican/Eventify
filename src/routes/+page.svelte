<script>
  import SearchBar from "../lib/searchBar.svelte";
	import Logo from "$lib/logo.svelte";
  import Header from "$lib/header.svelte";
</script>

<Header/>

<div class="flex flex-col justify-center h-screen text-center items-center p-20">
  <div class="flex items-center text-6xl font-bold text-purple-700 mb-20 align-middle">
    <Logo  --icon-border-height = 6 />
    <span class="ml-18">ventify</span>
  </div>
  <SearchBar />
</div>

<div class="mt-10 p-6 bg-gray-100 text-center">
  <h2 class="text-xl font-semibold text-gray-800">About Us</h2>
  <p class="mt-2 text-gray-600 max-w-2xl mx-auto">
    Eventify is your go-to platform for discovering and booking events near you. Our mission is to 
    make event exploration seamless, providing a user-friendly experience to connect people with 
    the best happenings around them. Whether you're looking for concerts, meetups, or workshops, 
    Eventify has got you covered!
  </p>
</div>
