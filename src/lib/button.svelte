<script lang="ts">
	let { text = 'Sign In', href = '/login', color = 'grey' } = $props();

	const colors: { [key: string]: string } = {
		grey: 'text-gray-700 hover:bg-gray-50 hover:inset-shadow-gray-300 bg-white hover:delay-150 duration-300 shadow-sm',
		indigo:
			'bg-indigo-600 shadow-indigo700/30 hover:bg-indigo-700/[95%] hover:inset-shadow-indigo-950 border border-transparent text-white hover:delay-150 duration-300 shadow-sm',
		transparent:
			'bg-white text-gray-700 ring-1 ring-transparent duration-250 hover:ring-indigo-300 hover:inset-shadow-indigo-100 inset-shadow-sm shadow-xs shadow-indigo-100 hover:shadow-transparent'
	};
</script>

{#if href !== '/logout'}
	<a
		{href}
		class="
      inline-flex items-center justify-center rounded-md
      px-6 py-3 text-base font-medium whitespace-nowrap
      inset-shadow-sm inset-shadow-transparent
      transition ease-out hover:shadow-transparent
      {`${colors[color]} ...`}
    ">{text}</a
	>
{:else}
	<a
		{href}
		class="
      inline-flex items-center justify-center rounded-md
      px-6 py-3 text-base font-medium whitespace-nowrap
      inset-shadow-sm inset-shadow-transparent
      transition ease-out hover:shadow-transparent
      {`${colors[color]} ...`}
    "
		data-sveltekit-reload>{text}</a
	>
{/if}
