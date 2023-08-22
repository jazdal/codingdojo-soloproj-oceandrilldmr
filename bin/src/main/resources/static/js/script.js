// Real-Time Clock:
let rtClock = setInterval(function() {timer()}, 1000);
		
const timer = () => {
	let date = new Date();
	const options = {
		month: "long", 
		day: "numeric", 
		year: "numeric", 
		hour: "2-digit", 
		minute: "2-digit", 
		second: "2-digit"
	};
	const formattedDate = date.toLocaleString("en-US", options);
	document.getElementById("clock").innerHTML = formattedDate;
}

// Color Mode Switcher:
const toggleTheme = () => {
	const htmlElement = document.querySelector("html");
	
	if (htmlElement.getAttribute("data-bs-theme") === "dark") {
		htmlElement.setAttribute("data-bs-theme", "light");
		localStorage.setItem("theme", "light");
		localStorage.setItem("toggleState", "off");
	} else {
		htmlElement.setAttribute("data-bs-theme", "dark");
		localStorage.setItem("theme", "dark");
		localStorage.setItem("toggleState", "on");
	}
}

document.addEventListener("DOMContentLoaded", function() {
	const storedTheme = localStorage.getItem("theme");
	const storedToggleState = localStorage.getItem("toggleState");
	if (storedTheme) {
		const htmlElement = document.querySelector("html");
		htmlElement.setAttribute("data-bs-theme", storedTheme);
	}
	if (storedToggleState === "on") {
		const toggleSwitch = document.getElementById("switch");
		if (toggleSwitch) {
			toggleSwitch.checked = true;
		}
	}
});
