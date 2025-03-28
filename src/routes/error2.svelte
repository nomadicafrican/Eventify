<script lang="ts">
	import { assets } from '$app/paths';
	import { page as data } from '$app/state';

	const poohPhrase = 'Oh bother, someone stole my honey!';
</script>

<div
	class="min-h-screen flex flex-col items-center justify-center bg-gradient-to-br from-purple-600 to-indigo-700 text-center p-6 text-white"
>
	<div class="max-w-lg w-full">
		{#if data.status === 404}
			<h1 class="text-5xl sm:text-6xl font-bold text-white mb-2">Error 404</h1>
			<img
				src="{assets}/winnie-the-pooh-disappointed.gif"
				alt="Winnie the Pooh looking puzzled"
				class="w-48 h-auto mx-auto mb-8 sm:w-64"
				width="256"
				height="256"
			/>
			<h2 class="text-xl sm:text-2xl font-semibold text-indigo-100 mb-4">Page Not Found</h2>
			<p class="text-3xl sm:text-4xl text-purple-200 mb-5">
				{poohPhrase}
			</p>
			<p class="text-indigo-100 mb-8">
				It seems the page you were looking for has wandered off, perhaps in search of a honey pot.
			</p>
		{:else}
			<h1 class="text-4xl sm:text-5xl font-bold text-white mb-2">
				Error {data.status}
			</h1>
			<img
				src="{assets}/winnie-the-pooh-disappointed.gif"
				alt="Winnie the Pooh looking puzzled"
				class="w-48 h-auto mx-auto mb-8 sm:w-64"
				width="256"
				height="256"
			/>
			<p class="text-2xl sm:text-3xl text-purple-200 mb-5">{poohPhrase}</p>
			<p class="text-indigo-100 mb-8">
				Something went wrong.
				{#if data.error?.message}
					({data.error.message})
				{/if}
			</p>
		{/if}
		<a
			href="/"
			class="inline-block px-6 py-3 bg-purple-600 text-white font-medium rounded-lg shadow-md hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-opacity-50 transition duration-200 ease-in-out"
		>
			Go Back Home
		</a>
	</div>
</div>
