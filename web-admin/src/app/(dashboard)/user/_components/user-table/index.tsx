"use client";

import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { cn } from "@/lib/utils";
import { useEffect, useState } from "react";
import { getAllUsers, deleteUser } from "@/lib/api/CRUD/users";
import { PencilSquareIcon, TrashIcon, } from "@/assets/icons";
import { ChevronUpDownIcon, ChevronUpIcon, ChevronDownIcon } from "@heroicons/react/16/solid"; 
import Modal from "@/components/Modal/modal";
import { CreateUserForm } from "../form/createuser-form";
import { UpdateUserForm } from "../form/updateuser-form";

type SortDirection = 'asc' | 'desc' | null;
type SortableField = 'username' | 'email' | 'role';

export function UserTable({ className }: { className?: string }) {
  const [users, setUsers] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [isDeleteModalOpen, setIsDeleteModalOpen] = useState(false);
  const [selectedUser, setSelectedUser] = useState<any | null>(null);
  const [userToDelete, setUserToDelete] = useState<any | null>(null);
  
  // Pagination state
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage, setItemsPerPage] = useState(5);
  
  // Sorting state
  const [sortField, setSortField] = useState<SortableField | null>(null);
  const [sortDirection, setSortDirection] = useState<SortDirection>(null);

  const fetchUsers = async () => {
    setLoading(true);
    try {
      const data = await getAllUsers();
      setUsers(data);
    } catch (err) {
      console.error("Error fetching users:", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  // Reset to first page when items per page or sorting changes
  useEffect(() => {
    setCurrentPage(1);
  }, [itemsPerPage, sortField, sortDirection]);

  // Sort users when sortField or sortDirection changes
  const sortedUsers = [...users].sort((a, b) => {
    if (!sortField) return 0;
    
    const aValue = a[sortField];
    const bValue = b[sortField];
    
    if (aValue < bValue) {
      return sortDirection === 'asc' ? -1 : 1;
    }
    if (aValue > bValue) {
      return sortDirection === 'asc' ? 1 : -1;
    }
    return 0;
  });

  // Pagination logic
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = sortedUsers.slice(indexOfFirstItem, indexOfLastItem);
  const totalPages = Math.ceil(sortedUsers.length / itemsPerPage);

  const paginate = (pageNumber: number) => setCurrentPage(pageNumber);

  const handleSort = (field: SortableField) => {
    if (sortField === field) {
      // Cycle through sort directions: null -> 'asc' -> 'desc' -> null
      if (sortDirection === null) {
        setSortDirection('asc');
      } else if (sortDirection === 'asc') {
        setSortDirection('desc');
      } else {
        setSortDirection(null);
        setSortField(null);
      }
    } else {
      setSortField(field);
      setSortDirection('asc');
    }
  };

  const renderSortIcon = (field: SortableField) => {
    if (sortField !== field) {
      return <ChevronUpDownIcon className="w-4 h-4 ml-1" />;
    }
    switch (sortDirection) {
      case 'asc':
        return <ChevronUpIcon className="w-4 h-4 ml-1" />;
      case 'desc':
        return <ChevronDownIcon className="w-4 h-4 ml-1" />;
      default:
        return <ChevronUpDownIcon className="w-4 h-4 ml-1" />;
    }
  };

  const handleDeleteClick = (user: any) => {
    setUserToDelete(user);
    setIsDeleteModalOpen(true);
  };

  const confirmDelete = async () => {
    if (!userToDelete) return;
    
    try {
      await deleteUser(userToDelete.user_id);
      // Refresh user list after successful deletion
      await fetchUsers();
      setIsDeleteModalOpen(false);
      setUserToDelete(null);
    } catch (error) {
      console.error("Failed to delete user:", error);
      alert("Failed to delete user. Please try again.");
    }
  };

  if (loading) return <div className="text-white">Loading...</div>;

  return (
    <div
      className={cn(
        "grid rounded-[10px] bg-white px-7.5 pb-4 pt-7.5 shadow-1 dark:bg-gray-dark dark:shadow-card",
        className,
      )}
    >
      {/* Heading and Create Button */}
      <div className="mb-4 flex items-center justify-between">
        <h2 className="text-body-2xlg font-bold text-dark dark:text-white">
          All Users
        </h2>
        <button 
          onClick={() => setIsModalOpen(true)} 
          className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-white hover:bg-primary-dark"
        >
          + Create
        </button>
      </div>

      {/* Modals */}
      <Modal isOpen={isModalOpen} onClose={() => setIsModalOpen(false)}>
        <CreateUserForm onClose={() => setIsModalOpen(false)} />
      </Modal>

      <Modal isOpen={isEditModalOpen} onClose={() => setIsEditModalOpen(false)}>
        <UpdateUserForm 
          user={selectedUser}
          onClose={() => setIsEditModalOpen(false)}
          onSuccess={fetchUsers}
        />
      </Modal>

      {/* Delete Confirmation Modal */}
      <Modal isOpen={isDeleteModalOpen} onClose={() => setIsDeleteModalOpen(false)}>
        <div className="space-y-6">
          <div className="flex items-center justify-between">
            <h2 className="text-xl font-semibold text-dark dark:text-white">
              Confirm Deletion
            </h2>
            <button
              onClick={() => setIsDeleteModalOpen(false)}
              className="text-xl font-semibold text-gray-500 hover:text-gray-800 dark:text-gray-300 dark:hover:text-white"
            >
              ✕
            </button>
          </div>
          
          <p className="text-dark dark:text-white">
            Are you sure you want to delete user <strong>{userToDelete?.username}</strong>?
          </p>
          
          <div className="flex justify-end space-x-3">
            <button
              onClick={() => setIsDeleteModalOpen(false)}
              className="rounded-md px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-700"
            >
              Cancel
            </button>
            <button
              onClick={confirmDelete}
              className="rounded-md bg-red-600 px-4 py-2 text-sm font-medium text-white hover:bg-red-700"
            >
              Delete
            </button>
          </div>
        </div>
      </Modal>

      {/* Items per page selector */}
      <div className="mb-4 flex items-center justify-between">
        <div className="flex items-center space-x-2">
          <span className="text-sm text-gray-500 dark:text-gray-400">Show:</span>
          <select
            value={itemsPerPage}
            onChange={(e) => setItemsPerPage(Number(e.target.value))}
            className="rounded-md border border-gray-300 bg-white px-3 py-1 text-sm dark:border-gray-600 dark:bg-gray-700"
          >
            <option value={5}>5</option>
            <option value={10}>10</option>
            <option value={20}>20</option>
            <option value={50}>50</option>
          </select>
          <span className="text-sm text-gray-500 dark:text-gray-400">entries</span>
        </div>
      </div>

      <Table>
        <TableHeader>
          <TableRow className="border-none uppercase">
            <TableHead 
              className="text-left cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700"
              onClick={() => handleSort('username')}
            >
              <div className="flex items-center">
                Username
                {renderSortIcon('username')}
              </div>
            </TableHead>
            <TableHead 
              className="text-left cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700"
              onClick={() => handleSort('email')}
            >
              <div className="flex items-center">
                Email
                {renderSortIcon('email')}
              </div>
            </TableHead>
            <TableHead 
              className="text-left cursor-pointer hover:bg-gray-100 dark:hover:bg-gray-700"
              onClick={() => handleSort('role')}
            >
              <div className="flex items-center">
                Role
                {renderSortIcon('role')}
              </div>
            </TableHead>
            <TableHead className="text-right">Action</TableHead>
          </TableRow>
        </TableHeader>

        <TableBody>
          {currentItems.map((user) => (
            <TableRow
              key={user.user_id}
              className="text-base font-medium text-dark dark:text-white"
            >
              <TableCell className="text-left">{user.username}</TableCell>
              <TableCell className="text-left">{user.email}</TableCell>
              <TableCell className="text-left">{user.role}</TableCell>
              <TableCell className="text-right xl:pr-7.5">
                <div className="flex justify-end items-center gap-x-3.5">
                  <button 
                    onClick={() => handleDeleteClick(user)} 
                    className="hover:text-red-600"
                  >
                    <span className="sr-only">Delete</span>
                    <TrashIcon />
                  </button>
                  <button 
                    onClick={() => {
                      setSelectedUser(user);
                      setIsEditModalOpen(true);
                    }} 
                    className="hover:text-orange-400"
                  >
                    <span className="sr-only">Edit</span>
                    <PencilSquareIcon />
                  </button>
                </div>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>

      {/* Pagination Controls */}
      <div className="mt-4 flex flex-col items-center justify-between gap-4 sm:flex-row">
        <div className="text-sm text-gray-500 dark:text-gray-400">
          Showing {indexOfFirstItem + 1} to {Math.min(indexOfLastItem, sortedUsers.length)} of {sortedUsers.length} entries
        </div>
        <div className="flex space-x-2">
          <button
            onClick={() => paginate(currentPage - 1)}
            disabled={currentPage === 1}
            className="rounded-md px-3 py-1 text-sm disabled:opacity-50 disabled:cursor-not-allowed bg-gray-100 dark:bg-gray-700"
          >
            Previous
          </button>
          
          {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
            let pageNum;
            if (totalPages <= 5) {
              pageNum = i + 1;
            } else if (currentPage <= 3) {
              pageNum = i + 1;
            } else if (currentPage >= totalPages - 2) {
              pageNum = totalPages - 4 + i;
            } else {
              pageNum = currentPage - 2 + i;
            }
            
            return (
              <button
                key={pageNum}
                onClick={() => paginate(pageNum)}
                className={`rounded-md px-3 py-1 text-sm min-w-[40px] ${
                  currentPage === pageNum 
                    ? 'bg-primary text-white' 
                    : 'bg-gray-100 dark:bg-gray-700'
                }`}
              >
                {pageNum}
              </button>
            );
          })}
          
          <button
            onClick={() => paginate(currentPage + 1)}
            disabled={currentPage === totalPages}
            className="rounded-md px-3 py-1 text-sm disabled:opacity-50 disabled:cursor-not-allowed bg-gray-100 dark:bg-gray-700"
          >
            Next
          </button>
        </div>
      </div>
    </div>
  );
}