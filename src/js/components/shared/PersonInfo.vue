<template>
	<div>

		<people-place-header heading="DIRECTORY" classes="hidden lg:flex" :primaryColor="primaryColor"></people-place-header>


		<div class="w-full flex flex-wrap justify-center p-4" style="outline: 1px red solid">

			<!-- 3/5 -->
			<div :class="'w-3/5 text-'+primaryColor">

				<div :class="'font-black mb-4 text-2xl text-'+primaryColor">{{ person.personFirstName }} {{ person.personLastName}}</div>

				<div class="font-bold">Title 1</div>
				<div>Department</div>
				<div class="font-bold">Title 2</div>
				<div class="mb-4">Department</div>

				<div class="font-bold">Building Name</div>
				<div>Suite #</div>
				<div class="mb-4">Floor #</div>

				<div>Address Line 1</div>
				<div class="mb-4">Address Line 2</div>

				<div class="font-bold">{{person.personPhone}}</div>
				<div class="font-bold mb-4">{{person.personEmail}}</div>

				<div>{{person.personDescription}}</div>

			</div>

			<!-- 2/5 -->
			<div class="w-2/5">

				<img class="w-3/5 mb-6" style="max-width: 300px" src="http://placehold.it/500"/>

				<div :class="'w-3/5 text-center text-'+primaryColor+' border border-'+primaryColor">Send to Phone</div>

			</div>

		</div>

	</div>
</template>

<script>
import PeoplePlaceHeader from '../../components/shared/PeoplePlaceHeader.vue'

export default {
	components: {
			PeoplePlaceHeader
	},
	props: {
		person: {
			type: Object,
			default: () => ({
				id: 0,
				personLastName: '',
				personLastName: '',
				personPhone: '',
				personEmail: '',
				personDescription: ''
			})
		},

    primaryColor: {
      type: String,
      default: null
    }
  }
}
</script>