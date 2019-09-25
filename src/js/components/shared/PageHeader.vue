<template>
  <div>
    <h1 class="font-black text-3xl leading-tight pt-8 pb-4" :style="`color: ${$store.state.app.theme.colors.primary}`">
      <slot></slot>
    </h1>
  </div>
</template>
