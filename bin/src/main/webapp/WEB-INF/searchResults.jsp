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
	<title>OceanDrill DMR: Search Results</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/css/style.css" />
</head>
<body>
	<nav class="p-3 d-flex navbar navbar-expand-lg bg-success-subtle bg-gradient align-items-center justify-content-between">
		<div class="d-flex flex-column">
			<p class="mb-0 text-success fs-4 fw-semibold">[<span id="clock"></span>]</p>
			<p class="text-success fs-4 fw-bold">In-Session: Dr. ${currentUser.firstName} ${currentUser.lastName}</p>
		</div>
		<div class="d-flex align-items-center justify-content-between">
			<a href="/dashboard" class="me-5 btn btn-success bg-gradient shadow fs-5 fw-semibold">Dashboard</a>
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
		<h3 class="mb-5 text-center fw-bold">PATIENT SEARCH RESULT(S)</h3>
		<table class="mb-5 table table-striped table-hover shadow fs-5">
			<thead>
				<tr class="table-active text-center">
					<th scope="col">ID</th>
					<th scope="col">Patient Name</th>
					<th scope="col">Age</th>
					<th scope="col">Gender</th>
					<th scope="col">Nationality</th>
					<th scope="col">Company</th>
					<th scope="col">Position</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="patient" items="${searchResults}">
					<tr class="text-center">
						<fmt:parseDate value="${patient.birthday}" var="parsedDate" type="date" pattern="yyyy-MM-dd" />
						<jsp:useBean id="now" class="java.util.Date" />
						<td>${patient.id}</td>
						<td>${patient.lastName}, ${patient.firstName} ${patient.middleName.substring(0,1)}.</td>
						<td><fmt:parseNumber type="number" integerOnly = "true" value="${(now.time - parsedDate.time) / (1000 * 60 * 60 * 24 * 365)}" /></td>
						<td>${patient.gender}</td>
						<td>${patient.nationality}</td>
						<td>${patient.company}</td>
						<td>${patient.position}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>