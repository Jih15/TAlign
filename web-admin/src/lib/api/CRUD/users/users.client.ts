// src/lib/api/CRUD/users/users.client.ts
"use client";

import constantValue from "@/lib/const/constant-value.client";

// ====================== PROFILE: CURRENT USER ====================== //

export async function getCurrentUserClient() {
  const headers = constantValue.getAuthHeader();
  
  const res = await fetch(`${constantValue.BASE_URL}/users/me`, {
    method: "GET",
    headers,
    cache: "no-store",
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Failed to get current user: ${res.status}`);
  }

  return res.json();
}


export async function updateCurrentUserClient(data: {
  email: string;
  username: string;
  profile_picture?: File;
}) {
  const formData = new FormData();
  formData.append("email", data.email);
  formData.append("username", data.username);
  if (data.profile_picture) {
    formData.append("photo", data.profile_picture);
  }
  
  const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/users/me`, {
    method: "PUT",
    headers: constantValue.getAuthHeaderFormData(), 
    body: formData,
    credentials: "include", 
  });
  
  if (!res.ok) {
    if (res.status === 401) {
      constantValue.handleAuthError(res.status);
    }
    throw new Error(`Failed to update user: ${res.status}`);
  }
  
  return res.json();
}
// export async function updateCurrentUserClient(data: any) {
//   const headers = constantValue.getAuthHeader();
  
//   const res = await fetch(`${constantValue.BASE_URL}/me`, {
//     method: "PUT",
//     headers,
//     body: JSON.stringify(data),
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to update current user: ${res.status}`);
//   }

//   return res.json();
// }



// ============================ ADMIN ============================ //

export async function getAllUsersClient() {
  const headers = constantValue.getAuthHeader();
  
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

export async function getUserByIdClient(userId: number) {
  const headers = constantValue.getAuthHeader();
  
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

export async function createUserClient(data: any) {
  const headers = constantValue.getAuthHeader();
  
  const formData = new FormData();
  formData.append('username', data.username);
  formData.append('email', data.email);
  formData.append('password', data.password);
  formData.append('role', data.role);
  
  // Add photo if exists
  if (data.photo) {
    formData.append('photo', data.photo);
  }

  // Remove Content-Type from headers - let browser set it for FormData
  const formHeaders = { ...headers };
  delete formHeaders['Content-Type'];
  
  const res = await fetch(`${constantValue.BASE_URL}/users`, {
    method: "POST",
    headers: formHeaders, 
    body: formData, 
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    const err = await res.json();
    throw new Error(err.detail || `Failed to create user: ${res.status}`);
  }

  return res.json();
}

export async function updateUserClient(userId: number, data: any) {
  const headers = constantValue.getAuthHeader();
  
  const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/users/${userId}`, {
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

export async function deleteUserClient(userId: number) {
  const headers = constantValue.getAuthHeader();
  
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

export async function countAllUsersClient() {
  const users = await getAllUsersClient();
  return users.length;
}