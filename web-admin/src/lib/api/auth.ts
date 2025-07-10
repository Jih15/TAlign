import constantValue from "../const/constant-value";

export async function loginUser({
    username,
    password
} : {
    username: string,
    password: string
}){
    const res = await fetch(`${constantValue.BASE_URL}/auth/login`, {
        method: "POST",
        headers: { "Content-Type" : "application/json" },
        body: JSON.stringify({username, password})
    });

    if (!res.ok){
        const error = await res.json();
        throw new Error(error.detail || "Login Failed!");
    }

    return res.json();
}