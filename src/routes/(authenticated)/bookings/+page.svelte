<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { browser } from '$app/environment';

	// Import types but don't directly import Leaflet (will do that in onMount)
	import type { Map as LeafletMap, Marker, Icon, LatLngExpression } from 'leaflet';

	// Types for our location data
	interface Location {
		id: number;
		name: string;
		lat: number;
		lng: number;
		description?: string;
	}

	// Sample data for Paris locations
	const locations: Location[] = [
		{
			id: 1,
			name: 'Musée du Louvre',
			lat: 48.8606,
			lng: 2.3376,
			description:
				'Found something more I bite it tail. Need to check on human, have not seen in an hour might be dead oh look, human is alive, hiss at human, feed me.'
		},
		{ id: 2, name: 'Eiffel Tower', lat: 48.8584, lng: 2.2945 },
		{ id: 3, name: 'Notre-Dame', lat: 48.853, lng: 2.3499 },
		{ id: 4, name: 'Sacré-Cœur', lat: 48.8867, lng: 2.3431 },
		{ id: 5, name: 'Centre Pompidou', lat: 48.8606, lng: 2.3522 }
	];

	// Filter state
	let searchQuery = 'Paris';
	let selectedLocation = 'Paris, France';
	let selectedDistance = '';
	let selectedPrice = '';

	// Location options
	const locationOptions = [
		{ value: 'Paris, France', label: 'Paris, France' },
		{ value: 'Paris, USA', label: 'Paris, USA' },
		{ value: 'Paris, Canada', label: 'Paris, Canada' },
		{ value: 'Paris, Mexico', label: 'Paris, Mexico' }
	];

	// Distance options
	const distanceOptions = [
		{ value: '500', label: 'Less than 500 m' },
		{ value: '1000', label: '500m - 1km' },
		{ value: '5000', label: '1km - 5km' },
		{ value: '5000+', label: '5km and more' }
	];

	// Price options
	const priceOptions = [
		{ value: '10', label: 'Less than $10' },
		{ value: '10-30', label: '$10 - $30' },
		{ value: '30-50', label: '$30 - $50' },
		{ value: '50+', label: '$50 and more' }
	];

	// Selected location for detail view
	let selectedVenue: Location | null = null;

	// Map references
	let mapElement: HTMLElement;
	let map: LeafletMap;
	let markers: Marker[] = [];
	let defaultIcon: Icon;
	let selectedIcon: Icon;

	onMount(async () => {
		if (!browser) return;

		// Dynamically import Leaflet (client-side only)
		const leaflet = await import('leaflet');

		// Import Leaflet CSS
		const leafletCss = document.createElement('link');
		leafletCss.rel = 'stylesheet';
		leafletCss.href = 'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css';
		document.head.appendChild(leafletCss);

		// Initialize map
		map = leaflet.map(mapElement).setView([48.8566, 2.3522], 13);

		// Add OpenStreetMap tiles
		leaflet
			.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
				attribution:
					'&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
			})
			.addTo(map);

		// Create custom icons
		defaultIcon = leaflet.icon({
			iconUrl: '/marker-red.png', // Add this image to your static folder
			iconSize: [25, 41],
			iconAnchor: [12, 41],
			popupAnchor: [1, -34]
		});

		selectedIcon = leaflet.icon({
			iconUrl: '/marker-purple.png', // Add this image to your static folder
			iconSize: [25, 41],
			iconAnchor: [12, 41],
			popupAnchor: [1, -34]
		});

		// Add markers for each location
		locations.forEach((location) => {
			const coords: LatLngExpression = [location.lat, location.lng];
			const marker = leaflet
				.marker(coords, { icon: defaultIcon })
				.addTo(map)
				.on('click', () => selectVenue(location));

			markers.push(marker);
		});
	});

	onDestroy(() => {
		if (browser && map) {
			map.remove();
		}
	});

	function handleSearch() {
		console.log('Searching with query:', searchQuery);
		// Would normally trigger API call or filter existing data
	}

	function selectVenue(venue: Location) {
		selectedVenue = venue;

		// Update marker icons
		if (browser && map && markers.length) {
			markers.forEach((marker, i) => {
				const icon = locations[i].id === venue.id ? selectedIcon : defaultIcon;
				marker.setIcon(icon);
			});

			// Center map on selected venue
			map.setView([venue.lat, venue.lng], 14);
		}
	}
</script>

<svelte:head>
	<!-- Required for using Leaflet icons -->
	<style>
		.leaflet-default-icon-path {
			background-image: url('https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png');
		}
	</style>
