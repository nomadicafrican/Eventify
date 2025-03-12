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
	{#each data.events as event}
		<div
			class="h-full w-full rounded-lg bg-white p-8 shadow-lg hover:bg-gray-100"
			title={`${Math.round(event.attendees!)}/${Math.round(event.max_attendees)} attendees`}
		>
			<ul class="h-max w-full">
				<li><h2 style="font-size: 24px; font-weight: 400;">{event.name}</h2></li>
				<li>Event date: {event.event_date}</li>
				<li>Event Venue: {event.venue_id}</li>
				<li>
					Attendees:
					<div class="h-2.5 w-full rounded-full bg-indigo-950">
						<div
							class="h-2.5 rounded-full bg-indigo-600"
							style="width: {`${Math.round(event.attendeesPercentage!)}%`};"
						></div>
					</div>
				</li>
			</ul>
		</div>
	{/each}
</div>
