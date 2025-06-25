import { useState, useEffect } from "react";
import type { User, PostUser } from "../types/user-type";
import { updateUser } from "../services/user-api";

interface UpdateUserModalProps {
  selectedUser: User | null;
  isOpen: boolean;
  onClose: () => void;
  onUserUpdated: () => void;
}

function UpdareUserModal({
  selectedUser,
  isOpen,
  onClose,
  onUserUpdated,
}: UpdateUserModalProps) {
  const [formData, setFormData] = useState<PostUser>({
    name: "",
    age: 0,
    email: "",
  });

  // Pre-populate form with existing user data when modal opens
  useEffect(() => {
    if (selectedUser && isOpen) {
      setFormData({
        name: selectedUser.name,
        age: selectedUser.age,
        email: selectedUser.email,
      });
    }
  }, [selectedUser, isOpen]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: name === "age" ? parseInt(value) || 0 : value,
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!selectedUser) return;

    try {
      // Create updated user object with ID
      const updatedUserData: User = {
        id: selectedUser.id,
        name: formData.name,
        age: formData.age,
        email: formData.email,
      };

      await updateUser(updatedUserData);
      console.log("User updated successfully");

      onClose();
      onUserUpdated(); // Refresh the user list
    } catch (error) {
      console.error("Error updating user:", error);
    }
  };

  const handleCancel = () => {
    // Reset form to original values
    if (selectedUser) {
      setFormData({
        name: selectedUser.name,
        age: selectedUser.age,
        email: selectedUser.email,
      });
    }
    onClose();
  };

  if (!isOpen || !selectedUser) return null;

  return (
    <div className="fixed inset-0  flex items-center justify-center z-50">
      <div className="w-5/12 border border-[#CCCCCC] rounded-lg shadow-md p-4 bg-white">
        <form onSubmit={handleSubmit} className="space-y-8">
          {/* Header */}
          <div className="flex flex-row justify-between items-center">
            <h3 className="text-3xl">Update User</h3>
            <button type="button" onClick={onClose} className="cursor-pointer">
              <img src="/x_vector.svg" className="w-4 h-4" />
            </button>
          </div>

          {/* Form inputs */}
          <div className="space-y-4">
            <div>
              <label
                htmlFor="name"
                className="block text-sm font-medium text-gray-700 mb-2"
              >
                Name
              </label>
              <input
                type="text"
                id="name"
                name="name"
                value={formData.name}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                placeholder="Enter user name"
                required
              />
            </div>

            <div>
              <label
                htmlFor="age"
                className="block text-sm font-medium text-gray-700 mb-2"
              >
                Age
              </label>
              <input
                type="number"
                id="age"
                name="age"
                value={formData.age}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                placeholder="Enter age"
                required
              />
            </div>

            <div>
              <label
                htmlFor="email"
                className="block text-sm font-medium text-gray-700 mb-2"
              >
                Email
              </label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={handleChange}
                className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                placeholder="Enter email address"
                required
              />
            </div>
          </div>

          {/* Buttons */}
          <div className="flex justify-between">
            <button
              type="button"
              onClick={handleCancel}
              className="px-4 py-2 text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500"
            >
              Cancel
            </button>
            <button type="submit" className="primary-button">
              Update User
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default UpdareUserModal;
