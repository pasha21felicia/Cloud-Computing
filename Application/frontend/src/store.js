import {authAxiosInstance} from "@/axios";
import jwt_decode from 'jwt-decode';
import { createStore } from 'vuex';

const state = {
    token: sessionStorage.getItem('token'),
    user: null,
    isLoggedIn: false
};

const mutations = {
    setUser(state, user) {
        state.isLoggedIn = true;
        state.user = user;
    },
    setToken(state, token) {
        state.token = token;
        sessionStorage.setItem('token', token);
  },
    removeUser(state) {
        state.isLoggedIn = false;
        state.user = null;
    },
    removeToken(state) {
        state.token = null;
        state.refresh_token = null;
        sessionStorage.removeItem('token');
    },
};

const actions = {
  async login({ commit }, user) {
      const response = await authAxiosInstance.post('/login', user)
      try {
        // If the login was successful, commit the setToken mutation with the JWT token
        const token = response.data.access_token;
        // const refresh_token = response.data.refresh_token;
        commit('setToken', token);
        const decoded = jwt_decode(token);
        console.log(decoded)
        return response.data.user;
      } catch (error) {
          throw Error("Invalid email or password format")
      }
  },
    logout({ commit }) {
        commit('removeUser');
        commit('removeToken');
        sessionStorage.clear()
    },

    async initialize({ commit, state }) {
        if (state.token && state.user) {
            // User and token already exist, return existing data
            return;
        }
        const token = sessionStorage.getItem('token')
        if (token) {
            const response = await authAxiosInstance.get('/me')
            const user = response.data
            commit('setToken', token)
            commit('setUser', user)
            console.log("initialise")
            return user;
        }
        return null;
    }
};
const store = createStore({
    state,
    mutations,
    actions,
})
export default store;