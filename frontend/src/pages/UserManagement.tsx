import { useState } from "react";
import UserTable from "../components/UserTable";
import TableHeader from "../components/TableHeader";
import AddUserModal from "../components/AddUserModal";
import type { User } from "../types/user-type";

function UserManagement() {
  const [data, setData] = useState<User[]>([]);
  const [isAddModalOpen, setIsAddModalOpen] = useState(false);

  const handleAddUserClick = () => {
    console.log(isAddModalOpen);
    setIsAddModalOpen(true);
    console.log("after : ", isAddModalOpen);
  };

  const handleCloseUserClick = () => {
    setIsAddModalOpen(false);
  };

  return (
    <div className="min-h-screen min-w-screen flex items-center justify-center">
      <div className="w-2/3">
        <TableHeader onHandleAddUserClick={handleAddUserClick} />
        <UserTable data={data} setData={setData} />
        {isAddModalOpen && (
          <AddUserModal
            data={data}
            setData={setData}
            onHandleCloseUserClick={handleCloseUserClick}
            isOpen={true}
          />
        )}
      </div>
    </div>
  );
}

export default UserManagement;
