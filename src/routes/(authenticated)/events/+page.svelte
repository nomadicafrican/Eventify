<script lang="ts">
	import type { PageProps } from './$types';
	let { data }: PageProps = $props();
</script>

<!-- Page container with neutral background -->
<div class="min-h-screen bg-gray-100">
  <!-- Header Section -->
  <header class="py-12 bg-gradient-to-r from-purple-600 to-blue-600">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <h1 class="text-4xl font-bold text-white">Upcoming Events</h1>
      <p class="mt-4 text-lg text-gray-100">
        Discover and book the most exciting events with ease.
      </p>
    </div>
  </header>

  <!-- Grid Container for Event Cards -->
  <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-8">
    <div class="grid gap-8 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
      {#each data.events as event}
        <a
          href={`/events/${event.id}`}
          title={`${Math.round(event.attendees!)}/${Math.round(event.max_attendees)} attendees`}
          class="block bg-white rounded-lg shadow-lg hover:shadow-2xl transition transform hover:-translate-y-1"
        >
          <div class="p-6">
            <!-- Event Title -->
            <h2 class="text-2xl font-bold text-gray-900">{event.name}</h2>
            <!-- Event Date -->
            <p class="mt-2 text-gray-600">
              Date: {new Date(event.event_date).toLocaleDateString()}
            </p>
            <!-- Venue -->
            <p class="mt-1 text-gray-600">Venue: {event.venue_id}</p>
            <!-- Attendees and Progress Bar -->
            <div class="mt-4">
              <div class="flex items-center justify-between text-gray-700">
                <span class="font-medium">Attendees</span>
                <span>{Math.round(event.attendees!)} / {Math.round(event.max_attendees)}</span>
              </div>
              <div class="mt-1 h-2 rounded-full bg-gray-300">
                <div
                  class="h-2 rounded-full bg-indigo-600 transition-all duration-300"
                  style="width: {Math.round(event.attendeesPercentage!)}%;"
                ></div>
              </div>
            </div>
          </div>
        </a>
      {/each}
    </div>
  </main>
</div>
