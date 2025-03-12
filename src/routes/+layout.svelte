<script lang="ts">
	import '../app.css';
	import Logo from '$lib/logo.svelte';
	import Button from '$lib/button.svelte';

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
						<Button color="transparent" href="/" text="Home" />
						<Button color="transparent" href="/events" text="Events" />
						<Button color="transparent" href="/about" text="About" />
						<Button color="transparent" href="/contact" text="Contact" />
					</nav>
				</div>
				<div class="hidden items-center space-x-4 md:flex">
					{#if data.session != null && data.session.id !== null}
						<Button
							href="/logout"
							text="Log Out, {capitalizeFirstLetter(data.user?.username || '')}"
						/>
						<Button href="/settings" text="settings" color="indigo" />
					{:else}
						<Button href="/login" text="Log In" />
						<Button href="/register" text="register" color="indigo" />
					{/if}
				</div>
			</div>
		</div>
	</header>
	{@render children()}
</div>
