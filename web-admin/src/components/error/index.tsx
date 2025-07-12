// "use client";

// import { Button } from "@/components/ui-elements/button";
// import { useRouter } from "next/navigation";
// import { useEffect } from "react";

// interface GlobalErrorProps {
//   error: Error & { digest?: string };
//   reset: () => void;
// }

// export default function GlobalError({ error, reset }: GlobalErrorProps) {
//   const router = useRouter();

//   useEffect(() => {
//     // console.error("Global Error:", error);
//   }, [error]);

//   return (
//     <div className="flex min-h-screen flex-col items-center justify-center gap-8 bg-white p-8 dark:bg-gray-dark">
//       <div className="max-w-2xl space-y-6 text-center">
//         <div className="space-y-2">
//           <h1 className="text-4xl font-bold text-red-600 dark:text-red-500">
//             Something went wrong!
//           </h1>
//           <h2 className="text-2xl font-semibold text-dark dark:text-white">
//             {"An unexpected error occurred"}
//           </h2>
//         </div>

//         <p className="text-lg text-gray-600 dark:text-gray-300">
//           We apologize for the inconvenience. Please try again or contact support if the problem persists.
//         </p>

//         <div className="flex flex-wrap justify-center gap-4 pt-4">
//           <Button
//             label="Try Again"
//             onClick={() => reset()}
//             variant="primary"
//             shape="rounded"
//           />
//           <Button
//             label="Go to Home"
//             onClick={() => router.push("/")}
//             variant="outlinePrimary"
//             shape="rounded"
//           />
//           <Button
//             label="Contact Support"
//             onClick={() => router.push("/support")}
//             variant="outlineDark"
//             shape="rounded"
//           />
//         </div>

//         {/* {error.digest && (
//           <div className="mt-8 rounded-md bg-gray-100 p-4 dark:bg-gray-800">
//             <p className="text-sm text-gray-500 dark:text-gray-400">
//               Error Reference: <code className="break-all">{`error.digest`}</code>
//             </p>
//           </div>
//         )} */}
//       </div>
//     </div>
//   );
// }