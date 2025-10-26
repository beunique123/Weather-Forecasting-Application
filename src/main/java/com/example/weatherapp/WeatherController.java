package com.example.weatherapp;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Collections;

@RestController
public class WeatherController {

    // --- CONFIGURATION: REPLACE THIS KEY ---
    private final String API_KEY = "b9cb385fb93d00c2730443f3dcc3eff5"; // <<-- REPLACE THIS!
    private final String API_URL = "https://api.openweathermap.org/data/2.5/weather?q={city}&appid={key}&units=metric";

    // --- API ENDPOINT ---
    @GetMapping("/api/weather")
    public WeatherResponse getWeather(@RequestParam String city) {
        
        // Use a RestTemplate to make the HTTP request
        RestTemplate restTemplate = new RestTemplate();
        
        try {
            // The request is made, substituting {city} and {key}
            String jsonResponse = restTemplate.getForObject(
                API_URL, 
                String.class, 
                city, 
                API_KEY
            );

            // Parse JSON Data (using Jackson)
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(jsonResponse);

            // Extract relevant metrics from the complex JSON structure
            double temp = root.path("main").path("temp").asDouble();
            int humidity = root.path("main").path("humidity").asInt();
            
            // Extract condition text from the 'weather' array
            String condition = root.path("weather").get(0).path("description").asText();
            String cityName = root.path("name").asText();

            // Return the simplified data object
            return new WeatherResponse(cityName, temp, condition, humidity);
            
        } catch (Exception e) {
            // If city not found or network fails, return an error message
            System.err.println("Error fetching weather: " + e.getMessage());
            return new WeatherResponse(city, 0.0, "Data Unavailable/City Not Found", 0);
        }
    }
}
