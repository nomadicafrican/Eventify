<script lang="ts">
	import { enhance } from '$app/forms';
	// import { invalidate } from '$app/navigation';
	import { onMount } from 'svelte';
	import type { PageProps } from './$types';

	type User = {
		id: number;
		username: string;
		email: string;
		profilePicture: string;
	};

	let { data }: PageProps = $props();

	const userInitState: User = {
		id: 0,
		email: '',
		username: '',
		profilePicture: ''
	};

	const sessionsInitState: String[] = [];

	let user = $state(userInitState);
	let sessionsList = $state(sessionsInitState);
	let newPassword = $state();
	let confirmPassword = $state();
	const curSession = data.curSession;

	$inspect(sessionsList).with((type, sessionsList) => {
		if (type === 'update') {
			console.log('SessionsList Updated:', sessionsList);
			// debugger;
		}
	});

	onMount(() => {
		user = {
			id: data.user?.id || 0,
			username: data.user?.username || '',
			email: data.user?.email || '',
			profilePicture: 'https://i.pravatar.cc/100'
		};
		data.sessions.forEach((session) => {
			sessionsList.push(session[0]);
		});
	});
</script>

<div
	class="flex min-h-screen items-center justify-center bg-gradient-to-br from-purple-500 to-blue-500"
>
	<div class="w-full max-w-md rounded-lg bg-white p-6 shadow-lg">
		<h2 class="mb-4 text-center text-2xl font-semibold">Account Settings</h2>

		<!-- Profile Info -->
		<div class="mb-4 text-center">
			<img
				class="mx-auto h-20 w-20 rounded-full border-2 border-gray-300"
				src={user.profilePicture}
				alt="Profile"
			/>
			<p class="mt-2 font-semibold">{user.username}</p>
			<p class="text-sm text-gray-500">{user.email}</p>
		</div>

		<!-- Update Profile Form -->
		<form method="POST" action="?/updateProfile" use:enhance>
			<input type="hidden" name="action" value="updateProfile" />

			<label for="username" class="block text-sm font-medium text-gray-700">Name</label>

			<input
				type="text"
				id="username"
				name="name"
				bind:value={user.username}
				class="mt-1 w-full rounded-md border-gray-300 p-2"
			/>

			<label for="email" class="mt-4 block text-sm font-medium text-gray-700">Email</label>
			<input
				type="email"
				name="email"
				id="email"
				bind:value={user.email}
				class="mt-1 w-full rounded-md border-gray-300 p-2"
			/>

			<button class="mt-4 w-full rounded-md bg-purple-600 py-2 text-white hover:bg-purple-700">
				Update Profile
			</button>
		</form>

		<!-- Change Password Form -->
		<h3 class="mt-6 text-lg font-semibold">Change Password</h3>
		<form method="POST" action="?/updatePassword" use:enhance>
			<input type="hidden" name="action" value="updatePassword" />

			<input
				type="password"
				name="newPassword"
				placeholder="New Password"
				bind:value={newPassword}
				class="mt-2 w-full rounded-md border-gray-300 p-2"
			/>

			<input
				type="password"
				name="confirmPassword"
				placeholder="Confirm Password"
				bind:value={confirmPassword}
				class="mt-2 w-full rounded-md border-gray-300 p-2"
			/>

			<button class="mt-4 w-full rounded-md bg-blue-600 py-2 text-white hover:bg-blue-700">
				Update Password
			</button>
		</form>

		<!-- Active Sessions -->
		<h3 class="mt-6 text-lg font-semibold">Active Sessions</h3>
		<div class="mt-2 space-y-2">
			{#each sessionsList as session}
				{#if curSession !== session}
					<form method="POST" action="?/logoutSession" use:enhance>
						<input type="hidden" name="sessionId" value={session} />

						<div class="flex items-center justify-between rounded-md bg-gray-100 p-2">
							<button class="text-red-500 hover:underline">
								Logout from {session || 'UNKNOWN ERROR'}
							</button>
						</div>
					</form>
				{/if}
			{/each}
		</div>

		<!-- Delete Account -->
		<h3 class="mt-6 text-lg font-semibold text-red-600">Danger Zone</h3>
		<form method="POST" action="?/deleteAccount" use:enhance>
			<input type="hidden" name="action" value="deleteAccount" />
			<button class="mt-2 w-full rounded-md bg-red-600 py-2 text-white hover:bg-red-700">
				Delete Account
			</button>
		</form>
	</div>
</div>
