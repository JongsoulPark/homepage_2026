const BASE_URL = 'http://localhost:8084';

const TOKEN_KEY = 'accessToken';

export const tokenStorage = {
    get: () => localStorage.getItem(TOKEN_KEY),
    set: (token) => localStorage.setItem(TOKEN_KEY, token),
    remove: () => localStorage.removeItem(TOKEN_KEY),
};

const request = async (endpoint, options = {}) => {
    const url = `${BASE_URL}${endpoint}`;
    const res = await fetch(url, {
        headers: {
            'Content-Type': 'application/json',
            ...options.headers
        },
        ...options
    });

    const data = await res.json().catch(() => {});

    if (!res.ok) {
        const message =
            data?.message || data?.resultCode || `서버 오류 (${res.status})`;
        throw new Error(message);
    }

    return data;
};

/**
 * 로그인
 * POST /api/v1/auth/authenticate
 * Body: { userId, password }
 * response: { token, ... }
 */
export const login = async (userId, password) => {
    const data = await request(`/api/v1/auth/authenticate`, {
        method: 'POST',
        body: JSON.stringify({userId, password}),
    });

    const token =  data.token ?? data.accessToken ?? data.jwt;
    if (!token) {
        throw new Error('서버에서 토큰을 받지 못했습니다');
    }

    tokenStorage.set(token);
    return data;
}

/**
 * 회원가입
 * POST /api/auth/register
 * Body: { username, password, name, email }
 * Response: { message, ... }
 */
export const register = async (payload) => {
    return request('/api/auth/register', {
        method: 'POST',
        body: JSON.stringify(payload),
    });
}

export function logout() {
    tokenStorage.remove();
}