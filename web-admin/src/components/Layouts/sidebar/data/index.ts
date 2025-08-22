import * as Icons from "../icons";
import { StarIcon, AcademicCapIcon } from "@heroicons/react/24/outline";
import { AcademicCapIcon as ACsolid } from "@heroicons/react/16/solid";

export const NAV_DATA = [
  {
    label: "MAIN",
    roles: ["ADMIN", "DOSEN"], // section ini bisa diakses keduanya
    items: [
      {
        title: "Dashboard",
        icon: Icons.HomeIcon,
        url: "/",
        roles: ["ADMIN", "DOSEN"],
        items: [],
      },
      {
        title: "Submission",
        icon: Icons.Table,
        url: "/student-submissions",
        roles: ["ADMIN", "DOSEN"],
        items: [
          // {
          //   title: "Student Submission",
          //   url: "/student-submissions",
          //   roles: ["ADMIN", "DOSEN"],
          // },
          // {
          //   title: "Submission Status",
          //   url: "/submission-status",
          //   roles: ["ADMIN"], // cuma ADMIN
          // },
        ],
      },
    ],
  },
  {
    label: "USER MANAGEMENT",
    roles: ["ADMIN"], // hanya ADMIN
    items: [
      {
        title: "User",
        url: "/user",
        icon: Icons.User,
        roles: ["ADMIN"],
        items: [],
      },
      {
        title: "Student",
        url: "/students",
        icon: AcademicCapIcon,
        roles: ["ADMIN"],
        items: [],
      },
      {
        title: "Lecturer",
        url: "/lecturer",
        icon: ACsolid,
        roles: ["ADMIN"],
        items: [],
      },
    ],
  },
  {
    label: "ADDS",
    roles: ["ADMIN"],
    items: [
      {
        title: "Feedback",
        url: "/feedback",
        icon: StarIcon,
        roles: ["ADMIN"],
        items: [],
      },
    ],
  },
  // {
  //   label: "HELPER",
  //   roles: ["ADMIN", "DOSEN"],
  //   items: [
  //     {
  //       title: "Calendar",
  //       url: "/calendar",
  //       icon: Icons.Calendar,
  //       roles: ["ADMIN", "DOSEN"],
  //       items: [],
  //     },
  //     {
  //       title: "Profile",
  //       url: "/profile",
  //       icon: Icons.User,
  //       roles: ["ADMIN", "DOSEN"],
  //       items: [],
  //     },
  //     {
  //       title: "Forms",
  //       icon: Icons.Alphabet,
  //       roles: ["ADMIN"], // cuma ADMIN
  //       items: [
  //         {
  //           title: "Form Elements",
  //           url: "/forms/form-elements",
  //           roles: ["ADMIN"],
  //         },
  //         {
  //           title: "Form Layout",
  //           url: "/forms/form-layout",
  //           roles: ["ADMIN"],
  //         },
  //       ],
  //     },
  //     {
  //       title: "Tables",
  //       url: "/tables",
  //       icon: Icons.Table,
  //       roles: ["ADMIN"],
  //       items: [
  //         {
  //           title: "Tables",
  //           url: "/tables",
  //           roles: ["ADMIN"],
  //         },
  //       ],
  //     },
  //     {
  //       title: "Pages",
  //       icon: Icons.Alphabet,
  //       roles: ["ADMIN"],
  //       items: [
  //         {
  //           title: "Settings",
  //           url: "/pages/settings",
  //           roles: ["ADMIN"],
  //         },
  //       ],
  //     },
  //     {
  //       title: "Charts",
  //       icon: Icons.PieChart,
  //       roles: ["ADMIN"],
  //       items: [
  //         {
  //           title: "Basic Chart",
  //           url: "/charts/basic-chart",
  //           roles: ["ADMIN"],
  //         },
  //       ],
  //     },
  //     {
  //       title: "UI Elements",
  //       icon: Icons.FourCircle,
  //       roles: ["ADMIN"],
  //       items: [
  //         {
  //           title: "Alerts",
  //           url: "/ui-elements/alerts",
  //           roles: ["ADMIN"],
  //         },
  //         {
  //           title: "Buttons",
  //           url: "/ui-elements/buttons",
  //           roles: ["ADMIN"],
  //         },
  //       ],
  //     },
  //     {
  //       title: "Authentication",
  //       icon: Icons.Authentication,
  //       roles: ["ADMIN"],
  //       items: [
  //         {
  //           title: "Sign In",
  //           url: "/sign-in",
  //           roles: ["ADMIN"],
  //         },
  //       ],
  //     },
  //   ],
  // },
];
