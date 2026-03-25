/**
 * portal/login/view.jsp 로그인 화면 스크립트
 */

// ── 상수 ──────────────────────────────────────────────────────────────────────

const COOKIE_KEY  = "savedLoginId";
const COOKIE_DAYS = 30;

// ── 초기화 (type="module" → defer 동작, DOM 파싱 완료 후 실행 보장) ───────────

loadSavedId();
showServerMessage();

document.getElementById("btnLogin").addEventListener("click", handleLogin);

document.getElementById("password").addEventListener("keydown", (e) => {
    if (e.key === "Enter") handleLogin();
});

document.getElementById("id").addEventListener("input", () => clearError("id"));
document.getElementById("password").addEventListener("input", () => clearError("password"));

// ── 서버 메시지 ───────────────────────────────────────────────────────────────

function showServerMessage() {
    const message = document.querySelector("input[name='message']")?.value ?? "";
    if (!message) return;

    const el = document.getElementById("loginError");
    el.textContent = message;
    el.classList.add("visible");
}

// ── 로그인 ────────────────────────────────────────────────────────────────────

function handleLogin() {
    if (!validate()) return;

    const form        = document.getElementById("loginForm");
    const contextPath = form.dataset.contextPath ?? "";

    saveId();
    form.action = `${contextPath}/uat/uia/actionLogin.do`;
    form.submit();
}

function validate() {
    const idVal = document.getElementById("id").value.trim();
    const pwVal = document.getElementById("password").value;
    let valid   = true;

    if (!idVal) {
        showError("id", "아이디를 입력하세요.");
        valid = false;
    }
    if (!pwVal) {
        showError("password", "비밀번호를 입력하세요.");
        valid = false;
    }

    if (!valid) {
        document.getElementById(!idVal ? "id" : "password").focus();
    }

    return valid;
}

function showError(fieldId, message) {
    document.getElementById(fieldId).classList.add("is-invalid");
    const err = document.getElementById(`${fieldId}Error`);
    err.textContent = message;
    err.classList.add("visible");
}

function clearError(fieldId) {
    document.getElementById(fieldId).classList.remove("is-invalid");
    document.getElementById(`${fieldId}Error`).classList.remove("visible");
}

// ── 아이디 저장 (쿠키) ────────────────────────────────────────────────────────

function saveId() {
    const checked = document.getElementById("checkId").checked;
    const value   = document.getElementById("id").value.trim();
    const expires = new Date();

    if (checked) {
        expires.setTime(expires.getTime() + 1000 * 60 * 60 * 24 * COOKIE_DAYS);
        setCookie(COOKIE_KEY, value, expires);
    } else {
        deleteCookie(COOKIE_KEY);
    }
}

function loadSavedId() {
    const savedId = getCookie(COOKIE_KEY);
    if (!savedId) return;

    document.getElementById("id").value = savedId;
    document.getElementById("checkId").checked = true;
}

function setCookie(name, value, expires) {
    document.cookie = `${name}=${encodeURIComponent(value)}; path=/; expires=${expires.toUTCString()}; SameSite=Lax`;
}

function getCookie(name) {
    const entry = document.cookie
        .split("; ")
        .find((row) => row.startsWith(`${name}=`));
    return entry ? decodeURIComponent(entry.split("=")[1]) : "";
}

function deleteCookie(name) {
    document.cookie = `${name}=; path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC; SameSite=Lax`;
}
