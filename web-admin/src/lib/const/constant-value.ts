const BASE_URL: string = "http://127.0.0.1:8000";

function getCookie(name: string): string | undefined {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop()?.split(';').shift();
}

function getAuthHeader(): { 
  Authorization: string; 
  "Content-Type": string 
} {
  const token = getCookie("access_token");
  if (!token) throw new Error("Unauthorized: No token found");
  return {
    Authorization: `Bearer ${token}`,
    "Content-Type": "application/json"
  };
}

function handleAuthError(status: number): void {
  if (status === 401 || status === 403) {
    document.cookie = "access_token=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT";
    window.location.href = "/auth/sign-in";
  }
}

export default {
  BASE_URL,
  getCookie,
  getAuthHeader,
  handleAuthError
};