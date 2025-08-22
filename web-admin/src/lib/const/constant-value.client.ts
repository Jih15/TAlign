// // src/lib/const/constant-value.client.ts
// import cookie from "./cookie";

// const BASE_URL = "http://127.0.0.1:8000";

// function getAuthHeader(): {
//   Authorization: string;
//   "Content-Type": string;
// } {
//   const token = cookie.getCookie("access_token");
//   if (!token) throw new Error("Unauthorized: No token found");
//   return {
//     Authorization: `Bearer ${token}`,
//     "Content-Type": "application/json",
//   };
// }

// function handleAuthError(status: number): void {
//   if (status === 401 || status === 403) {
//     document.cookie =
//       "access_token=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT";
//     window.location.href = "/sign-in";
//   }
// }

// export default {
//   BASE_URL,
//   getAuthHeader,
//   handleAuthError,
// };


// src/lib/const/constant-value.client.ts
// "use client";

// import { getCookie, deleteCookie } from "cookies-next"; // ✅ Import dengan benar

// const constantValue = {
//   BASE_URL: process.env.NEXT_PUBLIC_API_URL,

//   getAuthHeader() {
//     const token = getCookie("access_token"); // ✅ Langsung gunakan getCookie

//     return {
//       "Content-Type": "application/json",
//       ...(token ? { Authorization: `Bearer ${token}` } : {}),
//     };
//   },

//   handleAuthError(status: number) {
//     if (status === 401) {
//       deleteCookie("access_token"); // ✅ Langsung gunakan deleteCookie
//       window.location.href = "/sign-in";
//     }
//   },
// };

// export default constantValue;

"use client";

import { getCookie, deleteCookie } from "cookies-next";

const constantValue = {
  BASE_URL: process.env.NEXT_PUBLIC_API_URL,

  // Untuk JSON request
  getAuthHeader() {
    const token = getCookie("access_token");
    return {
      "Content-Type": "application/json",
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };
  },

  // Untuk FormData request
  getAuthHeaderFormData() {
    const token = getCookie("access_token");
    return {
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };
  },

  handleAuthError(status: number) {
    if (status === 401) {
      deleteCookie("access_token");
      window.location.href = "/sign-in";
    }
  },
};

export default constantValue;
