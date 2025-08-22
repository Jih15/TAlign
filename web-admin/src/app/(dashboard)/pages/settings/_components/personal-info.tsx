"use client";

import {
  EmailIcon,
  UploadIcon,
  UserIcon,
} from "@/assets/icons";
import InputGroup from "@/components/FormElements/InputGroup";
import { ShowcaseSection } from "@/components/Layouts/showcase-section";
import {
  getCurrentUserClient,
  updateCurrentUserClient,
} from "@/lib/api/CRUD/users/users.client";
import { useEffect, useState } from "react";
import Image from "next/image";

type UserResponse = {
  user_id: number;
  username: string;
  email: string;
  role: string;
  created_at: string;
  updated_at: string;
  profile_picture: string | null;
};

export function PersonalInfoForm() {
  const [loading, setLoading] = useState(false);
  const [preview, setPreview] = useState<string | null>(null);
  const [user, setUser] = useState<UserResponse | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [selectedFile, setSelectedFile] = useState<File | null>(null);

  // Fetch current user saat mount
  useEffect(() => {
    async function fetchUser() {
      try {
        const data = await getCurrentUserClient(); 
        setUser(data);
        if (data.profile_picture) {
          setPreview(data.profile_picture);
        }
      } catch (err: any) {
        setError("Gagal memuat data user");
        console.error("fetchUser error:", err);
      }
    }
    fetchUser();
  }, []);

  async function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!user) return;

    setLoading(true);
    const formData = new FormData(e.currentTarget);

    try {
      const updateData = {
        username: formData.get("username") as string,
        email: formData.get("email") as string,
        photo: selectedFile,
      };

      console.log("🚀 Sending update data:", {
        username: updateData.username,
        email: updateData.email,
        hasPhoto: !!updateData.photo,
        fileName: updateData.photo?.name,
      });

      // Validasi input
      if (!updateData.username || !updateData.email) {
        throw new Error("Username and email are required");
      }

      await updateCurrentUserClient(updateData);

      // Refresh user data
      const refreshedUser = await getCurrentUserClient();
      setUser(refreshedUser);
      if (refreshedUser.profile_picture) {
        setPreview(refreshedUser.profile_picture);
      }

      // Reset file selection
      setSelectedFile(null);

      alert("Profile Updated Successfully!");
    } catch (err: any) {
      console.error("❌ Update error:", err);
      alert(`Error: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }

  function handleFileChange(e: React.ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (file) {
      // Validasi file
      const maxSize = 5 * 1024 * 1024; // 5MB
      const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];
      
      console.log("📁 File selected:", {
        name: file.name,
        type: file.type,
        size: file.size,
        sizeInMB: (file.size / 1024 / 1024).toFixed(2) + 'MB'
      });

      if (!allowedTypes.includes(file.type)) {
        alert('Please select a valid image file (JPEG, JPG, PNG)');
        e.target.value = ''; // Reset input
        return;
      }

      if (file.size > maxSize) {
        alert('File size must be less than 5MB');
        e.target.value = ''; // Reset input
        return;
      }

      setSelectedFile(file);
      setPreview(URL.createObjectURL(file));
      console.log("✅ File validated and set successfully");
    } else {
      console.log("❌ No file selected");
    }
  }

  function handleDeletePhoto() {
    setPreview(user?.profile_picture || null);
    setSelectedFile(null);
    // Reset file input
    const fileInput = document.getElementById("photo") as HTMLInputElement;
    if (fileInput) {
      fileInput.value = "";
    }
  }

  if (error) return <p className="text-red-500">{error}</p>;
  if (!user) return <p>Loading...</p>;

  return (
    <ShowcaseSection title="Personal Information" className="!p-7">
      <form onSubmit={handleSubmit}>
        {/* Upload Photo */}
        <div className="mb-6 flex items-center gap-3">
          <Image
            src={preview || "/images/user/user-03.png"}
            width={55}
            height={55}
            alt="User"
            className="size-14 rounded-full object-cover"
          />
          <div>
            <span className="mb-1.5 font-medium text-dark dark:text-white">
              Edit your photo
            </span>
            <span className="flex gap-3">
              <button
                type="button"
                onClick={handleDeletePhoto}
                className="text-body-sm hover:text-red"
              >
                Delete
              </button>
              <label
                htmlFor="photo"
                className="cursor-pointer text-body-sm hover:text-primary"
              >
                Update
              </label>
            </span>
            {selectedFile && (
              <p className="text-xs text-green-600 mt-1">
                Selected: {selectedFile.name}
              </p>
            )}
          </div>
        </div>

        <input
          type="file"
          name="photo"
          id="photo"
          accept="image/png, image/jpg, image/jpeg"
          hidden
          onChange={handleFileChange}
        />

        {/* Personal Info */}
        <InputGroup
          className="mb-5.5"
          type="email"
          name="email"
          label="Email Address"
          placeholder="Enter your email"
          defaultValue={user.email}
          icon={<EmailIcon />}
          iconPosition="left"
          height="sm"
          required
        />

        <InputGroup
          className="mb-5.5"
          type="text"
          name="username"
          label="Username"
          placeholder="Enter your username"
          defaultValue={user.username}
          icon={<UserIcon />}
          iconPosition="left"
          height="sm"
          required
        />

        <InputGroup
          className="mb-5.5"
          type="text"
          name="role"
          label="Role"
          placeholder="role"
          defaultValue={user.role}
          disabled
          icon={<UserIcon />}
          iconPosition="left"
          height="sm"
        />

        <div className="mb-5 text-sm text-gray-500 dark:text-gray-400">
          <p>Created at: {new Date(user.created_at).toLocaleString()}</p>
          <p>Updated at: {new Date(user.updated_at).toLocaleString()}</p>
        </div>

        {/* Action buttons */}
        <div className="flex justify-end gap-3">
          <button
            className="rounded-lg border border-stroke px-6 py-[7px] font-medium text-dark hover:shadow-1 dark:border-dark-3 dark:text-white"
            type="button"
            onClick={() => {
              // Reset form to original values
              setPreview(user?.profile_picture || null);
              setSelectedFile(null);
              const form = document.querySelector("form") as HTMLFormElement;
              form?.reset();
            }}
          >
            Cancel
          </button>

          <button
            disabled={loading}
            className="rounded-lg bg-primary px-6 py-[7px] font-medium text-gray-2 hover:bg-opacity-90 disabled:opacity-50"
            type="submit"
          >
            {loading ? "Saving..." : "Save"}
          </button>
        </div>
      </form>
    </ShowcaseSection>
  );
}