package com.oceandrill.dmrsys.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.oceandrill.dmrsys.models.User;

public interface UserRepository extends CrudRepository<User, Long> {
    List<User> findAll();
    User findByEmail(String email);
    User findByPrcId(String prcId);
}
