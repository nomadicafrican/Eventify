<script>
  let { text = "Sign In", href = "/login" } = $props();
</script>

<a href={href}>
  <button
    class="transition-shadow ease-linear duration-75 border rounded-2xl items-center bg-white w-full border-slate-400 mr-3 hover:shadow-md active:shadow-inner"
  >
    <p class="p-2 px-7">{text}</p>
  </button>
</a>