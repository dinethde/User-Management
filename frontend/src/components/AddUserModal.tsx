import { useState } from "react";

function AddUserModal() {
  const [formData, setFormData] = useState({
    name: "",
    age: "",
    emial: "",
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Form data:", formData);
    // Add your submit logic here
  };
  return (
    <div className="w-5/12 border border-[#CCCCCC] rounded-lg shadow-md p-4">
      <form action="">
        {/* Header */}
        <div className="flex flex-row justify-between items-center">
          <h3 className="text-3xl">Add n new user</h3>
          <button>
            <img src="/x_vector.svg" className="w-4 h-4" />
          </button>
        </div>

        {/* Form inputs*/}
        <div>
          <p>Label</p>
        </div>
      </form>
    </div>
  );
}

export default AddUserModal;
