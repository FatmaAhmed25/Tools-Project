package Controller;

import javax.ejb.Stateless;
import javax.persistence.*;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import entity.*;

@Path("/runner")
@Stateless
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class RunnerService {
	
	UserService us;
	Runner runner = us.getCurrentRunner();
	
	@GET
	public void checkRunner()
	{
		System.out.println(runner.getName());
	}
}
