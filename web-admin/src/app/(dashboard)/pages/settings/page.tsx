import Breadcrumb from "@/components/Breadcrumbs/Breadcrumb";
import type { Metadata } from "next";
import { PersonalInfoForm } from "./_components/personal-info";
import { getCurrentUserServer } from "@/lib/api/CRUD/users/users.server";
// import { UploadPhotoForm } from "./_components/upload-photo";

export const metadata: Metadata = {
  title: "Settings Page",
};

export default async function SettingsPage() {
  // const currentUser = await getCurrentUserServer();

  return (
    <div className="mx-auto w-full max-w-[1080px]">
      <Breadcrumb pageName="Settings" />

      <div className="grid grid-cols-5">
        <div className="col-span-5 xl:col-span-3 xl:col-start-2">
          <PersonalInfoForm/>
        </div>
      </div>
    </div>
  );
}


// export default function SettingsPage() {
//   return (
//     <div className="mx-auto w-full max-w-[1080px]">
//       <Breadcrumb pageName="Settings" />

//       <div className="grid grid-cols-5 gap-8">
//         <div className="col-span-5 xl:col-span-3">
//           <PersonalInfoForm />
//         </div>
//         {/* <div className="col-span-5 xl:col-span-2">
//           <UploadPhotoForm />
//         </div> */}
//       </div>
//     </div>
//   );
// };

