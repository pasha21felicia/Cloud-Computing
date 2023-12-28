import axios from 'axios';

const authAxiosInstance = axios.create({
  baseURL: 'http://127.0.0.1:8001',
  headers: {
      'Content-Type': 'application/json',
      'Access-Control-Expose-Headers': 'Authorization',
      'Access-Control-Allow-Origin': '*'
  }
});

const businessAxiosInstance = axios.create({
  baseURL: 'http://127.0.0.1:8000',
  headers: {
      'Content-Type': 'application/json',
      'Access-Control-Expose-Headers': 'Authorization',
      'Access-Control-Allow-Origin': '*'
  }
});

export { authAxiosInstance, businessAxiosInstance };