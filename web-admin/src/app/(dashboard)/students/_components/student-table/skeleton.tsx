import { Skeleton } from "@/components/ui/skeleton";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

export function StudentTableSkeleton() {
  return (
    <div className="rounded-[10px] bg-white px-7.5 pb-4 pt-7.5 shadow-1 dark:bg-gray-dark dark:shadow-card">
      {/* Heading and Create Button Skeleton */}
      <div className="mb-4 flex items-center justify-between">
        <Skeleton className="h-8 w-40" />
      </div>

      {/* Items per page selector Skeleton */}
      <div className="mb-4 flex items-center justify-between">
        <div className="flex items-center space-x-2">
          <Skeleton className="h-5 w-10" />
          <Skeleton className="h-8 w-16" />
          <Skeleton className="h-5 w-16" />
        </div>
      </div>

      <Table>
        <TableHeader>
          <TableRow className="border-none uppercase">
            <TableHead className="text-left">
              <Skeleton className="h-5 w-16" />
            </TableHead>
            <TableHead className="text-left">
              <Skeleton className="h-5 w-28" />
            </TableHead>
            <TableHead className="text-left">
              <Skeleton className="h-5 w-24" />
            </TableHead>
            <TableHead className="text-left">
              <Skeleton className="h-5 w-28" />
            </TableHead>
            <TableHead className="text-right">
              <Skeleton className="h-5 w-16 ml-auto" />
            </TableHead>
          </TableRow>
        </TableHeader>

        <TableBody>
          {Array.from({ length: 5 }).map((_, i) => (
            <TableRow key={i}>
              <TableCell>
                <Skeleton className="h-5 w-24" />
              </TableCell>
              <TableCell>
                <Skeleton className="h-5 w-36" />
              </TableCell>
              <TableCell>
                <Skeleton className="h-5 w-28" />
              </TableCell>
              <TableCell>
                <Skeleton className="h-5 w-28" />
              </TableCell>
              <TableCell className="text-right">
                <div className="flex justify-end gap-x-3.5">
                  {/* Action Button Skeleton */}
                  <Skeleton className="h-6 w-6 rounded" />
                </div>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>

      {/* Pagination Controls Skeleton */}
      <div className="mt-4 flex flex-col items-center justify-between gap-4 sm:flex-row">
        <Skeleton className="h-5 w-48" />
        <div className="flex space-x-2">
          <Skeleton className="h-8 w-20" />
          {Array.from({ length: 5 }).map((_, i) => (
            <Skeleton key={i} className="h-8 w-8" />
          ))}
          <Skeleton className="h-8 w-20" />
        </div>
      </div>
    </div>
  );
}
