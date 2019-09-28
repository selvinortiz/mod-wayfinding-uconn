<template>
  <div>
    <h1 class="font-black text-3xl leading-tight pt-5 pb-6 xl:pb-2 xl:pt-4 max-w-lg" :style="`color: ${$store.state.app.theme.colors.primary}`">
      <slot></slot>
    </h1>
  </div>
</template>
