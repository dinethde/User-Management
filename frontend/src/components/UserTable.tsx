import { useEffect, useState } from "react";
import {
  flexRender,
  getCoreRowModel,
  useReactTable,
} from "@tanstack/react-table";
import type { ColumnDef } from "@tanstack/react-table";
import type { User } from "../types/user-type";
import { getAllUsers } from "../services/user-api";
import InfoModelApp from "./InfoModel";

interface UserTableProps {
  data: User[];
  setData: (data: User[]) => void;
}

function UserTable({ data, setData }: UserTableProps) {
  const [selectedUser, setSelectedUser] = useState<User | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);

  const columns: ColumnDef<User>[] = [
    {
      accessorKey: "id",
      header: "ID",
    },
    {
      accessorKey: "name",
      header: "Name",
    },
    {
      accessorKey: "email",
      header: "Email",
    },
    {
      accessorKey: "age",
      header: "Age",
    },
    {
      id: "actions", // Use 'id' instead of 'accessorKey' for custom columns
      header: "Actions",
      cell: (
        { row } // Custom cell renderer
      ) => (
        <button
          onClick={() => handleOpenModal(row.original)}
          className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-3 rounded text-sm"
        >
          View Details
        </button>
      ),
    },
  ];

  const handleOpenModal = (user: User) => {
    setSelectedUser(user);
    setIsModalOpen(true);
  };

  const handleCloseModal = () => {
    setSelectedUser(null);
    setIsModalOpen(false);
  };

  const onUserDeleted = async () => {
    try {
      const updatedUser = await getAllUsers();
      setData(updatedUser);
    } catch (err) {
      console.error("Failed to refresh", err);
    }
  };

  const onUserUpdated = async () => {
    try {
      const updatedUsers = await getAllUsers();
      setData(updatedUsers);
    } catch (error) {
      console.error("Failed to refresh user data:", error);
    }
  };

  // Fetching initial users
  useEffect(() => {
    async function fetchInitialUsers() {
      try {
        const result = await getAllUsers();

        setData(result);

        console.log("Initial users : ", data);
      } catch (err) {
        console.error("Error message : ", err);
      }
    }

    fetchInitialUsers();
  }, []);

  const table = useReactTable({
    data,
    columns,
    getCoreRowModel: getCoreRowModel(),
  });

  return (
    <div className="w-full">
      <table className="w-full">
        <thead>
          {table.getHeaderGroups().map((headerGroup) => (
            <tr key={headerGroup.id}>
              {headerGroup.headers.map((header) => (
                <th
                  key={header.id}
                  className="border border-gray-300 p-2 text-left"
                >
                  {header.isPlaceholder
                    ? null
                    : flexRender(
                        header.column.columnDef.header,
                        header.getContext()
                      )}
                </th>
              ))}
            </tr>
          ))}
        </thead>

        <tbody>
          {table.getCoreRowModel().rows.map((row) => (
            <tr key={row.id}>
              {row.getVisibleCells().map((cell) => (
                <td key={cell.id} className="border border-gray-300 p-2">
                  {flexRender(cell.column.columnDef.cell, cell.getContext())}
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>

      {/* User model */}
      <div>
        <InfoModelApp
          selectedUser={selectedUser}
          handleCloseModal={handleCloseModal}
          isModalOpen={isModalOpen}
          onUserDeleted={onUserDeleted}
          onUserUpdated={onUserUpdated}
        />
      </div>

      {/* {isModalOpen && (
        <div className="fixed inset-0  bg-amber-50/0 flex items-center justify-center z-50">
          <div className="bg-white p-6 rounded-lg shadow-lg max-w-md w-full mx-4">
            <div className="flex justify-between items-center mb-4">
              <h2 className="text-xl font-bold">User Details</h2>
              <button
                onClick={handleCloseModal}
                className="text-gray-500 hover:text-gray-700 text-2xl"
              >
                ×
              </button>
            </div>
            {selectedUser && (
              <div className="space-y-2">
                <p>
                  <strong>ID:</strong> {selectedUser.id}
                </p>
                <p>
                  <strong>Name:</strong> {selectedUser.name}
                </p>
                <p>
                  <strong>Age:</strong> {selectedUser.age}
                </p>
              </div>
            )}
            <div className="mt-4 flex justify-end">
              <button
                onClick={handleCloseModal}
                className="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded"
              >
                Close
              </button>
            </div>
          </div>
        </div>
      )} */}
    </div>
  );
}

export default UserTable;
