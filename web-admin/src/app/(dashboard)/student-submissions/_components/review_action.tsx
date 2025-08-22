"use client";

import { useState } from "react";
import { submissionStatusReviewClient } from "@/lib/api/CRUD/submission-status/submission-status.client";
import { useRouter } from "next/navigation";
import { Check, Edit3, X } from "lucide-react";

export default function ReviewActions({ submissionId }: { submissionId: number }) {
  const [loading, setLoading] = useState(false);
  const [showCommentBox, setShowCommentBox] = useState(false);
  const [comment, setComment] = useState("");
  const router = useRouter();

  async function handleAction(status: "APPROVED" | "REVISED" | "REJECTED") {
    try {
      setLoading(true);

      if (status === "REVISED" && !comment.trim()) {
        alert("Comment is required for revise");
        return;
      }

      await submissionStatusReviewClient(submissionId, status, comment);

      alert(`Submission ${status} successfully!`);
      router.refresh();
    } catch (err: any) {
      alert(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="border rounded-xl p-6 bg-gray-50 dark:bg-gray-800 shadow-sm space-y-4">
      <h3 className="text-lg font-semibold">Review Actions</h3>
      <p className="text-sm text-gray-600 dark:text-gray-300">
        Choose an action for this submission.
      </p>

      <div className="flex flex-wrap gap-3">
        <button
          disabled={loading}
          onClick={() => handleAction("APPROVED")}
          className="flex items-center gap-2 bg-green-800 text-white px-4 py-2 rounded-lg hover:bg-green-700 disabled:opacity-50"
        >
          <Check size={18} />
          Approve
        </button>

        <button
          disabled={loading}
          onClick={() => setShowCommentBox(!showCommentBox)}
          className="flex items-center gap-2 bg-yellow-600 text-white px-4 py-2 rounded-lg hover:bg-yellow-600 disabled:opacity-50"
        >
          <Edit3 size={18} />
          Revise
        </button>

        <button
          disabled={loading}
          onClick={() => handleAction("REJECTED")}
          className="flex items-center gap-2 bg-red-700 text-white px-4 py-2 rounded-lg hover:bg-red-700 disabled:opacity-50"
        >
          <X size={18} />
          Reject
        </button>
      </div>

      {showCommentBox && (
        <div className="space-y-3 animate-fadeIn">
          <textarea
            className="w-full border rounded-lg p-3 dark:bg-gray-900 dark:text-white"
            placeholder="Enter revision comment..."
            value={comment}
            onChange={(e) => setComment(e.target.value)}
          />
          <button
            disabled={loading}
            onClick={() => handleAction("REVISED")}
            className="w-full bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 disabled:opacity-50"
          >
            Submit Revision
          </button>
        </div>
      )}
    </div>
  );
}
