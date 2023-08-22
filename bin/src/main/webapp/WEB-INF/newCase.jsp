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
	<title>OceanDrill DMR: New Case</title>
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
		<h2 class="mb-5 text-center fw-bold">CREATE NEW CASE</h2>
		<div class="row justify-content-center">
			<form:form class="p-2 col-md-10 card bg-primary-subtle bg-gradient shadow" action="/cases/new" method="POST" modelAttribute="case">
				<form:input type="hidden" path="user.id" value="${currentUser.id}"/>
				<div class="card-body">
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="patient.id" class="col-form-label fs-5 fw-semibold">Patient Name:</form:label>
						</div>
						<div class="col-sm-9">
							<form:select class="form-select fs-5" path="patient.id">
								<option selected disabled>Choose patient name</option>
								<c:forEach var="patient" items="${allPatients}">
									<form:option value="${patient.id}" path="patient.id">${patient.firstName} ${patient.middleName.substring(0,1)}. ${patient.lastName}, ${patient.company}</form:option>
								</c:forEach>
							</form:select>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="status" class="col-form-label fs-5 fw-semibold">Case Status:</form:label>
						</div>
						<div class="col-sm-9">
							<form:select class="form-select fs-5" path="status">
								<option selected disabled>Choose case status</option>
								<form:option value="NEW" path="status"/>
								<form:option value="FF-UP" path="status"/>
							</form:select>
							<form:errors path="status" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 justify-content-between">
						<div class="col-auto">
							<form:label path="subjective" class="col-form-label fs-5 fw-semibold">Subjective Findings:</form:label>
						</div>
						<div class="col-sm-9">
							<form:textarea class="form-control fs-5" rows="5" path="subjective" placeholder="Enter subjective data"/>
							<form:errors path="subjective" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 justify-content-between">
						<div class="col-auto">
							<form:label path="objective" class="col-form-label fs-5 fw-semibold">Objective Findings:</form:label>
						</div>
						<div class="col-sm-9">
							<form:textarea class="form-control fs-5" rows="5" path="objective" placeholder="Enter objective data"/>
							<form:errors path="objective" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 justify-content-between">
						<div class="col-auto">
							<form:label path="assessment" class="col-form-label fs-5 fw-semibold">Assessment:</form:label>
						</div>
						<div class="col-sm-9">
							<form:textarea class="form-control fs-5" rows="3" path="assessment" placeholder="Enter diagnosis and/or differential diagnoses"/>
							<form:errors path="assessment" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-4 align-items-center justify-content-between">
						<div class="col-auto">
							<form:label path="category" class="col-form-label fs-5 fw-semibold">Category:</form:label>
						</div>
						<div class="col-sm-9">
							<form:select class="form-select fs-5" path="category">
								<option selected disabled>Choose case category</option>
								<form:option value="EENT" path="category"/>
								<form:option value="Pulmo" path="category"/>
								<form:option value="Cardio" path="category"/>
								<form:option value="Derma" path="category"/>
								<form:option value="Gastro" path="category"/>
								<form:option value="Musculoskeletal" path="category"/>
								<form:option value="Neuro" path="category"/>
								<form:option value="Infectious" path="category"/>
								<form:option value="Others" path="category"/>
							</form:select>
							<form:errors path="category" class="text-danger"/>
						</div>
					</div>
					<div class="row mb-5 justify-content-between">
						<div class="col-auto">
							<form:label path="plan" class="col-form-label fs-5 fw-semibold">Plan:</form:label>
						</div>
						<div class="col-sm-9">
							<form:textarea class="form-control fs-5" rows="5" path="plan" placeholder="Enter plan of management"/>
							<form:errors path="plan" class="text-danger"/>
						</div>
					</div>
					<div class="row justify-content-center">
						<input type="submit" class="btn btn-primary bg-gradient shadow fs-5 fw-semibold" value="Submit">
					</div>
				</div>
			</form:form>
		</div>
	</div>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>