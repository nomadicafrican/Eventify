<script>
	let { text = 'Sign In', href = '/login' } = $props();
</script>

{#if href === '/login'}
	<a {href} class="text-base font-medium text-gray-700 hover:text-gray-900">{text}</a>
{:else}
	<a {href} class="text-base font-medium text-gray-700 hover:text-gray-900" data-sveltekit-reload>{text}</a>
{/if}