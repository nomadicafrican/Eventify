<script lang='ts'>
  import { Search16 } from "svelte-octicons";

  var data = $state("");
  let searchButtonElement = $state();

  const search = () => {
    if (data.trim() == "") { 
      return; 
    }

    const searchButton = (searchButtonElement as unknown) as HTMLButtonElement;
    searchButton.disabled = false;
  };
</script>

<form
  class="relative block w-full mx-auto content-center"
  method="GET"
  action="/search?q={data}"
>
  <input
    bind:value={data}
    type="text"
    class="w-full bg-white placeholder:font-italitc border border-slate-400 rounded-2xl focus:outline-none h-10 placeholder:align-middle placeholder:-translate-y-0.5"
    placeholder="  Search&hellip;"
    name="q"
    oninput={search}
    required
  />
  <button
    class="absolute inset-y-0 right-0 flex items-center pr-3 fill-purple-700"
    type="submit"
    disabled
    bind:this={searchButtonElement}
  >
    <Search16 class="rounded-full" />
  </button>
</form>
