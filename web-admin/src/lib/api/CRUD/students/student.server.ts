"use server";

import constantValue from "@/lib/const/constant-value.server";

export async function getAllStudentsServer() {
  const headers = await constantValue.getAuthHeader();
  
  const resData = await fetch(`${process.env.API_URL}/students`, {
    method: "GET",
    headers,
    cache: "no-store",
  });

  if (!resData.ok) {
    constantValue.handleAuthError(resData.status);
    throw new Error(`Failed to fetch students: ${resData.status}`);
  }

  return resData.json();
}

export async function updateStudentServer(studentId: number, data: any) {
  const headers = await constantValue.getAuthHeader();
  
  const res = await fetch(`${process.env.API_URL}/students/${studentId}`, {
    method: "PUT",
    headers,
    body: JSON.stringify(data)
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Failed to update student ${studentId}: ${res.status}`);
  }

  return res.json();
}

  export async function countAllStudentsServer(){
    const students = await getAllStudentsServer();
    console.log(students.length);
    return students.length;
  }