package Controller;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.*;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import entity.*;


@Stateless
@Path("/user")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class UserService {
	
	@PersistenceContext
	EntityManager em ;
	User currentUser;
	Runner currentRunner = new Runner();
	
	
	@Path("/signUp")
	@POST
	public String signUp(User user)
	{
		String response ="Signed up !";
		
		if (user.getRole()== Role.RUNNER)
		{
			currentRunner.setName(user.getName());
			response = "Navigate to setUpRunner to apply delivery fees";
		}		
		
		em.persist(user);
		
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