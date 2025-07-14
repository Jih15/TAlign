import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import { Metadata } from "next";
import { Suspense } from "react";
import { StudentTable } from "./_components/student-table";
import { StudentTableSkeleton } from "./_components/student-table/skeleton";

export const metadata: Metadata = {
    title: "Student",
};

const TablesPage = () => {
    return (
        <>
            <Breadcrumb pageName="Student" />

            <div className="space-y-10">
                <Suspense fallback={<StudentTableSkeleton/>}>
                    <StudentTable />
                </Suspense>
            </div>
        </>
    );
};

export default TablesPage;