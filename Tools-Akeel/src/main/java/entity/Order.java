package entity;

import java.util.ArrayList;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
@Entity
public class Order {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private String id;
	private ArrayList<Item> items;
	private double total;
	@ManyToOne
	@JoinColumn(name = "runnerID")
	private Runner runnerID;
	@ManyToOne
	@JoinColumn(name = "resturantID")
	private Resturant resturantID;
	@Enumerated(EnumType.ORDINAL)
	private Status status;
}
