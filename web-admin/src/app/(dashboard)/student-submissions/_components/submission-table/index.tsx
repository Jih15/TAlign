"use client";

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { cn } from "@/lib/utils";
import { useEffect, useState } from "react";
import { getAllSubmissions } from "@/lib/api/CRUD/student-submission/student-submission.client";
import { useRouter } from "next/navigation";
import { DownloadIcon, PreviewIcon } from "@/components/Tables/icons";
import { TrashIcon } from "@/assets/icons";
import { Status, Submission } from "@/lib/model/types";
import { getBadgeClass, formatStatus } from "../../helper/submission-utils";
import { getAllSubmissionStatusClient } from "@/lib/api/CRUD/submission-status/submission-status.client";
import { SubmissionStatus } from "@/lib/api/CRUD/submission-status/status";

export function SubmissionTable({ className }: { className?: string }) {
  const [submissions, setSubmissions] = useState<Submission[]>([]);
  const [rows, setRows] = useState<Status[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  const fetchStatus = async () => {
    try {
      setLoading(true);
      setError(null);
      const status = await getAllSubmissionStatusClient();
      setRows(status);
    }catch (err) {
      console.error("Error fetch status:" ,err);
      setError("failed load data!")
    } finally {
      setLoading(false);
    }
  };

  const fetchSubmissions = async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await getAllSubmissions();
      setSubmissions(data);
    } catch (err) {
      console.error("Error fetching submissions:", err);
      setError("Failed to load submissions");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchStatus();
    fetchSubmissions();
  }, []);

  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary"></div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="rounded-md bg-red-50 p-4">
        <div className="flex">
          <div className="ml-3">
            <h3 className="text-sm font-medium text-red-800">{error}</h3>
            <button
              onClick={fetchSubmissions}
              className="mt-2 text-sm text-red-700 hover:text-red-600"
            >
              Retry
            </button>
          </div>
        </div>
      </div>
    );
  }

  if (submissions.length === 0) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">No submissions found</p>
      </div>
    );
  }

  return (
    <div className={cn("rounded-[10px] bg-white p-7.5 shadow-1 dark:bg-gray-dark", className)}>
      <Table>
        <TableHeader>
          <TableRow className="border-none uppercase">
            <TableHead>Student</TableHead>
            <TableHead>Title</TableHead>
            <TableHead>Field</TableHead>
            <TableHead>Status</TableHead>
            <TableHead>Similarity</TableHead>
            <TableHead className="text-right">Actions</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {submissions.map((item) => (
            <TableRow
              key={item.submission_id}
              className="cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800"
              onClick={() => router.push(`/student-submissions/${item.submission_id}`)}
            >
              <TableCell className="w-40">
                <div className="font-medium dark:text-white text-black">
                  {item.student?.full_name ?? "-"}
                </div>
                <div className="text-sm text-gray-500">NIM: {item.student?.nim ?? ""}</div>
              </TableCell>
              <TableCell className="font-medium line-clamp-2">{item.title}</TableCell>
              <TableCell className="text-sm text-gray-500">{item.title_field}</TableCell>
              <TableCell>
                {(() => {
                  const status = rows.find((s) => s.submission_id === item.submission_id);
                  const currentStatus = status?.status || item.title_status;

                  return (
                    <span className={getBadgeClass("status", currentStatus)}>
                      {formatStatus(currentStatus)}
                    </span>
                  );
                })()}
              </TableCell>
              <TableCell>{item.similarity_score?.toFixed(2) ?? 0}%</TableCell>
              <TableCell className="text-right">
                <div className="flex justify-end gap-3.5">
                  <button
                    className="hover:text-primary"
                    onClick={(e) => {
                      e.stopPropagation();
                      router.push(`/student-submissions/${item.submission_id}`);
                    }}
                  >
                    <PreviewIcon />
                  </button>
                  <button className="hover:text-orange-400" onClick={(e) => e.stopPropagation()}>
                    ✎
                  </button>
                  <button className="hover:text-red-600" onClick={(e) => e.stopPropagation()}>
                    <TrashIcon />
                  </button>
                  {/* <button className="hover:text-primary" onClick={(e) => e.stopPropagation()}>
                    <DownloadIcon />
                  </button> */}
                </div>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}
