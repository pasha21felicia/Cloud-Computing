<template>
  <div id = "app">
     <Navbar v-if="!isLoginPage && !isRegisterPage && !isLogoutPage" />
    <router-view/>
    <Footer v-if="!isLoginPage && !isRegisterPage && !isLogoutPage"/>
  </div>
</template>

<script>
import Navbar from './components/Navbar.vue'
import Footer from './components/Footer.vue'
export default {
  name: 'App',
  components: {
    Navbar,
    Footer
  },
  computed: {
    isLoginPage() {
      return this.$route.path === '/login'
    },
    isRegisterPage() {
      return this.$route.path === '/register'
    },
    isLogoutPage() {
      return this.$route.path === '/logout'
    },
  },
}
</script>

<style>
</style>
