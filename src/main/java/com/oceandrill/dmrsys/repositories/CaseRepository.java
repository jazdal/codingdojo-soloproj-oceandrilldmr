package com.oceandrill.dmrsys.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.oceandrill.dmrsys.models.Case;

public interface CaseRepository extends CrudRepository<Case, Long> {
    List<Case> findAll();
    
    @Query(value = "SELECT * FROM cases WHERE patient_id = ?1", nativeQuery = true)
    List<Case> findAllCasesWherePatientId(Long id);
    
    @Query(value = "SELECT * FROM cases WHERE MONTH(created_at) = MONTH(curdate())", nativeQuery = true)
    List<Case> findAllCasesFromCurrentMonth();
    
    @Query(value = "SELECT * FROM cases WHERE MONTH(created_at) = MONTH(curdate()) AND status = 'NEW'", nativeQuery = true)
    List<Case> findAllNewCasesFromCurrentMonth();
    
    @Query(value = "SELECT * FROM cases WHERE MONTH(created_at) = MONTH(curdate()) AND status = 'FF-UP'", nativeQuery = true)
    List<Case> findAllOldCasesFromCurrentMonth();
    
    @Query(value = "SELECT * FROM cases WHERE MONTH(created_at) = MONTH(curdate()) AND category = ?1", nativeQuery = true)
    List<Case> findAllCasesByCategory(String category);
}
