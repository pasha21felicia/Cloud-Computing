import {createRouter, createWebHistory} from "vue-router";
import Home from './components/Home.vue'
import Create from './components/Create.vue'
import ArticleDetails from "./components/ArticleDetails.vue";
import ArticleEdit from "./components/ArticleEdit.vue";
import Register from "@/components/Register.vue";
import Login from "@/components/Login.vue";
import Profile from "@/components/profile.vue";
import Logout from "@/components/Logout.vue";
import Politics from "@/components/SecondNavbarCategories/Politics.vue";

const routes = [
    {
        path: '/',
        name: 'home',
        component : Home
    },
    {
        path: '/politics',
        name: 'politics',
        component : Politics
    },
    {
        path: '/create',
        name: 'create',
        component : Create
    },
    {
        path: '/details/:id',
        name: 'details',
        component : ArticleDetails,
        props: true
    },
    {
        path: '/update/:id',
        name: 'article-edit',
        component : ArticleEdit,
        props: true
    },
    {
        path: '/register',
        name: 'register',
        component : Register
    },
    {
        path: '/login',
        name: 'login',
        component : Login
    },
    {
        path: '/me',
        name: 'profile',
        component : Profile
    },
    {
        path: '/logout',
        name: 'logout',
        component : Logout
    }
]

const router = createRouter( {
    history:createWebHistory(),
    routes,
})

export default router;