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
	<title>OceanDrill DMR: Patient Info</title>
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
		<h2 class="mb-5 text-center fw-bold">PATIENT INFORMATION AND CASES</h2>
		<div class="mb-4 d-flex justify-content-center">
			<table id="viewPatient" class="table table-striped table-hover shadow border-success fs-5">
				<tbody>
					<tr class="doctorInfo">
						<th scope="row">First Name:</th>
						<td>${patient.firstName}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Middle Name:</th>
						<td>${patient.middleName}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Last Name:</th>
						<td>${patient.lastName}</td>
					</tr>
					<tr class="doctorInfo">
						<fmt:parseDate pattern="yyyy-MM-dd" value="${patient.birthday}" var="parsedBirthday"/>
						<th scope="row">Date of Birth:</th>
						<td><fmt:formatDate value="${parsedBirthday}" pattern="MMMM dd, yyyy"/></td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Current Age:</th>
						<td>${currentAge}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Gender:</th>
						<td>${patient.gender}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Nationality:</th>
						<td>${patient.nationality}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Company:</th>
						<td>${patient.company}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Position:</th>
						<td>${patient.position}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Medical Condition(s):</th>
						<td>${patient.comorbids}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Allergies:</th>
						<td>${patient.allergies}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="mb-5 d-flex justify-content-center">
			<div class="btn-group" role="group">
				<a href="/patients/edit/${patient.id}" class="btn btn-success bg-gradient shadow fs-5 fw-semibold">Edit Patient</a>
				<c:choose>
					<c:when test="${currentUser.role.name eq 'ROLE_ADMIN'}">
						<a href="/patients/delete/${patient.id}" class="btn btn-danger bg-gradient shadow fs-5 fw-semibold" onclick="return confirm('Deleting patient will also delete ALL case files associated with this patient. Are you sure?')">Delete Patient</a>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-secondary bg-gradient fs-5 fw-semibold" disabled>Delete Patient</button>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<hr>
		<h3 class="fw-bold">Cases</h3>
		<table class="mb-4 table table-striped table-hover shadow fs-5 text-center">
			<thead>
				<tr class="table-active">
					<th scope="col">Date</th>
					<th scope="col">Diagnosis</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="patientCase" items="${patientCases}">
					<tr>
						<td><fmt:formatDate value="${patientCase.createdAt}" pattern="dd-MMM-yyyy"/></td>
						<td>${patientCase.assessment}</td>
						<c:choose>
							<c:when test="${currentUser.role.name eq 'ROLE_ADMIN'}">
								<td>
									<a href="/cases/${patientCase.id}" class="me-3 btn btn-primary bg-gradient shadow">View</a>
									<a href="/cases/edit/${patientCase.id}" class="me-3 btn btn-success bg-gradient shadow">Edit</a>
									<a href="/cases/delete/${patientCase.id}" class="btn btn-danger bg-gradient shadow" onclick="return confirm('Are you sure you want to delete this case?')">Delete</a>
								</td>
							</c:when>
							<c:when test="${currentUser.id eq patientCase.user.id}">
								<td>
									<a href="/cases/${patientCase.id}" class="me-3 btn btn-primary bg-gradient shadow">View</a>
									<a href="/cases/edit/${patientCase.id}" class="me-3 btn btn-success bg-gradient shadow">Edit</a>
								</td>
							</c:when>
							<c:otherwise>
								<td><a href="/cases/${patientCase.id}" class="me-3 btn btn-primary bg-gradient shadow">View</a></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<a href="/cases/new" class="btn btn-primary bg-gradient shadow fs-5 fw-semibold">Create New Case</a>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>