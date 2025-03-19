<script>
	let bookingReference = $state('ABC123XYZ'); // Example reference
	let eventName = $state('Awesome Event'); // Example event
</script>

<div
	class="flex flex-col items-center justify-center bg-gradient-to-r from-indigo-500 to-purple-500 px-4"
	style="height: 100vh;"
>
	<div class="rounded bg-white p-20 outline-3 outline-green-500">
		<main class="flex flex-col items-center justify-center px-4 py-5 text-center font-sans">
			<h1 class="mb-6 text-3xl font-bold text-gray-800 md:text-4xl">Booking Confirmed!</h1>

			<p class="mb-4 text-lg text-gray-600">
				Your booking for <strong class="font-semibold text-blue-600">{eventName}</strong> is successful.
			</p>

			<p class="mb-3 text-base text-gray-500">
				Your booking reference is: <strong class="font-semibold text-green-600"
					>{bookingReference}</strong
				>
			</p>

			<p class="mb-8 text-sm text-gray-400">Check your email for details and ticket information.</p>

			<button
				class="focus:shadow-outline rounded bg-blue-500 px-4 py-2 font-bold text-white hover:bg-blue-700 focus:outline-none"
				onclick={() => alert('Go to event details')}
			>
				View Event Details
			</button>
		</main>
	</div>
</div>
