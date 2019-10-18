<template>
  <div>
    <h1 class="font-bold text-2xl leading-tight w-full" :style="`color: ${$store.state.app.theme.colors.primary}`">
      <slot></slot>
    </h1>
  </div>
</template>
