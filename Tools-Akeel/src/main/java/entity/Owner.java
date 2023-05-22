package entity;

import java.util.List;
import java.util.Set;
import java.util.ArrayList;
import java.util.HashSet;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.Null;
@Entity
public class Owner extends User{
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	private int Id;
	private String name;
	@OneToOne(mappedBy="owner")
	private Restaurant restaurant;

	public Restaurant getRestaurants() {
		return restaurant;
	}
	public void setRestaurants(Restaurant restaurants) {
		this.restaurant = restaurants;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
	
	
	
	

}
