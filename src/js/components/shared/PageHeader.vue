<template>
    <h1 class="font-thin text-blue-800 text-4xl uppercase">
      <a @click="$router.go(-1)" class="cursor-pointer">
        ← <slot></slot>
      </a>
    </h1>
</template>
