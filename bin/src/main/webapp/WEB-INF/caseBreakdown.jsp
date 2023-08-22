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
	<title>OceanDrill DMR: Case Breakdown</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/css/style.css" />
	<script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.3/dist/chart.umd.min.js"></script>
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
		<h3 class="text-center fw-bold">CASE BREAKDOWN (BY CATEGORY)</h3>
		<h3 class="mb-5 text-center fw-bold fst-italic"><fmt:formatDate value="${currentMonth}" pattern="MMMM yyyy" /></h3>
		<div id="chart">
			<canvas id="pieChart"></canvas>
		</div>
	</div>
	<script>
	const ctx = document.getElementById("pieChart");

	let data = {
		labels: ["EENT", "Pulmo", "Cardio", "Derma", "Gastro", "Musculoskeletal", "Neuro", "Infectious", "Others"], 
		datasets: [{
			data: [
				${EENT}, 
				${Pulmo}, 
				${Cardio}, 
				${Derma}, 
				${Gastro}, 
				${Musculoskeletal}, 
				${Neuro}, 
				${Infectious}, 
				${Others}
			], 
			backgroundColor: [
				'rgba(255, 99, 132, 0.7)', 
				'rgba(54, 162, 235, 0.7)', 
				'rgba(255, 206, 86, 0.7)', 
				'rgba(75, 192, 192, 0.7)', 
				'rgba(153, 102, 255, 0.7)', 
				'rgba(255, 159, 64, 0.7)', 
				'rgba(123, 214, 111, 0.7)', 
				'rgba(87, 109, 132, 0.7)', 
				'rgba(200, 200, 200, 0.7)'
			], 
			borderWidth: 2
		}]
	};

	let myPieChart = new Chart(ctx, {
		type: "pie", 
		data: data
	});
	</script>
	<script type="text/javascript" src="/js/script.js"></script>
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>