<script lang="ts">
  import { Bug, Sun, Moon, Eye } from "lucide-svelte";
  import { Button } from "@/components/ui/button/index";
  import { sendNotification } from "@/stores/notifications";
  import { toggleVisible } from "@/utils/debug/visibility";
  import { IS_DARK_MODE } from "@/stores/phone";

  let visible: boolean = true;

  function toggleVisibility() {
    toggleVisible((visible = !visible));
  }

  function testNotification() {
    sendNotification({
      title: "Test Notification",
      body: "This is a test notification",
      app: "bleeter",
    });
  }

  function toggleMode() {
    IS_DARK_MODE.update((value) => !value);
  }
</script>

<div class="absolute w-full h-full -z-50 bg-foreground"></div>

<div class="absolute top-0 left-0 m-2 flex flex-col gap-2">
  <Button
    on:click={toggleMode}
    variant="outline"
    size="icon"
    class="w-8 h-8 text-white bg-black border-black"
  >
    <Sun
      class="w-4 h-4 rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0"
    />
    <Moon
      class="absolute w-4 h-4 rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100"
    />
  </Button>
  <Button
    on:click={toggleVisibility}
    variant="outline"
    size="icon"
    class="w-8 h-8 text-white bg-black border-black"
  >
    <Eye class="w-4 h-4" />
  </Button>
  <Button
    on:click={testNotification}
    variant="outline"
    size="icon"
    class="w-8 h-8 text-white bg-black border-black"
  >
    <Bug class="w-4 h-4" />
  </Button>
</div>
