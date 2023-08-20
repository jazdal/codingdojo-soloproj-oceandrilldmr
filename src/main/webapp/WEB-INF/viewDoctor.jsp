<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>OceanDrill DMR: Doctor Info</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/css/style.css" />
</head>
<body>
	<nav class="p-3 d-flex align-items-center justify-content-between navbar navbar-expand-lg bg-success-subtle bg-gradient">
		<p class="text-success fs-4 fw-semibold">[<span id="clock"></span>]</p>
		<div class="d-flex align-items-center justify-content-between">
			<a href="/admin" class="me-5 btn btn-success bg-gradient shadow fs-5 fw-semibold">Admin Dashboard</a>
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
		<h2 class="mb-4 text-center fw-bold">${doctor.firstName.toUpperCase()} ${doctor.lastName.toUpperCase()}, MD</h2>
		<table class="table table-striped table-hover shadow border-success fs-5">
			<tbody>
				<tr class="doctorInfo">
					<th scope="row">Email Address:</th>
					<td>${doctor.email}</td>
				</tr>
				<tr class="doctorInfo">
					<th scope="row">PRC ID Number:</th>
					<td>${doctor.prcId}</td>
				</tr>
				<tr class="doctorInfo">
					<th scope="row">PRC ID Validity:</th>
					<fmt:parseDate pattern="yyyy-MM-dd" value="${doctor.prcExp}" var="parsedDate"/>
					<c:choose>
						<c:when test="${doctor.prcExp.isBefore(oneMonthLater)}">
							<td class="text-danger fw-bold"><fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy"/></td>
						</c:when>
						<c:otherwise>
							<td class="text-success"><fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy"/></td>
						</c:otherwise>
					</c:choose>
				</tr>
				<tr class="doctorInfo">
					<th scope="row">Date Joined:</th>
					<td>
						<fmt:formatDate value="${doctor.createdAt}" type="date" pattern="MMMM dd, yyyy"/>
					</td>
				</tr>
				<tr class="doctorInfo">
					<th scope="row">Last Login:</th>
					<td>
						<fmt:formatDate value="${doctor.lastLogin}" type="date" pattern="MMMM dd, yyyy | hh:mm a"/>
					</td>
				</tr>
			</tbody>
		</table>
		<c:choose>
			<c:when test="${doctor.id eq adminUser.id}">
				<button class="btn btn-secondary bg-gradient fs-5 fw-semibold" disabled>Delete</button>
			</c:when>
			<c:otherwise>
				<a href="/admin/delete/${doctor.id}" class="btn btn-danger bg-gradient shadow fs-5 fw-semibold" onclick="return confirm('Are you sure you want to delete this doctor?')">Delete</a>
			</c:otherwise>
		</c:choose>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>