import axios from "axios";
import { API_CONFIG } from "../config/api";
import type { PostUser, User } from "../types/user-type";
import { use } from "react";

export async function getAllUsers(): Promise<User[]> {
  const result = await axios.get(
    `${API_CONFIG.BASE_URL}${API_CONFIG.ENDPOINTS.ALL_USERS}`
  );

  const data = await result.data;

  return data;
}

export async function addUser(data: PostUser): Promise<User> {
  const result = await axios.post(
    `${API_CONFIG.BASE_URL}${API_CONFIG.ENDPOINTS.USER}`,
    data
  );

  return result.data;
}

export async function deleteUser(id: string) {
  const result = await axios.delete(
    `${API_CONFIG.BASE_URL}${API_CONFIG.ENDPOINTS.USER}/${id}`
  );

  return result.data;
}

export async function updateUser(user: User) {
  const updateUser = await axios.put(
    `${API_CONFIG.BASE_URL}${API_CONFIG.ENDPOINTS.USER}`,
    user
  );

  return updateUser;
}
