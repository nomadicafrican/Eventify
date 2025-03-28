<script lang="ts">
	import MapDisplay from '$lib/components/MapDisplay.svelte';
	import type { LatLngExpression } from 'leaflet';

	// Example: Set different initial coordinates
	const initialCenter: LatLngExpression = [40.7128, -74.006]; // New York
	const initialZoom: number = 12;
</script>

<h1>My Leaflet Map in SvelteKit</h1>

<p>Here is an interactive map:</p>

<MapDisplay center={initialCenter} zoom={initialZoom} />

<p>Map controls and tiles should appear above.</p>

<style>
	h1 {
		color: #333;
	}
	p {
		margin-bottom: 1rem;
	}
</style>
