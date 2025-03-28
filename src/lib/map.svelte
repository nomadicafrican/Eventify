<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import type { Map as LeafletMap, TileLayer, LatLngExpression } from 'leaflet';

	// --- Props ---
	// You can make these props to configure the map from outside
	export let center: LatLngExpression = [51.505, -0.09]; // Default: London
	export let zoom: number = 13;
	export let mapId: string = 'map-id'; // Unique ID for the map container

	// --- Component State ---
	let mapContainer: HTMLDivElement; // Reference to the div element for the map
	let mapInstance: LeafletMap | null = null; // Holds the Leaflet map instance

	onMount(async () => {
		// IMPORTANT: Leaflet relies on browser APIs (window, document).
		// We must ensure it only runs on the client-side.
		// We use a dynamic import inside onMount for this.
		if (typeof window !== 'undefined') {
			const L = await import('leaflet');

			// Check if the container element is available
			if (!mapContainer) {
				console.error('Map container element not found!');
				return;
			}

			// Prevent re-initialization if component re-renders without destroying
			if (mapInstance) {
				return;
			}

			// Initialize the map
			mapInstance = L.map(mapContainer).setView(center, zoom);

			// Add a tile layer (OpenStreetMap is a common free choice)
			L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
				attribution:
					'&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
			}).addTo(mapInstance);

			// --- Optional: Add other map features ---
			// Example: Add a marker
			L.marker(center).addTo(mapInstance).bindPopup('Hello from Leaflet!');

			// You can add more layers, event listeners, etc. here
			// mapInstance.on('click', (e) => {
			//   console.log(`Map clicked at: ${e.latlng}`);
			// });
		}
	});

	onDestroy(() => {
		// Clean up the map instance when the component is destroyed
		// This prevents memory leaks
		if (mapInstance) {
			mapInstance.remove();
			mapInstance = null; // Clear the reference
			console.log('Leaflet map instance removed.');
		}
	});
</script>

<!-- Leaflet CSS - Make sure this is imported -->
<!-- You could also import this globally in your main layout or app.css -->
<svelte:head>
	<link
		rel="stylesheet"
		href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
		integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
		crossorigin=""
	/>
</svelte:head>

<!-- The container div for the map -->
<!-- bind:this connects the div element to the mapContainer variable -->
<!-- Make sure the container has a defined height! -->
<div bind:this={mapContainer} id={mapId} class="map-container"></div>

<style>
	/* --- CRITICAL: Set a height for the map container --- */
	.map-container {
		height: 400px; /* Or any desired height */
		width: 100%;
		border: 1px solid #ccc; /* Optional: just to see the container */
	}

	/* --- Optional: Import Leaflet CSS here instead of <svelte:head> --- */
	/* @import 'leaflet/dist/leaflet.css'; */
	/* If you install leaflet locally and import here, ensure your bundler (Vite) handles it */

	/* --- Fix potential issues with map tiles/popups if needed --- */
	/* :global(.leaflet-popup-content-wrapper),
  :global(.leaflet-popup-tip) {
     background: white;
     color: #333;
     box-shadow: 0 3px 14px rgba(0,0,0,0.4);
  } */
</style>
