// src/lib/api/CRUD/student-submissions.client.ts
import constantValueClient from "@/lib/const/constant-value.client";

const route = `${constantValueClient.BASE_URL}/submissions`;

export async function getAllSubmissions() {
  const res = await fetch(route, {
    method: "GET",
    headers: constantValueClient.getAuthHeader(),
    cache: "no-store",
  });

  if (!res.ok) {
    constantValueClient.handleAuthError(res.status);
    throw new Error(`Error fetch submissions: ${res.status}`);
  }

  return res.json();
}
