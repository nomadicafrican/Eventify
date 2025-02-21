<script lang="ts">
	import { enhance } from '$app/forms';
	import type { ActionData } from './$types';

	export let form: ActionData;
</script>

<!-- Login Form Section -->
<div
	class="flex min-h-screen items-center justify-center bg-gradient-to-r from-indigo-500 to-purple-500 px-4"
>
	<div class="w-full max-w-md space-y-6 rounded-xl bg-white p-8 shadow-lg">
		<h1 class="text-center text-3xl font-bold text-gray-800">Sign In</h1>
		<p class="text-center text-gray-500">Access your Eventify account</p>
		<form method="post" use:enhance class="space-y-4">
			<div>
				<label class="mb-1 block text-gray-700" for="form-login.email">Username</label>
				<input
					id="form-login.email"
					type="text"
					value={form?.email ?? ''}
					name="email"
					placeholder="Enter your username"
					class="w-full rounded-lg border border-gray-300 p-3 focus:ring-2 focus:ring-indigo-400 focus:outline-none"
					required
				/>
			</div>
			<div>
				<label class="mb-1 block text-gray-700" for="form-login.password">Password</label>
				<input
					id="form-login.password"
					type="password"
					name="password"
					placeholder="Enter your password"
					class="w-full rounded-lg border border-gray-300 p-3 focus:ring-2 focus:ring-indigo-400 focus:outline-none"
					required
				/>
			</div>
			<button
				class="w-full rounded-lg bg-indigo-600 py-3 font-semibold text-white transition-colors hover:bg-indigo-700"
			>
				Sign In
			</button>
			<p>{form?.message ?? ''}</p>
		</form>
		<div class="text-center">
			<p class="text-gray-500">
				Don't have an account?
				<a href="/register" class="text-indigo-600 hover:underline">Register</a>
			</p>
		</div>
	</div>
</div>
