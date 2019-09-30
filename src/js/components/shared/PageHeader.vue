<template>
  <div>
    <h1 class="font-black text-3xl leading-tight py-5 max-w-lg" :style="`color: ${$store.state.app.theme.colors.primary}`">
      <slot></slot>
    </h1>
  </div>
</template>
