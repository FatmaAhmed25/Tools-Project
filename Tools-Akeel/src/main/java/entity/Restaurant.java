package entity;

import java.util.ArrayList;
import java.util.List;
import java.util.*;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Id;


@Entity
public class Restaurant {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int restaurantId;
	private String name;
	@OneToMany(mappedBy = "restaurant")
	private List<Meal>meals=new ArrayList<Meal>();
	
	@OneToMany(mappedBy = "restaurant")
	private List<Order>orders=new ArrayList<Order>();
	
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id")
    private Owner owner;
    
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "report_id")
   private RestaurantReport restaurantReport ;
    
	public Restaurant() {

	}
	
	public RestaurantReport getRestaurantReport() {
	return restaurantReport;
}
    public void setRestaurantReport(RestaurantReport restaurantReport) {
	this.restaurantReport = restaurantReport;
}
	public List<Meal> getMeals() {
		return meals;
	}
	public void setMeals(List<Meal> menu) {
		this.meals = menu;
	}
	public int getId() {
		return restaurantId;
	}
	public void setId(int id) {
		restaurantId = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Owner getOwner() {
		return owner;
	}
	public void setOwner(Owner owner) {
		this.owner = owner;
	}
	public String printMenu()
    {
        String output="";
        
        for(int i =0;i<meals.size();i++)
        {
        	
            output+="meal with id: "+(i+1) +" "+meals.get(i).toString() +"                    "+"\n";
            
        }
        
        return output;
    }
	
	
	
}