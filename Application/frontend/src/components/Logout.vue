<template>
    <div class="px-4 py-5 my-5 text-center">
      <img class="d-block mx-auto" src="../assets/newsncloud-logo.png" alt="" width="300" height="150">
      <div class="col-lg-6 mx-auto">
        <p class="lead mb-4">Are you sure you want to leave us?</p>
        <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
          <button @click="logout" type="button" class="btn btn-primary btn-lg btn-orange px-4 gap-3">Logout</button>
          <router-link class="btn btn-outline-secondary btn-lg px-4" to="/">Cancel</router-link>
        </div>
      </div>
    </div>
</template>

<script>
import { mapActions } from 'vuex';
export default {
  name: "Logout-page.vue",
  ...mapActions(['logout']),
  methods: {
    logout() {
      this.$store.dispatch('logout').then(() => {
        // Redirect to the home page after logout
        this.$router.push('/');
      });
    },
  },
}
</script>

<style scoped>
  .btn-orange {
    background-color: #FC7300;
    border-color: #FC7300;
    color: white;
  }
</style>