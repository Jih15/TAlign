import { label } from "motion/react-client";
import * as Icons from "../icons";
import { title } from "process";
import { url } from "inspector";
import { StarIcon, AcademicCapIcon } from "@heroicons/react/24/outline";
import { AcademicCapIcon  as ACsolid } from "@heroicons/react/16/solid";

export const NAV_DATA = [
  {
    label: "MAIN",
    items: [
      {
        title: "Dashboard",
        icon: Icons.HomeIcon,
        url: "/",
        items: [
          // {
          //   title: "eCommerce",
          //   url: "/",
          // },
        ],
      },
      {
        title: "Submission",
        icon: Icons.Table,
        items: [
          {
            title : "Student Submission",
            url : "/student-submissions"
          },
          {
            title : "Submission Status",
            url : "/submission-status"
          },
        ]
      },
      // {
      //   title: "Student Submission",
      //   url: "/student-submission",
      //   icon: Icons.Table,
      //   items: []
      // },
      // {
      //   title: "Submission Status",
      //   url: "/submission-status",
      //   icon: Icons.Table,
      //   items: []
      // },      
    ],
  },
  {
    label: "USER MANAGEMENT",
    items: [
      {
        title: "User",
        url: "/user",
        icon: Icons.User,
        items: []
      },
      {
        title: "Student",
        url: "/students",
        icon: AcademicCapIcon,
        items: []
      },
      {
        title: "Lecturer",
        url: "/lecturer",
        icon: ACsolid,
        items: []
      },      
    ],
  },
    {
    label: "ADDS",
    items: [
      {
        title: "Feedback",
        url: "/feedback",
        icon: StarIcon,
        items: []
      },      
    ],
  },
  {
    label: "HELPER",
    items: [
      {
        title: "Calendar",
        url: "/calendar",
        icon: Icons.Calendar,
        items: [],
      },
      {
        title: "Profile",
        url: "/profile",
        icon: Icons.User,
        items: [],
      },
      {
        title: "Forms",
        icon: Icons.Alphabet,
        items: [
          {
            title: "Form Elements",
            url: "/forms/form-elements",
          },
          {
            title: "Form Layout",
            url: "/forms/form-layout",
          },
        ],
      },
      {
        title: "Tables",
        url: "/tables",
        icon: Icons.Table,
        items: [
          {
            title: "Tables",
            url: "/tables",
          },
        ],
      },
      {
        title: "Pages",
        icon: Icons.Alphabet,
        items: [
          {
            title: "Settings",
            url: "/pages/settings",
          },
        ],
      },      
      {
        title: "Charts",
        icon: Icons.PieChart,
        items: [
          {
            title: "Basic Chart",
            url: "/charts/basic-chart",
          },
        ],
      },
      {
        title: "UI Elements",
        icon: Icons.FourCircle,
        items: [
          {
            title: "Alerts",
            url: "/ui-elements/alerts",
          },
          {
            title: "Buttons",
            url: "/ui-elements/buttons",
          },
        ],
      },
      {
        title: "Authentication",
        icon: Icons.Authentication,
        items: [
          {
            title: "Sign In",
            url: "/sign-in",
          },
        ],
      },
    ],
  },
];
