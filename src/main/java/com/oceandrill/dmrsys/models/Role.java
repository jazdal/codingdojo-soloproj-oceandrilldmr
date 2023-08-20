package com.oceandrill.dmrsys.models;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "roles")
public class Role {
    // MODEL STRUCTURE
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    // RELATIONSHIPS
    @OneToMany(
        mappedBy = "role", 
        fetch = FetchType.EAGER
    )
    private List<User> users;

    // CONSTRUCTORS
    public Role() {
    }

    public Role(String name) {
        this.name = name;
    }
    
    public Role(String name, List<User> users) {
        this.name = name;
        this.users = users;
    }

    // GETTERS AND SETTERS
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }
}
