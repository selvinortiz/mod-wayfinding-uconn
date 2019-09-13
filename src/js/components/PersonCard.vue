<template>
  <router-link class="flex" :to="{ name: 'person', params: {id: person.id} }">
    <img class="w-full" src="/static/img/avatar.svg" />

    <div class="w-full p-2">
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
