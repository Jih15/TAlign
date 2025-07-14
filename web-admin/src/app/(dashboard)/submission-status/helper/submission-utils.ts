// lib/utils/submission-utils.ts

import { Difficulty, TitleStatus } from "@/lib/model/types";
import { cn } from "@/lib/utils";

export const difficultyColors = {
  Easy: "bg-[#219653]/[0.08] text-[#219653]",
  Medium: "bg-[#FFA70B]/[0.08] text-[#FFA70B]",
  Hard: "bg-[#D34053]/[0.08] text-[#D34053]",
} as const;

export const statusColors = {
  WAITING_REVIEW: "bg-[#219653]/[0.08] text-[#3c8fad]",
  APPROVED: "bg-[#FFA70B]/[0.08] text-[#219653]",
  REJECTED: "bg-[#D34053]/[0.08] text-[#D34053]",
  REVISED: "bg-[#FFA70B]/[0.08] text-[#FFA70B]",
} as const;

export const statusDisplayMap: Record<TitleStatus, string> = {
  WAITING_REVIEW: "Waiting",
  APPROVED: "Approved",
  REJECTED: "Rejected",
  REVISED: "Revised",
};

export const difficultyDisplayMap: Record<Difficulty, string> = {
  Easy: "Easy",
  Medium: "Medium",
  Hard: "Hard",
};

export function getBadgeClass(
  category: "difficulty" | "status",
  value: Difficulty | TitleStatus
): string {
  const base = "max-w-fit rounded-full px-3.5 py-1 text-sm font-medium";

  if (category === "difficulty" && value in difficultyColors) {
    return cn(base, difficultyColors[value as Difficulty]);
  }

  if (category === "status" && value in statusColors) {
    return cn(base, statusColors[value as TitleStatus]);
  }

  return cn(base, "bg-gray-100 text-gray-800");
}

export function formatStatus(status: string): string {
  return statusDisplayMap[status as TitleStatus] || status;
}
