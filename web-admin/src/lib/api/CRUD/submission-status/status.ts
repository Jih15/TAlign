
import { getAllSubmissionStatusServer } from "./submission-status.server";
import { getAllSubmissionStatusClient } from "./submission-status.client";

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

export async function countPendingSubmissions(): Promise<number> {
  let submissions: SubmissionStatus[] = [];

  if (typeof window === "undefined") {
    // server-side
    submissions = await getAllSubmissionStatusServer();
  } else {
    // client-side
    submissions = await getAllSubmissionStatusClient();
  }

  return submissions.filter((s) => s.status === "WAITING_REVIEW").length;
}

