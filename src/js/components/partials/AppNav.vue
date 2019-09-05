<template>
  <div class="flex flex-1 justify-center">
    <nav class="flex flex-1 max-w-6xl items-center justify-center">
      <div class="flex-grow @link" v-for="(link, i) in theme.nav.links" :key="i">
        <a class="flex self-center" v-if="link.type === 'url'" :href="link.url">
          <img class="icon" :src="`/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </a>

        <router-link
          v-if="link.type === 'route'"
          class="flex"
          :to="{name: link.route}"
        >
          <img class="icon" :src="`/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </router-link>

        <a
          v-if="link.type === 'action'"
          class="flex"
          @click="action(link.id)"
        >
          <img class="icon" :src="`/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </a>
      </div>
    </nav>
  </div>
</template>

<script>
export default {
  computed: {
    theme() {
      return this.$store.state.app.theme
    }
  },
  methods: {
    action(id) {
      switch(id) {
        case 'search':
          return this.search()
      }
    },
    search() {
      this.$store.commit('setSearchIsOpen', true)
    }
  }
}
</script>
