<template>
  <div class="container" style="margin-top: 120px">
      <form @submit.prevent="updateArticle" class="mt-4">
        <input type="text" class="form-control" name="" id="" v-model="title" placeholder="Enter your Article's Title">
        <br>
        <input type="text" class="form-control" name="" id="" v-model="category" readonly>
        <br>
        <textarea rows="10" class="form-control" v-model="body" placeholder="Enter your Article's body"></textarea>
        <br>
        <input type="text" class="form-control" name="" id="" v-model="image_url" placeholder="Enter the new image url">
        <button class="btn btn-orange mt-4">Update Article</button>
      </form>
      <div v-if="error" class="alert alert-warning alert-dismissible fade show mt-5" role="alert">
        <strong>{{error}}</strong>
      </div>
  </div>
</template>

<script>
import {businessAxiosInstance} from "@/axios";

export default {
  name: "ArticleEdit.vue",
  props:{
    id:{
      type:[Number, String],
      required:true
    }
  },
  data() {
    return {
      title: null,
      body:null,
      image_url: null,
      category: null,
      error:null
    }
  },
  beforeRouteEnter(to, from, next) {
  if (to.params.id !== undefined) {
    businessAxiosInstance.get(`/articles/get/${to.params.id}/`)
        .then((response) => {
          const data = response.data;
          return next(
            (vm) =>
              ((vm.title = data.title),
              (vm.body = data.body),
              (vm.category = data.category),
              (vm.image_url = data.image_url))
          );
        })
        .catch((error) => {
          console.log(error);
        });
    } else {
      return next();
    }
  },

  methods: {
    updateArticle() {
      if (!this.title || !this.body) {
        this.error = "Please add all the fields"
      } else {
          let formData = new FormData();

          formData.append('title', this.title);
          formData.append('body', this.body);
          formData.append('category', this.category);
          formData.append('image_url', this.image_url);

          businessAxiosInstance.put(`/articles/update/${this.id}/`, formData)
          .then(() => {
            this.$router.push({name:'home'})
          })
          .catch(error => {
            console.log(error)
          })
      }
    },
  },
}
</script>

<style scoped>
.btn-orange {
  background-color: #FC7300;
  border-color: #FC7300;
  color: #FFFFFF;
}
</style>