// src/lib/api/CRUD/users/users.server.ts
"use server";

import constantValue from "@/lib/const/constant-value.server";
import { cookies } from "next/headers";

// ====================== PROFILE: CURRENT USER ====================== //



export async function getCurrentUserServer() {
  const cookieStore = await cookies(); // ga usah pakai await
  const accessToken = cookieStore.get("access_token")?.value;

  console.log(accessToken)

  const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/users/me`, {
    method: "GET",
    headers: {
      Authorization: `Bearer ${accessToken}`,
      "Content-Type": "application/json",
    },
    cache: "no-store",
  });

  if (!res.ok) {
    throw new Error(`Failed to get current user: ${res.status}`);
  }

  return res.json();
}



// src/lib/api/CRUD/users/users.server.ts
export async function updateCurrentUserServer(data: {
  username: string;
  email: string;
  photo?: File | null;
}) {
  const formData = new FormData();
  formData.append("username", data.username);
  formData.append("email", data.email);
  if (data.photo) {
    formData.append("photo", data.photo); // 🔑 samakan field name
  }

  const headers = await constantValue.getAuthHeaderFormData();

  const res = await fetch(`${constantValue.BASE_URL}/users/me`, {
    method: "PUT",
    headers,
    body: formData,
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Failed to update current user: ${res.status}`);
  }

  return res.json();
}


// ============================ ADMIN ============================ //

export async function getAllUsersServer() {
  const headers = await constantValue.getAuthHeader(); // ✅ Tambahkan await
  
  const res = await fetch(`${constantValue.BASE_URL}/users`, {
    method: "GET",
    headers,
    cache: "no-store",
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Error fetching users: ${res.status}`);
  }

  return res.json();
}

export async function getUserByIdServer(userId: number) {
  const headers = await constantValue.getAuthHeader(); // ✅ Tambahkan await
  
  const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
    method: "GET",
    headers,
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Error fetching user ${userId}: ${res.status}`);
  }

  return res.json();
}

export async function createUserServer(data: any) {
  const headers = await constantValue.getAuthHeader(); // ✅ Tambahkan await
  
  const res = await fetch(`${constantValue.BASE_URL}/users`, {
    method: "POST",
    headers,
    body: JSON.stringify(data),
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    const err = await res.json();
    throw new Error(err.detail || `Failed to create user: ${res.status}`);
  }

  return res.json();
}

export async function updateUserServer(userId: number, data: any) {
  const headers = await constantValue.getAuthHeader(); // ✅ Tambahkan await
  
  const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
    method: "PUT",
    headers,
    body: JSON.stringify(data),
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Failed to update user ${userId}: ${res.status}`);
  }

  return res.json();
}

export async function deleteUserServer(userId: number) {
  const headers = await constantValue.getAuthHeader(); // ✅ Tambahkan await
  
  const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
    method: "DELETE",
    headers,
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Failed to delete user ${userId}: ${res.status}`);
  }

  return res.json();
}

export async function countAllUsersServer() {
  const users = await getAllUsersServer();
  // console.log(users.length);
  return users.length;
}


// export async function getCurrentUserServer() {
//   const headers = await constantValue.getAuthHeader(); // ✅ Tambahkan await
  
