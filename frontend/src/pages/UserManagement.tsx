import { useEffect } from "react";
import { getAllUsers } from "../services/user-api";
import UserTable from "../components/UserTable";
import TableHeader from "../components/TableHeader";

function UserManagement() {
  return (
    <div className="min-h-screen min-w-screen flex items-center justify-center">
      <div className="w-2/3">
        <TableHeader />
        <UserTable />
      </div>
    </div>
  );
}

export default UserManagement;
