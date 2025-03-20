<script lang="ts">
  import type { PageProps } from './$types';

  let { data }: PageProps = $props();

  // If the event has a max_attendees > 0, compute booking percentage; otherwise default to 0.
  const bookingPercentage = data.event?.max_attendees
    ? Math.round((data.numBookings / data.event.max_attendees) * 100)
    : 0;

  // Example subtitle fallback
  const eventSubtitle = data.event.subtitle ?? 'Event Subtitle';
</script>

<!-- 
  Gradient background 
  Note: Adjust padding or margin to fit your global layout 
-->
<div class="min-h-screen bg-gradient-to-br from-purple-500 to-blue-500 py-10 px-4 text-gray-800">
  <!-- Main container card -->
  <div class="mx-auto max-w-6xl bg-white rounded-lg shadow-lg p-6">
    <!-- Top bar: search + sign out -->
    <div class="flex items-center justify-between mb-6">
      <!-- Search field -->
      
    </div>

    <!-- Event Title & Subtitle -->
    <div class="text-center mb-10">
      <h1 class="text-4xl font-bold text-purple-700">
        {data.event.name ?? 'Event Name'}
      </h1>
      <p class="text-gray-500 mt-1">
        {eventSubtitle}
      </p>
    </div>

    <!-- Core Layout: Map on left, Info on right -->
    <div class="flex flex-col md:flex-row gap-8">
      <!-- Left column: Map placeholder -->
      <div class="flex-1">
        <div class="flex items-center justify-center w-full h-64 bg-gray-200 rounded">
          <!-- Replace with real map if desired -->
          <span class="text-gray-500">Map goes here</span>
        </div>
      </div>

      <!-- Right column: description, progress bar, tags, and buttons -->
      <div class="flex-1">
        <!-- Example text or dynamic text from your data -->
        <p class="text-gray-700 mb-4">
          Found something once I read. Need to check on humans; have not seen them in an hour
          might be dead oh no human. Well, it is a human, feed me. I'm so hungry, but never out of
          luck. Just here for the pet, pet the pit, pet the tail. In summary, we are just chilling.
        </p>

        <!-- Additional event info: user, date, venue (optional if you have these fields) -->
        {#if data.user}
          <p class="text-gray-800 mb-2">
            Organized by: <strong>{data.user.username}</strong>
          </p>
        {/if}
        <p class="text-gray-800 mb-2">
          Date: <strong>{data.event.event_date}</strong>
        </p>
        <p class="text-gray-800 mb-6">
          Venue:
          <a
            class="text-indigo-600 hover:underline"
            href={`/venues/${data.venue.id}`}
            >{data.venue.name}</a
          >
        </p>

        <!-- Attendee progress display -->
        <div class="text-center text-xl font-semibold text-gray-700 mb-2">
          {data.numBookings}/{data.event.max_attendees} participants
        </div>
        <div class="relative w-full h-3 mb-6 bg-gray-300 rounded-full">
          <div
            class="absolute left-0 top-0 h-3 bg-indigo-600 rounded-full transition-all duration-300"
            style="width: {bookingPercentage}%;"
          ></div>
        </div>

        <!-- Category tags row (static placeholders; replace or loop dynamically) -->
        <div class="flex flex-wrap gap-2 mb-6">
          <span class="px-3 py-1 bg-gray-200 rounded-full text-sm text-gray-700 hover:bg-indigo-100 cursor-pointer">
            Sports
          </span>
          <span class="px-3 py-1 bg-gray-200 rounded-full text-sm text-gray-700 hover:bg-indigo-100 cursor-pointer">
            Leisure
          </span>
          <span class="px-3 py-1 bg-gray-200 rounded-full text-sm text-gray-700 hover:bg-indigo-100 cursor-pointer">
            Classes
          </span>
          <span class="px-3 py-1 bg-gray-200 rounded-full text-sm text-gray-700 hover:bg-indigo-100 cursor-pointer">
            Concerts
          </span>
          <span class="px-3 py-1 bg-gray-200 rounded-full text-sm text-gray-700 hover:bg-indigo-100 cursor-pointer">
            Networking
          </span>
          <span class="px-3 py-1 bg-gray-200 rounded-full text-sm text-gray-700 hover:bg-indigo-100 cursor-pointer">
            Trivia
          </span>
          <span class="px-3 py-1 bg-gray-200 rounded-full text-sm text-gray-700 hover:bg-indigo-100 cursor-pointer">
            Add Your Own...
          </span>
        </div>

        <!-- Action buttons -->
        <div class="flex flex-wrap gap-4">
          <!-- Cancel -> Link to /events -->
          <a
            href="/events"
            class="px-4 py-2 rounded border border-gray-300 text-gray-700 hover:bg-gray-100 transition"
          >
            Cancel
          </a>
          <!-- Register -->
          <a
            class="px-4 py-2 rounded bg-indigo-600 text-white hover:bg-indigo-700 transition"
            href={`/bookings/register/${data.event.id}`}
            >Register</a
          >
        </div>
      </div>
    </div>
  </div>
</div>
