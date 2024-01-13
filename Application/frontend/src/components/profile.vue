<template>
<div class="container" style="margin-top: 120px">
  <div v-if="loading" class="text-center">Loading...</div>
  <div class="mt-5" v-else>
      <h1 class="mt-5 pt-5" v-if="!loading">The profile of user: {{user.username}}</h1>
  </div>
</div>
</template>

<script>
import { mapState } from 'vuex'
import {authAxiosInstance} from "@/axios";
export default {
  name: "Profile-page.vue",
  data() {
    return {
      user: {},
      loading: true,
    }
  },
  computed: {
    ...mapState(['token'])
  },
  methods: {
    async getUserProfile() {
        try {
          // axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${this.token}`;
          const response = await authAxiosInstance.get('/auth/me')
          if (response.status === 201 || response.status === 200) {
            this.loading = false
            this.user = response.data
          }
        }
        catch(error) {
          console.log(error);
          return null
        }
      },
    },
    async created() {
      await this.getUserProfile()
    }
}
</script>

<style scoped>

</style>