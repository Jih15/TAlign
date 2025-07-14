import { getSubmissionsById } from "@/lib/api/CRUD/student-submission/student-submission.server";
import { notFound } from "next/navigation";
import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import { formatStatus } from "../helper/submission-utils";

export default async function SubmissionDetailPage({ params }: { params: Promise<{ submissionId: string }> }) {
  const awaitedParams = await params;
  const id = Number(awaitedParams.submissionId);
  if (isNaN(id)) return notFound();

  const submission = await getSubmissionsById(id);
  if (!submission) return notFound();

  return (
    <div className="space-y-6">
      <Breadcrumb
        pageName={`Submissions Detail`}
        parentPages={[
          { name: "Student Submissions", href: "/student-submissions" },
        ]}
      />

      <div className="rounded-xl bg-white dark:bg-gray-dark p-12 shadow-md space-y-6">
        {/* <h1 className="text-2xl font-bold text-dark dark:text-white">
          Submission Detail
        </h1> */}

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* Student Information */}
          <div className="md:col-span-2">
            <h2 className="text-lg font-semibold mb-4">Student Information</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 p-6 bg-gray-100 dark:bg-gray-800 rounded-lg">
              <div>
                <p className="font-semibold">Name</p>
                <p className="dark:text-white text-black font-medium">{submission.student.full_name}</p>
              </div>
              <div>
                <p className="font-semibold">Study Program</p>
                <p className="dark:text-white text-black font-medium">{submission.student.study_program}</p>
              </div>
              <div>
                <p className="font-semibold">Majors</p>
                <p className="dark:text-white text-black font-medium">{submission.student.majors}</p>
              </div>
              <div>
                <p className="font-semibold">NIM</p>
                <p className="dark:text-white text-black font-medium">{submission.student.nim}</p>
              </div>
            </div>
          </div>

          {/* Submission Information */}
          <div className="space-y-4">
            <h2 className="text-lg font-semibold">Submission Details</h2>
            <div className="space-y-4">
              <div>
                <p className="font-semibold">Title</p>
                <p className="dark:text-white text-black font-medium">{submission.title}</p>
              </div>
              <div>
                <p className="font-semibold">Field</p>
                <p className="dark:text-white text-black font-medium">{submission.title_field}</p>
              </div>
              <div>
                <p className="font-semibold">Difficulty</p>
                <p className="dark:text-white text-black font-medium">{submission.difficulty}</p>
              </div>
              <div>
                <p className="font-semibold">Idea Source</p>
                <p className="dark:text-white text-black font-medium">{submission.idea_source}</p>
              </div>
            </div>
          </div>

          <div className="space-y-4">
            <h2 className="text-lg font-semibold">Status & Metrics</h2>
            <div className="space-y-4">
              <div>
                <p className="font-semibold">Status</p>
                <p className="dark:text-white text-black font-medium">{formatStatus(submission.title_status)}</p>
              </div>
              <div>
                <p className="font-semibold">Similarity Score</p>
                <p className="dark:text-white text-black font-medium">{submission.similarity_score.toFixed(2)}%</p>
              </div>
              <div>
                <p className="font-semibold">Submitted At</p>
                <p className="dark:text-white text-black font-medium">{new Date(submission.created_at).toLocaleString()}</p>
              </div>
              <div>
                <p className="font-semibold">Last Updated</p>
                <p className="dark:text-white text-black font-medium">{new Date(submission.updated_at).toLocaleString()}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
