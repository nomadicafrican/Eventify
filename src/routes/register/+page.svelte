<script lang="ts">
	import { enhance } from '$app/forms';
	import type { ActionData } from './$types';

	export let form: ActionData;
</script>

<!-- Registration Form Section -->
<div
	class="flex min-h-screen items-center justify-center bg-gradient-to-r from-indigo-500 to-purple-500 px-4"
>
	<div class="w-full max-w-md space-y-6 rounded-xl bg-white p-8 shadow-lg">
		<h1 class="text-center text-3xl font-bold text-gray-800">Register</h1>
		<p class="text-center text-gray-500">Create your new account on Eventify</p>
		<form method="post" class="space-y-4" use:enhance>
			<div>
				<label class="mb-1 block text-gray-700" for="email">Email</label>
				<input
					id="email"
					type="email"
					name="email"
					placeholder="Enter your email"
					class="w-full rounded-lg border border-gray-300 p-3 focus:ring-2 focus:ring-indigo-400 focus:outline-none"
					required
				/>
			</div>
			<div>
				<label class="mb-1 block text-gray-700" for="password">Password</label>
				<input
					id="password"
					type="password"
					name="password"
					placeholder="Enter your password"
					class="w-full rounded-lg border border-gray-300 p-3 focus:ring-2 focus:ring-indigo-400 focus:outline-none"
					required
				/>
			</div>
			<div>
				<label class="mb-1 block text-gray-700" for="passwordConfirm">Confirm Password</label>
				<input
					id="passwordConfirm"
					type="password"
					name="passwordConfirm"
					placeholder="Confirm your password"
					class="w-full rounded-lg border border-gray-300 p-3 focus:ring-2 focus:ring-indigo-400 focus:outline-none"
					required
				/>
			</div>
			<p class="text-xl text-red-700">{form?.message ?? ''}</p>
			<button
				class="w-full rounded-lg bg-indigo-600 py-3 font-semibold text-white transition-colors hover:bg-indigo-700 disabled:opacity-50"
			>
				Register
			</button>
		</form>
		<div class="text-center">
			<p class="text-gray-500">
				Already have an account?
				<a href="/login" class="text-indigo-600 hover:underline">Sign In</a>
			</p>
		</div>
	</div>
</div>
