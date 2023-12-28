import { createApp } from 'vue'
import App from './App.vue'
import 'bootstrap/dist/css/bootstrap.min.css'
import 'bootstrap-icons/font/bootstrap-icons.css'
import 'bootstrap/dist/js/bootstrap.bundle.min.js';

import router from './routers'
import store from './store'
import {businessAxiosInstance, authAxiosInstance} from "@/axios";

businessAxiosInstance.interceptors.request.use(
  (config) => {
    const token = store.state.token;
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

businessAxiosInstance.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response && error.response.status === 401) {
      console.log('Unauthorized request. Logging out.');
      store.dispatch('logout');
      router.push('/login');
    }
    return Promise.reject(error);
  }
);

// Set up Axios interceptor to automatically add the token to every request
authAxiosInstance.interceptors.request.use((config) => {
    const token = sessionStorage.getItem('token');
    if (token) {
        config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
});

const app = createApp(App);
app.use(router);
app.use(store);

app.mixin({
  created() {
    this.$store.dispatch('initialize');
  },
});

app.mount('#app');
