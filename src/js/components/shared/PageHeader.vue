<template>
  <div>
    <h1 class="font-bold text-2xl leading-tight max-w-lg" :style="`color: ${$store.state.app.theme.colors.primary}`">
      <slot></slot>
    </h1>
  </div>
</template>
