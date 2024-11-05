package com.example.chilliweb;

import com.example.Controlers.ChiliPeperApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ChilliWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChilliWebApplication.class, args);
		ChiliPeperApplication.run();
	}

}
