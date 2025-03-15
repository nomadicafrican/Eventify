<script lang="ts">
	import type { PageProps } from './$types';

	let { data }: PageProps = $props();
</script>

<!-- mx-auto h-full w-40 rounded-lg bg-white p-8 shadow-lg hover:bg-gray-100 -->
<div
	class="min-h-screen items-center justify-center bg-gradient-to-br from-purple-500 to-blue-500 p-40"
	title={`${data.numBookings} attendees`}
>
	<div class="h-full w-full rounded-lg bg-white p-8 shadow-lg hover:bg-gray-100">
		<li><h2 style="font-size: 24px; font-weight: 400;">{data.user.username}</h2></li>
		<li>Date: {data.event.event_date}</li>
		<li><a href="/venues/{data.venue.id}">{data.venue.name}</a></li>
		<li>
			Attendees:
			<div class="h-2.5 w-full rounded-full bg-indigo-950">
				<div
					class="h-2.5 rounded-full bg-indigo-600"
					style="width: {`${Math.round(data.numBookings / data.event.max_attendees)}%`};"
				></div>
			</div>
		</li>
	</div>
</div>
