import { cookies } from "next/headers";

const BASE_URL = "http://127.0.0.1:8000";

async function getAuthHeader(): Promise<{
  Authorization: string;
  "Content-Type": string;
}> {
  const cookieStore = await cookies(); // pakai await
  const token = cookieStore.get("access_token")?.value;

  if (!token) throw new Error("Unauthorized: No token found");

  return {
    Authorization: `Bearer ${token}`,
    "Content-Type": "application/json",
  };
}

function handleAuthError(status: number): void {
  if (status === 401 || status === 403) {
    console.warn("Unauthorized access (server-side)");
  }
}

export default {
  BASE_URL,
  getAuthHeader,
  handleAuthError,
};
