import { compactFormat } from "@/lib/format-number";
import { getOverviewData } from "../../fetch";
import { OverviewCard } from "./card";
import * as icons from "./icons";

export async function OverviewCardsGroup() {
  const { status, students, users, lecturers } = await getOverviewData();

  return (
    <div className="grid gap-4 sm:grid-cols-2 sm:gap-6 xl:grid-cols-4 2xl:gap-7.5">
      <OverviewCard
        label="Pending Submission"
        data={{
          ...status,
          value: compactFormat(status.value),
        }}
        Icon={icons.Views}
      />

      <OverviewCard
        label="Total Students"
        data={{
          ...students,
          value: compactFormat(students.value),
        }}
        Icon={icons.Profit}
      />

      <OverviewCard
        label="Total Users"
        data={{
          ...users,
          value: compactFormat(users.value),
        }}
        Icon={icons.Product}
      />

      <OverviewCard
        label="Total Lecturer"
        data={{
          ...lecturers,
          value: compactFormat(lecturers.value),
        }}
        Icon={icons.Users}
      />
    </div>
  );
}
