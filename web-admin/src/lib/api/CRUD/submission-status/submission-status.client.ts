// // src/lib/api/CRUD/student-submissions-status.client.ts
// import constantValueClient from "@/lib/const/constant-value.client";
// import { SubmissionStatus } from "./status";

// const route = `${constantValueClient.BASE_URL}/status`;

// export async function getAllSubmissionStatusClient(): Promise<SubmissionStatus[]> {
//   const res = await fetch(route, {
//     headers: constantValueClient.getAuthHeader(),
//   });

//   if (!res.ok) {
//     constantValueClient.handleAuthError(res.status);
//     throw new Error(`Error fetch submission-status: ${res.status}`);
//   }

//   return res.json();
// }

// export async function getSubmissionStatusBySubIdClient(submissionId:number): Promise<SubmissionStatus[]> {
//   const headers = await constantValueClient.getAuthHeader();

//   const res = await fetch(`${route}/submission/${submissionId}`, {
//     headers,
//     cache: "no-store"
//   });

//   if (!res.ok) throw new Error(`Error fetch submission-status by id: ${res.status}`);

//   return res.json();
// }


// export async function SubmissionStatusReviewClient(submissionId:number) {
  
// }

import constantValueClient from "@/lib/const/constant-value.client";
import { SubmissionStatus } from "./status";

const route = `${constantValueClient.BASE_URL}/status`;

export async function getAllSubmissionStatusClient(): Promise<SubmissionStatus[]> {
  const res = await fetch(route, {
    headers: constantValueClient.getAuthHeader(),
  });

  if (!res.ok) {
    constantValueClient.handleAuthError(res.status);
    throw new Error(`Error fetch submission-status: ${res.status}`);
  }

  return res.json();
}

export async function getSubmissionStatusBySubIdClient(submissionId: number): Promise<SubmissionStatus[]> {
  const headers = await constantValueClient.getAuthHeader();

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
export async function submissionStatusReviewClient(
  statusId: number,
  status: "APPROVED" | "REVISED" | "REJECTED",
  comment?: string
) {
  const headers = {
    ...constantValueClient.getAuthHeader(),
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
