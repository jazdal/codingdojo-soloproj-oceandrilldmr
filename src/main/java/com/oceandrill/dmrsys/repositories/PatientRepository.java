package com.oceandrill.dmrsys.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.oceandrill.dmrsys.models.Patient;

public interface PatientRepository extends CrudRepository<Patient, Long> {
	
	@Query(value = "SELECT * FROM patients ORDER BY last_name ASC", nativeQuery = true)
	List<Patient> findAllSorted();
	
	Patient findByFirstNameAndMiddleNameAndLastName(String firstName, String middleName, String lastName);
	
	List<Patient> findByLastNameContaining(String name);
}
