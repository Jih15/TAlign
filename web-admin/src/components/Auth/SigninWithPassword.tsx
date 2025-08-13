"use client";
import { EmailIcon, PasswordIcon } from "@/assets/icons";
import Link from "next/link";
import { useRouter } from "next/navigation";
import React, { useState } from "react";
import InputGroup from "../FormElements/InputGroup";
import { Checkbox } from "../FormElements/checkbox";
import { loginUser } from "@/lib/api/auth";
import cookie from "@/lib/const/cookie";

export default function SigninWithPassword() {
  const router = useRouter();
  const [error, setError] = useState<string | null>(null);

  const [data, setData] = useState({
    username: "",
    password: "",
    remember: false,
  });

  const [loading, setLoading] = useState(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setData({
      ...data,
      [e.target.name]: e.target.value,
    });
  };

  const handleLogin = async (e: React.FormEvent)=> {
    e.preventDefault();
    console.log("Submit login dipanggil");
    setLoading(true);
    setError(null);

    try {
      const res = await loginUser({
        username: data.username,
        password: data.password
      });
      
      const { access_token, role } = res;

      // Get token for cookie
      cookie.setCookie("access_token", res.access_token, 7);

      router.push("/");

    } catch (err: any){
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <form onSubmit={handleLogin}>
      {error && (
        <div className="mb-4 rounded bg-red-100 p-3 text-red-600">
          {error}
        </div>
      )}

      <InputGroup
        type="text"
        label="Username"
        className="mb-4 [&_input]:py-[15px]"
        placeholder="Enter your username"
        name="username"
        handleChange={handleChange}
        value={data.username}
        icon={<EmailIcon />}
      />

      <InputGroup
        type="password"
        label="Password"
        className="mb-5 [&_input]:py-[15px]"
        placeholder="Enter your password"
        name="password"
        handleChange={handleChange}
        value={data.password}
        icon={<PasswordIcon />}
      />

      <div className="mb-6 flex items-center justify-between gap-2 py-2 font-medium">
        <Checkbox
          label="Remember me"
          name="remember"
          withIcon="check"
          minimal
          radius="md"
          onChange={(e) =>
            setData({
              ...data,
              remember: e.target.checked,
            })
          }
        />

        <Link
          href="/auth/forgot-password"
          className="hover:text-primary dark:text-white dark:hover:text-primary"
        >
          Forgot Password?
        </Link>
      </div>

      <div className="mb-4.5">
        <button
          type="submit"
          disabled={loading}
          className="flex w-full cursor-pointer items-center justify-center gap-2 rounded-lg bg-primary p-4 font-medium text-white transition hover:bg-opacity-90 disabled:opacity-80"
        >
          Sign In
          {loading && (
            <span className="inline-block h-4 w-4 animate-spin rounded-full border-2 border-solid border-white border-t-transparent" />
          )}
        </button>
      </div>
    </form>
  );
}