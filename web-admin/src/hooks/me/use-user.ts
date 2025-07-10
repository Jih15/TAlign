import constantValue from "@/lib/const/constant-value";
import { useEffect, useState } from "react";

export function useUser() {
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const BaseUrl = "http://127.0.0.1:8000";

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const res = await fetch(`${BaseUrl}/users/me`, {
          headers: {
            Authorization: `Bearer ${constantValue.getCookie("access_token")}`,
          },
        });

        if (res.status === 401) {
          // Token expired, hapus cookie & redirect
          document.cookie = `access_token=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT`;
          window.location.href = "/auth/sign-in";
          return;
        }

        const data = await res.json();
        setUser(data);
      } catch (error) {
        console.error("Fetch user error:", error);
        setUser(null);
      } finally {
        setLoading(false);
      }
    };

    fetchUser();
  }, []);

  return { user, loading };
}
