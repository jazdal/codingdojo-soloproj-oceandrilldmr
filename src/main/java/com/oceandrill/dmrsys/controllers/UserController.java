package com.oceandrill.dmrsys.controllers;

import java.security.Principal;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oceandrill.dmrsys.models.User;
import com.oceandrill.dmrsys.services.UserService;
import com.oceandrill.dmrsys.validator.UserValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private UserValidator userValidator;

    @GetMapping("/")
    public String index(
        Principal principal, 
        Model model, 
        RedirectAttributes ra
        ) {
        if (principal == null) {
            return "redirect:/login";
        }
        User user = userService.findUserByPrcId(principal.getName());
        if (user != null) {
            user.setLastLogin(new Date());
            userService.updateUser(user);
            if (user.getRole().getName().contains("ROLE_ADMIN")) {
                return "redirect:/admin";
            }
            return "redirect:/dashboard";
        }
        ra.addFlashAttribute("unauthorized", "Unauthorized access!");
        return "redirect:/login";
    }

    @PostMapping("/register")
    public String registerUser(
            @Valid @ModelAttribute("user") User user, 
            BindingResult result, 
            Model model, 
            HttpServletRequest request
            ) {
        userValidator.validate(user, result);
        String password = user.getPassword();
        if (result.hasErrors()) {
            return "index.jsp";
        }
        if (userService.getAllUsers().size() == 0) {
            userService.createUser(user, "ROLE_ADMIN");
        } else {
            userService.createUser(user, "ROLE_USER");
        }
        authWithHttpServletRequest(request, user.getPrcId(), password);
        return "redirect:/";
    }

    private void authWithHttpServletRequest(
            HttpServletRequest request, 
            String prcId, 
            String password
            ) {
        try {
            request.login(prcId, password);
        } catch(ServletException e) {
            System.out.println("Error while login" + e);
        }
    }

    @GetMapping("/login")
    public String login(
    		@ModelAttribute("user") User user,
            @RequestParam(value = "error", required = false) String error, 
            @RequestParam(value = "logout", required = false) String logout, 
            Model model
            ) {
        
        if (error != null) {
            model.addAttribute("errorMessage", "Invalid credentials. Please try again.");
        }

        if (logout != null) {
            model.addAttribute("logoutMessage", "Logout successful!");
        }
        return "index.jsp";
    }
}
