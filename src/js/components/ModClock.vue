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
const months = [
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

export default {
  data() {
    return {
      params: {},
    };
  },
  created() {
    this.time();

    interval = setInterval(() => this.time(), 1000);
  },
  beforeDestroy: function() {
    clearInterval(interval);
  },
  methods: {
    time() {
      currentDate = new Date(Date.now());

      const day = currentDate.getDate();
      const year = currentDate.getFullYear();
      const month = currentDate.getMonth() + 1;

      const dayName = days[day];
      const monthName = months[currentDate.getMonth()];

      const hour = this.pad(currentDate.getHours() % 12 || 12);
      const minute = this.pad(currentDate.getMinutes());
      const suffix = currentDate.getHours() > 12 ? "PM" : "AM";

      this.params = {
        day,
        dayName,
        month,
        monthName,
        year,
        hour,
        minute,
        suffix
      };
    },
    pad(num) {
      return parseInt(num) < 10 ? `0${num}` : num;
    }
  }
};
</script>
