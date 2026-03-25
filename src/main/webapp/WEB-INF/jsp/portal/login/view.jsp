<%--
  Class Name : view.jsp
  Description : 포털 로그인 화면
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link href="<c:url value='/css/portal/login/view.css'/>" rel="stylesheet">
</head>
<body>

<div class="login-card">
    <h1>로그인</h1>
    <p class="subtitle">서비스를 이용하려면 로그인하세요.</p>

    <form:form id="loginForm" name="loginForm" method="post" action="#" data-context-path="${contextPath}">

        <div class="form-group">
            <label for="id">아이디</label>
            <input type="text" id="id" name="id" maxlength="10"
                   placeholder="아이디를 입력하세요" autocomplete="username" />
            <span id="idError" class="field-error">아이디를 입력하세요.</span>
        </div>

        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" maxlength="25"
                   placeholder="비밀번호를 입력하세요" autocomplete="current-password" />
            <span id="passwordError" class="field-error">비밀번호를 입력하세요.</span>
        </div>

        <label class="save-id">
            <input type="checkbox" id="checkId" name="checkId" />
            아이디 저장
        </label>

        <button type="button" id="btnLogin" class="btn-login">로그인</button>

        <span id="loginError" class="login-error"></span>

        <input type="hidden" name="message" value="${message}" />
        <input type="hidden" name="userSe"  value="USR" />
    </form:form>
</div>

<script type="module" src="<c:url value='/js/portal/login/view.js'/>"></script>
</body>
</html>
