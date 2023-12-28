<template>
  <div class="container"  style="margin-top: 120px">
      <form @submit.prevent="createArticle" class="mt-5 pt-5">
        <input type="text" class="form-control" name="" id="" v-model="title" placeholder="Enter your Article's Title">
        <br>
          <div class="dropdown">
            <button class="btn dropdown-toggle btn-outline-secondary" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              {{ selectedCategory || "Select category" }}
            </button>
            <div class="dropdown-menu pt-0 mx-0 rounded-3 shadow overflow-hidden" aria-labelledby="dropdownMenuButton">
              <form class="p-2 mb-2 bg-light border-bottom">
                <input v-model="filter" class="form-control" type="text" placeholder="Filter categories" aria-label="Filter categories"/>
              </form>
              <a v-for="(category, index) in filteredCategories" :key="index" class="dropdown-item d-flex align-items-center gap-2 py-2" @click="selectCategory(category)">
              {{ category }}
              </a>
            </div>
          </div>
        <br>
        <textarea rows="10" class="form-control" v-model="body" placeholder="Enter your Article's body"></textarea>
        <br>
        <input type="text" class="form-control" name="" id="" v-model="image_url" placeholder="Enter the image url for the Article feature picture">
        <br>
        <button class="btn btn-orange mt-4">Publish Article</button>
      </form>
      <div v-if="error" class="alert alert-warning alert-dismissible fade  show mt-5" role="alert">
        <strong>{{error}}</strong>
      </div>
  </div>
</template>

<script>
import {businessAxiosInstance} from "@/axios";
export default {
  name: "Create-app.vue",
  data() {
    return {
      title: null,
      body:null,
      category:null,
      image_url:null,
      error:null,
      categories: ["World", "Business", "Politics", "Local", "Technology", "Design", "Culture", "Social", "Opinion", "Science", "Health", "Style", "Travel"],
      selectedCategory: null,
      filter: "",
    }
  },
  methods:{
    createArticle() {
      if (!this.title || !this.body) {
        this.error = "Please add all the fields"
      } else {
          let formData = new FormData();

          formData.append('title', this.title);
          formData.append('body', this.body);
          formData.append('category', this.selectedCategory);
          formData.append('image_url', this.image_url);
          console.log(formData)
          businessAxiosInstance.post('/articles/add', formData)
          .then(() => {
            this.$router.push({name:'home'})
          })
          .catch(error => {
            console.log(error)
          })
      }
    },
    selectCategory(category) {
      this.selectedCategory = category;
    },
  },
  computed: {
    filteredCategories() {
      if (!this.filter) {
        return this.categories;
      }
      return this.categories.filter((category) =>
        category.toLowerCase().includes(this.filter.toLowerCase())
      );
    },
  },
}
</script>

<style scoped>

.btn-outline-orange {
  border-color: #FC7300;
  color: #FC7300;
}
.btn-outline-orange:hover {
  background-color: #FC7300;
  border-color: #FC7300;
  color: white;
}
.btn-orange:hover {
  background-color: #FC7300;
  border-color: white;
  color: white;
}
.btn-orange {
  background-color: #FC7300;
  border-color: #FC7300;
  color: white;
}
</style>