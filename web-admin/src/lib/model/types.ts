// lib/model/types.ts

export type Difficulty = "Easy" | "Medium" | "Hard";
export type IdeaSource = "Generate" | "Manual";
export type TitleStatus = "WAITING_REVIEW" | "APPROVED" | "REJECTED" | "REVISED";

export interface Student {
  student_id: number;
  nim: number;
  full_name: string;
  majors: string;
  study_program: string;
  user_id: number;
  created_at: string;
  updated_at: string;
}

export interface Submission {
  title: string;
  title_field: string;
  difficulty: Difficulty;
  idea_source: IdeaSource;
  title_status: TitleStatus;
  similarity_score: number;
  submission_id: number;
  student_id: number;
  created_at: string;
  updated_at: string;
  student: Student;
}

export interface Status {
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
