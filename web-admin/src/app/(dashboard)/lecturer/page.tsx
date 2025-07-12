import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import { Metadata } from "next";
import { Suspense } from "react";
import { LecturerTable } from "./_components/lecturer-table";

export const metadata: Metadata = {
    title: "Lecturer",
};

const TablesPage = () => {
    return (
        <>
            <Breadcrumb pageName="Lecturer" />

            <div className="space-y-10">
                <Suspense>
                    <LecturerTable />
                </Suspense>
            </div>
        </>
    );
};

export default TablesPage;