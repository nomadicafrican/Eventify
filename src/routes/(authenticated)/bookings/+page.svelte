<!-- <script lang="ts"> -->
<!-- 	import type { Booking } from '$lib/events/bookings'; -->
<!-- 	import type { Event } from '$lib/events/events'; -->
<!-- 	import { fetch } from 'bun'; -->
<!-- 	import SuccessModal from '$lib/successModal.svelte'; -->
<!--   import type { MouseEventHandler } from 'svelte/elements';} -->
<!---->
<!-- 	// Props from load function -->
<!-- 	const { data } = $props(); -->
<!---->
<!-- 	let showModal = $state(false); -->
<!-- 	let modalTitle = $state(''); -->
<!-- 	let bookings: Booking[] = $derived(data.bookingsResult); -->
<!-- 	let bookedEvents: Event[] = $derived(data.bookedEvents); -->
<!-- 	let bookingNumCounter = $state({ -->
<!-- 		count: 0, -->
<!-- 		inc: function () { -->
<!-- 			this.count += 1; -->
<!-- 		} -->
<!-- 	}); -->
<!---->
<!-- 	let numberOfAttendeesArray = $derived( -->
<!-- 		bookings.map((booking) => { -->
<!-- 			return booking.numberOfPeople; -->
<!-- 		}) -->
<!-- 	); -->
<!---->
<!-- 	// State variables -->
<!-- 	let loading = false; // Initial loading is done server-side -->
<!---->
<!-- 	async function changeAttendees(bookingNumCounter: number) { -->
<!-- 		let result: Response = new Response(); -->
<!-- 		async () => { -->
<!-- 			result = await fetch( -->
<!-- 				`/api/changeAttendees/?numAttendees=${numberOfAttendeesArray[bookingNumCounter]}`, -->
<!-- 				{ -->
<!-- 					method: 'POST', -->
<!-- 					body: JSON.stringify(bookings[bookingNumCounter]) -->
<!-- 				} -->
<!-- 			); -->
<!-- 		}; -->
<!-- 		if (result && result.ok) { -->
<!-- 			showModal = true; -->
<!-- 			modalTitle = 'Booking Success!'; -->
<!-- 		} else { -->
<!-- 			showModal = false; -->
<!-- 			modalTitle = 'Booking failure 😿'; -->
<!-- 		} -->
<!-- 		const MEH: MouseEventHandler<HTMLButtonElement>; -->
<!--     return MEH; -->
<!-- 	} -->
<!-- </script> -->
<!---->
<!-- <SuccessModal isOpen={showModal} title={modalTitle} /> -->
<!-- <div class="container mx-auto max-w-3xl rounded-lg bg-white p-6 shadow-lg"> -->
<!-- 	<h2 class="mb-4 text-2xl font-bold">Booked Events</h2> -->
<!---->
<!-- 	{#if loading} -->
<!-- 		<div class="flex justify-center py-8"> -->
<!-- 			<div class="animate-pulse text-center"> -->
<!-- 				<p>Loading...</p> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	{:else if bookings.length === 0} -->
<!-- 		<div class="rounded-md bg-gray-50 p-8 text-center"> -->
<!-- 			<p class="text-gray-600">No events available.</p> -->
<!-- 		</div> -->
<!-- 	{:else} -->
<!-- 		<div class="space-y-4"> -->
<!-- 			{#each bookings as booking} -->
<!-- 				<div class="rounded-md border border-gray-200 bg-gray-50 p-4 shadow-sm"> -->
<!-- 					<div class="space-y-3"> -->
<!-- 						<h3 class="text-lg font-semibold">{bookedEvents[bookingNumCounter.count].name}</h3> -->
<!-- 						<input type="hidden" name="eventId" value={booking.id} /> -->
<!-- 						<div class="grid grid-cols-1 gap-3 sm:grid-cols-2"> -->
<!-- 							<div> -->
<!-- 								<label class="block text-sm font-medium text-gray-700" for="numPeople" -->
<!-- 									>Number of Participants</label -->
<!-- 								> -->
<!-- 								<input -->
<!-- 									type="number" -->
<!-- 									id="numPeople" -->
<!-- 									name="numPeople" -->
<!-- 									value={numberOfAttendeesArray[bookingNumCounter.count]} -->
<!-- 									class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500" -->
<!-- 								/> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!---->
<!-- 						<div class="flex space-x-2 pt-2"> -->
<!-- 							<button -->
<!-- 								class="button rounded-md bg-blue-500 p-4 text-white shadow-sm hover:bg-blue-600 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none" -->
<!-- 								onclick={changeAttendees(bookingNumCounter.count)} -->
<!-- 							> -->
<!-- 								Change Booking -->
<!-- 							</button> -->
<!-- 							<a -->
<!-- 								href="/bookings/cancel/{booking.id}" -->
<!-- 								class="button rounded-md bg-red-500 p-4 text-white shadow-sm hover:bg-red-600 focus:ring-2 focus:ring-red-500 focus:ring-offset-2 focus:outline-none" -->
<!-- 								>Cancel Booking</a -->
<!-- 							> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				{bookingNumCounter.inc()} -->
<!-- 			{/each} -->
<!-- 		</div> -->
<!-- 	{/if} -->
<!-- </div> -->

<script lang="ts">
	import type { Booking } from '$lib/events/bookings';
	import type { Event } from '$lib/events/events';
	import { fetch } from 'bun';
	import SuccessModal from '$lib/successModal.svelte';

	// Props from load function
	const { data } = $props();

	let showModal = $state(false);
	let modalTitle = $state('');
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
	async function changeAttendees(bookingIndex: number) {
		let result: Response | null = null; // Initialize to null
		try {
			result = await fetch(
				`/api/changeAttendees/?numAttendees=${numberOfAttendeesArray[bookingIndex]}`,
				{
					method: 'POST',
					body: JSON.stringify(bookings[bookingIndex])
				}
			);
			if (result.ok) {
				showModal = true;
				modalTitle = 'Booking Success!';
			} else {
				showModal = false;
				modalTitle = 'Booking failure 😿 \nPlease contact our Humans to get this figured out';
			}
		} catch (error) {
			console.error('Error changing attendees:', error);
			showModal = false;
			modalTitle = 'Booking failure 😿 \nPlease contact our Humans to get this figured out';
		}
	}

	function handleClick(bookingIndex: number) {
		console.log('hello');
		$inspect('hello');
		changeAttendees(bookingIndex);
	}
</script>

<SuccessModal isOpen={showModal} title={modalTitle} />
<div class="container mx-auto max-w-3xl rounded-lg bg-white p-6 shadow-lg">
	<h2 class="mb-4 text-2xl font-bold">Booked Events</h2>

	<div class="space-y-4">
		{#each bookings as booking, index (booking.id)}
			<div class="rounded-md border border-gray-200 bg-gray-50 p-4 shadow-sm">
				<div class="space-y-3">
					<h3 class="text-lg font-semibold">
						{bookedEvents[index].name}
					</h3>
					<input type="hidden" name="eventId" value={booking.id} />
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
							type="button"
							class="button rounded-md bg-blue-500 p-4 text-white shadow-sm hover:bg-blue-600 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none"
							onclick={() => {
								console.log('haiiii');
							}}
						>
							Change Booking
						</button>
					</div>
					<a
						href="/bookings/cancel/{booking.id}"
						class="button rounded-md bg-red-500 p-4 text-white shadow-sm hover:bg-red-600 focus:ring-2 focus:ring-red-500 focus:ring-offset-2 focus:outline-none"
						>Cancel Booking</a
					>
				</div>
			</div>
		{:else}
			<div class="rounded-md bg-gray-50 p-8 text-center">
				<p class="text-gray-600">No events available.</p>
			</div>
		{/each}
	</div>
</div>
