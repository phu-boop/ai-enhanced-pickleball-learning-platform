import apiUser from "./apiUser";

export const createUpdate = (data) => {
  const jsonData = JSON.stringify(data);
  return apiUser.post("/learners",jsonData);
}
export const updateavata = (data) => {
  const jsonData = JSON.stringify(data);
  return apiUser.post("/users/update-avata",jsonData);
}