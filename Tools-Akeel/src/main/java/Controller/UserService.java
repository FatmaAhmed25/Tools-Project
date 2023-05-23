package Controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ejb.Stateless;
import javax.persistence.*;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import entity.*;

@PermitAll
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
    @Produces(MediaType.APPLICATION_JSON)
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
                
        		String[] path = new String[] {
        			    "cmd.exe", "/c", "%JBOSS_HOME%/bin/add-user.bat",
        			    "-a",
        			    "-u", user.getUsername(),
        			    "-p", user.getPassword(),
        			    "-g", user.getRole().toString()
        			};
        		ProcessBuilder pb = new ProcessBuilder(path);
        		
        		try {
        			Process p = pb.start();		
        			
        		} catch (IOException e) {
        			// TODO Auto-generated catch block
        			e.printStackTrace();
        		}
                
            } else if (user.getRole() == Role.CUSTOMER) {
                Customer customer = new Customer();
                customer.setUsername(user.getUsername());
                customer.setPassword(user.getPassword());
                customer.setRole(user.getRole());
                em.persist(customer);
                
        		String[] path = new String[] {
        			    "cmd.exe", "/c", "%JBOSS_HOME%/bin/add-user.bat",
        			    "-a",
        			    "-u", user.getUsername(),
        			    "-p", user.getPassword(),
        			    "-g", user.getRole().toString()
        			};
        		ProcessBuilder pb = new ProcessBuilder(path);
        		
        		try {
        			Process p = pb.start();		
        			
        		} catch (IOException e) {
        			// TODO Auto-generated catch block
        			e.printStackTrace();
        		}

            }
        }
        return response;
    }
    @Path("/getUserID/{username}/{role}")
	@GET
    public String getUserID(@PathParam("username")String username,@PathParam("role")Role role)
    {
    	TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :username AND u.role = :role", User.class);
        query.setParameter("username", username);
        query.setParameter("role", role);
        List<User> users = query.getResultList();
        return users.get(0).getId();
        
    }
    @Path("/getUserPassword/{username}/{role}")
	@GET
    public String getUserPassword(@PathParam("username")String username,@PathParam("role")Role role)
    {
    	TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :username AND u.role = :role", User.class);
        query.setParameter("username", username);
        query.setParameter("role", role);
        List<User> users = query.getResultList();
        return users.get(0).getPassword();
        
    }
	@Path("/setUpRunner/{deliveryFees}")
	@POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
	public String signUpRunner(User user ,@PathParam("deliveryFees") double fees)
	{
        String response = "Signed up!";

   
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :username AND u.role = :role ", User.class);
        query.setParameter("username", user.getUsername());
        query.setParameter("role", user.getRole());
        List<User> users = query.getResultList();
        if (!users.isEmpty()) {
            response = "User already exists!";
        } 
        else {
		Runner currentRunner=new Runner();
		currentRunner.setUsername(user.getUsername());
		currentRunner.setPassword(user.getPassword());
		currentRunner.setRole(Role.RUNNER);
		currentRunner.setDeliveryFees(fees);
		currentRunner.setAvailable(true);         
		em.persist(currentRunner);
		
		String[] path = new String[] {
			    "cmd.exe", "/c", "%JBOSS_HOME%/bin/add-user.bat",
			    "-a",
			    "-u", user.getUsername(),
			    "-p", user.getPassword(),
			    "-g", user.getRole().toString()
			};
		ProcessBuilder pb = new ProcessBuilder(path);
		
		try {
			Process p = pb.start();		
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

 
        }
		return response;
}
	/*public String signUp(User user) {
	    String response = "Signed up!";
	    TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :username", User.class);
	    query.setParameter("username", user.getUsername());
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
	}*/

	
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
	@Path("/login")
	@GET
	public String login(User user)
	{
		 TypedQuery<User> query = em.createQuery(
		            "SELECT u FROM User u WHERE u.username = :username AND u.password = :password AND u.role = :role ",User.class);
		        query.setParameter("username", user.getUsername());
		        query.setParameter("password", user.getPassword());
		        query.setParameter("role", user.getRole());
		        List<User> results = query.getResultList();
		        if (results.size() >= 1) {
		            User u= results.get(0);
		            
		            return "username: ("+u.getUsername() + ")  logged in successfully with role:  ("+ u.getRole()+")" ;
		        } else
		        {
		            return "User Not Found ,SignUp first '_' ";        
		        }
	}
	
	

	
	
	// To check on all users
	@GET
	@Path("/getUsers")
	public String getUsers()
	{
		String out = "" ;
		TypedQuery<User> query = em.createQuery("SELECT u FROM User u" , User.class);
		List<User> u = query.getResultList();
		for (User i:u)
		{
			out +=i.getUsername()+" " +i.getRole() + "\n";
	
		}
		return out ;
	}
	
	// To check on all runners
	@GET
	@Path("/getRunners")
	public List<Runner> getRunners()
	{
		TypedQuery<Runner> query = em.createQuery("SELECT r FROM Runner r" , Runner.class);
		
		return query.getResultList();
	}
	
//	// To use in other classes as the logged in user
//	public User getCurrentUser() {
//		return currentUser;
//	}
//
//	public Runner getCurrentRunner() {
//		return currentRunner;
//	}
		

}