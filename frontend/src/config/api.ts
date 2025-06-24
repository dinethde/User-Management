export const API_CONFIG = {
  BASE_URL: "http://localhost:9090",
  ENDPOINTS: {
    ALL_USERS: "/users",
    USER: "/user",
    USER_BY_ID: (id: string) => `/users/${id}`,
  },
};
