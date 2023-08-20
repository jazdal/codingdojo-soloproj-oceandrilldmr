package com.oceandrill.dmrsys.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oceandrill.dmrsys.models.Case;
import com.oceandrill.dmrsys.repositories.CaseRepository;

@Service
public class CaseService {
	@Autowired
	private CaseRepository caseRepo;

	// Gets all cases (READ):
	public List<Case> getAllCases() {
		return caseRepo.findAll();
	}
	
	// Creates a new case (CREATE):
	public void createCase(Case caseObject) {
		caseRepo.save(caseObject);
	}
	
	// Gets all cases of a patient (READ):
	public List<Case> getAllPatientCases(Long id) {
		return caseRepo.findAllCasesWherePatientId(id);
	}
	
	// Gets all cases from the current month (READ):
	public List<Case> getAllCasesOfTheMonth() {
		return caseRepo.findAllCasesFromCurrentMonth();
	}
	
	// Gets all NEW cases from the current month (READ):
	public List<Case> getAllNewCases() {
		return caseRepo.findAllNewCasesFromCurrentMonth();
	}
	
	// Gets all OLD cases from the current month (READ):
	public List<Case> getAllOldCases() {
		return caseRepo.findAllOldCasesFromCurrentMonth();
	}
	
	// Gets all cases by category from the current month (READ):
	public List<Case> getAllCasesByCategory(String category) {
		return caseRepo.findAllCasesByCategory(category);
	}
	
	// Gets one case by ID (READ):
	public Case getCaseById(Long id) {
		return caseRepo.findById(id).orElse(null);
	}
	
	// Updates a case (UPDATE):
	public void updateCase(Case caseObject) {
		caseRepo.save(caseObject);
	}
	
	// Deletes a case (DELETE):
	public void deleteCase(Long id) {
		caseRepo.deleteById(id);
	}
}
