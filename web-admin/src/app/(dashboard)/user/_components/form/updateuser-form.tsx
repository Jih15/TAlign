"use client";

import InputGroup from "@/components/FormElements/InputGroup";
import { updateUser } from "@/lib/api/CRUD/users";
import { useState, useEffect } from "react";

interface UpdateUserFormProps {
  user: {
    user_id: number;
    username: string;
    email: string;
    role: string;
  };
  onClose: () => void;
  onSuccess?: () => void;
}

export function UpdateUserForm({ user, onClose, onSuccess }: UpdateUserFormProps) {
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    password: "",
    role: "",
  });

  const [isSubmitting, setIsSubmitting] = useState(false);

  // Initialize form with user data
  useEffect(() => {
    if (user) {
      setFormData({
        username: user.username,
        email: user.email,
        password: "", // Password dikosongkan default
        role: user.role,
      });
    }
  }, [user]);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);

    // Validasi
    if (!formData.username || !formData.email || !formData.role) {
      alert("Username, email, dan role harus diisi!");
      setIsSubmitting(false);
      return;
    }

    try {
      // Siapkan data untuk update
      const updateData: any = {
        username: formData.username,
        email: formData.email,
        role: formData.role,
      };

      // Hanya kirim password jika diisi
      if (formData.password) {
        updateData.password = formData.password;
      }

      await updateUser(user.user_id, updateData);
      
      alert("User berhasil diupdate!");
      onClose();
      
      // Panggil callback success jika ada
      if (onSuccess) {
        onSuccess();
      }
      
    } catch (error: any) {
      alert(`Gagal mengupdate user: ${error.message}`);
      console.error("Update user error:", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-dark dark:text-white">
          Update User ({user.username})
        </h2>
        <button
          onClick={onClose}
          className="text-xl font-semibold text-gray-500 hover:text-gray-800 dark:text-gray-300 dark:hover:text-white"
          disabled={isSubmitting}
        >
          ✕
        </button>
      </div>

      <form onSubmit={handleSubmit} className="space-y-5">
        <InputGroup
          label="Username"
          name="username"
          type="text"
          placeholder="Enter username"
          value={formData.username}
          handleChange={handleChange}
          required
        />

        <InputGroup
          label="Email"
          name="email"
          type="email"
          placeholder="Enter email address"
          value={formData.email}
          handleChange={handleChange}
          required
        />

        <InputGroup
          label="Password (biarkan kosong jika tidak ingin diubah)"
          name="password"
          type="password"
          placeholder="Enter new password"
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
            className="w-full rounded-lg border border-stroke bg-white p-4 text-sm text-dark outline-none focus:border-primary
                      dark:border-strokedark dark:bg-dark-2 dark:text-white dark:focus:border-primary"
            disabled={isSubmitting}
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
          className="w-full rounded-lg bg-primary p-3 font-medium text-white hover:bg-opacity-90 disabled:opacity-70"
          disabled={isSubmitting}
        >
          {isSubmitting ? "Updating..." : "Update User"}
        </button>
      </form>
    </div>
  );
}