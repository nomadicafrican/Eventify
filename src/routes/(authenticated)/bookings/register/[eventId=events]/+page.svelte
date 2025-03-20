<script lang="ts">
  import { enhance } from '$app/forms';
  import type { PageProps } from './$types';

  // Data from your load function
  let { data, form }: PageProps = $props();

  // Extract fields for convenience
  const { eventResult, venue, schedule, numBookings } = data;

  // If the event has a max_attendees > 0, compute participant ratio or default to 0
  const participantInfo = eventResult?.max_attendees
    ? `${numBookings}/${eventResult.max_attendees} participants`
    : `${numBookings} participants`;

  // We'll store "1" as the default numberOfPeople in a hidden input, 
  // or you can change this logic as needed.
  const defaultNumPeople = 1;

  // Provide a placeholder for your map or actual map integration
  const mapPlaceholderText = 'Map goes here';
</script>

<!-- Outer gradient background -->
<div class="min-h-screen bg-gradient-to-br from-purple-500 to-blue-500 py-8 px-4 text-gray-800">
  <!-- Main white container for the page content -->
  <div class="mx-auto max-w-6xl bg-white rounded-lg shadow-lg p-6">
    <!-- Two-column layout -->
    <div class="flex flex-col md:flex-row gap-8">
      <!-- Left column -->
      <div class="flex-1">
        <!-- Centered event title and subtitle -->
        <h1 class="text-3xl font-bold text-purple-700 text-center">
          {eventResult?.name ?? 'Event Name'}
        </h1>
        <p class="text-gray-500 mt-1 mb-6 text-center">
          {eventResult?.subtitle ?? 'Event Subtitle'}
        </p>

        <!-- Map placeholder (or embed an actual map) -->
        <div class="flex items-center justify-center w-full h-64 bg-gray-200 rounded">
          <span class="text-gray-500">{mapPlaceholderText}</span>
        </div>
      </div>

      <!-- Right column: heading, Book form, participant count -->
      <div class="flex-1 flex flex-col items-center justify-center">
        <!-- Heading above the book button -->
        <h2 class="text-2xl font-semibold text-gray-800 mb-6">
          Attend This Event
        </h2>

        <!-- The booking form -->
        <form method="POST" use:enhance class="mb-6">
          <!-- Hidden inputs for minimal user interaction -->
          <input type="hidden" name="numPeople" value={defaultNumPeople} />
          <input type="hidden" name="event" value={JSON.stringify(eventResult)} />
          <input type="hidden" name="venue" value={JSON.stringify(venue)} />

          <!-- Book button -->
          <button
            type="submit"
            class="px-6 py-3 text-lg rounded bg-green-500 text-white font-semibold hover:bg-green-600 transition"
          >
            Book
          </button>

          <!-- If form submission fails, show the error message -->
          {#if form?.message}
            <p class="mt-3 text-red-600">{form.message}</p>
          {/if}
        </form>

        <!-- Participant count in a pill-like shape -->
        <div class="px-4 py-2 rounded-full bg-gray-200 text-gray-800 text-sm font-medium">
          {participantInfo}
        </div>
      </div>
    </div>
  </div>
</div>
