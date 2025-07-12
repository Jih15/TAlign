import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import { Metadata } from "next";
import { Suspense } from "react";
import { SubmissionTable } from "./_components/submission-table";

export const metadata: Metadata = {
    title: "Student Submissions"
};

const TablesPage = () => {
    return (
        <>
            <Breadcrumb pageName="Student Submission"/>

            <div className="space-y-10">
                <Suspense>
                    <SubmissionTable />
                </Suspense>
            </div>
        </>
    );
};

export default TablesPage;