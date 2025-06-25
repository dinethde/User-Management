import type { User } from "../types/user-type";
import { deleteUser } from "../services/user-api";

interface InfoModelAppProps {
  selectedUser: User | null;
  isModalOpen: boolean;
  handleCloseModal: () => void;
  onUserDeleted?: () => void;
}

// function delete

function InfoModelApp({
  handleCloseModal,
  isModalOpen,
  selectedUser,
  onUserDeleted,
}: InfoModelAppProps) {
  // const [isUpdateModalOpen, setUpdateModalOpen] = useState(false);

  const handleDeleteUser = async () => {
    if (!selectedUser?.id) return;

    try {
      await deleteUser(selectedUser.id);

      handleCloseModal();
      onUserDeleted?.();
    } catch (error) {
      console.error("Failed to delete user : ", error);
    }
  };

  return (
    isModalOpen && (
      <div className="flex flex-col gap-4 border border-[#e6e6e6] p-4 rounded-sm drop-shadow-xl bg-white w-fit">
        <button onClick={handleCloseModal}>
          <img src="/x_vector.svg" />
        </button>
        <button className="px-3 py-2 flex gap-2 bg-[#1A1A1A] rounded-sm w-fit whitespace-nowrap ">
          <img src="/update-icon.svg" alt="Update icon" />
          <button
            // onClick={handleUpdateUserModalOpen}
            className="text-neutral-50"
          >
            Update User
          </button>
        </button>

        <button className="px-3 py-2 flex gap-2 bg-[#1A1A1A] rounded-sm  whitespace-nowrap w-fit">
          <img src="/delete-icon.svg" alt="Delete icon" />
          <button className="text-neutral-50" onClick={handleDeleteUser}>
            Delete User
          </button>
        </button>
      </div>
    )
  );
}

export default InfoModelApp;
