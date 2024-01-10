import axios from 'axios';

const authAxiosInstance = axios.create({
  baseURL: 'http://'+process.env.VUE_APP_AUTH_URL,
  headers: {
      'Content-Type': 'application/json',
      'Access-Control-Expose-Headers': 'Authorization',
      'Access-Control-Allow-Origin': '*'
  }
});

const businessAxiosInstance = axios.create({
  baseURL: 'http://'+process.env.VUE_APP_BACKEND_URL,
  headers: {
      'Content-Type': 'application/json',
      'Access-Control-Expose-Headers': 'Authorization',
      'Access-Control-Allow-Origin': '*'
  }
});

export { authAxiosInstance, businessAxiosInstance };