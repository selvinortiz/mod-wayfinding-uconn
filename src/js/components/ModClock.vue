<template>
  <div class="py-8 text-center">
    <slot name="display" :params="params"></slot>
  </div>
</template>

<script>
let interval;
let currentDate;

const days = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];
const monthsAbrv = [
  "Jan",
  "Feb",
  "Mar",
  "April",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec"
];

const months = [
  "Janauary",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

export default {
  data() {
    return {
      params: {}
    };
  },
  created() {
    this.time();

    interval = setInterval(() => this.time(), 1000);
  },
  beforeDestroy: function() {
    clearInterval(interval);
  },
  computed: {
    theme() {
      return this.$store.state.app.theme;
    },
    monthFormat() {
      return this.theme.header.clock.monthFullName;
    }
  },
  methods: {
    time() {
      currentDate = new Date(Date.now());

      const day = currentDate.getDate();
      const year = currentDate.getFullYear();
      const month = currentDate.getMonth() + 1;

      const dayName = days[day];
      const monthName = this.monthFormat ? months[currentDate.getMonth()] : monthsAbrv[currentDate.getMonth()];
      const hour = this.pad(currentDate.getHours() % 12 || 12);
      const minute = this.pad(currentDate.getMinutes());
      const suffix = currentDate.getHours() > 12 ? "PM" : "AM";

      this.params = {
        month,
        monthName,
        day,
        dayName,
        year,
        hour,
        minute,
        suffix
      }
    },
    pad(num) {
      return parseInt(num) < 10 ? `0${num}` : num;
    }
  }
};
</script>
