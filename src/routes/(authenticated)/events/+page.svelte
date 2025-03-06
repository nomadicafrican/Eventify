<script lang="ts">
	import type { PageProps } from './$types';
	let { data }: PageProps = $props();
</script>

<div
	class="flex min-h-screen items-center justify-center bg-gradient-to-br from-purple-500 to-blue-500 p-20"
>
	{#each data.events as event}
		<div
			class="w-full max-w-md rounded-lg bg-white p-6 shadow-lg"
			style="font-size: 24px; font-weight: 400;"
		>
			<ul>
				<li><h2>{event.name}</h2></li>
				<li>Min attendees: {event.min_attendees}</li>
				<li>Max attendees: {event.max_attendees}</li>
				<li>Event date: {event.event_date}</li>
				<li>Event Venue: {event.venue_id}</li>
			</ul>
		</div>
	{/each}
</div>
