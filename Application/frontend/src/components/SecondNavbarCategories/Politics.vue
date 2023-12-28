<template>
  <div class="container" style="margin-top: 120px">
    <div class="p-4 p-md-5 mb-4 rounded hero" v-if="!loading">
      <img :src=featuredArticle.image_url alt="image">
      <div class="col-md-6 px-0 hero-text">
        <h1 class="display-4 fst-italic hero-title" v-if="!loading">{{ featuredArticle.title }}</h1>
        <p class=" my-3 my-truncate my-truncate-2-lines hero-subtitle" v-if="!loading">{{ featuredArticle.body }}</p>
        <p class="lead mb-0"><router-link class="text-orange-50" :to="{name:'details', params:{id:featuredArticle.id}}">Continue reading...</router-link></p>
        <small class="text-white-50" v-if="!loading">{{ formattedTime(featuredArticle.date) }}</small>
      </div>
      <div class="hero-overlay"></div>
    </div>

<!--    Featured article section   ·  -->
    <section>
        <div class="row g-5">
          <div class="col-md-8">
            <article class="blog-post">
              <h2 class="fst-italic blog-post-title mb-4" v-if="!loading">{{ featuredArticle.title }}</h2>
              <p class="blog-post-meta border-bottom" v-if="!loading"><span class="bi-text-left">{{featuredArticle.category }}</span>
                · {{ formatDate(featuredArticle.date) }} by
<!--                <span class="text-decoration-underline fw-bold">{{ featuredArticle.author.username }}</span>-->
              </p>
              <pre class="my-truncate text-color-grey" v-if="!loading">{{ featuredArticle.body }}</pre>
              <hr>
            </article>
          </div>
        <div class="col-md-4">
          <div class="position-sticky" style="top: 2rem;">
            <div class="p-4 mb-3 bg-light rounded">
              <h4 class="fst-italic text-orange">Politics</h4>
              <p class="mb-0">We provide our readers with in-depth analysis of the latest political news of the world, fostering a vibrant community of curious minds and informed citizens.</p>
            </div>

            <div class="p-4">
              <h4 class="fst-italic mb-3 text-orange">Latest Updates</h4>
              <ol class="list-unstyled" v-for="article in articles.slice(0,5)" :key="article.id">
                <li>
                  <div class="card">
                    <router-link class="link-style fw-bold fs-5 text-color-grey mb-2" :to="{name:'details', params:{id:article.id}}" v-if="!loading">{{article.title}}</router-link>
                    <small class="text-muted mb-3" v-if="!loading">{{article.category}}  ·  {{ formatDate(article.date) }}</small>
                  </div>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </div>
    </section>
<!--    All news section-->
    <section>
      <div class="album mt-5">
        <h3 class="fst-italic mb-3 text-orange">Politics Collection</h3>
        <div class="row row-cols-sm-1 row-cols-md-3 row-cols-lg-5 g-3">
          <div v-for="article in articles.slice(0,15)" :key="article.id" class="col-xx">
            <div class="card">
              <router-link class="link-style" :to="{name:'details', params:{id:article.id}}" >
                <img :src=article.image_url class="card-img-top card-img" alt="Article Image" width="100%" style="height: auto">
                <div class="card-body" >
                  <div class="d-flex justify-content-between mb-3">
                    <small class="bi-text-left" v-if="!loading">{{ article.category }}</small>
                  </div>
                  <h5 class="card-title text-color-grey mb-3" v-if="!loading">{{ article.title }}</h5>
                  <div class="d-flex justify-content-between">
                    <small class="text-muted" v-if="!loading">{{ formatDate(article.date) }}</small>
                  </div>
                </div>
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import {businessAxiosInstance} from "@/axios";
// import { mapGetters } from 'vuex';
export default {
  name: "Politics-page",
  data() {
    return {
      articles:[],
      featuredArticle:null,
      loading: true
    }
  },
  methods: {
    async getArticles() {
        try {
          const category = 'Politics'
          const response = await businessAxiosInstance.get(`/articles/${category}/`)
          console.log(response.data)
          if (response.status === 201) {
            this.articles.push(...response.data)
            this.featuredArticle = this.articles[this.articles.length - 1]
            this.loading = false
          }
        }
        catch(error) {
          console.log(error);
          return null
        }
    },
  },
  async created() {
      await this.getArticles()
  },
  computed: {
    formatDate() {
      return function(dateStr) {
        const dateObj = new Date(dateStr)
        const options = { day: 'numeric', month: 'long', year: 'numeric' }
        return dateObj.toLocaleDateString('en-US', options)
      }
    },
    formattedTime() {
      return function(datetimeStr) {
        const date = new Date(datetimeStr);
        return date.toLocaleDateString('en-US', {
          day: 'numeric', month: 'long', year: 'numeric',
          hour: 'numeric', minute: 'numeric', second: 'numeric',
          hour12: true,
        });
      }
    },
  }
}
</script>

<style scoped>
.link-style {
  color: black;
  text-decoration: none;
}
.link-style:hover {
  color: #434242;
  text-decoration: none;
}
.btn-orange {
  background-color: #FC7300;
  border-color: #FC7300;
}
.text-orange {
  color: #FC7300;
}
.card-title {
  font-size: 1.1rem; /* Change this value to adjust the font size */
  margin-bottom: 0.2rem;
}
.card-body {
  padding: 0.7rem 0;
}
.card {
  border: none;
}
.my-truncate {
  overflow: hidden;
  display: -webkit-box;
  /*-webkit-line-clamp: 2; !* number of lines to show *!*/
  -webkit-box-orient: vertical;
}
.my-truncate-2-lines {
  -webkit-line-clamp: 2; /* number of lines to show */
}
.my-truncate-3-lines {
  -webkit-line-clamp: 3; /* number of lines to show */
}
.text-orange-50 {
  color: #FC7300;
  opacity: 70%;
}
.line.bottom {
  width: 100%;
}
.line {
  height: 1px;
  background-image: linear-gradient(90deg,rgba(0,0,0,0.00) 0%,#000000 50%,rgba(0,0,0,0.00) 100%);
  opacity: .1;
  width: 100%;
}
.hero-overlay {
    height: 100%;
    width: 100%;
    opacity: 0.6;
    z-index: 2;
    background-color: rgb(12, 12, 12);
    position: absolute;
    top: 0;
    left: 0;
}
.hero img {
    position: absolute;
    height: 100%;
    width: 100%;
    object-fit: cover;
    object-position: top;
    top: 0;
    left: 0;
}
.hero {
    position: relative;
    overflow: hidden;
    width: 100%;
    display: flex;
    padding: 190px 30px;
    box-sizing: border-box;
}

.hero-text {
    z-index: 3;
    color: #FFFFFF;
    position: relative;
}
pre {
  font-family: "Helvetica Neue";
  font-size: 1.1rem;
  line-height: 1.5rem;
  display: block;
  margin: 0 0 1rem;
  white-space: pre-wrap;
  -webkit-line-clamp: 30; /* number of lines to show */
}
.text-color-grey {
  color: #404040;
}
</style>
