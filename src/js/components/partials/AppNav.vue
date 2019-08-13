<template>
  <nav class="flex text-center uppercase justify-center">
    <router-link
      v-for=" (item, i) in theme.footer.nav.links"
      :key="i+1"
      class="shadow rounded link"
      :style="styles"
      :to="{ name: item.route }"
    >
      <span v-if="item.title === 'Wayfinding' ">
        <places-icon class="icon" />
        {{item.title}}
      </span>
      <span v-if="item.title === 'Directory' ">
        <people-icon class="icon" />
        {{item.title}}
      </span>
      <span v-if="item.title === 'Bus Tracker' " @click="externalLinkRedirect(item.url)">
        <search-icon class="icon" />
        {{item.title}}
      </span>
      <span v-if="item.title === 'Search' ">
        <settings-icon class="icon" />
        {{item.title}}
      </span>
    </router-link>
  </nav>
</template>

<style scoped>
.link {
  margin: 0.5rem;
  padding: 0.5rem;
  font-size: 1rem;
}

.icon {
  display: inline;
  max-height: 1rem;
}
@media screen and (min-width: 720px) {
  .link {
    margin: 1rem;
    padding: 1rem;
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
