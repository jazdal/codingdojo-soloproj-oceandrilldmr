package com.oceandrill.dmrsys.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import com.oceandrill.dmrsys.models.Role;
import com.oceandrill.dmrsys.repositories.RoleRepository;

@Component
public class RoleInitializer implements CommandLineRunner {
	@Autowired
	private RoleRepository roleRepo;

	@Override
	public void run(String... args) throws Exception {
		createRoleIfNotExists("ROLE_USER");
		createRoleIfNotExists("ROLE_ADMIN");
	}
	
	private void createRoleIfNotExists(String roleName) {
		Role role = roleRepo.findByName(roleName);
		
		if (role == null) {
			role = new Role(roleName);
			roleRepo.save(role);
		}
	}
}
