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
import { getAllSubmissionStatus, SubmissionStatus } from "@/lib/api/CRUD/submission-status/status";
import { useRouter } from "next/navigation";
import { PreviewIcon } from "@/components/Tables/icons";
import { TrashIcon } from "@/assets/icons";
import { getBadgeClass, formatStatus } from "../../helper/submission-utils";

interface Props {
  className?: string;
}

export function StatusTable({ className }: Props) {
  const [rows, setRows] = useState<SubmissionStatus[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  const fetchStatus = async () => {
    try {
      setLoading(true);
      setError(null);
      const data = await getAllSubmissionStatus();
      setRows(data);
    } catch (err) {
      console.error("Error fetching submission-status:", err);
      setError("Failed to load data");
    } finally {
      setLoading(false);
    }
  };

  /* --- panggil sekali saat mount --- */
  useEffect(() => {
    fetchStatus();
  }, []);

  /* ---------- STATE: LOADING ---------- */
  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-primary"></div>
      </div>
    );
  }

  /* ---------- STATE: ERROR ---------- */
  if (error) {
    return (
      <div className="rounded-md bg-red-50 p-4">
        <div className="flex">
          <div className="ml-3">
            <h3 className="text-sm font-medium text-red-800">{error}</h3>
            <button
              onClick={fetchStatus}
              className="mt-2 text-sm text-red-700 hover:text-red-600"
            >
              Retry
            </button>
          </div>
        </div>
      </div>
    );
  }

  /* ---------- STATE: DATA KOSONG ---------- */
  if (rows.length === 0) {
    return (
      <div className="text-center py-12">
        <p className="text-gray-500">No submissions found</p>
      </div>
    );
  }

  /* ---------- STATE: BERHASIL ---------- */
  return (
    <div
      className={cn(
        "rounded-[10px] bg-white p-7.5 shadow-1 dark:bg-gray-dark",
        className
      )}
    >
      <Table>
        <TableHeader>
          <TableRow className="border-none uppercase">
            <TableHead>Student</TableHead>
            <TableHead className="w-180">Title</TableHead>
            <TableHead>Accepted By</TableHead>
            <TableHead>Status</TableHead>
            <TableHead className="text-right">Actions</TableHead>
          </TableRow>
        </TableHeader>

        <TableBody>
          {rows.map((item) => (
            <TableRow
              key={item.status_id}
              className="cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-800"
              // onClick={() => router.push(`/student-submissions/${item.submission_id}`)}
            >
              {/* ---------- COL: STUDENT ---------- */}
              <TableCell className="w-40">
                <div className="font-medium dark:text-white text-black">
                  {item.student.full_name}
                </div>
                <div className="text-sm text-gray-500">
                  NIM: {item.student.nim}
                </div>
              </TableCell>

              {/* ---------- COL: TITLE ---------- */}
              <TableCell className="font-medium line-clamp-2">
                {item.student_submission.title}
              </TableCell>

              {/* ---------- COL: ACCEPTED BY (LECTURER) ---------- */}
              <TableCell className="text-sm text-gray-500">
                <div className="font-medium dark:text-white text-black">
                  {item.lecturer.fullname}
                </div>
                <div className="text-sm text-gray-500">
                  NIP: {item.lecturer.nip}
                </div>
              </TableCell>

              {/* ---------- COL: STATUS ---------- */}
              <TableCell>
                <span className={getBadgeClass("status", item.status)}>
                  {formatStatus(item.status)}
                </span>
              </TableCell>

              {/* ---------- COL: ACTIONS ---------- */}
              <TableCell className="text-right">
                <div className="flex justify-end gap-3.5">
                  <button className="hover:text-primary">
                    <PreviewIcon />
                  </button>
                  <button
                    className="hover:text-orange-400"
                    onClick={(e) => e.stopPropagation()}
                  >
                    ✎
                  </button>
                  <button
                    className="hover:text-red-600"
                    onClick={(e) => e.stopPropagation()}
                  >
                    <TrashIcon />
                  </button>
                </div>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}
