<script lang="ts">
	import type { NavigationTarget } from '@sveltejs/kit';
	import type { PageProps } from './$types';
	import { page } from '$app/state';
	import { enhance } from '$app/forms';

	// Variable definitions
	const { data, form }: PageProps = $props();
	const { eventResult, venue, schedule } = $state(data);
	const formattedDate = schedule.startTime.toISOString().split('T');
	let numBookings = $state(1);

	let formattedTimeDate = $derived(() => {
		const date = new Date(schedule.startTime);
		const hours = String(date.getHours()).padStart(2, '0');
		const minutes = String(date.getMinutes()).padStart(2, '0');
		return `${hours}:${minutes}`;
	});

	let referrer = $derived(
		((data) => {
			if (!data.referrer) {
				const baseLocation = page.url.host;
				const protocol = page.url.protocol;

				let newNav: NavigationTarget = {
					url: new URL(`${protocol}${baseLocation}/events/`),
					route: { id: null },
					params: null
				};
				return newNav;
			} else {
				console.log(data.referrer);
				return data.referrer;
			}
		})(data)
	);
</script>

<div
	class="min-h-screen items-center justify-center bg-gradient-to-br from-purple-500 to-blue-500 p-40"
>
	<h2 class="mb-4 text-2xl font-bold text-white">Book {eventResult.name}</h2>

	<div class="space-y-4">
		<div class="rounded-md border border-gray-200 bg-gray-50 p-4 shadow-sm">
			<div class="space-y-3">
				<!-- <h3 class="text-lg font-semibold">{eventResult.name}</h3> -->

				<form use:enhance method="POST">
					<div class="grid grid-cols-1 gap-3 sm:grid-cols-3">
						<input type="hidden" id="event" value={JSON.stringify(eventResult)} name="event" />
						<input type="hidden" id="venue" value={JSON.stringify(venue)} name="venue" />
						<div>
							<label class="block text-sm font-medium text-gray-700" for="numPeople"
								>Number of Participants</label
							>
							<input
								type="number"
								id="numPeople"
								name="numPeople"
								value={numBookings}
								class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
							/>
						</div>
						<div>
							<label class="block text-sm font-medium text-gray-700" for="booking-date">Date</label>
							<input
								type="date"
								id="booking-date"
								name="bookingDate"
								value={formattedDate[0]}
								disabled
								class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
							/>
						</div>
						<div>
							<label class="block text-sm font-medium text-gray-700" for="booking.time">Time</label>
							<input
								type="time"
								id="booking-time"
								name="bookingTime"
								value={formattedTimeDate()}
								disabled
								class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
							/>
						</div>
					</div>

					{#if form?.message}
						<p class="text-red-700">{form?.message}</p>
					{/if}

					<div class="flex space-x-2 pt-2">
						<button
							type="submit"
							class="rounded-md bg-blue-500 px-3 py-1.5 text-sm text-white hover:bg-blue-600 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none"
						>
							Book
						</button>
						<a
							href={referrer?.url.toString()}
							class="rounded-md bg-gray-300 px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-400 focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 focus:outline-none"
						>
							Cancel
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
