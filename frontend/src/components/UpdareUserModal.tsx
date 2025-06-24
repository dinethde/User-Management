import type { User } from "../types/user-type";

interface UserUpdateProps {
  selectedUser: User | null;
}

function UpdareUserModal({ selectedUser }: UserUpdateProps) {
  return <div>isModalOpen</div>;
}

export default UpdareUserModal;
