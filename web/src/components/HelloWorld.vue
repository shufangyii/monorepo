<script setup lang="ts">
import { ref } from 'vue'

defineProps<{
  msg: string
}>()

const name = ref('Gemini')
const message = ref('')

async function callApi() {
  try {
    const response = await fetch(`/api/hello/${name.value}`)
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`)
    }
    const data = await response.text()
    message.value = data
  } catch (error) {
    console.error('Error calling API:', error)
    message.value = 'Error calling API'
  }
}
</script>

<template>
  <div class="greetings">
    <h1 class="green">{{ msg }}</h1>
    <h3>
      You’ve successfully created a project with
      <a href="https://vite.dev/" target="_blank" rel="noopener">Vite</a> +
      <a href="https://vuejs.org/" target="_blank" rel="noopener">Vue 3</a>.
    </h3>
    <div class="api-call">
      <input v-model="name" type="text" placeholder="Enter a name" />
      <button @click="callApi">Call API</button>
      <p v-if="message">Response: {{ message }}</p>
    </div>
  </div>
</template>

<style scoped>
h1 {
  font-weight: 500;
  font-size: 2.6rem;
  position: relative;
  top: -10px;
}

h3 {
  font-size: 1.2rem;
}

.greetings h1,
.greetings h3 {
  text-align: center;
}

.api-call {
  margin-top: 2rem;
  text-align: center;
}

.api-call input {
  margin-right: 1rem;
  padding: 0.5rem;
}

@media (min-width: 1024px) {
  .greetings h1,
  .greetings h3,
  .api-call {
    text-align: left;
  }
}
</style>
