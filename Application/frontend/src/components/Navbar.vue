<template>
  <div class="fixed-top">
    <div class="container bg-white">
        <header class="blog-header">
          <div class="row flex-nowrap justify-content-between align-items-center">
            <div class="col-4 pt-1" v-if="!isLoggedIn">
              <a class="link-secondary" href="#">Subscribe</a>
            </div>
            <div class="col-4 pt-1" v-if="isLoggedIn">
              <router-link class="btn btn-sm btn-secondary btn-orange" to="/create">Create</router-link>
            </div>
            <div class="col-4 text-center">
              <router-link class="blog-header-logo text-dark" to="/"><img class="d-block mx-auto" src="../assets/newsncloud-logo.png" alt="" width="140" height="65"></router-link>
            </div>
            <div class="col-4 d-flex justify-content-end align-items-center" v-if="!isLoggedIn">
              <a id="search-icon"  @click="toggleSearch" class="link-secondary" href="#" aria-label="Search">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img" viewBox="0 0 24 24"><title>Search</title><circle cx="10.5" cy="10.5" r="7.5"/><path d="M21 21l-5.2-5.2"/></svg>
              </a>
              <form id="search-container" :class="{ 'd-none': !showSearch }" class="w-60" role="search">
                <input type="search" class="form-control" placeholder="Search..." aria-label="Search">
              </form>
                <router-link class="btn btn-sm btn-outline-secondary mx-2 btn-outline-orange" to="/login">Sign In</router-link>
                <router-link class="btn btn-sm btn-outline-secondary btn-orange" to="/register">Register</router-link>
            </div>
            <div class="col-4 d-flex justify-content-end align-items-center" v-if="isLoggedIn">
              <a id="search-icon"  @click="toggleSearch" class="link-secondary" href="#" aria-label="Search">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img" viewBox="0 0 24 24"><title>Search</title><circle cx="10.5" cy="10.5" r="7.5"/><path d="M21 21l-5.2-5.2"/></svg>
              </a>
              <form id="search-container" :class="{ 'd-none': !showSearch }" class="w-60 me-2" role="search">
                <input type="search" class="form-control" placeholder="Search..." aria-label="Search">
              </form>
              <div class="dropdown text-end">
                  <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-haspopup="true"  aria-expanded="false">
                    <img :src=user.image_file alt="mdo" width="32" height="32" class="rounded-circle">
                  </a>
                  <ul class="dropdown-menu text-small" aria-labelledby="dropdownMenuButton" v-once>
<!--                    <li><router-link class="dropdown-item" to="/me/articles">My Articles</router-link></li>-->
<!--                    <li><router-link class="dropdown-item" to="/me">Profile</router-link></li>-->
                    <li><a class="dropdown-item" href="#">Settings</a></li>
                    <li><router-link class="dropdown-item" to="/">Home</router-link></li>
                    <li><hr class="dropdown-divider"></li>
                    <li> <router-link class="dropdown-item" to="/logout"> Sign out </router-link></li>
                  </ul>
              </div>
            </div>
        </div>
        <div class="line bottom"></div>
      </header>

      <div class="nav-scroller py-1 mb-2">
        <nav class="nav d-flex justify-content-between">
          <a class="p-2 link-secondary" href="#">World</a>
          <a class="p-2 link-secondary" href="#">Local</a>
          <a class="p-2 link-secondary" href="#">Technology</a>
          <a class="p-2 link-secondary" href="#">Design</a>
          <a class="p-2 link-secondary" href="#">Culture</a>
          <a class="p-2 link-secondary" href="#">Business</a>
          <router-link class="p-2 link-secondary" to="/politics">Politics</router-link>
<!--          <a class="p-2 link-secondary" href="#">Politics</a>-->
          <a class="p-2 link-secondary" href="#">Opinion</a>
          <a class="p-2 link-secondary" href="#">Science</a>
          <a class="p-2 link-secondary" href="#">Health</a>
          <a class="p-2 link-secondary" href="#">Style</a>
          <a class="p-2 link-secondary" href="#">Travel</a>
        </nav>
      </div>
    </div>
  </div>
</template>

<script>
import {mapState} from 'vuex';
import '@/assets/style.css';
export default {
  name: "Navbar-app",
  data() {
      return {
        showSearch: false,
      }
  },
   methods: {
    toggleSearch() {
      this.showSearch = !this.showSearch;
    },
  },
  computed: {
    ...mapState(['isLoggedIn']),
    ...mapState(['user']),
  },
  mounted() {
    console.log(this.isLoggedIn)
  }
}
</script>

<style scoped>
.text_logo_style {
  font-family: "Helvetica Neue";
  font-size: 30px;
  color: brown;
}
.line.bottom {
  /*position: fixed;*/
  top: 58px;
  left: 0;
  width: 100%;
}
.line {
  height: 1px;
  background-image: linear-gradient(90deg,rgba(0,0,0,0.00) 0%,#000000 50%,rgba(0,0,0,0.00) 100%);
  opacity: .1;
  width: 100%;
}
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
.btn-outline-orange {
  border-color: #FC7300;
  color: #FC7300;
}
.btn-outline-orange:hover {
  background-color: #FC7300;
  border-color: #FC7300;
  color: white;
}
#search-icon {
  cursor: pointer;
}
</style>