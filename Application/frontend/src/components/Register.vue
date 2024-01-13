<template>
      <div class="container">
        <header class="blog-header lh-1 py-3">
          <div class="row flex-nowrap justify-content-between align-items-center">
            <div class="col-1 pt-1">
              <router-link class="text-dark" to="/"><img class="d-block mx-auto" src="../assets/newsncloud-logo.png" alt="" width="140" height="60"></router-link>
            </div>
            <div class="d-flex justify-content-end col-md-8">
                <small class="text-muted">Already have an account? <router-link class="text-orange" to="/login">Sign In</router-link></small>
            </div>
          </div>
        </header>
      </div>
      <div class="container col-xl-10 col-xxl-8 px-4 py-5">
        <div class="row align-items-center g-lg-5 py-5">
          <div class="col-lg-7 text-center text-lg-start">
            <h1 class="display-4 fw-bold lh-1 mb-3">Welcome to Newsncloud</h1>
            <p class="col-lg-10 fs-4">Join Newsncloud today and unlock a wealth of knowledge and inspiration at your fingertips! By registering, you'll gain access to a curated selection of articles, in-depth analysis, and compelling stories tailored just for you. Don't miss out – embark on a journey of discovery and become a part of our vibrant community now.</p>
          </div>
          <div class="col-md-10 mx-auto col-lg-5">
            <form @submit.prevent="register" class="p-4 p-md-5 border rounded-3 bg-light">
              <div class="form-floating mb-3">
                <input v-model="username" type="text" class="form-control" id="username" placeholder="username" required>
                <span v-if="errors.username" class="error">{{ errors.username.join(', ') }}</span>
                <label for="username">Username</label>
              </div>
              <div class="form-floating mb-3">
                <input v-model="email" type="email" class="form-control" id="floatingInput" placeholder="name@example.com" required>
                <span v-if="errors.email" class="error">{{ errors.email.join(', ') }}</span>
                <label for="floatingInput">Email address</label>
              </div>
              <div class="form-floating mb-3">
                <input v-model="password" type="password" class="form-control" id="floatingPassword" placeholder="Password" required>
                <span v-if="errors.password" class="error">{{ errors.password.join(', ') }}</span>
                <label for="floatingPassword">Password</label>
              </div>
              <div class="form-floating mb-3">
                <input v-model="confirmPassword" type="password" class="form-control" id="confirmPassword" placeholder="Confirm Password" required>
                <label for="confirmPassword">Confirm Password</label>
              </div>
              <div class="checkbox mb-3">
                <label>
                  <input type="checkbox" value="remember-me"> Remember me
                </label>
              </div>
              <button class="w-100 btn btn-lg btn-primary btn-orange" type="submit">Sign up</button>
              <hr class="my-4">
              <small class="text-muted">Already have an account? <router-link class="text-orange" to="/login">Sign In</router-link></small>
            </form>
          </div>
        </div>
      </div>

</template>

<script>
import {authAxiosInstance} from "@/axios";
import '@/assets/style.css';
export default {
  name: "RegisterPage.vue",
  data() {
    return {
      username: '',
      email: '',
      password: '',
      confirmPassword: '',
      errors: {}
    }
  },
  methods: {
    async register() {
        const data = {
          username: this.username,
          email: this.email,
          password: this.password,
          confirm_password: this.confirmPassword
        }
        try {
          await authAxiosInstance.post('/auth/register', data)
          this.$router.push({name:'login'}) // redirect to login page
        } catch (error) {
          if (error.response && error.response.status === 400) {
            this.errors = error.response.data.errors
          } else {
            console.error(error)
          }
        }
    }
  }
}
</script>

<style scoped>
.error {
  color: red;
  font-size: 12px;
}
.btn-orange {
  background-color: #FC7300;
  border-color: #FC7300;
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
