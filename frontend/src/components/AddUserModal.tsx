import { useState } from "react";
import type { User } from "../types/user-type";
import type { PostUser } from "../types/user-type";
import { addUser } from "../services/user-api";

interface AddUserModalProps {
  data: User[];
  setData: (data: User[]) => void;
  onHandleCloseUserClick: () => void;
  isOpen: boolean; // Add this prop to control modal visibility
}

function AddUserModal({
  data,
  setData,
  onHandleCloseUserClick,
  isOpen,
}: AddUserModalProps) {
  console.log(data);

  const [formData, setFormData] = useState<PostUser>({
    name: "",
    age: 0,
    email: "",
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: name === "age" ? parseInt(value) || 0 : value,
    }));

    console.log("Form data in handle change : " + formData);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Form data:", formData);

    try {
      const newUser = await addUser(formData);
      console.log("User added successfully:", newUser);

      // Add the new user to the existing data
      setData([...data, newUser]);

      // Reset the form
      setFormData({
        name: "",
        age: 0,
        email: "",
      });

      // Close the modal after successful submission
      onHandleCloseUserClick();
    } catch (error) {
      console.error("Error adding user:", error);
    }
  };

  // Don't render if modal is not open
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-white/80 flex items-center justify-center z-50">
      <div className="w-5/12 border bg-white border-[#CCCCCC] rounded-lg shadow-md p-4 ">
        <form onSubmit={handleSubmit} className="space-y-8">
          {/* Header */}
          <div className="flex flex-row justify-between items-center">
            <h3 className="text-3xl">Add n new user</h3>
            <button onClick={onHandleCloseUserClick} className="cursor-pointer">
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
          <div className="flex justify-between ">
            <button
              type="button"
              onClick={onHandleCloseUserClick}
              className="px-4 py-2 text-gray-700 bg-gray-200 rounded-md hover:bg-gray-300 focus:outline-none focus:ring-2 focus:ring-gray-500"
            >
              Cancel
            </button>
            <button type="submit" className="primary-button">
              Add User
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

export default AddUserModal;
