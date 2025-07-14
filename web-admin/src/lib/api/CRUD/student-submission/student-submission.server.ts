// src/lib/api/CRUD/student-submissions.server.ts
import constantValueServer from "@/lib/const/constant-value.server";

const route = `${constantValueServer.BASE_URL}/submissions`;

export async function getSubmissionsById(submissionId: number) {
  const headers = await constantValueServer.getAuthHeader();

  const res = await fetch(`${route}/${submissionId}`, {
    method: "GET",
    headers,
    cache: "no-store",
  });

  if (!res.ok) {
    constantValueServer.handleAuthError(res.status);
    throw new Error(`Error fetch submission: ${res.status}`);
  }

  return res.json();
}
