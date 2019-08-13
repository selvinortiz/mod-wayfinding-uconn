<template>
  <nav class="flex text-center uppercase justify-center">
    <router-link
      class="link shadow rounded"
      v-for="link in theme.footer.nav.links"
      :key="link.id"
      :style="styles"
      :to="{ name: link.route }"
    >
      <span v-if="link.id === 'places' ">
        <places-icon class="icon" />
        {{ link.title }}
      </span>
      <span v-if="link.id === 'people' ">
        <people-icon class="icon" />
        {{ link.title }}
      </span>
      <span v-if="link.id === 'busTracker' " @click="externalLinkRedirect(item.url)">
        <search-icon class="icon" />
        {{ link.title }}
      </span>
      <span v-if="link.id === 'search' ">
        <settings-icon class="icon" />
        {{ link.title }}
      </span>
    </router-link>
  </nav>
</template>

<style scoped>
.link {
  margin: 0.5rem;
  padding: 0.5rem 1rem;
  font-size: 1rem;
}

.icon {
  display: inline;
  max-height: 1rem;
}
@media screen and (min-width: 720px) {
  .link {
    margin: 1rem;
    padding: 1rem 2rem;
    font-size: 1.25rem;
  }
  .icon {
    max-height: 1.25rem;
  }
}
</style>

<script>
import PlacesIcon from "../../../svg/icons/places.svg";
import PeopleIcon from "../../../svg/icons/people.svg";
import SearchIcon from "../../../svg/icons/search.svg";
import SettingsIcon from "../../../svg/icons/settings.svg";

export default {
  components: {
    PlacesIcon,
    PeopleIcon,
    SearchIcon,
    SettingsIcon
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    styles() {
      return [
        `color: ${this.theme.footer.nav.item.text}`,
        `background-color: ${this.theme.footer.nav.item.bg}`
      ].join(";");
    }
  },
  methods: {
    externalLinkRedirect(url) {
      window.open(url);
    }
  }
};
</script>
