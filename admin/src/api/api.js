import {API_BASE_URL,ACCESS_TOKEN} from '../constant/constant'
import axios from 'axios';

const config = {
    Accept: "application/json",
    "Content-Type": "application/json",
};

const instance = axios.create({
    baseURL: API_BASE_URL,
    config: config,
});

instance.interceptors.request.use(async (config)=> {
    if(localStorage.getItem(ACCESS_TOKEN)){
        const token = await localStorage.getItem(ACCESS_TOKEN)
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
})



export default instance;