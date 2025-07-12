import constantValue from "@/lib/const/constant-value";

export async function getAllStudents() {
  const res = await fetch(`${constantValue.BASE_URL}/students`, {
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

export async function updateStudent(studentId:number, data:any) {
  const res = await fetch(`${constantValue.BASE_URL}/students/${studentId}`, {
    method: "PUT",
    headers: constantValue.getAuthHeader(),
    body: JSON.stringify(data)
  });

  if (!res.ok) {
    constantValue.handleAuthError(res.status);
    throw new Error(`Failed to update student ${studentId}: ${res.status}`);
  }

  return res.json();
}

