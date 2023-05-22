package Controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.ejb.Stateless;
import javax.naming.InitialContext;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import entity.Meal;
import entity.Owner;
import entity.Restaurant;
import entity.RestaurantReport;
import entity.Role;
import entity.User;
import javax.annotation.security.RolesAllowed;

@RolesAllowed("OWNER")
@Path("/owner")
@Stateless
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class OwnerService {
	@PersistenceContext(unitName="primary")
	private EntityManager entityManager;
	//Owner owner;
	
	
	@Path("/signUpOwner")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public void signUp(Owner owner)
	{			
		entityManager.persist(owner);
	}
	@Path("/createRestaurant/{ownerID}/{name}")
    @POST
    public String createRestaurant(@PathParam("ownerID") String ownerID, @PathParam("name") String Name,List<Meal> menu) 
	{
		
        Owner owner = entityManager.find(Owner.class, ownerID);
        if (owner == null) {
            return "Owner not found";
        }
        if (Name == null) {
            return "Name is null";
        }
        if (menu.isEmpty()) {
            return "Menu is empty";
        }
        
        RestaurantReport restaurantReport=  new RestaurantReport();
        Restaurant restaurant = new Restaurant();
		restaurantReport.setRestaurant(restaurant);
	    restaurant.setRestaurantReport(restaurantReport);
	    entityManager.persist(restaurantReport);
;        restaurant.setName(Name);
        //restaurant.setMeals(menu);
        restaurant.setOwner(owner);
    
        for (Meal meal:menu)
        {
        	meal.setRestaurant(restaurant);
        	
        	restaurant.getMeals().add(meal);
        	entityManager.persist(meal);
        }
  
        entityManager.persist(restaurant);
        
        System.out.println("Restaurant added with id " + restaurant.getId()+restaurant.printMenu());
        
        return "Restaurant added with id " + restaurant.getId()+"  \n"+restaurant.printMenu();
    }
	
	@Path("/getRestaurant/{RestuarantID}")
	@GET
	public String getRestaurant(@PathParam("RestuarantID") int restaurantId) {
	    String output = "";
	    Restaurant restaurant = entityManager.find(Restaurant.class, restaurantId);
	    if (restaurant != null) {
	        output = restaurant.printMenu();
	    } else {
	        output = "Restaurant not found.";
	    }
	    return output;
	}
	
	@Path("/getRestaurantReport/{ownerID}")
	@GET
	public String getRestaurantReport(@PathParam("ownerID") String ownerID)
	{
		
		String output="";
        Owner owner = entityManager.find(Owner.class, ownerID);
        Restaurant restaurant =owner.getRestaurants();
		RestaurantReport resturantReport= restaurant.getRestaurantReport();		
		return resturantReport.toString();
	}
	
	
	@Path("/getMeals")
    @GET
    public String getMeals()
    {
        String output="";
        TypedQuery<Meal> query = entityManager.createQuery("SELECT u FROM Meal u " , Meal.class);
        List<Meal> list=query.getResultList();
        for(int i=0;i<list.size();i++)
        {
            output+="RestaurantID: "+list.get(i).getRestaurant().getId()+" - Meal Name: "+list.get(i).getName()+" - Price: "+list.get(i).getPrice()+" - Description: "+list.get(i).getDescription()+"\n";
        }
        return output;
    }
	
/*	
	@Path("/createMenu")
	@POST
	public String createRestaurantMenu(Owner owner,List<Meal> menuItems,int restaurantId)
	{
		if(menuItems != null) {
			Restaurant restaurant = owner.getRestaurants();
			//menuItems.setRestaurant(restauraunt);
			restaurant.setMeals(menuItems);
			entityManager.persist(menuItems);
			return "Menu : "+menuItems;
		}
		return "Menu items are null";
	}
	*/
//	public String login(Owner owner)
//	{
//		this.owner=owner;
//		return "logged in successfully";
//	}
	@Path("/editMealName/{ownerID}/{restaurantId}/{mealID}/{name}")
	@PUT
	public String editMealNameInMenu(@PathParam("ownerID")String ownerID,@PathParam("restaurantId")int restaurantId,@PathParam("mealID")int mealID,@PathParam("name")String name)
	{
		Owner owner = entityManager.find(Owner.class, ownerID);
		Restaurant restaurant = entityManager.find(Restaurant.class, restaurantId);
		Meal meal =entityManager.find(Meal.class, mealID);
		meal.setName(name);		
		return restaurant.printMenu();
		
	}
//	@Path("/editMealPrice")
//	@PUT
//	public String editMealPriceInMenu(Owner owner,int restaurantId,int mealID,Double price)
//	{
//		Restaurant restaurant = entityManager.find(Restaurant.class, restaurantId);
//		Meal meal =entityManager.find(Meal.class, mealID);
//		meal.setPrice(mealID);
//		
//		return null;
//		
//	}
//	@Path("/getRestaurantReport")
//	@GET
//	public String getRestaurantReport(Owner owner,int restaurantId)
//	{
//		Restaurant restaurant = entityManager.find(Restaurant.class, restaurantId);
//		
//		return restaurant.getReport().toString();
//	}
	
	
	
	
}
