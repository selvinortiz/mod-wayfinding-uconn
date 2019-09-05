<template>
  <div class="flex flex-1 justify-center" :class="classes.container" :style="styles.container">
    <nav class="flex flex-1 max-w-6xl items-center justify-center">
      <div
        class="flex-grow @link"
        v-for="(link, i) in theme.nav.links"
        :key="i"
        >

        <a
          class="flex self-center"
          v-if="link.type === 'url'"
          :href="link.url"
          :class="classes.link"
          :style="styles.link"
          >
          <img class="icon" :src="`/static/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </a>

        <router-link
          v-if="link.type === 'route'"
          class="flex"
          :to="{name: link.route}"
          :class="classes.link"
          :style="styles.link"
        >
          <img class="icon" :src="`/static/svg/icons/${link.icon}`" alt />
          <span>{{ link.title }}</span>
        </router-link>

        <a
          v-if="link.type === 'action'"
          class="flex"
          :class="classes.link"
          :style="styles.link"
          @click="action(link.id)"
        >
          <img class="icon" :src="`/static/svg/icons/${link.icon}`" alt />
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
    },
    styles() {
      return {
        container: [
          this.$bg(this.theme.nav.bg),
          `color: ${this.theme.nav.fg}`
        ].join(';'),
        link: [
          this.$bg(this.theme.nav.link.bg),
          `color: ${this.theme.nav.link.fg}`
        ].join(';')
      }
    },
    classes() {
      return {
        container: '',
        link: this.theme.nav.link.classes
      }
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
