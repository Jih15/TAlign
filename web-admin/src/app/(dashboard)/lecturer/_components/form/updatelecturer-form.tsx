"use client";

import InputGroup from "@/components/FormElements/InputGroup";
import { updateLecturer } from "@/lib/api/CRUD/lecturers";
import { useState, useEffect } from "react";

interface UpdateLecturerFormProps {
  lecturer: {
    user_id: number;
    lecturer_id: number;
    fullname: string;
    nip: string;
    field: string;
  };
  onClose: ()=> void;
  onSuccess?: ()=> void;
}

export function UpdateLecturerForm({ lecturer, onClose, onSuccess }: UpdateLecturerFormProps) {
  const [formData, setFormData] = useState({
    nip: "",
    fullname: "",
    field: "",
  });

  const [isSubmitting, setIsSubmitting] = useState(false);

  // Initialize form with lecturer data
  useEffect(() => {
    if (lecturer) {
      setFormData({
        nip: lecturer.nip,
        fullname: lecturer.fullname,
        field: lecturer.field,
      });
    }
  }, [lecturer]);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);

    if (!formData.nip || !formData.fullname || !formData.field ) {
      alert("NIP, Fullname dan field harus diisi!");
      setIsSubmitting(false);
      return;
    }

    try {
      const updateData: any = {
        nip: formData.nip,
        fullname: formData.fullname,
        field: formData.field,
      }

      await updateLecturer(lecturer.lecturer_id, updateData);
      
      alert("Data lecturer berhasil diupdate!");
      onClose();
      
      if (onSuccess) {
        onSuccess();
      }
      
    } catch (error: any) {
      alert(`Gagal mengupdate lecturer: ${error.message}`);
      console.error("Update lecturer error: ", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-dark dark:text-white">
          Update Lecturer ({lecturer.fullname})
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
          label="NIP"
          name="nip"
          type="text"
          placeholder="Enter NIP"
          value={formData.nip ?? ""}
          handleChange={handleChange}
          required
        />

        <InputGroup
          label="Full Name"
          name="fullname"
          type="text"
          placeholder="Enter full name"
          value={formData.fullname ?? ""}
          handleChange={handleChange}
          required
        />

        <InputGroup
          label="Field"
          name="field"
          type="text"
          placeholder="Enter field"
          value={formData.field ?? ""}
          handleChange={handleChange}
          required
        />

        <button
          type="submit"
          className="w-full rounded-lg bg-primary p-3 font-medium text-white hover:bg-opacity-90 disabled:opacity-70"
          disabled={isSubmitting}
        >
          {isSubmitting ? "Updating..." : "Update Lecturer"}
        </button>
      </form>
    </div>
  );
}