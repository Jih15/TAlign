// // src/lib/const/constant-value.server.ts

// import { cookies } from "next/headers";

// const BASE_URL = "http://127.0.0.1:8000";


// export async function getAccessToken(): Promise<string> {
//   // cookies() sekarang async → harus di-await
//   const cookieStore = await cookies();
//   const token = cookieStore.get("access_token")?.value;

//   if (!token) {
//     throw new Error("Unauthorized: No token found (server)");
//   }

//   return token;
// }

// // async function getAuthHeader(): Promise<{
// //   Authorization: string;
// //   "Content-Type": string;
// // }> {
// //   const cookieStore = await cookies(); // pakai await
// //   const token = cookieStore.get("access_token")?.value;

// //   if (!token) throw new Error("Unauthorized: No token found");

// //   return {
// //     Authorization: `Bearer ${token}`,
// //     "Content-Type": "application/json",
// //   };
// // }

// export async function getAuthHeader() {
//   // cookies() sekarang async
//   const cookieStore = await cookies();
//   const token = cookieStore.get("access_token")?.value;

//   if (!token) throw new Error("Unauthorized: No token found (server)");

//   return {
//     Authorization: `Bearer ${token}`,
//     "Content-Type": "application/json",
//   };
// }

// function handleAuthError(status: number): void {
//   if (status === 401 || status === 403) {
//     console.warn("Unauthorized access (server-side)");
//   }
// }

// export default {
//   BASE_URL,
//   getAuthHeader,
//   handleAuthError,
// };


// src/lib/const/constant-value.server.ts
// import { cookies } from "next/headers";
// import { redirect } from "next/navigation";

// const constantValue = {
//   BASE_URL: process.env.API_URL,

//   async getAuthHeader() {
//     const cookieStore = await cookies();
//     const token = cookieStore.get("access_token")?.value;

//     return {
//       "Content-Type": "application/json",
//       ...(token ? { Authorization: `Bearer ${token}` } : {}),
//     };
//   },

//   handleAuthError(status: number) {
//     if (status === 401) {
//       // Di server-side, gunakan redirect untuk mengarahkan ke halaman login
//       redirect("/sign-in");
//     }
//   },
// };

// export default constantValue;

// src/lib/const/constant-value.server.ts
import { cookies } from "next/headers";
import { redirect } from "next/navigation";

const constantValue = {
  BASE_URL: process.env.API_URL,

  // Untuk request JSON
  async getAuthHeader() {
    const cookieStore = await cookies();
    const token = cookieStore.get("access_token")?.value;

    return {
      "Content-Type": "application/json",
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };
  },

  // Untuk request FormData (biarkan browser/Node set Content-Type)
  async getAuthHeaderFormData() {
    const cookieStore = await cookies();
    const token = cookieStore.get("access_token")?.value;

    return {
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
    };
  },

  handleAuthError(status: number) {
    if (status === 401) {
      redirect("/sign-in");
    }
  },
};

export default constantValue;


