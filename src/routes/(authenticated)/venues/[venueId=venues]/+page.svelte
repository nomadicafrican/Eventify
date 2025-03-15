<script lang="ts">
	import type { PageProps } from './$types';

	let { data }: PageProps = $props();
</script>

<!-- mx-auto h-full w-40 rounded-lg bg-white p-8 shadow-lg hover:bg-gray-100 -->
<div
	class="min-h-screen items-center justify-center bg-gradient-to-br from-purple-500 to-blue-500 p-40"
	title={`${data.venue.name}`}
>
	<div class="h-full w-full rounded-lg bg-white p-8 shadow-lg">
		<li class="list-none">
			<a style="font-size: 24px; font-weight: 400;" href={data.venue.website}
				>{data.venue.website}</a
			>
		</li>
		<li class="list-none">
			Address: {data.venue.state}, {data.venue.city}, {data.venue.address}, {data.venue.zip}
		</li>

		<h2 class="mt-8 mb-4 text-2xl font-semibold">Events at this venue</h2>

		<div class="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
			{#if data.events && data.events.length > 0}
				{#each data.events as event}
					<a
						class="h-full w-full rounded-lg bg-white p-8 shadow-lg hover:bg-gray-100"
						title={`${Math.round(event.bookings || 0)}/${Math.round(event.max_attendees)} attendees`}
						href={`/events/${event.id}`}
					>
						<ul class="h-max w-full">
							<li><h2 style="font-size: 24px; font-weight: 400;">{event.name}</h2></li>
							<li>Date: {new Date(event.event_date).toLocaleDateString()}</li>
							<li>
								Time: {new Date(event.event_date).toLocaleTimeString([], {
									hour: '2-digit',
									minute: '2-digit'
								})}
							</li>
							<li>
								<div class="mt-2 flex items-center">
									<div class="h-2 w-full rounded-full bg-gray-200">
										<div
											class="h-full rounded-full bg-blue-600"
											style={`width: ${(event.bookings! / event.max_attendees) * 100}%`}
										></div>
									</div>
								</div>
							</li>
						</ul>
					</a>
				{/each}
			{:else}
				<p class="col-span-full text-gray-500">No events scheduled at this venue.</p>
			{/if}
		</div>
	</div>
</div>
