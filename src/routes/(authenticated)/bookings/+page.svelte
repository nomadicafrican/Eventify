<script lang="ts">
	import type { Booking } from '$lib/events/bookings';
	import { deleteBooking, updateBooking } from '$lib/events/bookings';

	let bookings: Booking[] = [];
	let loading = true;
	let editingBookingId: number | null = null;

	async function cancelBooking(bookingId: number) {
		if (!confirm('Are you sure you want to cancel this booking?')) return;
		await deleteBooking(bookingId);
	}

	function startEditing(bookingId: number) {
		editingBookingId = bookingId;
	}

	function cancelEditing() {
		editingBookingId = null;
	}

	async function saveBooking(booking: Booking) {
		await updateBooking(booking);
	}
</script>

<div class="container mx-auto max-w-3xl rounded-lg bg-white p-6 shadow-lg">
	<h2 class="mb-4 text-2xl font-bold">My Booked Events</h2>

	{#if loading}
		<div class="flex justify-center py-8">
			<div class="animate-pulse text-center">
				<p>Loading your bookings...</p>
			</div>
		</div>
	{:else if bookings.length === 0}
		<div class="rounded-md bg-gray-50 p-8 text-center">
			<p class="text-gray-600">You haven't booked any events yet.</p>
			<a
				href="/events"
				class="mt-4 inline-block rounded-md bg-blue-500 px-4 py-2 text-white hover:bg-blue-600"
			>
				Browse Events
			</a>
		</div>
	{:else}
		<div class="space-y-4">
			{#each bookings as booking}
				<div class="rounded-md border border-gray-200 bg-gray-50 p-4 shadow-sm">
					{#if editingBookingId === booking.id}
						<div class="space-y-3">
							<h3 class="text-lg font-semibold">{booking.eventName}</h3>

							<div class="grid grid-cols-1 gap-3 sm:grid-cols-2">
								<div>
									<label class="block text-sm font-medium text-gray-700" for="booking-date"
										>Date</label
									>
									<input
										type="date"
										id="booking-date"
										bind:value={booking.date}
										class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
									/>
								</div>
								<div>
									<label class="block text-sm font-medium text-gray-700" for="booking.time"
										>Time</label
									>
									<input
										type="time"
										id="booking-time"
										bind:value={booking.time}
										class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500"
									/>
								</div>
							</div>

							<div class="flex space-x-2 pt-2">
								<button
									on:click={() => saveBooking(booking)}
									class="rounded-md bg-blue-500 px-3 py-1.5 text-sm text-white hover:bg-blue-600 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none"
								>
									Save
								</button>
								<button
									on:click={cancelEditing}
									class="rounded-md bg-gray-300 px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-400 focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 focus:outline-none"
								>
									Cancel
								</button>
							</div>
						</div>
					{:else}
						<div class="flex items-center justify-between">
							<div>
								<h3 class="text-lg font-semibold">{booking.eventName}</h3>
								<p class="text-sm text-gray-600">📅 {booking.date} at {booking.time}</p>
								<p class="text-sm text-gray-600">📍 {booking.venue}</p>
								<span
									class={`mt-2 inline-block rounded-full px-2 py-0.5 text-xs ${
										booking.status === 'confirmed'
											? 'bg-green-100 text-green-800'
											: booking.status === 'pending'
												? 'bg-yellow-100 text-yellow-800'
												: 'bg-red-100 text-red-800'
									}`}
								>
									{booking.status.charAt(0).toUpperCase() + booking.status.slice(1)}
								</span>
							</div>
							<div class="flex flex-col space-y-2 sm:flex-row sm:space-y-0 sm:space-x-2">
								<button
									on:click={() => startEditing(booking.id)}
									class="rounded-md bg-blue-500 px-3 py-1.5 text-sm text-white hover:bg-blue-600"
								>
									Edit
								</button>
								<button
									on:click={() => cancelBooking(booking.id)}
									class="rounded-md bg-red-500 px-3 py-1.5 text-sm text-white hover:bg-red-600"
								>
									Cancel
								</button>
							</div>
						</div>
					{/if}
				</div>
			{/each}
		</div>
	{/if}
</div>
