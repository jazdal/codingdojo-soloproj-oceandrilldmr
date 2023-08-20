package com.oceandrill.dmrsys.models;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import jakarta.persistence.CascadeType;
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
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "patients")
public class Patient {
    // MODEL STRUCTURE
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "First name is required.")
    @Size(min = 2, max = 80, message = "First name must be between 2-80 characters.")
    private String firstName;

    private String middleName;

    @NotBlank(message = "Last name is required.")
    @Size(min = 2, max = 80, message = "Last name must be between 2-80 characters.")
    private String lastName;

    @NotNull(message = "Date of birth is required.")
    @Past(message = "Birthdate cannot be in the present or future.")
    private LocalDate birthday;

    @NotBlank(message = "Gender is required.")
    private String gender;
    
    @NotBlank(message = "Nationality is required.")
    @Size(min = 2, max = 80, message = "Nationality must be between 2-80 characters.")
    private String nationality;

    @NotBlank(message = "Company is required.")
    @Size(min = 2, max = 80, message = "Company must be between 2-80 characters.")
    private String company;

    @NotBlank(message = "Position is required.")
    @Size(min = 2, max = 80, message = "Position must be between 2-80 characters.")
    private String position;

    @Column(columnDefinition = "TEXT")
    private String comorbids;

    @Column(columnDefinition = "TEXT")
    private String allergies;

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

    // RELATIONSHIPS
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(
        mappedBy = "patient", 
        fetch = FetchType.LAZY, 
        cascade = CascadeType.ALL
    )
    private List<Case> cases;

    // CONSTRUCTORS
    public Patient() {
    }

    public Patient(
			String firstName,
			String middleName,
			String lastName,
			LocalDate birthday,
			String gender,
			String nationality,
			String company,
			String position,
			String comorbids, 
			String allergies, 
			User user, 
			List<Case> cases
			) {
		super();
		this.firstName = firstName;
		this.middleName = middleName;
		this.lastName = lastName;
		this.birthday = birthday;
		this.gender = gender;
		this.nationality = nationality;
		this.company = company;
		this.position = position;
		this.comorbids = comorbids;
		this.allergies = allergies;
		this.user = user;
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

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public LocalDate getBirthday() {
		return birthday;
	}

	public void setBirthday(LocalDate birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getComorbids() {
		return comorbids;
	}

	public void setComorbids(String comorbids) {
		this.comorbids = comorbids;
	}

	public String getAllergies() {
		return allergies;
	}

	public void setAllergies(String allergies) {
		this.allergies = allergies;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Case> getCases() {
		return cases;
	}

	public void setCases(List<Case> cases) {
		this.cases = cases;
	}
}
