package Controller;
import java.awt.MenuItem;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.annotation.security.RolesAllowed;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.PathVariable;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import entity.*;


@RolesAllowed("CUSTOMER")
@Stateless
@Path("/customer")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class CustomerService {
    @PersistenceContext
    private EntityManager em;
    @POST
    @Path("/createOrder/{customerId}/{ResturantId}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String createOrder(@PathParam("customerId") String customerId,@PathParam("ResturantId") int ResturantId, ArrayList<Integer> itemIds) {
    	String Response ="";
        Order order = new Order();

        // Select a random available runner from the database
        Customer customer = em.find(Customer.class, customerId);
        Restaurant restaurant =em.find(Restaurant.class, ResturantId);
        Runner runner = getRandomAvailableRunner();
        if (runner == null) {
            return "no available runner";
        }

        // Fetch the selected items from the database
        List<Meal> items = new ArrayList<Meal>();
        for (Integer id : itemIds) {
            Meal item = em.find(Meal.class, id);
            System.out.println(item.toString());
            if (item != null) {
                items.add(item);
                order.getItems().add(item);
            }
        }
        // Create a new order
        order.setCustomer(customer);
        order.setRestauarant(restaurant);
        order.setRunner(runner);
        order.setItems(items);
        double total = 0.0;
        for (int i = 0; i < items.size(); i++) {
            total += items.get(i).getPrice();
        }
        order.setTotal(total + runner.getDeliveryFees());
        order.setStatus(OrderStatus.PREPARING);

         //Update the runner's status to busy
        //runner.setAvailable(false);
        em.persist(runner);

        // Persist the order and update the customer's orders list
        em.persist(order);
        customer.getOrders().add(order);
        em.persist(customer);
        em.persist(restaurant);
        return order.toString();
    }

    
    @POST
    @Path("/cancelOrder/{orderId}/{ResturantId}")
    public String cancelOrder(@PathParam("orderId") String orderId,@PathParam("ResturantId") int ResturantId) {
        Order order = em.find(Order.class, orderId);
        
        if (order == null) {
            return"Invalid order ID: " + orderId;
        }
        if (order.getStatus() != OrderStatus.PREPARING) {
            return "Cannot cancel order that is not in the preparing state";
        }
        order.setStatus(OrderStatus.CANCELED);
        em.persist(order);
        Restaurant restaurant =order.getRestauarant();
        RestaurantReport restaurantReport = restaurant.getRestaurantReport();
        restaurantReport.addNumberOfCanceledOrders();
        return "Order with ID " + orderId + " has been canceled"+ "    resturantID:"+restaurant.getId();
        
        
    }
    public Runner getRandomAvailableRunner() {
        
        Query query = em.createQuery("SELECT r FROM Runner r WHERE r.isAvailable = true");
        List<Runner> runners = query.getResultList();
        if (runners.isEmpty()) {
            return null;
        }
        Collections.shuffle(runners);
        return runners.get(0);
    }
    @PUT
    @Path("/editOrderAddItem/{customerId}/{orderID}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String addItemToOrder(@PathParam("customerId") String customerId,@PathParam("orderID")String orderID, ArrayList<Integer> itemIds) {
    	Order order=em.find(Order.class, orderID);
    	if(order==null)return "No order with this ID";
    	if (order.getStatus() != OrderStatus.PREPARING || order.getStatus() == OrderStatus.CANCELED) {
            return("Order cannot be edited");
        }
    	 List<Meal> items = new ArrayList<Meal>();
         for (Integer id : itemIds) {
             Meal item = em.find(Meal.class, id);
             if(item==null) return "item with id "+id+" not found";
             System.out.println(item.toString());
             if (item != null) {
                 items.add(item);
                 order.getItems().add(item);
             }
         }
    	
         return order.getItems().toString()+"    ID="+order.getId();
    }
    @PUT
    @Path("/editOrderRemoveItem/{customerId}/{orderID}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String removeItemFromOrder(@PathParam("customerId") String customerId,@PathParam("orderID")String orderID, ArrayList<Integer> itemIds) {
    	Order order=em.find(Order.class, orderID);
    	if(order==null)return "No order with this ID";
    	if (order.getStatus() != OrderStatus.PREPARING || order.getStatus() == OrderStatus.CANCELED) {
            return("Order cannot be edited");
        }
    	 List<Meal> items = new ArrayList<Meal>();
         for (Integer id : itemIds) {
             Meal item = em.find(Meal.class, id);
             if(item==null) return "item with id "+id+" not found";
             System.out.println(item.toString());
             if (item != null) {
                 items.remove(item);
                 order.getItems().remove(item);
             }
         }
   
    	
         return order.getItems().toString()+"    ID="+order.getId();
    }

    @GET
    @Path("/getAllRestaurants")
    public String getAllRestaurants() {
    	String output="";
    	TypedQuery<Restaurant> query = em.createQuery("SELECT u FROM Restaurant u " , Restaurant.class);
    	List<Restaurant> list=query.getResultList();
        for(int i=0;i<list.size();i++)
		{
			output+="ResturanID: "+list.get(i).getId()+"\n"+"Restuarant Name: "+list.get(i).getName()+"\nRestaurant Owner:"+ list.get(i).getOwner().getUsername()+list.get(i).printMenu()+"   \n";
		}
		return output;
    }
    @GET
    @Path("/listOrdersByCustomerId/{customerId}")
    public String listOrdersByCustomerId(@PathParam("customerId")String customerId) {
    	String output="";
        Query query = em.createQuery("SELECT o FROM Order o WHERE o.customer.id = :customerId");
        query.setParameter("customerId", customerId);
        List<Order> list= query.getResultList();
        for(Order i: list)
        {
        	for(int j=0;j<i.getItems().size();j++)
        	{
        		output+="OrderID: "+ i.getId()+"  "+i.getItems().get(j)+"  |  ";
        	}
        	output+=i.getStatus();
        	output+="\n";
        }
        return output;
    }

}
