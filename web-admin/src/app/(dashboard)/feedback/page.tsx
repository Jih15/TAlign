import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import { Metadata } from "next";
import { Suspense } from "react";
import { FeedbackTable } from "./_components/feedback-table";
import { StudentTableSkeleton } from "./_components/feedback-table/skeleton";

export const metadata: Metadata = {
    title: "Feedback",
};

const TablesPage = () => {
    return (
        <>
            <Breadcrumb pageName="Feedback" />

            <div className="space-y-10">
                <Suspense fallback={<StudentTableSkeleton/>}>
                    <FeedbackTable />
                </Suspense>
            </div>
        </>
    );
};

export default TablesPage;