<script lang="ts">
	import '../app.css';
	import Logo from '$lib/logo.svelte';
	import LoginOutButton from '$lib/login-outButton.svelte';

	let { children, data } = $props();

	function capitalizeFirstLetter(str: String): String {
		return String(str).charAt(0).toUpperCase() + String(str).slice(1);
	}
</script>

<div>
	<!-- Navigation/Header (Consistent with Homepage) -->
	<header class="bg-white shadow">
		<div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
			<div class="flex items-center justify-between py-6">
				<div class="flex items-center">
					<!-- Bigger Logo with proper spacing -->
					<div class="mr-10">
						<Logo />
					</div>
					<nav class="hidden space-x-10 md:flex">
						<a href="/" class="text-base font-medium text-gray-700 hover:text-gray-900">Home</a>
						<a href="/events" class="text-base font-medium text-gray-700 hover:text-gray-900"
							>Events</a
						>
						<a href="/about" class="text-base font-medium text-gray-700 hover:text-gray-900"
							>About</a
						>
						<a href="/contact" class="text-base font-medium text-gray-700 hover:text-gray-900"
							>Contact</a
						>
					</nav>
				</div>
				<div class="hidden items-center space-x-4 md:flex">
					{#if data.session != null && data.session.id !== null}
						<LoginOutButton
							href="/logout"
							text="Log Out, {capitalizeFirstLetter(data.user?.username || '')}"
						/>
						<a
							href="/settings"
							class="inline-flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-6 py-3 text-base font-medium whitespace-nowrap text-white shadow-sm hover:bg-indigo-700"
						>
							Settings
						</a>
					{:else}
						<LoginOutButton href="/login" text="Log In" />
						<a
							href="/register"
							class="inline-flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-6 py-3 text-base font-medium whitespace-nowrap text-white shadow-sm hover:bg-indigo-700"
						>
							Register
						</a>
					{/if}
				</div>
			</div>
		</div>
	</header>
	{@render children()}
</div>