//   const res = await fetch(`${constantValue.BASE_URL}/users/me`, {
//     method: "GET",
//     headers,
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to get current user: ${res.status}`);
//   }

//   return res.json();
// }

// src/lib/api/CRUD/users/users.server.ts
// "use server";

// import constantValue from "@/lib/const/constant-value.server";
// import { cookies } from "next/headers";

// // ============================ ADMIN ============================ //

// export async function getAllUsersServer() {
//   try {
//     console.log("🔍 Fetching all users...");
    
//     const headers = await constantValue.getAuthHeader();
//     console.log("🔑 Headers:", headers);
//     console.log("🌐 API URL:", `${constantValue.BASE_URL}/users`);
    
//     const res = await fetch(`${constantValue.BASE_URL}/users`, {
//       method: "GET",
//       headers,
//       cache: "no-store",
//     });

//     console.log("📡 Response status:", res.status);
//     console.log("📡 Response ok:", res.ok);

//     if (!res.ok) {
//       // Coba baca response body untuk detail error
//       const errorBody = await res.text();
//       console.log("❌ Error response body:", errorBody);
      
//       constantValue.handleAuthError(res.status);
//       throw new Error(`Error fetching users: ${res.status} - ${errorBody}`);
//     }

//     const data = await res.json();
//     console.log("✅ Users fetched successfully, count:", data.length || 'unknown');
    
//     return data;
//   } catch (error) {
//     console.error("❌ getAllUsersServer error:", error);
//     throw error;
//   }
// }

// export async function countAllUsersServer() {
//   try {
//     console.log("🔢 Counting all users...");
//     const users = await getAllUsersServer();
//     const count = Array.isArray(users) ? users.length : 0;
//     console.log("✅ User count:", count);
//     return count;
//   } catch (error) {
//     console.error("❌ countAllUsersServer error:", error);
//     // Return 0 instead of throwing to prevent crash
//     return 0;
//   }
// }

// // ====================== PROFILE: CURRENT USER ====================== //

// export async function getCurrentUserServer() {
//   try {
//     const cookieStore = await cookies();
//     const accessToken = cookieStore.get("access_token")?.value;

//     console.log("🔑 Access token exists:", !!accessToken);

//     if (!accessToken) {
//       throw new Error("No access token found");
//     }

//     const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/users/me`, {
//       method: "GET",
//       headers: {
//         Authorization: `Bearer ${accessToken}`,
//         "Content-Type": "application/json",
//       },
//       cache: "no-store",
//     });

//     console.log("📡 getCurrentUser response status:", res.status);

//     if (!res.ok) {
//       const errorBody = await res.text();
//       console.log("❌ getCurrentUser error body:", errorBody);
//       throw new Error(`Failed to get current user: ${res.status} - ${errorBody}`);
//     }

//     return res.json();
//   } catch (error) {
//     console.error("❌ getCurrentUserServer error:", error);
//     throw error;
//   }
// }

// export async function updateCurrentUserServer(data: {
//   username: string;
//   email: string;
//   photo?: File | null;
// }) {
//   try {
//     const formData = new FormData();
//     formData.append("username", data.username);
//     formData.append("email", data.email);
//     if (data.photo) {
//       formData.append("profile_picture", data.photo);
//     }

//     const headers = await constantValue.getAuthHeaderFormData();

//     const res = await fetch(`${constantValue.BASE_URL}/users/me`, {
//       method: "PUT",
//       headers,
//       body: formData,
//     });

//     if (!res.ok) {
//       const errorBody = await res.text();
//       console.log("❌ updateCurrentUser error body:", errorBody);
//       constantValue.handleAuthError(res.status);
//       throw new Error(`Failed to update current user: ${res.status} - ${errorBody}`);
//     }

//     return res.json();
//   } catch (error) {
//     console.error("❌ updateCurrentUserServer error:", error);
//     throw error;
//   }
// }

// export async function getUserByIdServer(userId: number) {
//   try {
//     const headers = await constantValue.getAuthHeader();
    
//     const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
//       method: "GET",
//       headers,
//     });

//     if (!res.ok) {
//       const errorBody = await res.text();
//       console.log(`❌ getUserById(${userId}) error body:`, errorBody);
//       constantValue.handleAuthError(res.status);
//       throw new Error(`Error fetching user ${userId}: ${res.status} - ${errorBody}`);
//     }

//     return res.json();
//   } catch (error) {
//     console.error(`❌ getUserByIdServer(${userId}) error:`, error);
//     throw error;
//   }
// }

// export async function createUserServer(data: any) {
//   try {
//     const headers = await constantValue.getAuthHeader();
    
//     const res = await fetch(`${constantValue.BASE_URL}/users`, {
//       method: "POST",
//       headers,
//       body: JSON.stringify(data),
//     });

//     if (!res.ok) {
//       constantValue.handleAuthError(res.status);
//       const err = await res.json().catch(() => ({ detail: "Unknown error" }));
//       throw new Error(err.detail || `Failed to create user: ${res.status}`);
//     }

//     return res.json();
//   } catch (error) {
//     console.error("❌ createUserServer error:", error);
//     throw error;
//   }
// }

// export async function updateUserServer(userId: number, data: any) {
//   try {
//     const headers = await constantValue.getAuthHeader();
    
//     const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
//       method: "PUT",
//       headers,
//       body: JSON.stringify(data),
//     });

//     if (!res.ok) {
//       const errorBody = await res.text();
//       console.log(`❌ updateUser(${userId}) error body:`, errorBody);
//       constantValue.handleAuthError(res.status);
//       throw new Error(`Failed to update user ${userId}: ${res.status} - ${errorBody}`);
//     }

//     return res.json();
//   } catch (error) {
//     console.error(`❌ updateUserServer(${userId}) error:`, error);
//     throw error;
//   }
// }

// export async function deleteUserServer(userId: number) {
//   try {
//     const headers = await constantValue.getAuthHeader();
    
//     const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
//       method: "DELETE",
//       headers,
//     });

//     if (!res.ok) {
//       const errorBody = await res.text();
//       console.log(`❌ deleteUser(${userId}) error body:`, errorBody);
//       constantValue.handleAuthError(res.status);
//       throw new Error(`Failed to delete user ${userId}: ${res.status} - ${errorBody}`);
//     }

//     return res.json();
//   } catch (error) {
//     console.error(`❌ deleteUserServer(${userId}) error:`, error);
//     throw error;
//   }
// }