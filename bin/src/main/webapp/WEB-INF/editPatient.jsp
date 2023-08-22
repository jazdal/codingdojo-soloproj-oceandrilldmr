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
	<title>OceanDrill DMR: Edit Patient</title>
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
		<h3 class="text-center fw-bold">EDIT PATIENT DETAILS</h3>
		<h3 class="text-center fw-bold">FOR ${patient.firstName.toUpperCase()} ${patient.middleName.substring(0,1)}. ${patient.lastName.toUpperCase()}</h3>
		<h4 class="mb-5 text-center fst-italic">Patient ID: [${patient.id}]</h4>
		<div class="row justify-content-center">
			<form:form class="p-2 col-md-10 card bg-primary-subtle bg-gradient shadow" action="/patients/process" method="PUT" modelAttribute="patient">
				<form:input type="hidden" path="user.id" value="${currentUser.id}"/>
				<div class="card-body">
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="firstName" class="col-form-label fs-5 fw-semibold">First Name:</form:label>
						</div>
						<div class="col-sm-9">
							<form:input type="text" class="form-control fs-5" path="firstName" placeholder="Enter first name"/>
							<form:errors path="firstName" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="middleName" class="col-form-label fs-5 fw-semibold">Middle Name:</form:label>
						</div>
						<div class="col-sm-9">
							<form:input type="text" class="form-control fs-5" path="middleName" placeholder="Enter middle name (optional)"/>
							<form:errors path="middleName" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="lastName" class="col-form-label fs-5 fw-semibold">Last Name:</form:label>
						</div>
						<div class="col-sm-9">
							<form:input type="text" class="form-control fs-5" path="lastName" placeholder="Enter last name"/>
							<form:errors path="lastName" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="birthday" class="col-form-label fs-5 fw-semibold">Date of Birth:</form:label>
						</div>
						<div class="col-sm-9">
							<form:input type="date" class="form-control fs-5" path="birthday"/>
							<form:errors path="birthday" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="gender" class="col-form-label fs-5 fw-semibold">Gender:</form:label>
						</div>
						<div class="col-sm-9">
							<form:select class="form-select fs-5" path="gender">
								<option selected disabled>Choose Gender</option>
								<form:option value="Male" path="gender"/>
								<form:option value="Female" path="gender"/>
							</form:select>
							<form:errors path="gender" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="nationality" class="col-form-label fs-5 fw-semibold">Nationality:</form:label>
						</div>
						<div class="col-sm-9">
							<form:input type="text" class="form-control fs-5" path="nationality" placeholder="Enter nationality"/>
							<form:errors path="nationality" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="company" class="col-form-label fs-5 fw-semibold">Company:</form:label>
						</div>
						<div class="col-sm-9">
							<form:input type="text" class="form-control fs-5" path="company" placeholder="Enter company name"/>
							<form:errors path="company" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="position" class="col-form-label fs-5 fw-semibold">Position:</form:label>
						</div>
						<div class="col-sm-9">
							<form:input type="text" class="form-control fs-5" path="position" placeholder="Enter position"/>
							<form:errors path="position" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 justify-content-between">
						<div class="col-auto">
							<form:label path="comorbids" class="col-form-label fs-5 fw-semibold">Medical Condition(s):</form:label>
						</div>
						<div class="col-sm-9">
							<form:textarea class="form-control fs-5" rows="5" path="comorbids" placeholder="Enter medical condition(s) (if applicable)"/>
							<form:errors path="comorbids" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-5 justify-content-between">
						<div class="col-auto">
							<form:label path="allergies" class="col-form-label fs-5 fw-semibold">Allergies:</form:label>
						</div>
						<div class="col-sm-9">
							<form:textarea class="form-control fs-5" rows="4" path="allergies" placeholder="Enter any allergies (if applicable)"/>
							<form:errors path="allergies" class="text-danger"/>
						</div>
					</div>
					<div class="d-flex justify-content-center">
						<input type="submit" class="btn btn-success bg-gradient fs-5 fw-semibold shadow" value="Update">
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>