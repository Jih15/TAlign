// src/lib/const/constant-value.ts
import clientConst from "./constant-value.client";
import serverConst from "./constant-value.server";

const constantValue =
  typeof window === "undefined" ? serverConst : clientConst;

export default constantValue;
