package com.oceandrill.dmrsys.models;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Future;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")
public class User {
    // MODEL STRUCTURE
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "First name is required.")
    @Size(min = 2, max = 80, message = "First name must be between 2-80 characters.")
    private String firstName;

    @NotBlank(message = "Last name is required.")
    @Size(min = 2, max = 80, message = "Last name must be between 2-80 characters.")
    private String lastName;

    @NotBlank(message = "Email is required.")
    @Size(min = 5, max = 80, message = "Email must be between 5-80 characters.")
    @Email(message = "Email must have the proper format.")
    private String email;

    @NotBlank(message = "PRC ID is required.")
    @Digits(integer = 7, fraction = 0, message = "PRC ID must consist of 7 digits only.")
    private String prcId;

    @NotNull(message = "PRC ID validity date is required.")
    @Future(message = "PRC ID validity date must not be in the past or present.")
    private LocalDate prcExp;

    @NotBlank(message = "Password is required.")
    @Size(min = 8, max = 80, message = "Password must be between 8-80 characters.")
    @Pattern(regexp = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!]).*$", message = "Password must contain at least one uppercase letter, one number, and one special character.")
    private String password;

    @Transient
    private String confirmPassword;

    @Column(updatable = false)
    private Date createdAt;

    @PrePersist
    private void onCreate() {
        this.createdAt = new Date();
    }

    private Date updatedAt;

    @PreUpdate
    private void onUpdate() {
        this.updatedAt = new Date();
    }

    private Date lastLogin;

    // RELATIONSHIPS
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "role_id")
    private Role role;

    @OneToMany(
        mappedBy = "user", 
        fetch = FetchType.LAZY
    )
    private List<Patient> patients;

    @OneToMany(
        mappedBy = "user", 
        fetch = FetchType.LAZY
    )
    private List<Case> cases;

    // CONSTRUCTORS
    public User() {
    }

    public User(
            String firstName,
            String lastName,
            String email,
            String prcId,
            LocalDate prcExp,
            String password,
            String confirmPassword, 
            Date lastLogin, 
            Role role,
            List<Patient> patients, 
            List<Case> cases
            ) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.prcId = prcId;
        this.prcExp = prcExp;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.lastLogin = lastLogin;
        this.role = role;
        this.patients = patients;
        this.cases = cases;
    }

    // GETTERS AND SETTERS
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPrcId() {
        return prcId;
    }

    public void setPrcId(String prcId) {
        this.prcId = prcId;
    }

    public LocalDate getPrcExp() {
        return prcExp;
    }

    public void setPrcExp(LocalDate prcExp) {
        this.prcExp = prcExp;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public List<Patient> getPatients() {
        return patients;
    }

    public void setPatients(List<Patient> patients) {
        this.patients = patients;
    }

    public List<Case> getCases() {
        return cases;
    }

    public void setCases(List<Case> cases) {
        this.cases = cases;
    }
}
