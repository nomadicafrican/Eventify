<script lang="ts">
  import type { Action } from "svelte/action";

  let user = $state("");
  let password = $state("");
  let passwordConfirm = $state("");

  const signUpURL = "/signup";
  const emailVerificationRegex = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;

  let buttonText = "Sign Up";

  const signIn = () => {
    console.log("Signing in as: " + user + ";");
  };

  const verifyPassword: Action = (node) => {
    $effect(() => {
      const nodeButton = (node as unknown) as HTMLButtonElement;
      if (password == passwordConfirm && 
          password.length >= 0 && 
          passwordConfirm.length >= 0 &&
          emailVerificationRegex.test(user)
      ) {
        nodeButton.disabled = false;
        nodeButton.title = "";

        nodeButton.classList.remove("shadow-inner");
        nodeButton.classList.remove("hover:bg-slate-50");
        nodeButton.classList.add("hover:shadow-md");
        nodeButton.classList.add("active:shadow-inner");
      } else {
        nodeButton.disabled = true;
        nodeButton.title = "Passwords do not match";
        
        nodeButton.classList.add("shadow-inner");
        nodeButton.classList.add("hover:bg-slate-50");
        nodeButton.classList.remove("hover:shadow-md");
        nodeButton.classList.remove("active:shadow-inner");
      }
    });
  };
</script>

<form 
  class="flex flex-col gap-3"
  method="POST"
  action="{signUpURL}"
>
  <label aria-details="email field">
    <input
      bind:value={user}
      type="text"
      class="w-full bg-white placeholder:font-italic border rounded-2xl py-2 pl-3 pr-10 focus:outline-none placeholder:italic p-3 {emailVerificationRegex.test(user) || user.length == 0 ? 'border-slate-400' : 'border-red-400'}"
      placeholder="Email&hellip;"
      autocomplete="email"
      required
      name="email"
      />
  </label>
  
  <label>
    <input
      bind:value={password}
      type="password"
      class="w-full bg-white placeholder:font-italic border border-slate-400 rounded-2xl py-2 pl-3 pr-10 focus:outline-none placeholder:italic p-3 {password == passwordConfirm && password.length >= 0 && passwordConfirm.length >= 0 ? 'border-slate-400' : 'border-red-400'}"
      placeholder="Password&hellip;"
      required
      name="password"
    />
  </label>
  <!-- style:borderColour={borderColour} -->

  <label>
    <input
      bind:value={passwordConfirm}
      type="password"
      class="w-full bg-white placeholder:font-italic border border-slate-400 rounded-2xl py-2 pl-3 pr-10 focus:outline-none placeholder:italic p-3 {password == passwordConfirm && password.length >= 0 && passwordConfirm.length >= 0 ? 'border-slate-400' : 'border-red-400'}"
      placeholder="Confirm password&hellip;"
      autocomplete="off"
      required
      name="passwordConfirm"
    />
  </label>
  <label>
    <button
      id="submitButtonSignUp"
      class="transition-shadow ease-linear duration-75 border border-slate-400 rounded-2xl items-center bg-white w-full mr-3 shadow-inner hover:bg-slate-50"
      onclick={signIn}
      use:verifyPassword
      type="submit"
      title="Passwords do not match"
    >
      <p class="p-2">{buttonText}</p>
    </button>
  </label>
</form>