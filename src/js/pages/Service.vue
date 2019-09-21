<template>
  <content-iframe class="wrapper" :src="$route.query.src"></content-iframe>
</template>

<style>
.wrapper, iframe {
  width: 100%;
  height: 100%;
  overflow: hidden;
}
</style>
