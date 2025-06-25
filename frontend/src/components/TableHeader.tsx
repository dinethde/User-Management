import "../index.css";

interface TableHeaderProps {
  onHandleAddUserClick: () => void;
}

function TableHeader({ onHandleAddUserClick }: TableHeaderProps) {
  return (
    <div className="flex flex-row justify-between items-center py-6">
      <h3 className="text-4xl">User List</h3>

      <button
        className="primary-button"
        id="addUserTable"
        onClick={onHandleAddUserClick}
      >
        <img src="./plus_vector.svg" />
        <p>Add new user</p>
      </button>
    </div>
  );
}

export default TableHeader;
