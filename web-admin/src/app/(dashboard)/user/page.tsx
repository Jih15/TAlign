import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import { InvoiceTable } from "@/components/Tables/invoice-table";
import { UserTable } from "./_components/user-table";
import { UserTableSkeleton } from "./_components/user-table/skeleton";
import { TopProducts } from "@/components/Tables/top-products";
import { TopProductsSkeleton } from "@/components/Tables/top-products/skeleton";

import { Metadata } from "next";
import { Suspense } from "react";

export const metadata: Metadata = {
  title: "User",
};

const TablesPage = () => {
  return (
    <>
      <Breadcrumb pageName="User" />

      <div className="space-y-10">
        <Suspense fallback={<UserTableSkeleton />}>
          <UserTable />
        </Suspense>

      </div>
    </>
  );
};

export default TablesPage;
