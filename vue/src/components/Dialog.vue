<template>
  <v-dialog
    v-model="isVisible"
    width="400"
    transition="dialog-bottom-transition"
    opacity="0"
  >
    <v-card class="dialog-card" theme="dark" loading border="10px">
      <v-card-title>{{ title }}</v-card-title>
      <v-card-text>{{ message }}</v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn
          class="dialog-button"
          @click="confirm"
          v-tooltip="confirmButtonText"
          color="success"
          ><v-icon icon="fas fa-check"></v-icon
        ></v-btn>
        <v-btn
          class="dialog-button"
          @click="cancel"
          v-tooltip="cancelButtonText"
          color="error"
          ><v-icon icon="fas fa-times"></v-icon
        ></v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup>
import { ref, watch, defineProps, defineEmits } from 'vue'

const props = defineProps({
  modelValue: {
    type: Boolean,
    required: true
  },
  title: {
    type: String,
    default: 'Confirm Action'
  },
  message: {
    type: String,
    default: 'Are you sure you want to proceed?'
  },
  confirmButtonText: {
    type: String,
    default: 'Accept'
  },
  cancelButtonText: {
    type: String,
    default: 'Cancel'
  }
})

const emit = defineEmits(['update:modelValue', 'confirm', 'cancel'])
const isVisible = ref(false)

// Sync props.modelValue with local state
watch(
  () => props.modelValue,
  (newValue) => {
    isVisible.value = newValue
  },
  { immediate: true }
)

// Close the dialog and emit updates
const closeDialog = () => {
  isVisible.value = false
  emit('update:modelValue', false)
}

// Confirm action
const confirm = () => {
  emit('confirm')
  closeDialog()
}

// Cancel action
const cancel = () => {
  emit('cancel')
  closeDialog()
}

// Watch local state and sync it back to parent
watch(isVisible, (newValue) => {
  if (newValue !== props.modelValue) {
    emit('update:modelValue', newValue)
  }
})
</script>

<style scoped>
.dialog-card {
  background: linear-gradient(
    135deg,
    #000000ec 0%,
    #1a1a1aee 50%,
    #333333 100%
  );
}
.dialog-button {
  border-radius: 10px;
  color: white;
  background: linear-gradient(
    -135deg,
    #00000091 0%,
    #1a1a1aab 50%,
    #333333 100%
  );
  border: 1px solid white;
}
</style>
