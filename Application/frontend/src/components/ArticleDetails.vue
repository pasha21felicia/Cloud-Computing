<template>
<div class="container" style="margin-top: 120px">
   <div v-if="loading" class="text-center">Loading...</div>
    <div class="mt-5" v-else>
      <h2 class="my-4 pt-5 text-left">{{article.title}}</h2>
      <h6 class="mb-4"><i class="bi bi-clock"></i> {{formattedTime(article)}}</h6>
      <h6 class="mb-4 bi-text-indent-left"> {{article.category}}</h6>
      <div class="overflow-hidden text-center" style="max-height: 50vh;">
        <div class="container px-0 align-items-center">
          <img :src=article.image_url  class="img-fluid border rounded-3 mb-4" alt="Example image" max-width="100%" height="auto" loading="lazy" style="object-fit: cover;object-position: center;">
        </div>
      </div>
<!--      <h6 class="bi-text-left my-4 fs-6">Authored By <span class="fs-5 fw-bold text-decoration-underline">{{article.author.username}}</span> </h6>-->
      <pre class="mt-3 d-flex justify-content-evenly">{{article.body}}</pre>
      <router-link v-if="isLoggedIn" class="btn btn-orange mt-3" :to="{name:'article-edit', params:{id:article.id}}">Update</router-link>
      <button v-if="isLoggedIn" class="btn btn-danger mx-3 mt-3" @click="deleteArticleData">Delete</button>
    </div>
</div>
</template>

<script>
import {businessAxiosInstance} from "@/axios";
import {mapState} from 'vuex';
export default {
  name: "ArticleDetails.vue",
  data() {
    return {
      article:{},
      loading: true
    }
  },
  props:{
    id:{
      type:[Number, String],
      required:true
    }
  },
  computed: {
    ...mapState(['isLoggedIn'])
  },
  mounted() {
    console.log(this.isLoggedIn)
  },
  methods:{
    formattedTime(article) {
        const datetimeStr = article.date;
        const date = new Date(datetimeStr);
        const formattedDate = date.toLocaleDateString('en-US', {
          day: 'numeric', month: 'long', year: 'numeric',
          hour: 'numeric', minute: 'numeric', second: 'numeric',
          hour12: true,
        });
        return formattedDate;
    },

    deleteArticleData() {
      businessAxiosInstance.delete(`/articles/delete/${this.id}/`)
        .then(() => {
          this.$router.push({
            name: 'home',
          });
        })
        .catch((error) => {
          console.log(error);
        });
    },

    async getArticleData() {
        try {
          console.log(this.id)
          const response = await businessAxiosInstance.get(`/articles/get/${this.id}/`)
          console.log(response)
          this.article = response.data
          this.loading = false
        }
        catch(error) {
          console.log(error);
          return null
        }
      }
  },
  created() {
    this.getArticleData()
  },
}
</script>

<style scoped>
pre {
  font-family: "Helvetica Neue",serif;
  font-size: 1.25rem;
  line-height: 1.5rem;
  display: block;
  margin: 0 0 1rem;
  white-space: pre-wrap;
  -webkit-line-clamp: 30; /* number of lines to show */
}
.btn-orange {
  background-color: #FC7300;
  border-color: #FC7300;
  color: #FFFFFF;
}
</style>