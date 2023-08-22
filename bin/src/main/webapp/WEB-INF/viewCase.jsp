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
	<title>OceanDrill DMR: View Case</title>
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
		<h2 class="mb-5 text-center fw-bold">VIEW CASE DETAILS</h2>
		<div class="mb-4 d-flex justify-content-center">
			<table id="viewPatient" class="table table-striped table-hover shadow border-success fs-5">
				<tbody>
					<tr class="doctorInfo">
						<th scope="row">Date of Entry:</th>
						<td><fmt:formatDate value="${thisCase.createdAt}" pattern="MMMM dd, yyyy"/></td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Time of Entry:</th>
						<td><fmt:formatDate value="${thisCase.createdAt}" pattern="hh:mm a"/></td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Case Status:</th>
						<c:choose>
							<c:when test="${thisCase.status eq 'NEW'}">
								<td>${thisCase.status}</td>
							</c:when>
							<c:otherwise>
								<td>FOLLOW-UP</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Patient Name:</th>
						<td>${thisCase.patient.firstName} ${thisCase.patient.middleName.substring(0,1)}. ${thisCase.patient.lastName}</td>
					</tr>
					<tr class="doctorInfo">
						<fmt:parseDate pattern="yyyy-MM-dd" value="${thisCase.patient.birthday}" var="parsedBirthday"/>
						<th scope="row">Date of Birth:</th>
						<td><fmt:formatDate value="${parsedBirthday}" pattern="MMMM dd, yyyy"/></td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Age:</th>
						<td>${currentAge}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Gender:</th>
						<td>${thisCase.patient.gender}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Nationality:</th>
						<td>${thisCase.patient.nationality}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Company:</th>
						<td>${thisCase.patient.company}</td>
					</tr>
					<tr class="doctorInfo">
						<th scope="row">Position:</th>
						<td>${thisCase.patient.position}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<h3 class="fw-bold">S.O.A.P. MEDICAL HISTORY</h3>
		<hr>
		<h4 class="mt-5 fw-bold">Subjective</h4>
		<div class="row p-3 card bg-secondary-subtle bg-gradient shadow fs-4 fst-italic">
			<div class="card-body">
				<p>${thisCase.subjective}</p>
				<p class="mb-1">
					<span class="fw-semibold">Medical Comorbid(s): </span>
					<c:choose>
						<c:when test="${thisCase.patient.comorbids ne ''}">
							${thisCase.patient.comorbids}
						</c:when>
						<c:otherwise>
							No known medical co-morbidities.
						</c:otherwise>
					</c:choose>
				</p>
				<p>
					<span class="fw-semibold">Allergies: </span>
					<c:choose>
						<c:when test="${thisCase.patient.allergies ne ''}">
							${thisCase.patient.allergies}
						</c:when>
						<c:otherwise>
							Nil allergies.
						</c:otherwise>
					</c:choose>
				</p>
			</div>
		</div>
		<h4 class="mt-5 fw-bold">Objective:</h4>
		<div class="row p-3 card bg-secondary-subtle bg-gradient shadow fs-4 fst-italic">
			<div class="card-body">
				<p>${thisCase.objective}</p>
			</div>
		</div>
		<h4 class="mt-5 fw-bold">Assessment:</h4>
		<div class="row p-3 card bg-secondary-subtle bg-gradient shadow fs-4 fst-italic">
			<div class="card-body">
				<p>${thisCase.assessment}</p>
			</div>
		</div>
		<h4 class="mt-5 fw-bold">Plan:</h4>
		<div class="mb-4 row p-3 card bg-secondary-subtle bg-gradient shadow fs-4 fst-italic">
			<div class="card-body">
				<p>${thisCase.plan}</p>
			</div>
		</div>
		<div class="d-flex align-items-center justify-content-between">
			<c:choose>
				<c:when test="${thisCase.user.id ne null}">
					<p class="fs-4 fw-bold">Physician: Dr. ${thisCase.user.firstName} ${thisCase.user.lastName}</p>
				</c:when>
				<c:otherwise>
					<p class="fs-4 fw-semibold fst-italic">[Previous physician not in system anymore]</p>
				</c:otherwise>
			</c:choose>
			<a href="/patients/${thisCase.patient.id}" class="btn btn-primary bg-gradient shadow fs-5 fw-semibold">Back to Patient Details</a>
		</div>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>