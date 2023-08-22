<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>OceanDrill DMR: Registration and Login</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/css/style.css" />
</head>
<body>
	<div id="regForm" class="p-3 container">
		<c:if test="${logoutMessage != null}">
			<h2 class="mb-3 text-center text-success fw-bold"><c:out value="${logoutMessage}"/></h2>
		</c:if>
		<div class="d-flex justify-content-center">
			<img class="mb-3" src="/img/OceanDrill_Logo.jpg" alt="oceandrill_logo" width="60%">
		</div>
		<div class="mb-4 d-flex align-items-center justify-content-center form-check form-switch">
			<img class="me-5" src="/img/light-mode.webp" alt="lightModeIcon" width="5%">
			<input class="form-check-input" type="checkbox" role="switch" id="switch" onClick="toggleTheme()">
			<img class="ms-2" src="/img/night-mode.png" alt="darkModeIcon" width="4%">
		</div>
		<div class="row justify-content-between">
			<form:form class="p-2 col-sm-5 card bg-primary-subtle bg-gradient shadow" action="/register" method="POST" modelAttribute="user">
				<div class="card-body">
					<h3 class="mb-4 card-title fw-bold">REGISTER</h3>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="firstName" class="col-form-label fs-5 fw-semibold">First Name:</form:label>
						</div>
						<div class="col-sm-8">
							<form:input type="text" class="form-control fs-5" path="firstName" placeholder="Enter first name"/>
							<form:errors path="firstName" class="text-danger"/>
						</div>
					</div>
                    <div class="row mb-4 align-items-center justify-content-between">
                        <div class="col-auto">
                            <form:label path="lastName" class="col-form-label fs-5 fw-semibold">Last Name:</form:label>
                        </div>
                        <div class="col-sm-8">
                            <form:input type="text" class="form-control fs-5" path="lastName" placeholder="Enter last name"/>
                            <form:errors path="lastName" class="text-danger"/>
                        </div>
                    </div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="email" class="col-form-label fs-5 fw-semibold">Email:</form:label>
						</div>
						<div class="col-sm-8">
							<form:input type="email" class="form-control fs-5" path="email" placeholder="Enter email"/>
							<form:errors path="email" class="text-danger"/>
						</div>
					</div>
                    <div class="row mb-4 align-items-center justify-content-between">
                        <div class="col-auto">
                            <form:label path="prcId" class="col-form-label fs-5 fw-semibold">PRC ID:</form:label>
                        </div>
                        <div class="col-sm-8">
                            <form:input type="text" class="form-control fs-5" path="prcId" placeholder="Enter PRC ID number"/>
                            <form:errors path="prcId" class="text-danger"/>
                        </div>
                    </div>
                    <div class="row mb-4 align-items-center justify-content-between">
                        <div class="col-auto">
                            <form:label path="prcExp" class="col-form-label fs-5 fw-semibold">PRC Exp:</form:label>
                        </div>
                        <div class="col-sm-8">
                            <form:input type="date" class="form-control fs-5" path="prcExp" placeholder="Enter PRC Expiry Date"/>
                            <form:errors path="prcExp" class="text-danger"/>
                        </div>
                    </div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="password" class="col-form-label fs-5 fw-semibold">Password:</form:label>
						</div>
						<div class="col-sm-8">
							<form:password class="form-control fs-5" path="password" placeholder="Enter password"/>
							<form:errors path="password" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-5 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="confirmPassword" class="col-form-label fs-5 fw-semibold">Confirm PW:</form:label>
						</div>
						<div class="col-sm-8">
							<form:password class="form-control fs-5" path="confirmPassword" placeholder="Confirm password"/>
							<form:errors path="confirmPassword" class="text-danger"/>
						</div>
					</div>
					<div class="row g-2 align-items-center">
						<input type="submit" class="btn btn-primary bg-gradient shadow fs-5 fw-semibold" value="Submit">
					</div>
				</div>
			</form:form>
			<form:form class="p-2 col-sm-5 card bg-warning-subtle bg-gradient shadow" action="/login" method="POST" modelAttribute="user">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="card-body">
					<h3 class="mb-4 card-title fw-bold">LOGIN</h3>
					<div class="mb-4 row align-items-center justify-content-between">
						<div class="col-auto">
							<form:label class="col-form-label fs-5 fw-semibold" path="prcId">PRC ID:</form:label>
						</div>
						<div class="col-sm-8">
							<form:input type="text" class="form-control fs-5" path="prcId" placeholder="Enter your PRC ID"/>
						</div>
					</div>
					<div class="mb-5 row align-items-center justify-content-between">
						<div class="col-auto">
							<form:label class="col-form-label fs-5 fw-semibold" path="password">Password:</form:label>
						</div>
						<div class="col-sm-8">
							<form:password class="form-control fs-5" path="password" placeholder="Enter password"/>
						</div>
					</div>
					<c:if test="${errorMessage != null}">
						<p class="text-danger text-center fs-5 fw-semibold">
							<c:out value="${errorMessage}"/>
						</p>
					</c:if>
					<div class="row g-2 align-items-center">
						<input type="submit" class="btn btn-warning bg-gradient shadow fs-5 fw-semibold" value="Login">
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>