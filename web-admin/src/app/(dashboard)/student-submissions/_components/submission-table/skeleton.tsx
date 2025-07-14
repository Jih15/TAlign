import { Skeleton } from "@/components/ui/skeleton";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

export function SubmissionTableSkeleton() {
  return (
    <div className="rounded-[10px] border border-stroke bg-white p-4 shadow-1 dark:border-dark-3 dark:bg-gray-dark dark:shadow-card sm:p-7.5">
      {/* Heading and Create Button Skeleton */}
      <div className="mb-4 flex items-center justify-between">
        <Skeleton className="h-8 w-40" />
        <Skeleton className="h-9 w-24" />
      </div>

      <Table>
        <TableHeader>
          <TableRow className="border-none bg-[#F7F9FC] dark:bg-dark-2">
            <TableHead className="min-w-[155px] xl:pl-7.5">
              <Skeleton className="h-5 w-24" />
            </TableHead>
            <TableHead className="w-115">
              <Skeleton className="h-5 w-40" />
            </TableHead>
            <TableHead>
              <Skeleton className="h-5 w-20" />
            </TableHead>
            <TableHead>
              <Skeleton className="h-5 w-28" />
            </TableHead>
            <TableHead>
              <Skeleton className="h-5 w-20" />
            </TableHead>
            <TableHead className="text-right xl:pr-7.5">
              <Skeleton className="h-5 w-20 ml-auto" />
            </TableHead>
          </TableRow>
        </TableHeader>

        <TableBody>
          {Array.from({ length: 5 }).map((_, i) => (
            <TableRow key={i} className="border-[#eee] dark:border-dark-3">
              <TableCell className="min-w-[155px] xl:pl-7.5">
                <Skeleton className="h-5 w-32 mb-1" />
                <Skeleton className="h-4 w-20" />
              </TableCell>

              <TableCell>
                <Skeleton className="h-5 w-full mb-1" />
                <Skeleton className="h-4 w-32" />
              </TableCell>

              <TableCell>
                <Skeleton className="h-6 w-20 rounded-full" />
              </TableCell>

              <TableCell>
                <Skeleton className="h-5 w-24" />
              </TableCell>

              <TableCell>
                <Skeleton className="h-6 w-20 rounded-full" />
              </TableCell>

              <TableCell className="xl:pr-7.5">
                <div className="flex justify-end gap-x-3.5">
                  <Skeleton className="h-6 w-6 rounded" />
                  <Skeleton className="h-6 w-6 rounded" />
                  <Skeleton className="h-6 w-6 rounded" />
                </div>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  );
}
