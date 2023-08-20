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
	<title>OceanDrill DMR: Dashboard</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/css/style.css" />
</head>
<body>
	<nav class="p-3 d-flex align-items-center justify-content-between navbar navbar-expand-lg bg-success-subtle bg-gradient">
		<p class="text-success fs-4 fw-semibold">[<span id="clock"></span>]</p>
		<div class="d-flex align-items-center justify-content-between">
			<c:if test="${currentUser.role.name eq 'ROLE_ADMIN'}">
				<a href="/admin" class="me-5 btn btn-success bg-gradient shadow fs-5 fw-semibold">Admin Dashboard</a>
			</c:if>
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
		<h2 class="mb-5 text-center fw-bold">WELCOME, DR. ${currentUser.firstName.toUpperCase()} ${currentUser.lastName.toUpperCase()}</h2>
		<h3 class="fw-bold">Cases for <fmt:formatDate value="${currentMonth}" pattern="MMMM yyyy"/></h3>
		<table class="mb-5 table table-hover shadow">
			<thead>
				<tr class="table-active text-center fs-5">
					<th scope="col">Total No. of Cases</th>
					<th scope="col">New Cases</th>
					<th scope="col">Follow-Up Cases</th>
					<th scope="col">Breakdown by Category</th>
				</tr>
			</thead>
			<tbody>
				<tr class="text-center fs-5 fw-semibold">
					<td>${allCases.size()}</td>
					<td>${newCases.size()}</td>
					<td>${oldCases.size()}</td>
					<td><a href="/cases/breakdown">Click Here</a></td>
				</tr>
			</tbody>
		</table>
		<table class="mb-5 table table-striped table-hover border shadow fs-5">
			<thead>
				<tr class="table-active text-center">
					<th scope="col">Date</th>
					<th scope="col">New or Follow-Up Case</th>
					<th scope="col">Patient Name</th>
					<th scope="col">Company</th>
					<th scope="col">Diagnosis</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="eachCase" items="${allCases}">
					<fmt:formatDate value="${eachCase.createdAt}" pattern="M" var="createdAtMonth"/>
					<fmt:formatDate value="${now}" pattern="M" var="currentMonth"/>
					<c:if test="${createdAtMonth eq currentMonth}">
						<tr class="text-center">
							<td><fmt:formatDate value="${eachCase.createdAt}" pattern="dd-MMM-yy"/></td>
							<td>${eachCase.status}</td>
							<td><a href="/patients/${eachCase.patient.id}">${eachCase.patient.firstName} ${eachCase.patient.middleName.substring(0,1)}. ${eachCase.patient.lastName}</a></td>
							<td>${eachCase.patient.company}</td>
							<td>${eachCase.assessment}</td>
							<c:choose>
								<c:when test="${currentUser.role.name eq 'ROLE_ADMIN'}">
									<td>
										<a href="/cases/${eachCase.id}" class="me-3 btn btn-primary bg-gradient shadow">View</a>
										<a href="/cases/edit/${eachCase.id}" class="me-3 btn btn-success bg-gradient shadow">Edit</a>
										<a href="/cases/delete/${eachCase.id}" class="btn btn-danger bg-gradient shadow" onclick="return confirm('Are you sure you want to delete this case?')">Delete</a>
									</td>
								</c:when>
								<c:when test="${currentUser.id eq eachCase.user.id}">
									<td>
										<a href="/cases/${eachCase.id}" class="me-3 btn btn-primary bg-gradient shadow">View</a>
										<a href="/cases/edit/${eachCase.id}" class="me-3 btn btn-success bg-gradient shadow">Edit</a>
									</td>
								</c:when>
								<c:otherwise>
									<td><a href="/cases/${eachCase.id}" class="me-3 btn btn-primary bg-gradient shadow">View</a></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<div class="btn-group" role="group">
			<button type="button" class="btn btn-primary bg-gradient shadow fs-5 fw-semibold" onclick="location.href='/patients'">View All Patients</button>
			<button type="button" class="btn btn-success bg-gradient shadow fs-5 fw-semibold" onclick="location.href='/patients/new'">Add New Patient</button>
			<button type="button" class="btn btn-warning bg-gradient shadow fs-5 fw-semibold" onclick="location.href='/cases/new'">Create New Case</button>
		</div>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>