package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
@Entity
public class RestaurantReport {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;
	
	@OneToOne( mappedBy="restaurantReport")
	private Restaurant restaurant;
	
	public Restaurant getRestaurant() {
		return restaurant;
	}
	public void setRestaurant(Restaurant restaurant) {
		this.restaurant = restaurant;
	}
	double totalAmountEarned=0.0;
	
	int numberOfCompletedOrders=0;
	int numberOfCanceledOrders=0;
	public double getTotalAmountEarned() {
		return totalAmountEarned;
	}
	public int getNumberOfCompletedOrders() {
		return numberOfCompletedOrders;
	}
	public int getNumberOfCanceledOrders() {
		return numberOfCanceledOrders;
	}
	public void addTotalAmountEarned(double totalAmountEarned) {
		this.totalAmountEarned += totalAmountEarned;
	}
	public void addNumberOfCompletedOrders() {
		this.numberOfCompletedOrders += 1;
	}
	public void addNumberOfCanceledOrders() {
		this.numberOfCanceledOrders += 1;
	}
	public String toString()
	{
		return "Total amount earned by restaurant : " +totalAmountEarned +"\n"+
		"Number of completed Orders : "+numberOfCompletedOrders+"\n"+
				"Number of canceled Orders : "+numberOfCanceledOrders;
	}
	
	
}
