<script lang="ts">
	import { enhance } from '$app/forms';
	import type { Booking } from '$lib/events/bookings';
	import type { Event } from '$lib/events/events';
	import SuccessModal from '$lib/successModal.svelte';
	import type { PageProps } from './$types.js';

	// Props from load function
	const { data, form }: PageProps = $props();

	let isOpen: boolean = $state();
	let showModal = $derived(
		form?.success &&
			((isOpen: boolean) => {
				return isOpen == true;
			})
			? true
			: false
	);
	let modalTitle = $derived(
		form?.success
			? 'Booking failure 😿 \nPlease contact our Humans to get this figured out'
			: 'Booking Success! 🥳'
	);
	const debugTitle = 'debug bookings:';

	// (modalClosedByUser === true || form?.success ? true : false)
	let bookings: Booking[] = $derived(data.bookingsResult);
	let bookedEvents: Event[] = $derived(data.bookedEvents);
	// let bookingNumCounter = $state({
	// count: 0,
	// inc: function () {
	// this.count += 1;
	// }
	// });

	let numberOfAttendeesArray = $derived(
		bookings.map((booking) => {
			return booking.numberOfPeople;
		})
	);

	// State variables
	// async function changeAttendees(bookingIndex: number) {
	// 	let result: Response | null = null; // Initialize to null
	// 	try {
	// 		result = await fetch(
	// 			`/api/changeAttendees/?numAttendees=${numberOfAttendeesArray[bookingIndex]}`,
	// 			{
	// 				method: 'POST',
	// 				body: JSON.stringify(bookings[bookingIndex])
	// 			}
	// 		);
	// 		if (result.ok) {
	// 			modalTitle = 'Booking Success!';
	// 		} else {
	// 			modalTitle = 'Booking failure 😿 \nPlease contact our Humans to get this figured out';
	// 		}
	// 	} catch (error) {
	// 		console.error('Error changing attendees:', error);
	// 		modalTitle = 'Booking failure 😿 \nPlease contact our Humans to get this figured out';
	// 	}
	// }
	//
	function closeModal() {
		console.log('CloseModal has been run');
		isOpen = false;
	}

	function handleClickOutside(event) {
		if (isOpen && !event.target.closest('.modal')) {
			closeModal();
		}
	}
</script>

{@debug debugTitle, showModal}
<SuccessModal title={modalTitle} {handleClickOutside} {closeModal} isOpen={showModal} />
<div class="container mx-auto max-w-3xl rounded-lg bg-white p-6 shadow-lg">
	<h2 class="mb-4 text-2xl font-bold">Booked Events</h2>

	<div class="space-y-4">
		{#each bookings as booking, index (booking.id)}
			<div class="rounded-md border border-gray-200 bg-gray-50 p-4 shadow-sm">
				<form class="space-y-3" use:enhance method="post">
					<input type="hidden" name="bookingId" value={booking.id} />
					<h3 class="text-lg font-semibold">
						{bookedEvents[index].name}
					</h3>
					<div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
						<div>
							<label class="block text-sm font-medium text-gray-700" for="numPeople"
								>Number of Participants</label
							>
							<input
								type="number"
								id="numPeople"
								name="numPeople"
								value={numberOfAttendeesArray[index]}
								class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
							/>
						</div>
					</div>

					<div class="flex space-x-2 pt-2">
						<button
							type="submit"
							class="button rounded-md bg-blue-500 p-4 text-white shadow-sm hover:bg-blue-600 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none"
						>
							Change Booking
						</button>
					</div>
					<a
						href="/bookings/cancel/{booking.id}"
						class="button rounded-md bg-red-500 p-4 text-white shadow-sm hover:bg-red-600 focus:ring-2 focus:ring-red-500 focus:ring-offset-2 focus:outline-none"
						>Cancel Booking</a
					>
				</form>
			</div>
		{:else}
			<div class="rounded-md bg-gray-50 p-8 text-center">
				<p class="text-gray-600">No events available.</p>
			</div>
		{/each}
	</div>
</div>
