"use client";

import InputGroup from "@/components/FormElements/InputGroup";
import { createUser } from "@/lib/api/CRUD/users";
import { useState } from "react";

export function CreateUserForm({ onClose }: { onClose: () => void }) {
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    password: "",
    role: "", // Kosong default agar user harus pilih role
  });

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    // Validasi sederhana
    if (
      !formData.username ||
      !formData.email ||
      !formData.password ||
      !formData.role
    ) {
      alert("Please fill in all fields!");
      return;
    }

    try {
      await createUser(formData);
      alert("User created successfully!");
      onClose(); // Tutup modal
      setFormData({
        username: "",
        email: "",
        password: "",
        role: "",
      });
      window.location.reload(); // Refresh data
    } catch (error: any) {
      alert(`Failed to create user: ${error.message}`);
      console.error("Create user error:", error);
    }
  };

  return (
    <div className="space-y-6">
      {/* Header: Title + Close Button */}
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-dark dark:text-white">
          Create New User
        </h2>
        <button
          onClick={onClose}
          className="text-xl font-semibold text-gray-500 hover:text-gray-800 dark:text-gray-300 dark:hover:text-white"
        >
          ✕
        </button>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="space-y-5">
        <InputGroup
          label="Username"
          name="username"
          type="text"
          placeholder="Enter username"
          value={formData.username}
          handleChange={handleChange}
        />

        <InputGroup
          label="Email"
          name="email"
          type="email"
          placeholder="Enter email address"
          value={formData.email}
          handleChange={handleChange}
        />

        <InputGroup
          label="Password"
          name="password"
          type="password"
          placeholder="Enter password"
          value={formData.password}
          handleChange={handleChange}
        />

        <div>
          <label className="mb-2 block text-sm font-medium text-dark dark:text-white">
            Role
          </label>
          <select
            name="role"
            value={formData.role}
            onChange={handleChange}
            required
            className="w-full rounded-lg border border-stroke bg-white focus:border-primary p-4 text-sm text-dark outline-none
                        dark:border-strokedark dark:disabled:bg-dark dark:bg-dark-2 dark:text-white appearance-none"
          >
            <option value="" disabled>
              Select Role
            </option>
            <option value="ADMIN">Admin</option>
            <option value="DOSEN">Dosen</option>
            <option value="MAHASISWA">Mahasiswa</option>
          </select>
        </div>

        <button
          type="submit"
          className="w-full rounded-lg bg-primary p-3 font-medium text-white hover:bg-opacity-90"
        >
          Create User
        </button>
      </form>
    </div>
  );
}
