<script lang="ts">
	import { enhance } from '$app/forms';
	import type { PageProps } from './$types';

	let { data, form }: PageProps = $props();

	const { eventResult, venue, schedule, numBookings } = data;

	const participantInfo = eventResult?.max_attendees
		? `${numBookings}/${eventResult.max_attendees} participants`
		: `${numBookings} participants`;

	const defaultNumPeople = 1;

	const mapPlaceholderText = 'Map goes here';
</script>

<div class="min-h-screen bg-gradient-to-br from-purple-500 to-blue-500 py-8 px-4 text-gray-800">
	<div class="mx-auto max-w-6xl bg-white rounded-lg shadow-lg p-6">
		<div class="flex flex-col md:flex-row gap-8">
			<div class="flex-1">
				<h1 class="text-3xl font-bold text-purple-700 text-center">
					{eventResult?.name ?? 'Event Name'}
				</h1>
				<p class="text-gray-500 mt-1 mb-6 text-center">
					{eventResult?.subtitle ?? 'Event Subtitle'}
				</p>

				<div class="flex items-center justify-center w-full h-64 bg-gray-200 rounded">
					<span class="text-gray-500">{mapPlaceholderText}</span>
				</div>
			</div>

			<div class="flex-1 flex flex-col items-center justify-center">
				<h2 class="text-2xl font-semibold text-gray-800 mb-6">Attend This Event</h2>

				<form method="POST" use:enhance class="mb-6">
					<input type="hidden" name="numPeople" value={defaultNumPeople} />
					<input type="hidden" name="event" value={JSON.stringify(eventResult)} />
					<input type="hidden" name="venue" value={JSON.stringify(venue)} />

					<button
						type="submit"
						class="px-6 py-3 text-lg rounded bg-green-500 text-white font-semibold hover:bg-green-600 transition"
					>
						Book
					</button>

					{#if form?.message}
						<p class="mt-3 text-red-600">{form.message}</p>
					{/if}
				</form>
				<div class="px-4 py-2 rounded-full bg-gray-200 text-gray-800 text-sm font-medium">
					{participantInfo}
				</div>
			</div>
		</div>
	</div>
</div>
