<script lang="ts">
	let marker: Marker;

  import { browser } from '$app/environment';
  import type { PageData } from './$types';
  import VenueMap from '$lib/map.svelte';
  import type { Venue as VenueType } from '$lib/events/venues'; // Alias Venue type


// --- Props & Data ---
let { data }: PageData = $props();
let mapCenter = $state(data.initialCenter || [51.505, -0.09]);
let mapZoom = $state(data.initialZoom || 13);
let markers = $state([]);

let searchQuery = ''; // Clear default search
  let selectedLocation = '';
  let selectedDistance = '';
  let selectedPrice = '';
  
// --- Effects ---
$effect(() => {
  markers = data.events.map(event => ({
    id: event.id,
    position: [event.venue.latitude!, event.venue.longitude!],
    popupContent: `
      <div class="font-sans">
        <h3 class="font-semibold text-md mb-1">${event.name}</h3>
        <p class="text-sm text-gray-600 mb-2">${event.venue.name}</p>
        <a href="/events/${event.id}" class="text-purple-600 hover:underline text-sm">View Event</a>
      </div>
    `,
    eventName: event.name as string,
    eventLink: `/events/${event.id}`
  }));
});

function handleSearch() {
  console.log('Searching with query:', searchQuery);
  if (searchQuery.trim()) {
    window.location.href = `/search?q=${encodeURIComponent(searchQuery)}`;
  }
}

// Function to center map on event when list item is clicked
function centerOnEvent(event: EventWithVenue) {
  if (event.venue?.latitude != null && event.venue?.longitude != null) {
    mapCenter = [event.venue.latitude, event.venue.longitude];
    mapZoom = 15; // Zoom in
  }
}
// Define combined type locally if not defined globally
type EventWithVenue = EventType & { venue: VenueType };
</script>

<div style="width:100%;height:500px;">
	<div class="mb-6 rounded-lg shadow-md overflow-hidden">
		{#if browser}
			<VenueMap bind:center={mapCenter} bind:zoom={mapZoom} {markers} />
		{:else}
			<div class="h-96 w-full bg-gray-100 flex items-center justify-center text-gray-500">
				Map loading...
			</div>
		{/if}
	</div>

 <!-- Event List -->
 <div class="space-y-4">
   {#if data.events.length > 0}
     {#each data.events as event (event.id)}
       <div class="bg-white rounded-lg shadow-md p-4 flex gap-4 hover:shadow-lg transition-shadow cursor-pointer" on:click={() => centerOnEvent(event)} role="button" tabindex="0" on:keydown={(e) => e.key === 'Enter' && centerOnEvent(event)}>
         <!-- Optional Image Placeholder -->
         <div class="w-24 h-24 bg-gray-200 rounded flex-shrink-0 hidden sm:block"></div>
         <div class="flex-grow">
           <h3 class="text-lg font-semibold text-purple-700">{event.name}</h3>
           <p class="text-sm text-gray-600">{event.venue.name} - {event.venue.city}, {event.venue.state}</p>
           <p class="text-sm text-gray-500">{new Date(event.event_date).toLocaleDateString()}</p>
           <a href="/events/{event.id}" class="text-sm text-indigo-600 hover:underline mt-1 inline-block" on:click|stopPropagation>
             View Details
           </a>
         </div>
       </div>
     {/each}
   {:else}
     <p class="text-center text-gray-500 py-10">No events found matching the criteria.</p>
   {/if}
 </div>
</div>
<!-- <script lang="ts"> -->
<!-- 	// import { LeafletMap, TileLayer } from 'svelte-leafletjs'; -->
<!-- 	import type { MapOptions } from 'leaflet'; -->
<!---->
<!-- 	const mapOptions: MapOptions = { -->
<!-- 		center: [1.364917, 103.822872], -->
<!-- 		zoom: 11 -->
<!-- 	}; -->
<!-- </script> -->

<!-- <LeafletMap options={mapOptions}> -->
<!-- 	<TileLayer url={'Title'} /> -->
<!-- </LeafletMap> -->
