import { getSubmissionsById } from "@/lib/api/CRUD/student-submission/student-submission.server";
import { notFound } from "next/navigation";
import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import { formatStatus } from "../helper/submission-utils";
import { getSubmissionStatusesByIdServer } from "@/lib/api/CRUD/submission-status/submission-status.server";
import ReviewActions from "../_components/review_action";
import { Badge } from "lucide-react";

export default async function SubmissionDetailPage({
  params,
}: {
  params: { submissionId: string };
}) {
  const id = Number(params.submissionId);
  if (isNaN(id)) return notFound();

  const submission = await getSubmissionsById(id);
  if (!submission) return notFound();

  // ambil status history
  const statuses = await getSubmissionStatusesByIdServer(id);

  // ambil object status terbaru
  const latestStatusObject =
    statuses.length > 0
      ? statuses.reduce((latest, current) =>
          new Date(current.created_at) > new Date(latest.created_at)
            ? current
            : latest
        )
      : null;

  const latestStatus = latestStatusObject?.status ?? submission.title_status;

  return (
    <div className="space-y-6">
      <Breadcrumb
        pageName="Submissions Detail"
        parentPages={[{ name: "Student Submissions", href: "/student-submissions" }]}
      />

      <div className="rounded-xl bg-white dark:bg-gray-dark p-12 shadow-md space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* Student Information */}
          <div className="md:col-span-2">
            <h2 className="text-lg font-semibold mb-4">Student Information</h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 p-6 bg-gray-100 dark:bg-gray-800 rounded-lg">
              <div>
                <p className="font-semibold">Name</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.student?.full_name ?? "-"}
                </p>
              </div>
              <div>
                <p className="font-semibold">Study Program</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.student?.study_program ?? "-"}
                </p>
              </div>
              <div>
                <p className="font-semibold">Majors</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.student?.majors ?? "-"}
                </p>
              </div>
              <div>
                <p className="font-semibold">NIM</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.student?.nim ?? "-"}
                </p>
              </div>
            </div>
          </div>

          {/* Submission Information */}
          <div className="space-y-4">
            <h2 className="text-lg font-semibold">Submission Details</h2>
            <div className="space-y-4">
              <div>
                <p className="font-semibold">Title</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.title}
                </p>
              </div>
              <div>
                <p className="font-semibold">Field</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.title_field}
                </p>
              </div>
              <div>
                <p className="font-semibold">Idea Source</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.idea_source}
                </p>
              </div>
              <div>
                <p className="font-semibold">File</p>
                {submission.file_path ? (
                  <a
                    href={`${process.env.NEXT_PUBLIC_API_URL}/${submission.file_path.replace(
                      /\\/g,
                      "/"
                    )}`}
                    download
                    className="text-blue-600 underline"
                  >
                    Download File
                  </a>
                ) : (
                  <p className="dark:text-white text-black font-medium">
                    No file uploaded
                  </p>
                )}
              </div>
            </div>
          </div>

          {/* Status & Metrics */}
          <div className="space-y-4">
            <h2 className="text-lg font-semibold">Status & Metrics</h2>
            <div className="space-y-4">
              <div>
                <p className="font-semibold">Status</p>
                  {formatStatus(latestStatus)} 
              </div>
              <div>
                <p className="font-semibold">Reviewed By</p>
                <p className="dark:text-white text-black font-medium">
                  {latestStatusObject?.lecturer?.fullname ?? "-"}
                </p>
              </div>
              <div>
                <p className="font-semibold">Submitted At</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.created_at
                    ? new Date(submission.created_at).toLocaleString()
                    : "-"}
                </p>
              </div>
              <div>
                <p className="font-semibold">Last Updated</p>
                <p className="dark:text-white text-black font-medium">
                  {submission.updated_at
                    ? new Date(submission.updated_at).toLocaleString()
                    : "-"}
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Review Actions */}
        <div className="mt-8">
          <ReviewActions submissionId={id} />
        </div>
      </div>
    </div>
  );
}
