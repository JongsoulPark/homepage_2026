# 포털 로그인 화면 개발 문서

## 개요

eGovFrame 4.2.0 기반 프로젝트의 포털 로그인 화면을 신규 구현한 작업 기록입니다.
기존 `EgovLoginUsr.jsp`(레거시 스타일)와 별개로, `/portal/login/view.do` 경로에 독립적인 로그인 화면을 구성했습니다.

---

## 파일 구성

```
src/main/webapp/
├── WEB-INF/jsp/portal/login/
│   └── view.jsp                  ← 로그인 뷰 (JSP)
├── css/portal/login/
│   └── view.css                  ← 로그인 전용 스타일시트
└── js/portal/login/
    └── view.js                   ← 로그인 전용 스크립트 (ES Module)

src/main/java/egovframework/portal/login/
└── web/
    └── LoginController.java      ← GET /portal/login/view.do
```

---

## URL 흐름

```
GET  /portal/login/view.do
  → LoginController.loginView()
  → WEB-INF/jsp/portal/login/view.jsp

POST /uat/uia/actionLogin.do      ← 폼 submit 목적지 (기존 인증 처리)
```

---

## view.jsp

### 주요 결정 사항

| 항목 | 결정 | 이유 |
|------|------|------|
| DOCTYPE | `<!DOCTYPE html>` | HTML 4.01 Transitional은 불필요한 레거시 선언 |
| eGovFrame 레이아웃 | 미사용 | 로그인 페이지는 헤더/좌측메뉴/푸터 불필요 |
| 인라인 이벤트 | 미사용 | XSS 취약점 벡터, CSP 위반 |
| `<style>` 블록 | 미사용 | 외부 CSS 파일로 분리 (`css/portal/login/view.css`) |
| script 위치 | `</body>` 직전 | DOM 파싱 완료 후 로드 보장 |
| script 방식 | `type="module"` | 스코프 격리, strict mode 자동 적용, defer 기본 동작 |
| contextPath 전달 | `data-context-path` 속성 | 전역 JS 변수 없이 DOM을 통해 서버 데이터 전달 |

### contextPath 전달 방식

```jsp
<%-- JSP에서 JSTL로 contextPath 설정 --%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%-- form의 data 속성으로 전달 --%>
<form:form id="loginForm" data-context-path="${contextPath}" ...>
```

```js
// JS에서 DOM을 통해 읽기
const contextPath = form.dataset.contextPath ?? "";
```

### 서버 메시지 처리

로그인 실패 등 서버에서 내려오는 `message` 값을 `alert()` 없이 화면 내 인라인 박스로 표시합니다.

```jsp
<input type="hidden" name="message" value="${message}" />
```

```js
// hidden input에서 읽어서 DOM에 렌더링
const message = document.querySelector("input[name='message']")?.value ?? "";
```

---

## view.css

### 설계 원칙

- **CSS Variables (`:root`)** 로 컬러/수치 중앙 관리 → 향후 공통 CSS로 분리 용이
- Flexbox 기반 중앙 정렬 카드 레이아웃
- 이미지 의존 없는 순수 CSS 스타일

### CSS Variables

```css
:root {
    --primary:    #4f46e5;   /* 주요 색상 (버튼, 포커스 링) */
    --primary-hv: #4338ca;   /* hover 상태 */
    --danger:     #ef4444;   /* 에러 상태 */
    --text:       #111827;
    --muted:      #6b7280;
    --border:     #d1d5db;
    --bg:         #f3f4f6;   /* 페이지 배경 */
    --card:       #ffffff;   /* 카드 배경 */
    --radius:     12px;
}
```

### 에러 상태 클래스

| 클래스 | 적용 대상 | 역할 |
|--------|-----------|------|
| `.is-invalid` | `<input>` | 빨간 테두리 + 포커스 링 |
| `.field-error.visible` | `<span>` | 필드 하단 에러 메시지 노출 |
| `.server-message.visible` | `<div>` | 폼 상단 서버 에러 박스 노출 |

---

## view.js

### ES Module 채택 이유

| 항목 | IIFE | ES Module |
|------|------|-----------|
| 스코프 격리 | 수동으로 감쌈 | 자동 |
| strict mode | 직접 선언 필요 | 자동 적용 |
| defer (DOM 보장) | 별도 처리 필요 | 기본 동작 |
| DOMContentLoaded | 필요 | 불필요 |
| import/export | 불가 | 가능 |
| 콘솔 직접 호출 차단 | 됨 | 됨 |

`type="module"` 스크립트는 파싱이 완료된 후 실행되므로 `DOMContentLoaded` 래핑 없이 최상위에서 바로 DOM 접근이 가능합니다.

### 입력값 검증

`alert()` 대신 필드별 인라인 에러 메시지로 처리합니다.

```js
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
```

- 아이디/비밀번호 각각 독립적으로 에러 표시
- 입력 시작(`input` 이벤트) 즉시 에러 해제
- 첫 번째 빈 필드로 자동 포커스 이동

### 아이디 저장 (쿠키)

```js
const COOKIE_KEY  = "savedLoginId";
const COOKIE_DAYS = 30;
```

- 체크 시: 30일 유지 쿠키 저장
- 체크 해제 시: 즉시 삭제
- `encodeURIComponent` / `decodeURIComponent` 로 값 인코딩
- `SameSite=Lax` 속성으로 CSRF 방어 보완

```js
function setCookie(name, value, expires) {
    document.cookie = `${name}=${encodeURIComponent(value)}; path=/; expires=${expires.toUTCString()}; SameSite=Lax`;
}
```

---

## 향후 고려사항

- `:root` CSS Variables → `css/portal/common.css` 또는 전역 `common.css`로 분리 예정
- 쿠키 유틸(`setCookie`, `getCookie`, `deleteCookie`) → 공통 유틸 모듈로 분리 후 `import` 사용 가능
