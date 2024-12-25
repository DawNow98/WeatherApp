Weather App 🌤

Purpose
This Weather App provides users with real-time weather information for their current location or a default location if access to the device's location is denied. The app uses the OpenWeatherMap API to fetch accurate and up-to-date weather data, including temperature, weather conditions, and timezone.

The app is designed to showcase clean and user-friendly UI elements, featuring dynamic backgrounds that change based on the weather and time of day (day/night).

Features
1. Fetches real-time weather data using OpenWeatherMap API.
2. Displays key weather information:
- Current temperature (rounded to the nearest whole number).
- General weather condition (e.g., Clear, Cloudy).
- Detailed weather description.
- Timezone of the location.
3. Dynamic background updates to reflect weather conditions (e.g., sunny, cloudy, snowy) and time of day.
4. Handles location services:
- Fetches weather for the user’s location.
- Defaults to Aarhus weather when location access is denied.
5.Responsive design built with SwiftUI.

Skills Demonstrated
1. Integration with a RESTful API:
- Used OpenWeatherMap API to fetch and decode JSON weather data.
- Handled API keys securely by using environment variables to prevent exposing sensitive information.
2. SwiftUI for UI Development:
- Built a user-friendly interface using modern SwiftUI components.
- Designed a dynamic background system that updates based on weather conditions and the time of day.
3. Location Services:
- Integrated CoreLocation to determine the user's geographic location.
- Provided a fallback mechanism for denied location access.
4. State Management with Combine:
- Managed UI updates in real-time using @StateObject and @Published.
5. Error Handling:
- Implemented robust error handling for API calls and location services.

How to Run
1. Clone the repository:
- git clone https://github.com/your-username/weather-app.git
2. Open the project in Xcode.
3. Add your API key securely:
- Create a .xcconfig file or add an environment variable for API_KEY.
4. Build and run the app on a simulator or device.
  
Preview

The app dynamically updates to provide an engaging user experience, making it an ideal project to demonstrate skills in Swift, SwiftUI, and working with external APIs.
