// import constantValue from "@/lib/const/constant-value.client";

// // ====================== PROFILE: CURRENT USER ====================== //

// export async function getCurrentUser(){
//   const res = await fetch(`${constantValue.BASE_URL}/me`, {
//     method: "GET",
//     headers: constantValue.getAuthHeader(),
//   });

//   if (!res.ok){
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to get current user: ${res.status}`);
//   }

//   return res.json();
// }


// export async function updateCurrentUser(data: any){
//   const res = await fetch(`${constantValue.BASE_URL}/me`, {
//     method: "PUT",
//     headers: constantValue.getAuthHeader(),
//     body: JSON.stringify(data),
//   });

//   if (!res.ok){
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to update current user: ${res.status}`);
//   }

//   return res.json();
// }

// // ============================ ADMIN ============================ //

// export async function getAllUsers() {
//   const res = await fetch(`${constantValue.BASE_URL}/users`,{
//     method: "GET",
//     headers: constantValue.getAuthHeader(),
//     cache: "no-store",
//   });

//   if (!res.ok){
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Error fetching users: ${res.status}`);
//   }

//   return res.json();
// }


// export async function getUserById(userId:number) {
//   const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`,{
//     method: "GET",
//     headers: constantValue.getAuthHeader(),
//   });

//   if (!res.ok){
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Error fetching user ${userId}: ${res.status}`);
//   }

//   return res.json();
// }


// export async function createUser(data:any) {
//   const res = await fetch(`${constantValue.BASE_URL}/users`, {
//     method: "POST",
//     headers: constantValue.getAuthHeader(),
//     body: JSON.stringify(data)
//   });

//   if (!res.ok){
//     constantValue.handleAuthError(res.status);
//     const err = await res.json();
//     throw new Error(err.detail || `Failed to create user: ${res.status}`);    
//   }

//   return res.json();
// }


// export async function updateUser(userId:number, data:any) {
//   const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
//     method: "PUT",
//     headers: constantValue.getAuthHeader(),
//     body: JSON.stringify(data)
//   });

//   if (!res.ok){
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to update user ${userId}: ${res.status}`);
//   }

//   return res.json();
// }


// export async function deleteUser(userId:number) {
//   const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`,{
//     method: "DELETE",
//     headers: constantValue.getAuthHeader(),
//   });

//   if (!res.ok){
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to delete user ${userId}: ${res.status}`);
//   }

//   return res.json();
// }


// export async function countAllUsers() {
//   const users = await getAllUsers();
//   return users.length;
// }


// // src/lib/api/CRUD/users/users.ts
// import constantValue from "@/lib/const/contsant-value";

// // ====================== PROFILE: CURRENT USER ====================== //

// export async function getCurrentUser() {
//   const res = await fetch(`${constantValue.BASE_URL}/me`, {
//     method: "GET",
//     headers: await constantValue.getAuthHeader(),
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to get current user: ${res.status}`);
//   }

//   return res.json();
// }

// export async function updateCurrentUser(data: any) {
//   const res = await fetch(`${constantValue.BASE_URL}/me`, {
//     method: "PUT",
//     headers: await constantValue.getAuthHeader(),
//     body: JSON.stringify(data),
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to update current user: ${res.status}`);
//   }

//   return res.json();
// }

// // ============================ ADMIN ============================ //

// export async function getAllUsers() {
//   const res = await fetch(`${constantValue.BASE_URL}/users`, {
//     method: "GET",
//     headers: await constantValue.getAuthHeader(),
//     cache: "no-store",
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Error fetching users: ${res.status}`);
//   }

//   return res.json();
// }

// export async function getUserById(userId: number) {
//   const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
//     method: "GET",
//     headers: await constantValue.getAuthHeader(),
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Error fetching user ${userId}: ${res.status}`);
//   }

//   return res.json();
// }

// export async function createUser(data: any) {
//   const res = await fetch(`${constantValue.BASE_URL}/users`, {
//     method: "POST",
//     headers: await constantValue.getAuthHeader(),
//     body: JSON.stringify(data),
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     const err = await res.json();
//     throw new Error(err.detail || `Failed to create user: ${res.status}`);
//   }

//   return res.json();
// }

// export async function updateUser(userId: number, data: any) {
//   const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
//     method: "PUT",
//     headers: await constantValue.getAuthHeader(),
//     body: JSON.stringify(data),
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to update user ${userId}: ${res.status}`);
//   }

//   return res.json();
// }

// export async function deleteUser(userId: number) {
//   const res = await fetch(`${constantValue.BASE_URL}/users/${userId}`, {
//     method: "DELETE",
//     headers: await constantValue.getAuthHeader(),
//   });

//   if (!res.ok) {
//     constantValue.handleAuthError(res.status);
//     throw new Error(`Failed to delete user ${userId}: ${res.status}`);
//   }

//   return res.json();
// }

// export async function countAllUsers() {
//   const users = await getAllUsers();
//   // console.log(users);
//   return users.length;
// }
