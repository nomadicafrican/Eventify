<script>
	let { text = 'Sign In', href = '/login' } = $props();
</script>

<a {href} class="text-base font-medium text-gray-700 hover:text-gray-900">{text}</a>
