// // src/lib/api/CRUD/student-submissions-status.server.ts
// import constantValueServer from "@/lib/const/constant-value.server";
// import { SubmissionStatus } from "./status";

// const route = `${constantValueServer.BASE_URL}/status`;

// export async function getAllSubmissionStatusServer(): Promise<SubmissionStatus[]> {
//   const headers = await constantValueServer.getAuthHeader();

//   const res = await fetch(route, {
//     headers,
//     cache: "no-store",
//   });

//   if (!res.ok) throw new Error(`Error fetch submission-status: ${res.status}`);

//   return res.json();
// }

// export async function getSubmissionStatusesByIdServer(submissionId: number): Promise<SubmissionStatus[]> {
//   const headers = await constantValueServer.getAuthHeader();

//   const res = await fetch(`${route}/submission/${submissionId}`, {
//     headers,
//     cache: "no-store",
//   });

//   if (!res.ok) throw new Error(`Error fetch submission-status by id: ${res.status}`);

//   return res.json();
// }

import constantValueServer from "@/lib/const/constant-value.server";
import { SubmissionStatus } from "./status";

const route = `${constantValueServer.BASE_URL}/status`;

export async function getAllSubmissionStatusServer(): Promise<SubmissionStatus[]> {
  const headers = await constantValueServer.getAuthHeader();

  const res = await fetch(route, {
    headers,
    cache: "no-store",
  });

  if (!res.ok) throw new Error(`Error fetch submission-status: ${res.status}`);

  return res.json();
}

export async function getSubmissionStatusesByIdServer(submissionId: number): Promise<SubmissionStatus[]> {
  const headers = await constantValueServer.getAuthHeader();

  const res = await fetch(`${route}/submission/${submissionId}`, {
    headers,
    cache: "no-store",
  });

  if (!res.ok) throw new Error(`Error fetch submission-status by submissionId: ${res.status}`);

  return res.json();
}

/**
 * Review submission status (Approve / Revise / Reject)
 */
export async function submissionStatusReviewServer(
  statusId: number,
  status: "APPROVED" | "REVISED" | "REJECTED",
  comment?: string
) {
  const headers = {
    ...await constantValueServer.getAuthHeader(),
    "Content-Type": "application/json",
  };

  const res = await fetch(`${route}/${statusId}/review`, {
    method: "PUT",
    headers,
    body: JSON.stringify({ status, comment: comment ?? null }),
  });

  if (!res.ok) {
    const err = await res.json();
    throw new Error(err.detail || `Failed to review status: ${res.status}`);
  }

  return res.json();
}
