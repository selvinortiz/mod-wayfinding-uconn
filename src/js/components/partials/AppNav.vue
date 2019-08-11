<template>
  <nav class="flex text-center uppercase">
    <router-link :to="{ name: 'places' }" class="link shadow rounded" :style="styles">
      <places-icon class="icon" />Places
    </router-link>
    <router-link :to="{ name: 'people' }" class="link shadow rounded" :style="styles">
      <people-icon class="icon" />People
    </router-link>
    <router-link :to="{ name: 'search' }" class="link shadow rounded" :style="styles">
      <search-icon class="icon" />Search
    </router-link>
    <router-link :to="{ name: 'settings' }" class="link shadow rounded" :style="styles">
      <settings-icon class="icon" />Settings
    </router-link>
  </nav>
</template>

<style scoped>
.link {
  flex: 1;
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
  }
};
</script>
