<script>
  let user = $state("");
  let pw = $state("");
  const signUpURL = "/signup";
  const loginPostURL = "/login";

  const signIn = () => {
    console.log("Signing in as: " + user + ";");
  };
</script>

<form 
  class="flex flex-col gap-3"
  method="POST"
  action={loginPostURL}
>
  <input
    bind:value={user}
    type="text"
    class="w-full bg-white placeholder:font-italitc border border-slate-400 rounded-2xl py-2 pl-3 pr-10 focus:outline-none placeholder:italic p-3"
    placeholder="Username&hellip;"
    required
  />
  <input
    bind:value={pw}
    type="password"
    class="w-full bg-white placeholder:font-italitc border border-slate-400 rounded-2xl py-2 pl-3 pr-10 focus:outline-none placeholder:italic p-3"
    placeholder="Password&hellip;"
    required
  />
  <div class="text-center">
    <a
      href={signUpURL}
      class="text-slate-600 underline decoration-black hover:text-slate-500 hover:decoration-slate-500"
      >Don't have an account? Click Here!</a
    >
  </div>
  <button
    class="transition-shadow ease-linear duration-75 border rounded-2xl items-center bg-white w-full border-slate-400 mr-3 hover:shadow-md active"
    onclick={signIn}
  >
    <p class="p-2">Sign In</p>
  </button>
</form>