</svelte:head>

<div class="flex flex-col min-h-screen bg-white">
	<!-- Header with gradient - consistent with your app design -->
	<header class="bg-gradient-to-br from-purple-600 to-indigo-700 p-6 text-white">
		<div class="max-w-7xl mx-auto">
			<h1 class="text-3xl sm:text-4xl font-bold mb-2">Discover</h1>
			<p class="text-lg sm:text-xl">Find and book amazing events near you.</p>
		</div>
	</header>

	<!-- Main content area -->
	<main class="flex-grow p-4 sm:p-6 max-w-7xl mx-auto w-full">
		<div class="flex flex-col lg:flex-row gap-6">
			<!-- Filters section - styled like your event cards -->
			<div class="lg:w-1/4">
				<div class="bg-white rounded-lg shadow-md p-4">
					<h2 class="text-xl font-semibold mb-4">Filters</h2>

					<!-- Search input -->
					<div class="mb-6">
						<div class="relative">
							<input
								type="text"
								bind:value={searchQuery}
								placeholder="Search locations..."
								class="w-full px-4 py-2 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-purple-500"
							/>
							<button
								class="absolute right-2 top-2 text-gray-400 hover:text-purple-600"
								on:click={handleSearch}
								aria-label="Search"
							>
								<svg
									xmlns="http://www.w3.org/2000/svg"
									class="h-5 w-5"
									fill="none"
									viewBox="0 0 24 24"
									stroke="currentColor"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										stroke-width="2"
										d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
									/>
								</svg>
							</button>
						</div>
					</div>

					<!-- Location filter -->
					<div class="mb-6">
						<h3 class="font-medium mb-2">Location</h3>
						<div class="space-y-2">
							{#each locationOptions as option}
								<div class="flex items-center">
									<input
										type="radio"
										id={`location-${option.value}`}
										name="location"
										value={option.value}
										bind:group={selectedLocation}
										class="h-4 w-4 text-purple-600 focus:ring-purple-500"
									/>
									<label for={`location-${option.value}`} class="ml-2 text-sm text-gray-700">
										{option.label}
									</label>
								</div>
							{/each}
						</div>
					</div>

					<!-- Distance filter -->
					<div class="mb-6">
						<h3 class="font-medium mb-2">Distance</h3>
						<div class="space-y-2">
							{#each distanceOptions as option}
								<div class="flex items-center">
									<input
										type="radio"
										id={`distance-${option.value}`}
										name="distance"
										value={option.value}
										bind:group={selectedDistance}
										class="h-4 w-4 text-purple-600 focus:ring-purple-500"
									/>
									<label for={`distance-${option.value}`} class="ml-2 text-sm text-gray-700">
										{option.label}
									</label>
								</div>
							{/each}
						</div>
					</div>

					<!-- Price filter -->
					<div class="mb-4">
						<h3 class="font-medium mb-2">Price</h3>
						<div class="space-y-2">
							{#each priceOptions as option}
								<div class="flex items-center">
									<input
										type="radio"
										id={`price-${option.value}`}
										name="price"
										value={option.value}
										bind:group={selectedPrice}
										class="h-4 w-4 text-purple-600 focus:ring-purple-500"
									/>
									<label for={`price-${option.value}`} class="ml-2 text-sm text-gray-700">
										{option.label}
									</label>
								</div>
							{/each}
						</div>
					</div>
				</div>
			</div>

			<!-- Map and venue details section -->
			<div class="lg:w-3/4 flex flex-col">
				<!-- Map container -->
				<div bind:this={mapElement} class="h-96 w-full rounded-lg shadow-md mb-6 bg-gray-100"></div>

				<!-- Selected venue details - styled like your event cards -->
				{#if selectedVenue}
					<div class="bg-white rounded-lg shadow-md p-6">
						<h2 class="text-2xl font-bold mb-2">{selectedVenue.name}</h2>
						<p class="text-gray-600 mb-4">
							{selectedVenue.description ||
								'Found something more I bite it tail. Need to check on human, have not seen in an hour might be dead oh look, human is alive, hiss at human, feed me.'}
						</p>
						<div
							class="flex flex-col sm:flex-row sm:justify-between items-start sm:items-center mt-6"
						>
							<a
								href={`/events?venue=${selectedVenue.id}`}
								class="px-6 py-3 bg-purple-600 text-white font-medium rounded-lg shadow-md hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-opacity-50 transition duration-200"
							>
								Book
							</a>
						</div>
					</div>
				{/if}
			</div>
		</div>
	</main>
</div>
