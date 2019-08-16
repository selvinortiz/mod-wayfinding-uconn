<template>
  <div class="p-4">

    <div class="mx-auto" style="max-width: 640px;">
      <mod-page-header>Search</mod-page-header>
      <mod-keyboard placeholder="Type to seach..." keyboardClass="fullKeyboard" @search="handleSearch"></mod-keyboard>
    </div>
  </div>
</template>

<script>
import ModKeyboard from '../components/shared/ModKeyboard.vue';

export default {
  metaInfo: {
    title: "Search"
  },
  components: {
    ModKeyboard
  },
  methods: {
    handleSearch(value) {
      console.log(value)
    }
  }
};
</script>
