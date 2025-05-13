<script lang="ts">
  import { register, REGISTER_ERROR } from "../stores/bleeter";

  let username = "";
  let password = "";
  let avatar = "";
  let bio = "";

  function handleSignup() {
    register({ username, password, avatar, bio });
  }
</script>

<div class="signup-container">
  <h1>Create a Bleeter Account</h1>
  <input type="text" placeholder="Username" bind:value={username} />
  <input type="password" placeholder="Password" bind:value={password} />
  <input type="text" placeholder="Avatar URL (optional)" bind:value={avatar} />
  <textarea placeholder="Bio (optional)" bind:value={bio}></textarea>
  <button on:click={handleSignup}>Register</button>

  {#if $REGISTER_ERROR}
    <p class="error">{$REGISTER_ERROR}</p>
  {/if}
</div>

<style>
  .signup-container {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    padding: 2rem;
    color: white;
  }

  input, textarea {
    padding: 0.5rem;
    border-radius: 5px;
  }

  button {
    padding: 0.5rem;
    background-color: #1d9bf0;
    border: none;
    color: white;
    border-radius: 5px;
    cursor: pointer;
  }

  .error {
    color: red;
  }
</style>
