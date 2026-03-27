# JWT Migration Plan

This document lists the practical migration steps to move this project from the current session-centric login model to a JWT-based authentication model.

## Goal

- Remove dependency on session `LoginVO`
- Make Spring Security the single source of truth for authentication
- Standardize password verification with `PasswordEncoder`
- Introduce JWT for API authentication
- Keep migration incremental to avoid breaking existing JSP flows all at once

## Current Problems

- Authentication responsibility is split across Security, provider, login service, and session state.
- `LoginVO` is used as both login/session data and security principal.
- Controllers and interceptors check session `LoginVO` directly or through `EgovUserDetailsHelper`.
- Password verification is hidden behind legacy login service flow instead of explicit `PasswordEncoder.matches(...)`.
- Current login success flow stores `LoginVO` in session, which conflicts with stateless JWT design.

## Recommended Order

### 1. Define the target authentication model

Decide the following before changing code:

- Use Spring Security `User` or a small custom `UserDetails` implementation as principal
- Use `username` as the security identity
- Load additional user data from DB only when needed
- Limit JWT to `/api/**` first, then decide whether JSP area should remain session-based temporarily

Target files to add or revise:

- `src/main/java/.../security/user/CustomUserDetails.java` or use Spring `User`
- `docs/jwt-migration-plan.md`

### 2. Replace legacy password verification path

Stop relying on `loginService.actionLogin(...)` as the hidden authentication checker.

Tasks:

- Identify actual password encoding/check logic inside login service and DAO flow
- Move password verification into Spring Security authentication flow
- Introduce `PasswordEncoder` bean
- Make provider explicitly call `passwordEncoder.matches(raw, encoded)`

Primary files:

- `src/main/java/egovframework/com/sec/auth/EgovAuthenticationProvider.java`
- `src/main/java/egovframework/let/uat/uia/service/impl/EgovLoginServiceImpl.java`
- `src/main/java/egovframework/let/uat/uia/service/impl/LoginDAO.java`
- `src/main/resources/egovframework/mapper/let/uat/uia/EgovLoginUsr_SQL_postgres.xml`
- `src/main/java/egovframework/com/sec/config/SecurityConfig.java`

Expected result:

- Authentication logic becomes visible and testable
- Security provider owns credential validation

### 3. Introduce a dedicated user lookup layer for Security

Separate user lookup from authentication result packaging.

Tasks:

- Create a service that loads a user by username
- Return a security principal object or Spring `User`
- Stop returning `LoginVO` as principal

Suggested files:

- `src/main/java/.../security/service/SecurityUserService.java`
- `src/main/java/.../security/service/SecurityUserDetailsService.java`
- `src/main/java/egovframework/com/sec/auth/EgovAuthenticationProvider.java`

Expected result:

- Security uses Security-native types
- Domain/session VO no longer drives authentication

### 4. Remove session-based authentication dependencies

This is the main cleanup step before JWT.

Tasks:

- Stop storing authenticated user in session as `LoginVO`
- Remove direct `request.getSession().getAttribute("LoginVO")` checks
- Replace `EgovUserDetailsHelper` calls with Security APIs
- Remove or retire legacy login/session helper code

Direct session users to revise first:

- `src/main/java/egovframework/let/uat/uia/web/EgovLoginController.java`
- `src/main/java/egovframework/com/sec/handler/EgovAuthenticationSuccessHandler.java`
- `src/main/java/egovframework/let/cop/com/web/EgovBBSUseInfoManageController.java`
- `src/main/java/egovframework/let/cop/smt/sim/web/EgovIndvdlSchdulManageController.java`

Helper/interceptor users to revise next:

- `src/main/java/egovframework/com/cmm/util/EgovUserDetailsHelper.java`
- `src/main/java/egovframework/com/cmm/interceptor/AuthenticInterceptor.java`
- `src/main/java/egovframework/com/cmm/web/EgovFileDownloadController.java`
- `src/main/java/egovframework/com/cmm/web/EgovFileMngController.java`
- `src/main/java/egovframework/let/cop/bbs/web/EgovBBSManageController.java`
- `src/main/java/egovframework/let/cop/bbs/web/EgovBBSAttributeManageController.java`
- `src/main/java/egovframework/let/cop/bbs/web/EgovBBSLoneMasterController.java`
- `src/main/java/egovframework/let/cop/com/web/EgovBBSUseInfoManageController.java`
- `src/main/java/egovframework/let/cop/com/web/EgovTemplateManageController.java`
- `src/main/java/egovframework/let/cop/smt/sim/web/EgovIndvdlSchdulManageController.java`

Expected result:

- Authentication state is read only from `SecurityContext`
- Session `LoginVO` is no longer required

### 5. Replace manual auth checks with method security

Once session checks are removed, simplify controller authorization.

