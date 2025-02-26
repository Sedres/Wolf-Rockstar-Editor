<template>
  <Dialog
    theme="dark"
    v-model="dialogVisible"
    :title="DialogData.title"
    :message="DialogData.message"
    :confirmButtonText="DialogData.confirmButtonText"
    :cancelButtonText="DialogData.cancelButtonText"
    @confirm="handleConfirm"
    @cancel="handleCancel"
    @update:modelValue="dialogVisible = false"
  />
  <Notify
    v-show="isNotifyActive"
    :openNotify="isNotifyActive"
    :message="NotifyMessage"
    :type="NotifyType"
    :icon="NotifyIcon"
    :timeout="NotifyTimeout"
    @close="isNotifyActive = false"
  />
  <RecordingMessage v-if="recording" />
  <div v-if="editorOpen" theme="dark" class="editor-buttons-container">
    <v-btn
      class="editor-buttons"
      v-for="button in buttons"
      :key="button.key"
      :aria-label="button.key"
      :title="button.key"
      :flat="false"
      :ripple="false"
      variant="text"
      size="50"
      v-tooltip:left="button.tooltip"
      @click="HandleClick(button.key)"
    >
      <v-icon :icon="button.icon"></v-icon>
    </v-btn>
  </div>
</template>

<script setup>
import { useEventListener } from '../utils/useServerMessages.ts'
import { useGlobalStore } from '../stores/global.ts'
import { computed } from 'vue'

const store = useGlobalStore()
const editorOpen = ref(true)
const recording = ref(false)
const buttons = ref([])
const dialogVisible = ref(false)

const DialogData = computed(() => {
  return {
    title: store.locales ? store.locales.dialogs.title : 'Rockstar Editor',
    message: store.locales ? store.locales.dialogs.message : 'Are you sure?',
    confirmButtonText: store.locales ? store.locales.dialogs.yes : 'Yes',
    cancelButtonText: store.locales ? store.locales.dialogs.no : 'No'
  }
})

let timeoutId = null

const sendNotify = ({ message, type, icon, timeout }) => {
  isNotifyActive.value = false
  clearTimeout(timeoutId)

  setTimeout(() => {
    NotifyMessage.value = message
    NotifyType.value = type
    NotifyIcon.value = icon
    NotifyTimeout.value = timeout
    isNotifyActive.value = true

    timeoutId = setTimeout(() => {
      isNotifyActive.value = false
    }, timeout)
  }, 100)
}

const NotifyMessage = ref('')
const NotifyType = ref('')
const NotifyIcon = ref('')
const NotifyTimeout = ref(0)
const isNotifyActive = ref(false)

const HandleClick = (buttonKey) => {
  api
    .post('buttonClick', { button: buttonKey })
    .then((response) => {
      const action = response.data.action
      const actionData = response.data.actionData
      switch (action) {
        case 'close':
          editorOpen.value = !actionData.close
          break
        case 'recording':
          recording.value = actionData.record
          editorOpen.value = !actionData.close
          sendNotify({
            message: store.locales.notifications.recordingStarted,
            type: 'info',
            icon: 'fa-solid fa-circle-check',
            timeout: 5000
          })
          break
        case 'saved':
          if (actionData.type == 'clip') {
            if (recording.value) {
              sendNotify({
                message: store.locales.notifications.recordingSaved,
                type: 'info',
                icon: 'fa-solid fa-circle-check',
                timeout: 5000
              })
            } else {
              sendNotify({
                message: store.locales.notifications.notRecording,
                type: 'error',
                icon: 'fa-solid fa-circle-exclamation',
                timeout: 5000
              })
            }
            recording.value = actionData.record
          } else if (actionData.type == 'photo') {
            sendNotify({
              message: store.locales.notifications.photoSaved,
              type: 'info',
              icon: 'fa-solid fa-circle-check',
              timeout: 5000
            })
          }
          break
        case 'deleted':
          if (recording.value) {
            sendNotify({
              message: store.locales.notifications.recordingDiscarted,
              type: 'info',
              icon: 'fa-solid fa-circle-check',
              timeout: 5000
            })
          } else {
            sendNotify({
              message: store.locales.notifications.notRecording,
              type: 'error',
              icon: 'fa-solid fa-circle-exclamation',
              timeout: 5000
            })
          }
          recording.value = actionData.record
          break
        case 'opening':
          dialogVisible.value = true
          break
      }
    })
    .catch(() => {
      sendNotify({
        message: store.locales.notifications.error,
        type: 'error',
        icon: 'fa-solid fa-circle-exclamation',
        timeout: 5000
      })
    })
}

const handleConfirm = () => {
  dialogVisible.value = true

  api.post('openEditor').catch(() => {
    sendNotify({
      message: store.locales.notifications.error,
      type: 'error',
      icon: 'fa-solid fa-circle-exclamation',
      timeout: 5000
    })
  })
}

const handleCancel = () => {
  dialogVisible.value = false
}

const handleMessage = (event) => {
  const eventName = event.data.eventName
  switch (eventName) {
    case 'openEditor':
      editorOpen.value = true
      const language = event.data.language
      store.locales = language
      buttons.value = [
        {
          key: 'record',
          icon: 'fas fa-record-vinyl',
          tooltip: store.locales.buttons.startRecording
        },
        {
          key: 'save',
          icon: 'fas fa-save',
          tooltip: store.locales.buttons.stopRecordingSave
        },
        {
          key: 'delete',
          icon: 'fas fa-trash',
          tooltip: store.locales.buttons.stopRecordingDiscart
        },
        {
          key: 'photo',
          icon: 'fas fa-camera',
          tooltip: store.locales.buttons.takePhoto
        },
        {
          key: 'open',
          icon: 'fa-regular fa-message-pen',
          tooltip: store.locales.buttons.openEditor
        },

        {
          key: 'close',
          icon: 'fas fa-times',
          tooltip: store.locales.buttons.closeEditor
        }
      ]

      break
  }
}
useEventListener('message', handleMessage)
</script>

<style scoped>
.editor-buttons-container {
  width: fit-content;
  position: fixed;
  top: 50%;
  right: 1%;
  transform: translateY(-50%);

  background: transparent;
  border: none;

  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 10px;
  border-radius: 10px;
}
.editor-buttons {
  border-radius: 10px;
  color: white;
  background: linear-gradient(
    -135deg,
    #00000091 0%,
    #1a1a1aab 50%,
    #333333 100%
  );
}
.editor-buttons:hover {
  scale: 1.1;
  box-shadow: 0 0 10px white;
}

.editor-buttons:active {
  scale: 0.9;
}
</style>
