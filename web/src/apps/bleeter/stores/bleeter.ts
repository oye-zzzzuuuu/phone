import { writable } from "svelte/store";

// UI State
export const ACTIVE_PAGE = writable<string>("home");
export const LOGGED_IN_AS = writable<string | null>(null);
export const SELECTED_USER = writable<string | null>(null);
export const SELECTED_BLEET = writable<string | null>(null);

// Auth & Profile
export const LOGGED_USER = writable<any>(null);
export const REGISTER_ERROR = writable<string | null>(null);
export const LOGIN_ERROR = writable<string | null>(null);

// Bleets
export const BLEETS = writable<any[]>([]);

// Handle NUI Messages
window.addEventListener("message", (event) => {
    const { action, data, success, message } = event.data;

    if (action === "loginResult") {
        if (success) {
            LOGGED_USER.set(data);
            LOGGED_IN_AS.set(data.username);
            LOGIN_ERROR.set(null);
            ACTIVE_PAGE.set("home");
        } else {
            LOGIN_ERROR.set(data);
        }
    }

    if (action === "registerResult") {
        if (success) {
            REGISTER_ERROR.set(null);
            ACTIVE_PAGE.set("login");
        } else {
            REGISTER_ERROR.set(message);
        }
    }

    if (action === "refresh") {
        getBleets();
    }
});

// Functions to call Lua backend
export function register(data: {
    username: string;
    password: string;
    avatar?: string;
    bio?: string;
}) {
    fetchNui("bleeter:Register", data);
}

export function login(data: {
    username: string;
    password: string;
}) {
    fetchNui("bleeter:Login", data);
}

export function postBleet(message: string) {
    fetchNui("bleeter:PostBleet", { message });
}

export async function getBleets() {
    const bleets = await fetchNui("bleeter:GetBleets");
    BLEETS.set(bleets);
}

// Helper for NUI interaction
function fetchNui<T = any>(event: string, data?: any): Promise<T> {
    return new Promise((resolve) => {
        window.postMessage({ type: "nui", event, data });
        window.addEventListener(
            "message",
            (e) => {
                if (e.data.event === event) resolve(e.data.data);
            },
            { once: true }
        );
    });
}
