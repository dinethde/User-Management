import { useEffect, useState } from "react";
import { getAllUsers } from "../services/user-api";
import UserTable from "../components/UserTable";
import TableHeader from "../components/TableHeader";
import AddUserModal from "../components/AddUserModal";
import type { User } from "../types/user-type";

function UserManagement() {
  const [data, setData] = useState<User[]>([]);

  return (
    <div className="min-h-screen min-w-screen flex items-center justify-center">
      <div className="w-2/3">
        <TableHeader />
        <UserTable data={data} setData={setData} />
        <AddUserModal data={data} setData={setData} />
      </div>
    </div>
  );
}

export default UserManagement;
