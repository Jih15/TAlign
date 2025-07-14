import constantValueClient from "@/lib/const/constant-value.client";

/**
 * Struktur data yang dikembalikan endpoint `/submission-status`
 * -> silakan lengkapi/ubah enum & tipe sesuai skema real di backend.
 */
export interface SubmissionStatus {
  status_id: number;
  submission_id: number;
  student_id: number;
  lecturer_id: number;
  status: "WAITING_REVIEW" | "APPROVED" | "REJECTED" | "REVISED";
  created_at: string;
  updated_at: string;

  student_submission: {
    title: string;
    title_field: string;
    difficulty: string;
    idea_source: string;
    title_status: string;
    submission_id: number;
    student_id: number;
    created_at: string;
    updated_at: string;
  };

  student: {
    nim: number;
    full_name: string;
    majors: string;
    study_program: string;
  };

  lecturer: {
    nip: number;
    fullname: string;
    field: string;
  };
}

const route = `${constantValueClient.BASE_URL}/submission-status`;

export async function getAllSubmissionStatus(): Promise<SubmissionStatus[]> {
  const res = await fetch(route, {
    headers: constantValueClient.getAuthHeader(),
  });

  if (!res.ok) {
    // tangani kasus token expired dlsb
    constantValueClient.handleAuthError(res.status);
    throw new Error(`Error fetch submission-status: ${res.status}`);
  }

  return res.json() as Promise<SubmissionStatus[]>;
}
