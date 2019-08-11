<template>
  <div>
    <router-link :to="{ name: 'index' }">
      <img src="/img/modcore.png" alt />
    </router-link>
  </div>
</template>

<style scoped>
img {
  width: auto;
  max-height: 64px;
}

@media screen and (min-width: 720px) {
  img {
    max-height: 90px;
  }
}
</style>
