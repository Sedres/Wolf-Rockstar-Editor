<template>
  <v-card theme="dark" class="recording-card">
    <v-card-text class="recording-text">
      <div class="recording-icon"></div>
      {{ formattedTime }}</v-card-text
    >
  </v-card>
</template>

<script setup>
const timeInSeconds = ref(0)
const formattedTime = ref('00:00')

const recordingTimer = setInterval(() => {
  timeInSeconds.value++

  // Calcula minutos y segundos
  const minutes = Math.floor(timeInSeconds.value / 60)
  const seconds = timeInSeconds.value % 60

  // Formatea el tiempo en formato MM:SS
  formattedTime.value = `${String(minutes).padStart(2, '0')}:${String(
    seconds
  ).padStart(2, '0')}`

  // Si quieres reiniciar el tiempo después de 3 minutos
  if (timeInSeconds.value >= 3 * 60) {
    timeInSeconds.value = 0
  }
}, 1000)
</script>

<style scoped>
.recording-card {
  position: fixed;
  top: 1%;
  left: 50%;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;

  background: linear-gradient(
    -135deg,
    #00000091 0%,
    #1a1a1aab 50%,
    #333333 100%
  );
  box-shadow: none;

  transform: translateX(-50%);
  width: fit-content;
  height: fit-content;
  padding: 8px;
  margin: 0;
}
.recording-text {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 0;
  margin: 0;
}

.recording-icon {
  width: 15px;
  height: 15px;
  border-radius: 50%;
  background-color: red;
  animation: recordinganimation 1.5s infinite;
}
@keyframes recordinganimation {
  0% {
    background-color: red;
    opacity: 1;
  }
  50% {
    background-color: #f06c6c;
    opacity: 0.5;
  }
  100% {
    background-color: red;
    opacity: 1;
  }
}
</style>
