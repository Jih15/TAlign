import { getAllStudentsServer } from "@/lib/api/CRUD/students/student.server";
import { getAllStudents } from "@/lib/api/CRUD/students/students";
import { countPendingSubmissions } from "@/lib/api/CRUD/submission-status/status";
// import { countAllUsers } from "@/lib/api/CRUD/users/users";
import { countAllUsersServer, getAllUsersServer } from "@/lib/api/CRUD/users/users.server";


export async function getOverviewData() {
  // Fake delay
  // await new Promise((resolve) => setTimeout(resolve, 2000));
  const students = await getAllStudentsServer();
  const users = await countAllUsersServer();

  const studentCount = Array.isArray(students) ? students.length : 0;
  // console.log(studentCount);
  const pendingCount = await countPendingSubmissions();
  // console.log(pendingCount)

  return {
    students: {
      value: studentCount,
      growthRate: 0,
    },
    status: {
      value: pendingCount,
      growthRate: 0,
    },
    users: {
      value: users,
      growthRate: 2.59,
    },
    lecturers: {
      value: 3456,
      growthRate: -0.95,
    },
  };
}

// export async function getChatsData() {
//   // Fake delay
//   await new Promise((resolve) => setTimeout(resolve, 1000));

//   return [
//     {
//       name: "Jacob Jones",
//       profile: "/images/user/user-01.png",
//       isActive: true,
//       lastMessage: {
//         content: "See you tomorrow at the meeting!",
//         type: "text",
//         timestamp: "2024-12-19T14:30:00Z",
//         isRead: false,
//       },
//       unreadCount: 3,
//     },
//     {
//       name: "Wilium Smith",
//       profile: "/images/user/user-03.png",
//       isActive: true,
//       lastMessage: {
//         content: "Thanks for the update",
//         type: "text",
//         timestamp: "2024-12-19T10:15:00Z",
//         isRead: true,
//       },
//       unreadCount: 0,
//     },
//     {
//       name: "Johurul Haque",
//       profile: "/images/user/user-04.png",
//       isActive: false,
//       lastMessage: {
//         content: "What's up?",
//         type: "text",
//         timestamp: "2024-12-19T10:15:00Z",
//         isRead: true,
//       },
//       unreadCount: 0,
//     },
//     {
//       name: "M. Chowdhury",
//       profile: "/images/user/user-05.png",
//       isActive: false,
//       lastMessage: {
//         content: "Where are you now?",
//         type: "text",
//         timestamp: "2024-12-19T10:15:00Z",
//         isRead: true,
//       },
//       unreadCount: 2,
//     },
//     {
//       name: "Akagami",
//       profile: "/images/user/user-07.png",
//       isActive: false,
//       lastMessage: {
//         content: "Hey, how are you?",
//         type: "text",
//         timestamp: "2024-12-19T10:15:00Z",
//         isRead: true,
//       },
//       unreadCount: 0,
//     },
//   ];
// }