package Controller;

import entity.Order;
import entity.OrderStatus;
import entity.Restaurant;
import entity.RestaurantReport;
import entity.Runner;

import javax.annotation.security.RolesAllowed;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import java.util.List;
@RolesAllowed("RUNNER")
@Stateless
@Path("/runner")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.TEXT_PLAIN)
public class RunnerService {
	@PersistenceContext
	private EntityManager entityManager;
	@Path("/markOrderAsDelivered/{orderId}/{runnerID}")
	@PUT
    public String markOrderAsDelivered(@PathParam("orderId")String orderId,@PathParam("runnerID") String runnerId) {
        Order order =entityManager.find(Order.class,orderId);
        Runner runner = entityManager.find(Runner.class,runnerId);

        
        if (order.getStatus().equals(OrderStatus.PREPARING)) {
            return "Order is not accepted yet '~' ";
        }
        if (order.getStatus() == OrderStatus.CANCELED) {
            return "the order is already canceled '~' ";
        }
        if (order.getStatus() == OrderStatus.DELIVERED) {
            return "the order is already delivered '-' ";
        }
        
        if (order.getStatus().equals(OrderStatus.DELIVERING)) {
            order.setStatus(OrderStatus.DELIVERED);
        
            runner.setAvailable(true);
            entityManager.persist(order);
            entityManager.persist(runner);
            Restaurant restaurant =order.getRestauarant();
            RestaurantReport restaurantReport = restaurant.getRestaurantReport();
            restaurantReport.addNumberOfCompletedOrders();
            restaurantReport.addTotalAmountEarned(order.getTotal());

        }
        return "orderId: " + orderId + "  is deliverd ;-) ";
    }
	
	@Path("/getNumberOfTripsCompleted/{runnerID}")
	@GET
    public String getNumberOfTripsCompleted(@PathParam("runnerID")String runnerId) {
        Runner runner = entityManager.find(Runner.class, runnerId);

        List<Order> completedOrders = entityManager.createQuery(
                "SELECT o FROM Order o WHERE o.runner = :runner AND o.status = :status",
                Order.class)
                .setParameter("runner", runner)
                .setParameter("status", OrderStatus.DELIVERED)
                .getResultList();

        return "completed orders are: "+ completedOrders.size();
    }
	
	@Path("/rejectOrder/{orderId}/{runnerId}")
    @PUT
    public String rejectOrder(@PathParam("orderId") String orderId,@PathParam("runnerId") String runnerId) {
        Order order = entityManager.find(Order.class, orderId);

        if (order == null) {
            return "No order with this id";
        }
        if (order.getStatus() == OrderStatus.CANCELED) {
            return "the order is already canceled";
        }
        if (order.getStatus() == OrderStatus.DELIVERED) {
            return "the order is already delivered";
        }
        if (order.getStatus() == OrderStatus.DELIVERING) {
            return "the order is already accepted ";
        }
       
        Runner runner = entityManager.find(Runner.class, runnerId);
        if (runner == null) {
            return "No runner with this id";
        }
        if (!runner.isAvailable()) {
            return "Runner "+runnerId+"is not available";
        }
   
        entityManager.persist(order);
        entityManager.persist(runner);
        
        return "Order"+orderId+" is reject";
    }
	
	@Path("/acceptOrder/{orderId}/{runnerId}")
    @PUT
    public String acceptOrder(@PathParam("orderId") String orderId,@PathParam("runnerId") String runnerId) {
        Order order = entityManager.find(Order.class, orderId);

        if (order == null) {
            return "No order with this id";
        }
        if (order.getStatus() == OrderStatus.CANCELED) {
            return "the order is already canceled";
        }
        if (order.getStatus() == OrderStatus.DELIVERED) {
            return "the order is already delivered";
        }
        if (order.getStatus() == OrderStatus.DELIVERING) {
            return "the order is already accepted ";
        }
       
        Runner runner = entityManager.find(Runner.class, runnerId);
        if (runner == null) {
            return "No runner with this id";
        }
        if (!runner.isAvailable()) {
            return "Runner "+runnerId+"is not available";
        }
        order.setStatus(OrderStatus.DELIVERING);
        runner.setAvailable(false);
        entityManager.persist(order);
        entityManager.persist(runner);
        
        return "Order"+orderId+" is accepted";
    }

}//
//@Path("/runner")
//@Stateless
//@Consumes(MediaType.APPLICATION_JSON)
//@Produces(MediaType.APPLICATION_JSON)
//public class RunnerService {
//	
//	UserService us;
//	Runner runner = us.getCurrentRunner();
//	
//	@GET
//	public void checkRunner()
//	{
//		System.out.println(runner.getName());
//	}
//}
