package com.oceandrill.dmrsys.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.oceandrill.dmrsys.models.Case;
import com.oceandrill.dmrsys.models.Patient;
import com.oceandrill.dmrsys.models.User;
import com.oceandrill.dmrsys.repositories.RoleRepository;
import com.oceandrill.dmrsys.repositories.UserRepository;

import jakarta.transaction.Transactional;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepo;

    @Autowired
    private RoleRepository roleRepo;

    @Autowired
    private BCryptPasswordEncoder bCryptPwEncoder;

    // Gets all users (READ):
    public List<User> getAllUsers() {
        return userRepo.findAll();
    }

    // Creates a new user (CREATE):
    public void createUser(User user, String role) {
        user.setPassword(bCryptPwEncoder.encode(user.getPassword()));
        user.setRole(roleRepo.findByName(role));
        userRepo.save(user);
    }

    // Updates a user (READ):
    public void updateUser(User user) {
        userRepo.save(user);
    }
    
    // Finds a user by ID (READ):
    public User findUserById(Long id) {
        return userRepo.findById(id).orElse(null);
    }

    // Finds a user by email (READ):
    public User findUserByEmail(String email) {
        return userRepo.findByEmail(email);
    }

    // Finds a user by PRC ID (READ):
    public User findUserByPrcId(String prcId) {
        return userRepo.findByPrcId(prcId);
    }

    // Deletes a user (DELETE):
    @Transactional
    public void deleteUser(Long id) {
    	User user = userRepo.findById(id).orElse(null);
    	
    	if (user != null) {
    		for (Patient patient : user.getPatients()) {
    			patient.setUser(null);
    		}
    		for (Case eachCase : user.getCases()) {
    			eachCase.setUser(null);
    		}
    	}
        userRepo.delete(user);
    }
}
