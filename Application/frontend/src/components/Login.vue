<template>
  <div class="container">
    <header class="blog-header lh-1 py-3">
      <div class="row flex-nowrap justify-content-between align-items-center">
        <div class="col-1 pt-1">
          <router-link class="text-dark" to="/"><img class="d-block mx-auto" src="../assets/newsncloud-logo.png" alt="" width="140" height="60"></router-link>
        </div>
      </div>
    </header>
  </div>
  <div class="container col-xl-10 col-xxl-8 px-4 py-5">
      <div class="row align-items-center g-lg-5 py-5">
          <div class="col-lg-7 text-center text-lg-start">
            <h1 class="display-4 fw-bold lh-1 mb-3">Welcome Back</h1>
            <p class="col-lg-10 fs-4">Dive into a world of thought-provoking articles, expert insights, and engaging stories tailored to your interests. Log in now to stay connected, informed, and inspired. Let's explore together!</p>
            <small class="text-muted">Need to create an account? <router-link class="text-orange" to="/register">Sign Up</router-link></small>
          </div>
          <div class="col-md-10 mx-auto col-lg-5">
            <form @submit.prevent="login" class="p-4 p-md-5 border rounded-3 bg-light">
              <div v-if="message_error" class="alert alert-danger" role="alert">
                {{message_error}}
              </div>
              <div v-if="message_success" class="alert alert-success" role="alert">
                {{message_success}}
              </div>
              <div class="form-floating mb-3">
                <input v-model="email" type="email" class="form-control" id="floatingInput" placeholder="name@example.com" required>
                <label for="floatingInput">Email address</label>
              </div>
              <div class="form-floating mb-3">
                <input v-model="password" type="password" class="form-control" id="floatingPassword" placeholder="Password" required>
                <label for="floatingPassword">Password</label>
              </div>
              <div class="checkbox mb-3">
                <label>
                  <input type="checkbox" value="remember-me"> Remember me
                </label>
              </div>
              <button class="w-100 btn btn-lg btn-primary btn-orange" type="submit">Sign in</button>
              <hr class="my-4">
              <small class="text-muted">Forgot Password? <router-link class="text-orange" to="/">Forgot Password</router-link></small>
            </form>
<!--            <p v-if="message" class="text-danger">{{ message }}</p>-->
          </div>
      </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
export default {
  name: "LoginPage.vue",
  data() {
    return {
      email: '',
      password: '',
      message_error: '',
      message_success: ''
    };
  },
  methods: {
      ...mapActions(['login']),
      login() {
        const user = { email: this.email, password: this.password };
        console.log(this.message)
        this.$store.dispatch('login', user)
          .then((user) => {
            console.log(user.id)
            this.message_success = "Successful Login"
            // If the login was successful, redirect to the home page
            setTimeout(() => {
              this.$router.push('/');
            }, 1000);
          })
          .catch((error) => {
            // Handle login error
            console.error(error);
            this.message_error = "Invalid email or password";
          });
      },
  }
}
</script>

<style scoped>
.btn-orange {
  background-color: #FC7300;
  border-color: #FC7300;
  color: white;
}
.btn-orange:hover {
    background-color: #FC7300;
    border-color: white;
    color: white;
}
.text-orange {
  color: #FC7300;
}

</style>