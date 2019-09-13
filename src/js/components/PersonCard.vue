<template>
  <router-link class="block" :to="{ name: 'person', params: {id: person.id} }">
    <img src="/static/img/avatar.svg" style="max-height: 80px;" />

    <div class="p-2">
      <p class="font-bold text-2xl">
        {{ person.personFirstName }}
        {{ person.personLastName }}
      </p>
      <p>
        Role
        <!--{{ person.personFirstName }}-->
      </p>
      <p>
        Suite #
        <!--{{ person.personFirstName }}-->
      </p>
      <p>
        Can't tell what goes here
        <!--{{ person.personFirstName }}-->
      </p>
    </div>
  </router-link>
</template>

<script>
export default {
  props: {
    person: {
      type: Object,
      default: () => {id: null}
    }
  }
}
</script>
