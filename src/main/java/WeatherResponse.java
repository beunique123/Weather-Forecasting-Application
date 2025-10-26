public class WeatherResponse {
    private String city;
    private double temperatureC;
    private String condition;
    private int humidity;

    // Constructor
    public WeatherResponse(String city, double temperatureC, String condition, int humidity) {
        this.city = city;
        this.temperatureC = temperatureC;
        this.condition = condition;
        this.humidity = humidity;
    }

    // Getters (needed for Spring to convert to JSON)
    public String getCity() { return city; }
    public double getTemperatureC() { return temperatureC; }
    public String getCondition() { return condition; }
    public int getHumidity() { return humidity; }
}
