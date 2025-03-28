<script lang="ts">
	import { assets } from '$app/paths';
	import { page as data } from '$app/state';

	const poohPhrase = 'Oh bother, someone stole my honey!';
	const poohImagePath = assets + '/winnie-the-pooh-disappointed.gif';
</script>

<div class="min-h-screen flex flex-col items-center justify-center text-center p-6">
	<div class="max-w-lg w-full">
		{#if data.status === 404}
			<!-- 404 Specific Content -->
			<h1 class="text-5xl sm:text-6xl font-bold text-red-600 mb-2">Error 404</h1>
			<img
				src={poohImagePath}
				alt="Winnie the Pooh looking disappointed"
				class="w-48 h-auto mx-auto mb-6 sm:w-64"
				width="256"
				height="256"
			/>
			<h2 class="text-xl sm:text-2xl font-semibold text-gray-800 mb-4">Page Not Found</h2>
			<p class="text-2xl sm:text-3xl text-gray-700 italic mb-5">
				{poohPhrase}
			</p>
			<p class="text-gray-600 mb-8">
				It seems the page you were looking for has wandered off, perhaps in search of a honey pot.
			</p>
		{:else}
			<!-- Generic Error Content -->
			<h1 class="text-4xl sm:text-5xl font-bold text-red-600 mb-2">
				Error {data.status}
			</h1>
			<img
				src={poohImagePath}
				alt="Winnie the Pooh looking disappointed"
				class="w-48 h-auto mx-auto mb-6 sm:w-64"
				width="256"
				height="256"
			/>
			<p class="text-xl sm:text-2xl text-gray-700 italic mb-5">
				"{poohPhrase}"
			</p>
			<p class="text-gray-600 mb-8">
				Something went wrong.
				{#if data.error?.message}
					({data.error.message})
				{/if}
			</p>
		{/if}
	</div>
</div>
