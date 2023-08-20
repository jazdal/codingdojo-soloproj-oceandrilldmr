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
	<title>OceanDrill DMR: Admin</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/css/style.css" />
</head>
<body>
	<nav class="p-3 d-flex align-items-center justify-content-between navbar navbar-expand-lg bg-success-subtle bg-gradient">
		<p class="text-success fs-4 fw-semibold">[<span id="clock"></span>]</p>
		<div class="d-flex align-items-center justify-content-between">
			<a href="/dashboard" class="me-5 btn btn-success bg-gradient shadow fs-5 fw-semibold">Case Dashboard</a>
			<form action="/logout" method="POST">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="submit" class="btn btn-primary bg-gradient shadow fs-5 fw-semibold" value="Logout">
			</form>
		</div>
	</nav>
	<div id="regForm" class="p-3 container">
		<div class="d-flex justify-content-center">
			<img class="mb-4" src="/img/OceanDrill_Logo.jpg" alt="oceandrill_logo" width="50%">
		</div>
		<div class="mb-3 d-flex align-items-center justify-content-center form-check form-switch">
			<img class="me-5" src="/img/light-mode.webp" alt="lightModeIcon" width="5%">
			<input class="form-check-input" type="checkbox" role="switch" id="switch" onClick="toggleTheme()">
			<img class="ms-2" src="/img/night-mode.png" alt="darkModeIcon" width="4%">
		</div>
		<h2 class="mb-5 text-center fw-bold">WELCOME, DR. ${adminUser.firstName.toUpperCase()} ${adminUser.lastName.toUpperCase()}</h2>
		<h3>Current Doctors:</h3>
		<table class="table table-striped table-hover shadow">
			<thead>
				<tr class="table-active text-center fs-5">
					<th scope="col">Name</th>
					<th scope="col">Email</th>
					<th scope="col">PRC ID</th>
					<th scope="col">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="user" items="${allUsers}">
					<tr class="text-center fs-5">
						<td><a href="/admin/view/${user.id}">Dr. ${user.firstName} ${user.lastName}</a></td>
						<td>${user.email}</td>
						<td>${user.prcId}</td>
						<c:choose>
							<c:when test="${user.role.name eq adminUser.role.name}">
								<td>Admin</td>
							</c:when>
							<c:otherwise>
								<td><a href="/admin/delete/${user.id}" class="btn btn-danger bg-gradient shadow fs-6 fw-semibold" onclick="return confirm('Are you sure you want to delete this doctor?')">Delete</a></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>