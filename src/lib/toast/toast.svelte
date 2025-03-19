<script lang="ts">
	import { fade } from 'svelte/transition';
	import SuccessIcon from './successIcon.svelte';
	import ErrorIcon from './errorIcon.svelte';
	import InfoIcon from './infoIcon.svelte';
	import CloseIcon from './closeIcon.svelte';

	const type = 'error';
	const dismissible = true;
	const { text } = $props();

	let element;
</script>

<article bind:this={element} class={type} role="alert" in:fade={{ duration: 200 }}>
	{#if type === 'success'}
		<SuccessIcon width="1.1em" />
	{:else if type === 'error'}
		<ErrorIcon width="1.1em" />
	{:else}
		<InfoIcon width="1.1em" />
	{/if}

	<div class="text">
		{@render text()}
	</div>

	{#if dismissible}
		<button class="close" onclick={() => text()}>
			<CloseIcon width="0.8em" />
		</button>
	{/if}
</article>

<style>
	article {
		color: white;
		padding: 0.75rem 1.5rem;
		border-radius: 0.2rem;
		display: flex;
		align-items: center;
		margin: 0 auto 0.5rem auto;
		width: 20rem;
	}
	.error {
		background: IndianRed;
	}
	.success {
		background: MediumSeaGreen;
	}
	.info {
		background: SkyBlue;
	}
	.text {
		margin-left: 1rem;
	}
	button {
		color: white;
		background: transparent;
		border: 0 none;
		padding: 0;
		margin: 0 0 0 auto;
		line-height: 1;
		font-size: 1rem;
	}
</style>
