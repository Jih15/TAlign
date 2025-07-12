import constantValue from "@/lib/const/constant-value";
import cookie from "@/lib/const/cookie";
import { useEffect, useState } from "react";

export function useUser() {
  const [user, setUser] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        const res = await fetch(`${constantValue.BASE_URL}/users/me`, {
          headers: {
            Authorization: `Bearer ${cookie.getCookie("access_token")}`,
          },
        });

        if (res.status === 401) {
          // Token expired, hapus cookie & redirect
          document.cookie = `access_token=; path=/; expires=Thu, 01 Jan 1970 00:00:00 GMT`;
          window.location.href = "/sign-in";
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
