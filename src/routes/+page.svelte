<script lang="ts">
	import SearchBar from '$lib/searchBar.svelte';
</script>

<!-- Navigation/Header -->

<!-- Hero Section with a Larger Logo Above the Search Bar -->
<div
	class="flex min-h-screen flex-col items-center justify-center bg-gradient-to-r from-indigo-500 to-purple-500 px-4"
>
	<div class="text-center">
		<h1 class="text-6xl font-bold text-white">Eventify</h1>
		<p class="mx-auto mt-4 max-w-2xl text-2xl text-white">
			Discover and book amazing events near you.
		</p>
		<div class="mx-auto mt-12 w-full max-w-3xl">
			<!-- Larger Search Bar -->
			<SearchBar />
			<!-- Adjust h-20, text-2xl, and p-4 if you want it even bigger -->
		</div>
	</div>
</div>
