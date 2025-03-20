<script lang="ts">
	let { isOpen = false, title } = $props();

	function closeModal() {
		isOpen = false;
	}

	function handleClickOutside(event) {
		if (isOpen && !event.target.closest('.modal')) {
			closeModal();
		}
	}
</script>

{#if isOpen}
	<div class="modal-overlay">
		<div class="modal">
			<div class="modal-header">
				<h2>{title}</h2>
				<button class="close-button" onclick={closeModal}>&times;</button>
			</div>
			<div class="modal-body">
				<div class="bg-opacity-50 fixed inset-0 z-50 flex items-center justify-center bg-black">
					<div class="overflow-hidden rounded-lg bg-white shadow-xl">
						<div class="px-6 py-4">
							<div class="flex items-center justify-center">
								<svg
									class="h-12 w-12 text-green-500"
									fill="none"
									stroke="currentColor"
									viewBox="0 0 24 24"
									xmlns="http://www.w3.org/2000/svg"
								>
									<path
										stroke-linecap="round"
										stroke-linejoin="round"
										stroke-width="2"
										d="M5 13l4 4L19 7"
									/>
								</svg>
							</div>
							<h2 class="mt-2 text-center text-2xl font-semibold text-gray-800">
								Booking Change Successful!
							</h2>
							<p class="mt-2 text-center text-gray-600">
								Your booking has been successfully updated.
							</p>
						</div>
						<div class="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
							<button
								type="button"
								class="inline-flex w-full justify-center rounded-md border border-transparent bg-green-600 px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-green-700 focus:ring-2 focus:ring-green-500 focus:ring-offset-2 focus:outline-none sm:ml-3 sm:w-auto sm:text-sm"
							>
								OK
							</button>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button onclick={closeModal}>Close</button>
			</div>
		</div>
	</div>
{/if}

<svelte:window on:click={handleClickOutside} />
