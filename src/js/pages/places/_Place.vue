<script>
export default {
  beforeRouteEnter(to, from, next) {
    next(vm => {
      let to = `/places/campus`
      const id = vm.$store.state.app.kiosk.id

      if (id) {
        // From a kiosk
        to = `/places/building/${id}`;
      }

      next(to)
    });
  },

  render() {
    return null;
  }
};
</script>
