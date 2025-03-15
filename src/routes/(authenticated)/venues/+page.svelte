<script lang="ts">
	import type { PageProps } from './$types';
	let { data }: PageProps = $props();
</script>

<div
	class="
    grid min-h-screen grid-cols-1 items-center justify-center gap-4
    bg-gradient-to-br from-purple-500 to-blue-500 p-40 sm:grid-cols-1 md:grid-cols-2
    lg:grid-cols-3 xl:grid-cols-5
  "
>
	{#each data.venues as venue}
		<a
			class="h-full w-full rounded-lg bg-white p-8 shadow-lg hover:bg-gray-100"
			title={venue.name}
			href={`/venues/${venue.id}`}
		>
			<ul class="h-max w-full">
				<li><h2 style="font-size: 24px; font-weight: 400;">{venue.name}</h2></li>
				<li>Venue location: {venue.state}, {venue.city}, {venue.address}, {venue.zip}</li>
				<li>capacity: {venue.capacity}</li>
			</ul>
		</a>
	{/each}
</div>