Tasks:

- Enable method security
- Replace `checkAuthority()` and `isAuthenticated()` checks with annotations
- Use `Principal`, `Authentication`, or `@AuthenticationPrincipal`

Primary files:

- `src/main/java/egovframework/com/sec/config/SecurityConfig.java`
- Controller classes that currently call `EgovUserDetailsHelper`

Common conversions:

- `if (!EgovUserDetailsHelper.isAuthenticated())` -> `@PreAuthorize("isAuthenticated()")`
- `LoginVO user = ...` -> `Authentication authentication` or `Principal principal`

Expected result:

- Authorization rules become declarative
- Controller code becomes smaller and easier to audit

### 6. Decide how to handle legacy JSP login

Do not mix old form login assumptions with JWT login on the same endpoint.

Tasks:

- Keep `/portal/login/view.do` only as login page view if JSP login remains temporarily
- Decide whether `/uat/uia/actionLogin.do` will stay form-login only, or be replaced
- Avoid having the same login URL handled by both Security filter and controller

Primary files:

- `src/main/java/egovframework/com/sec/config/SecurityConfig.java`
- `src/main/java/egovframework/let/uat/uia/web/EgovLoginController.java`
- `src/main/java/egovframework/portal/login/web/LoginController.java`

Recommended migration strategy:

- Keep JSP login temporarily for web pages
- Add separate JWT login endpoint for APIs

### 7. Add JWT infrastructure

Only after authentication model is cleaned up.

Tasks:

- Add JWT utility/service for token generation and validation
- Add authentication endpoint for token issuance
- Add JWT authentication filter before `UsernamePasswordAuthenticationFilter`
- Parse token and restore authenticated principal into `SecurityContextHolder`

Suggested new files:

- `src/main/java/.../security/jwt/JwtService.java`
- `src/main/java/.../security/jwt/JwtAuthenticationFilter.java`
- `src/main/java/.../security/jwt/JwtAuthenticationEntryPoint.java`
- `src/main/java/.../api/auth/AuthController.java`
- `src/main/java/.../api/auth/dto/LoginRequest.java`
- `src/main/java/.../api/auth/dto/LoginResponse.java`

Files to revise:

- `src/main/java/egovframework/com/sec/config/SecurityConfig.java`

Expected result:

- `/api/auth/login` issues JWT
- `/api/**` requests authenticate through token instead of session

### 8. Separate web and API security behavior

The project has JSP pages and likely future APIs. Their behavior should differ.

Tasks:

- Keep browser page access redirect behavior for JSP paths if needed
- Return `401/403` JSON responses for API paths
- Scope JWT filter to API routes

Primary files:

- `src/main/java/egovframework/com/sec/config/SecurityConfig.java`
- API exception handling classes

Expected result:

- Web pages behave like web pages
- APIs behave like APIs

### 9. Remove obsolete legacy pieces

After JWT works and controllers no longer depend on session `LoginVO`:

- Remove `AuthenticInterceptor`
- Remove `EgovUserDetailsHelper` if no longer used
- Remove session login storage logic
- Remove any duplicate login path that is no longer the single source of truth

Primary files:

- `src/main/java/egovframework/com/cmm/interceptor/AuthenticInterceptor.java`
- `src/main/java/egovframework/com/cmm/util/EgovUserDetailsHelper.java`
- related MVC config where interceptor is registered

### 10. Verify and harden

Tasks:

- Verify login success/failure behavior
- Verify authenticated and anonymous access rules
- Verify token expiration and invalid token behavior
- Verify file download, board, template, and schedule flows after principal conversion
- Add tests for provider, JWT utility, and protected endpoints

Important verification areas:

- board controllers
- file download/upload flows
- schedule management flows
- login/logout behavior
- API auth responses

## Migration Batches

### Batch A: Authentication cleanup

- `SecurityConfig`
- `EgovAuthenticationProvider`
- login service and DAO

### Batch B: Session dependency removal

- `EgovAuthenticationSuccessHandler`
- `EgovLoginController`
- `EgovUserDetailsHelper`
- `AuthenticInterceptor`
- controllers using session `LoginVO`

### Batch C: Method security conversion

- controllers currently using `checkAuthority()` or helper checks

### Batch D: JWT API introduction

- JWT service
- JWT filter
- auth API controller
- API exception handling

## Practical First Implementation Slice

If the goal is to reduce risk, start with this exact slice:

1. Refactor provider to explicit user lookup plus `PasswordEncoder`
2. Stop using `LoginVO` as principal
3. Replace direct session `LoginVO` access in the few direct-session methods
4. Add method security for controller auth checks
5. Add `/api/auth/login` and JWT filter for `/api/**`
6. Leave JSP login flow untouched until API JWT is stable

This is the lowest-risk route to JWT adoption in the current codebase.
