package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Runner {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
	private String name;
	private boolean isAvailable;
	private double deliveryFees;

	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean isAvailable() {
		return isAvailable;
	}
	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}
	public double getDeliveryFees() {
		return deliveryFees;
	}
	public void setDeliveryFees(double deliveryFees) {
		this.deliveryFees = deliveryFees;
	}
	
	

}