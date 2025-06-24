function TableHeader() {
  return (
    <div className="flex flex-row justify-between items-center py-6">
      <h3 className="text-4xl">User List</h3>

      <button
        className="flex flex-row justify-between items-center p-3
     bg-neutral-950 text-white rounded-sm gap-3 cursor-pointer"
      >
        <img src="./plus_vector.svg" />
        <p>Add new user</p>
      </button>
    </div>
  );
}

export default TableHeader;
