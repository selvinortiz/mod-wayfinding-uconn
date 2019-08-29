<template>
	<div>

		<people-place-header heading="WAYFINDING" classes="hidden lg:flex" :primaryColor="primaryColor"></people-place-header>


		<div class="w-full flex flex-wrap justify-center p-4" style="outline: 1px red solid">

			<div :class="'w-full mb-4 text-2xl font-black text-'+primaryColor">
				{{place.title}}
			</div>

			<!-- Half -->
			<div class="w-1/2">

				<img class="w-4/5 mb-4" src="http://placehold.it/500"/>

				<div :class="'font-bold mb-4 text-'+primaryColor">Phone Number</div>

				<div :class="'font-bold text-'+primaryColor">Address Line 1</div>
				<div :class="'font-bold mb-4 text-'+primaryColor">Address Line 2</div>

				<div :class="'text-'+primaryColor">Place Description</div>

			</div>

			<!-- Half -->
			<div class="w-1/2 text-center">

				<select :class="'w-full flex items-center h-12 px-6 border-2 border-'+primaryColor">
				<option class="hidden" value="" disabled selected>Choose Destination</option>
				</select>

				<div :class="'text-'+primaryColor">
				Don't see what you're looking for?
				<u @click="() => $store.state.app.searchIsOpen = true">Switch to SEARCH</u>
				</div>

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
		place: {
			type: Object,
			default: () => ({
				id: 0,
				title: '',
				maps: [
				{
						image: ''
				},
				{
						markers: [
						{ width: 0, height: 0, x: 0, xr: 0, y: 0,yr: 0 }
						]
				}
				],
				loaded: false
			})
		},

    primaryColor: {
      type: String,
      default: null
    }
  }
}
</script>