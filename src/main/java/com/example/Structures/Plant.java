package com.example.Structures;

public class Plant {
        private Teracota.PlantTypes plantType;
        private int growDays;
        private int price;
        public Plant(Teracota.PlantTypes pt, int growDays,int price)
        {
            plantType = pt;
            this.growDays = growDays;
            this.price = price;
        }
        public Teracota.PlantTypes getPlantTypes() {return plantType;}
        public int getGrowDays() {return growDays;}
        public int getPrice() {return price;}

}
