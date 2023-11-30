// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: process.env.FIREBASE,
    authDomain: "blog-98101.firebaseapp.com",
    projectId: "blog-98101",
    storageBucket: "blog-98101.appspot.com",
    messagingSenderId: "581230852156",
    appId: "1:581230852156:web:e1c1925f6aafdaf0b6ab39"
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);