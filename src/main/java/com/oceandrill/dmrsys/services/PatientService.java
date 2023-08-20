package com.oceandrill.dmrsys.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.oceandrill.dmrsys.models.Patient;
import com.oceandrill.dmrsys.repositories.PatientRepository;

@Service
public class PatientService {
	@Autowired
	private PatientRepository patientRepo;
	
	// Gets all patients (READ):
	public List<Patient> getAllPatients() {
		return patientRepo.findAllSorted();
	}
	
	// Finds patients by searched name (READ):
	public List<Patient> findPatientByName(String name) {
		return patientRepo.findByLastNameContaining(name);
	}
	
	// Creates a new patient (CREATE):
	public void createPatient(Patient patient) {
		patientRepo.save(patient);
	}
	
	// Additional validation for patient:
	public Patient validate(Patient patient, BindingResult result) {
		Patient potentialPatient = patientRepo.findByFirstNameAndMiddleNameAndLastName(patient.getFirstName(), patient.getMiddleName(), patient.getLastName());
		
		if (potentialPatient != null) {
			result.rejectValue("firstName", "Invalid", "Patient already exists in the database!");
		}
		
		if (!result.hasErrors()) {
			return patientRepo.save(patient);
		}
		return patient;
	}
	
	// Updates a patient (UPDATE):
	public void updatePatient(Patient patient) {
		patientRepo.save(patient);
	}
	
	// Gets one patient by ID (READ):
	public Patient getOnePatientById(Long id) {
		return patientRepo.findById(id).orElse(null);
	}
	
	// Deletes a patient (DELETE):
	public void deletePatient(Long id) {
		patientRepo.deleteById(id);
	}
}
