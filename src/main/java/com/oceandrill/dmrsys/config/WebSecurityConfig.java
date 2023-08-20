package com.oceandrill.dmrsys.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.servlet.util.matcher.MvcRequestMatcher;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {
    private UserDetailsService userDetailsService;

    @Bean
    protected BCryptPasswordEncoder bCryptPwEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    protected SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authorize -> authorize
                .requestMatchers(
                        new MvcRequestMatcher(null, "/css/**"), 
                        new MvcRequestMatcher(null, "/js/**"), 
                        new MvcRequestMatcher(null, "/register"), 
                        new MvcRequestMatcher(null, "/login"))
                    .permitAll()
                .requestMatchers(
                        new MvcRequestMatcher(null, "/delete/**"), 
                        new MvcRequestMatcher(null, "/admin/**"))
                    .hasRole("ADMIN")
                .requestMatchers(
                        new MvcRequestMatcher(null, "/home"),  
                        new MvcRequestMatcher(null, "/dashboard"), 
                        new MvcRequestMatcher(null, "/patients/**"), 
                        new MvcRequestMatcher(null, "/cases/**"))
                    .authenticated().anyRequest().permitAll())
            .exceptionHandling(exception -> exception
                .accessDeniedPage("/WEB-INF/accessDenied.jsp"))
            .formLogin(login -> login
                .loginPage("/login")
                .usernameParameter("prcId")
                .permitAll())
            .logout(logout -> logout.permitAll());
        
        return http.build();
    }

    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPwEncoder());
    }
}
