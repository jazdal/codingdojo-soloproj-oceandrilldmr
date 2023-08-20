package com.oceandrill.dmrsys.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.oceandrill.dmrsys.models.Role;

public interface RoleRepository extends CrudRepository<Role, Long> {
    List<Role> findAll();
    Role findByName(String name);
}
