package Controller;

import java.util.List;

import javax.annotation.security.RolesAllowed;
import javax.ejb.Stateless;
import javax.persistence.*;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import entity.*;

//@RolesAllowed("*")
@Stateless
@Path("/user")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class UserService {
	
	@PersistenceContext
	EntityManager em ;
	
    @Path("/signUp")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String signUp(User user) {
        String response = "Signed up!";
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :username AND u.role = :role", User.class);
        query.setParameter("username", user.getUsername());
        query.setParameter("role", user.getRole());
        List<User> users = query.getResultList();
        if (!users.isEmpty()) {
            response = "User already exists!";
        } else {
            if (user.getRole() == Role.RUNNER) {
                response = "Navigate to setUpRunner to apply delivery fees";
            } else if (user.getRole() == Role.OWNER) {
                Owner owner = new Owner();
                owner.setUsername(user.getUsername());
                owner.setPassword(user.getPassword());
                owner.setRole(user.getRole());
                em.persist(owner);
            } else if (user.getRole() == Role.CUSTOMER) {
                Customer customer = new Customer();
                customer.setUsername(user.getUsername());
                customer.setPassword(user.getPassword());
                customer.setRole(user.getRole());
                em.persist(customer);
            }
        }
        return response;
    }
    
	@Path("/setUpRunner/{deliveryFees}")
	@POST
	public void signUpRunner(@PathParam("deliveryFees") double fees)
	{
		currentRunner.setDeliveryFees(fees);
		currentRunner.setAvailable(true);
		em.persist(currentRunner);
	}
	
	@Path("/login")
	@POST
	public void login(User user)  // momkn diff login for runner kaman
	{
		// currentUser -- > user from json
	}
	
	
	// To check on all users
	@GET
	@Path("/getUsers")
	public List<User> getUsers()
	{
		TypedQuery<User> query = em.createQuery("SELECT u FROM User u" , User.class);
		
		return query.getResultList();
	}
	
	// To check on all runners
	@GET
	@Path("/getRunners")
	public List<Runner> getRunners()
	{
		TypedQuery<Runner> query = em.createQuery("SELECT r FROM Runner r" , Runner.class);
		
		return query.getResultList();
	}
	
	// To use in other classes as the logged in user
	public User getCurrentUser() {
		return currentUser;
	}

	public Runner getCurrentRunner() {
		return currentRunner;
	}
		

}