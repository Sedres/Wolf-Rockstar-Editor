// utils/useServerMessages.ts
import { onMounted, onUnmounted } from 'vue'

export function useEventListener(
  event: string,
  callback: EventListenerOrEventListenerObject,
  options?: boolean | AddEventListenerOptions
) {
  onMounted(() => {
    window.addEventListener(event, callback, options)
  })

  onUnmounted(() => {
    window.removeEventListener(event, callback, options)
  })
}
