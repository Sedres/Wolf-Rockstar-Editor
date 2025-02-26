<template>
  <v-expand-x-transition>
    <v-card class="notify" :color="type" elevation="2">
      <v-card-title class="notify-text">
        <v-icon v-if="icon" class="notify-icon">{{ icon }}</v-icon>
        {{ message }}
      </v-card-title>
    </v-card>
  </v-expand-x-transition>
</template>

<script setup>
const props = defineProps({
  openNotify: Boolean,
  message: String,
  type: {
    type: String,
    default: 'info' // success, error, warning, info
  },
  icon: String
})
</script>

<style scoped>
.notify {
  position: fixed;
  top: 20px;
  right: 20px;
  border-radius: 10px;
  background: linear-gradient(
    135deg,
    #00000091 0%,
    #1a1a1aab 50%,
    #333333 100%
  );
}
.notify-text {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px;
  color: white;
  font-weight: bold;
  font-size: 15px;
}
.notify-icon {
  font-size: 25px;
}
</style>
