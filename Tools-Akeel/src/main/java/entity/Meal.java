package entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Id;

@Entity
public class Meal {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;
	@ManyToOne
	@JoinColumn(name="restaurantId")
	private Restaurant restaurant;
	
	
	@ManyToMany(mappedBy = "meals")
	private List<Order> orders;
	
	private String name;
	private double price;
	private String description;
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	
	
	public String toString()
    {
        
        return "Name: "+name+" \tPrice : "+price+"\t Description : "+description;
        
    }
	public Restaurant getRestaurant() {
		return restaurant;
	}
	public void setRestaurant(Restaurant restaurant) {
		this.restaurant=restaurant;
	}
	
	
	


}