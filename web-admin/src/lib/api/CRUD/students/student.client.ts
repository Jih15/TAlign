"use client";

import constantValue from "@/lib/const/constant-value.client";

export async function getAllStudentsClient() {
  const headers = constantValue.getAuthHeader();
  
  const resData = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/students`, {
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

export async function updateStudentClient(studentId: number, data: any) {
  const headers = constantValue.getAuthHeader();
  
  const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/students/${studentId}`, {
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