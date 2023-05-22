package entity;
import java.util.ArrayList;
import java.util.Set;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;

@Entity
public class Customer extends User{
	
	@OneToMany(mappedBy = "customer")
	
    private List<Order> orders ;

	public List<Order> getOrders() {
		// TODO Auto-generated method stub
		return orders;
	}

}
