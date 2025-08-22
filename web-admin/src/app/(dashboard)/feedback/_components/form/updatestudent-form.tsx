"use client";

import InputGroup from "@/components/FormElements/InputGroup";
// import { updateStudent } from "@/lib/api/CRUD/students/students";
import { updateStudentClient } from "@/lib/api/CRUD/students/student.client";
import { useState, useEffect } from "react";

interface UpdateStudentFormProps {
  student: {
    user_id: number;
    student_id: number;
    nim: string;
    full_name: string;
    majors: string;
    study_program: string;
  };
  onClose: ()=> void;
  onSuccess?: ()=> void;
}

export function UpdateStudentForm({ student, onClose, onSuccess }: UpdateStudentFormProps) {
  const [formData, setFormData] = useState({
    nim: "",
    full_name: "",
    majors: "",
    study_program: "",
  });

  const [isSubmitting, setIsSubmitting] = useState(false);

  // Initialize form with student data
  useEffect(() => {
    if (student) {
      setFormData({
        nim: student.nim,
        full_name: student.full_name,
        majors: student.majors,
        study_program: student.study_program,
      });
    }
  }, [student]);

  const handleChange = (
    e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
  ) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);

    if (!formData.nim || !formData.full_name || !formData.majors || !formData.study_program) {
      alert("NIM, Fullname, majors, dan study program harus diisi!");
      setIsSubmitting(false);
      return;
    }

    try {
      const updateData: any = {
        nim: formData.nim,
        full_name: formData.full_name,
        majors: formData.majors,
        study_program: formData.study_program,
      }

      await updateStudentClient(student.student_id, updateData);
      
      alert("Data student berhasil diupdate!");
      onClose();
      
      if (onSuccess) {
        onSuccess();
      }
      
    } catch (error: any) {
      alert(`Gagal mengupdate student: ${error.message}`);
      console.error("Update student error: ", error);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-dark dark:text-white">
          Update Student ({student.full_name})
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
          label="NIM"
          name="nim"
          type="text"
          placeholder="Enter NIM"
          value={formData.nim ?? ""}
          handleChange={handleChange}
          required
        />

        <InputGroup
          label="Full Name"
          name="full_name"
          type="text"
          placeholder="Enter full name"
          value={formData.full_name ?? ""}
          handleChange={handleChange}
          required
        />

        <InputGroup
          label="Majors"
          name="majors"
          type="text"
          placeholder="Enter majors"
          value={formData.majors ?? ""}
          handleChange={handleChange}
          required
        />

        <InputGroup
          label="Study Program"
          name="study_program"
          type="text"
          placeholder="Enter study program"
          value={formData.study_program ?? ""}
          handleChange={handleChange}
          required
        />

        <button
          type="submit"
          className="w-full rounded-lg bg-primary p-3 font-medium text-white hover:bg-opacity-90 disabled:opacity-70"
          disabled={isSubmitting}
        >
          {isSubmitting ? "Updating..." : "Update Student"}
        </button>
      </form>
    </div>
  );
}