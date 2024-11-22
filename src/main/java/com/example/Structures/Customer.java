package com.example.Structures;

import java.util.ArrayList;
import java.util.List;

public class Customer {
    private final String userName;
    private final int id;
    private List<Teracota> ownedTeracotas = new ArrayList<>();
    private String email;
    private String tel;

    public Customer(int id, String userName, String email, String tel) {
        this.id = id;
        this.userName = userName;
        this.email = email;
        this.tel = tel;
    }
    public String getUserName() {return userName;}
    public int getId() {return id;}
    public String getName(){return userName;}
    public String getEmail(){return email;}
    public String getTel(){return tel;}

    public void addTeracota(Teracota t) {ownedTeracotas.add(t);}
    public void removeTeracota(Teracota t) {ownedTeracotas.remove(t);}
    public List<Teracota> getOwnedTeracotas() {return ownedTeracotas;}

}
