package com.oceandrill.dmrsys.controllers;

import java.security.Principal;
import java.time.LocalDate;
import java.time.Period;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oceandrill.dmrsys.models.Case;
import com.oceandrill.dmrsys.models.Patient;
import com.oceandrill.dmrsys.services.CaseService;
import com.oceandrill.dmrsys.services.PatientService;
import com.oceandrill.dmrsys.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class MainController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private PatientService patientService;
	
	@Autowired
	private CaseService caseService;
	
	@GetMapping("/admin")
	public String adminDashboard(
			Principal principal, 
			Model model, 
			HttpSession session
			) {
		model.addAttribute("adminUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("allUsers", userService.getAllUsers());
		return "adminDashboard.jsp";
	}
	
	@GetMapping("/admin/view/{doctorId}")
	public String viewDoctor(
			Principal principal, 
			Model model, 
			@PathVariable("doctorId") Long doctorId
			) {
		model.addAttribute("adminUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("doctor", userService.findUserById(doctorId));
		model.addAttribute("oneMonthLater", LocalDate.now().plusMonths(1));
		return "viewDoctor.jsp";
	}
	
	@GetMapping("/admin/delete/{doctorId}")
	public String deleteDoctor(@PathVariable("doctorId") Long doctorId) {
		userService.deleteUser(doctorId);
		return "redirect:/admin";
	}
	
	@GetMapping("/dashboard")
	public String mainDashboard(
			Principal principal, 
			Model model
			) {
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("currentMonth", new Date());
		model.addAttribute("allCases", caseService.getAllCasesOfTheMonth());
		model.addAttribute("newCases", caseService.getAllNewCases());
		model.addAttribute("oldCases", caseService.getAllOldCases());
		model.addAttribute("now", new Date());
		return "mainDashboard.jsp";
	}
	
	@GetMapping("/cases/breakdown")
	public String caseBreakdown(
			Principal principal, 
			Model model
			) {
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("currentMonth", new Date());
		model.addAttribute("EENT", caseService.getAllCasesByCategory("EENT").size());
		model.addAttribute("Pulmo", caseService.getAllCasesByCategory("Pulmo").size());
		model.addAttribute("Cardio", caseService.getAllCasesByCategory("Cardio").size());
		model.addAttribute("Derma", caseService.getAllCasesByCategory("Derma").size());
		model.addAttribute("Gastro", caseService.getAllCasesByCategory("Gastro").size());
		model.addAttribute("Musculoskeletal", caseService.getAllCasesByCategory("Musculoskeletal").size());
		model.addAttribute("Neuro", caseService.getAllCasesByCategory("Neuro").size());
		model.addAttribute("Infectious", caseService.getAllCasesByCategory("Infectious").size());
		model.addAttribute("Others", caseService.getAllCasesByCategory("Others").size());
		return "caseBreakdown.jsp";
	}
	
	@GetMapping("/patients")
	public String showAllPatients(
			Principal principal, 
			Model model
			) {
		model.addAttribute("dateToday", LocalDate.now());
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("allPatients", patientService.getAllPatients());
		return "allPatients.jsp";
	}
	
	@GetMapping("/search")
	public String searchPatients(
			@RequestParam("search") String searchTerm, 
			Principal principal, 
			Model model
			) {
		List<Patient> searchResults = patientService.findPatientByName(searchTerm);
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("searchResults", searchResults);
		return "searchResults.jsp";
	}
	
	@GetMapping("/patients/new")
	public String newPatientForm(
			Principal principal, 
			Model model, 
			@ModelAttribute("patient") Patient patient
			) {
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		return "newPatient.jsp";
	}
	
	@PostMapping("/patients/new")
	public String addPatient(
			@Valid @ModelAttribute("patient") Patient patient, 
			BindingResult result, 
			Principal principal, 
			Model model
			) {
		patientService.validate(patient, result);
		if (result.hasErrors()) {
			model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
			return "newPatient.jsp";
		}
		patientService.createPatient(patient);
		Long patientId = patient.getId();
		return "redirect:/patients/" + patientId;
	}
	
	@GetMapping("/patients/{patientId}")
	public String viewPatientInfo(
			@PathVariable("patientId") Long patientId, 
			Principal principal, 
			Model model
			) {
		Patient thisPatient = patientService.getOnePatientById(patientId);
		Integer currentAge = Period.between(thisPatient.getBirthday(), LocalDate.now()).getYears();
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("patient", thisPatient);
		model.addAttribute("currentAge", currentAge);
		model.addAttribute("patientCases", caseService.getAllPatientCases(patientId));
		return "viewPatient.jsp";
	}
	
	@GetMapping("/patients/edit/{patientId}")
	public String editPatientForm(
			Principal principal, 
			Model model, 
			@PathVariable("patientId") Long patientId, 
			HttpSession session
			) {
		session.setAttribute("patientId", patientId);
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("patient", patientService.getOnePatientById(patientId));
		return "editPatient.jsp";
	}
	
	@PutMapping("/patients/process")
	public String updatePatient(
			@Valid @ModelAttribute("patient") Patient patient, 
			BindingResult result, 
			Principal principal, 
			Model model, 
			HttpSession session
			) {
		if (result.hasErrors()) {
			model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
			return "editPatient.jsp";
		}
		Patient patientToUpdate = patientService.getOnePatientById((Long) session.getAttribute("patientId"));
		patientToUpdate.setUser(userService.findUserByPrcId(principal.getName()));
		patientToUpdate.setFirstName(patient.getFirstName());
		patientToUpdate.setMiddleName(patient.getMiddleName());
		patientToUpdate.setLastName(patient.getLastName());
		patientToUpdate.setBirthday(patient.getBirthday());
		patientToUpdate.setGender(patient.getGender());
		patientToUpdate.setNationality(patient.getNationality());
		patientToUpdate.setCompany(patient.getCompany());
		patientToUpdate.setPosition(patient.getPosition());
		patientToUpdate.setComorbids(patient.getComorbids());
		patientToUpdate.setAllergies(patient.getAllergies());
		patientService.updatePatient(patientToUpdate);
		return "redirect:/patients/" + (Long) session.getAttribute("patientId");
	}
	
	@GetMapping("/patients/delete/{patientId}")
	public String deletePatient(@PathVariable("patientId") Long patientId) {
		patientService.deletePatient(patientId);
		return "redirect:/dashboard";
	}
	
	@GetMapping("/cases/new")
	public String newCaseForm(
			Principal principal, 
			Model model, 
			@ModelAttribute("case") Case caseObject
			) {
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("allPatients", patientService.getAllPatients());
		return "newCase.jsp";
	}
	
	@PostMapping("/cases/new")
	public String addNewCase(
			@Valid @ModelAttribute("case") Case caseObject, 
			BindingResult result, 
			Principal principal, 
			Model model
			) {
		if (result.hasErrors()) {
			model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
			model.addAttribute("allPatients", patientService.getAllPatients());
			return "newCase.jsp";
		}
		caseService.createCase(caseObject);
		return "redirect:/dashboard";
	}
	
	@GetMapping("/cases/{caseId}")
	public String showCase(
			Principal principal, 
			Model model, 
			@PathVariable("caseId") Long caseId
			) {
		Case thisCase = caseService.getCaseById(caseId);
		Integer currentAge = Period.between(thisCase.getPatient().getBirthday(), LocalDate.now()).getYears();
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("thisCase", thisCase);
		model.addAttribute("currentAge", currentAge);
		return "viewCase.jsp";
	}
	
	@GetMapping("/cases/edit/{caseId}")
	public String editCaseForm(
			Principal principal, 
			Model model, 
			@PathVariable("caseId") Long caseId
			) {
		model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
		model.addAttribute("thisCase", caseService.getCaseById(caseId));
		model.addAttribute("currentCase", caseService.getCaseById(caseId));
		return "editCase.jsp";
	}
	
	@PutMapping("/cases/edit/{caseId}")
	public String updateCase(
			@Valid @ModelAttribute("thisCase") Case thisCase, 
			BindingResult result, 
			Principal principal, 
			Model model, 
			@PathVariable("caseId") Long caseId
			) {
		if (result.hasErrors()) {
			model.addAttribute("currentUser", userService.findUserByPrcId(principal.getName()));
			model.addAttribute("currentCase", caseService.getCaseById(caseId));
			return "editCase.jsp";
		}
		Case caseToUpdate = caseService.getCaseById(caseId);
		caseToUpdate.setUser(userService.findUserById(thisCase.getUser().getId()));
		caseToUpdate.setStatus(thisCase.getStatus());
		caseToUpdate.setSubjective(thisCase.getSubjective());
		caseToUpdate.setObjective(thisCase.getObjective());
		caseToUpdate.setAssessment(thisCase.getAssessment());
		caseToUpdate.setCategory(thisCase.getCategory());
		caseToUpdate.setPlan(thisCase.getPlan());
		caseService.updateCase(caseToUpdate);
		return "redirect:/dashboard";
	}
	
	@GetMapping("/cases/delete/{caseId}")
	public String deleteCase(
			@PathVariable("caseId") Long caseId
			) {
		caseService.deleteCase(caseId);
		return "redirect:/dashboard";
	}
}
