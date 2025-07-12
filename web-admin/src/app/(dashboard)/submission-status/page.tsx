import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import { InvoiceTable } from "@/components/Tables/invoice-table";
import { Metadata } from "next";
import { Suspense } from "react";
import { SubmissionTable } from "../student-submissions/_components/submission-table";

export const metadata: Metadata = {
    title: "Submission Status",
};

const TablesPage = () => {
    return (
        <>
            <Breadcrumb pageName="Submission Status" />

            <div className="space-y-10">
                <Suspense>
                     
                </Suspense>
            </div>
        </>
    );
};

export default TablesPage;