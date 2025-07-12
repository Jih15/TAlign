import constantValue from "@/lib/const/constant-value";

export async function getAllLecturer() {
  const res = await fetch(`${constantValue.BASE_URL}/lecturers`, {
    method: "GET", 
    headers: constantValue.getAuthHeader(),
    cache: "no-store"
  });

  if (!res.ok){
    constantValue.handleAuthError(res.status);
    throw new Error(`Error fetch students: ${res.status}`);
  }

  return res.json();
}

export async function updateLecturer(lectureId:number, data:any) {
  const res = await fetch(`${constantValue.BASE_URL}/lecturers/${lectureId}`, {
    method: "PUT",
    headers: constantValue.getAuthHeader(),
    body: JSON.stringify(data)
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Failed to update lecturer ${lectureId}: ${res.status}`);
  }

  return res.json();
}

