<script lang="ts">
  import { Heart, MessageSquare, Repeat2 } from "lucide-svelte";

  interface Props {
    bleet: any;
  }

  let { bleet = $bindable() }: Props = $props();

  /**
   * Handles the like action for a bleet.
   * @param {MouseEvent} event - The click event.
   */
  function likeBleet(event: MouseEvent): void {
    event.stopPropagation();
    bleet.likes++;
    // TODO: move to utils
  }

  /**
   * Handles the rebleet action for a bleet.
   * @param {MouseEvent} event - The click event.
   */
  function rebleetBleet(event: MouseEvent): void {
    event.stopPropagation();
    bleet.rebleets++;
    // TODO: move to utils
  }
</script>

<div class="flex gap-8 mt-4">
  <button
    class="flex items-center w-16 text-gray-400 group"
    aria-label="Comment"
  >
    <MessageSquare
      size="20"
      class="group-hover:fill-blue-400 group-hover:text-blue-400"
    />
    <span class="ml-2">{bleet.comments}</span>
  </button>
  <button
    onclick={rebleetBleet}
    class="flex items-center w-16 text-gray-400 group"
    aria-label="Rebleet"
  >
    <Repeat2
      size="20"
      class="group-hover:fill-emerald-500 group-hover:text-emerald-500"
    />
    <span class="ml-2">{bleet.rebleets}</span>
  </button>
  <button
    onclick={likeBleet}
    class="flex items-center w-16 text-gray-400 group"
    aria-label="Like"
  >
    <Heart
      size="20"
      class="group-hover:fill-rose-500 group-hover:text-rose-500"
    />
    <span class="ml-2">{bleet.likes}</span>
  </button>
</div>
