package com.oceandrill.dmrsys.validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.oceandrill.dmrsys.models.User;
import com.oceandrill.dmrsys.repositories.UserRepository;

@Component
public class UserValidator implements Validator {
    @Autowired
    UserRepository userRepo;

    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.equals(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;
        User emailUser = userRepo.findByEmail(user.getEmail());
        User prcIdUser = userRepo.findByPrcId(user.getPrcId());

        if (emailUser != null) {
            errors.rejectValue("email", "Invalid", "Email address must be unique.");
        }

        if (prcIdUser != null) {
            errors.rejectValue("prcId", "Invalid", "PRC ID must be unique.");
        }
        
        if (!user.getConfirmPassword().equals(user.getPassword())) {
            errors.rejectValue("confirmPassword", "Match", "Passwords must match.");
        }
    }
}
