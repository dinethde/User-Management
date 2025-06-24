import axios from "axios";
import { API_CONFIG } from "../config/api";
import type { User } from "../types/user-type";

export async function getAllUsers(): Promise<User[]> {
  const result = await axios.get(
    `${API_CONFIG.BASE_URL}${API_CONFIG.ENDPOINTS.ALL_USERS}`
  );

  const data = await result.data;

  return data;
}
