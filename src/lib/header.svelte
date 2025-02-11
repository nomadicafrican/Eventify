<script lang="ts">
    import SearchBar from "$lib/searchBar.svelte";
    import LoginOutButton from "./login-outButton.svelte";
    import Logo from "./logo.svelte";
</script>

<div
    class="container mx-auto p-3 bg-slate-50 shadow-md max-w-full  join flex flex-row gap-2"
>
    <Logo />
    <SearchBar />
    <LoginOutButton />
</div>