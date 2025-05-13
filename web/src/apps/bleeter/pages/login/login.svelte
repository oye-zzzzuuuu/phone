<script lang="ts">
  import { login, LOGIN_ERROR } from "../stores/bleeter";
  import { get } from "svelte/store";

  let username = "";
  let password = "";

  function handleLogin() {
    login({ username, password });
  }
</script>

<div class="login-container">
  <h1>Login to Bleeter</h1>
  <input type="text" placeholder="Username" bind:value={username} />
  <input type="password" placeholder="Password" bind:value={password} />
  <button on:click={handleLogin}>Login</button>

  {#if $LOGIN_ERROR}
    <p class="error">{$LOGIN_ERROR}</p>
  {/if}
</div>

<style>
  .login-container {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    padding: 2rem;
    color: white;
  }

  input {
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
