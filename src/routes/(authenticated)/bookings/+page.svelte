<script lang="ts"</script>

<div class="container">
	<h2 class="mb-4 text-2xl font-bold">My Booked Events</h2>

	{#if loading}
		<p>Loading your bookings...</p>
	{:else if bookings.length === 0}
		<p>No bookings found.</p>
	{:else}
		<div class="space-y-4">
			{#each bookings as booking}
				<div class="flex items-center justify-between rounded-md bg-gray-100 p-4">
					<div>
						<h3 class="text-lg font-semibold">{booking.eventName}</h3>
						<p class="text-sm text-gray-600">📅 {booking.date} | 📍 {booking.location}</p>
					</div>
					<button
						on:click={() => cancelBooking(booking.id)}
						class="rounded-md bg-red-500 px-4 py-2 text-white hover:bg-red-600"
					>
						Cancel
					</button>
				</div>
			{/each}
		</div>
	{/if}
</div>

<style>
	.container {
		@apply mx-auto max-w-3xl rounded-lg bg-white p-6 shadow-lg;
	}
</style>
