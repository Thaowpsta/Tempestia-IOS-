# Tempestia 🌤️

**Tempestia** is an intuitive and beautifully designed iOS weather application written in Swift. It provides users with up-to-date weather conditions, forecasts, and atmospheric data to help you stay prepared for whatever the weather brings.

## ✨ Features

* **Real-Time Weather:** Get accurate, current weather conditions for your exact location.
* **Detailed Forecasts:** View hourly and daily weather forecasts.
* **Location Search:** Easily search and save weather data for multiple cities worldwide.
* **Dynamic UI:** A clean, user-friendly interface that updates visually based on current weather conditions.
* **Native Performance:** Built 100% in Swift, ensuring smooth animations and fast load times.

---

## 🛠 Prerequisites

Before you begin, ensure you have met the following requirements:
* **macOS:** macOS Monterey (12.0) or later.
* **IDE:** Xcode 14.0 or later.
* **Language:** Swift 5.0+
* **Target OS:** iOS 15.0+ 

---

## 🚀 Installation & Setup

To get a local copy up and running, follow these steps:

### 1. Clone the repository
Open your terminal and run the following command to clone the project:
```sh
git clone [https://github.com/Thaowpsta/Tempestia-IOS-.git](https://github.com/Thaowpsta/Tempestia-IOS-.git)

```

### 2. Open the project

Navigate into the cloned directory and open the project in Xcode:

```sh
cd Tempestia-IOS-
open Tempestia.xcodeproj

```

---

## 🔑 API Key Configuration

This app requires a Weather API key to fetch real-time data (e.g., OpenWeatherMap, WeatherAPI). To keep your credentials secure, the API key is not included in this repository. Follow these steps to configure it locally:

### Step 1: Obtain an API Key

1. Go to your chosen weather data provider (e.g., [OpenWeatherMap](https://openweathermap.org/api)).
2. Create an account and generate a free API key.

### Step 2: Create the Configuration File

1. Open the project in Xcode.
2. In the Project Navigator (left sidebar), right-click the main `Tempestia` folder and select **New File**.
3. Choose **Swift File** and click **Next**.
4. Name the file exactly `APIConfig.swift` and click **Create**.

### Step 3: Add Your Key

Open the newly created `APIConfig.swift` file and add the following code, replacing `"YOUR_API_KEY_HERE"` with the actual key you generated:

```swift
import Foundation

struct APIConfig {
    static let weatherAPIKey = "YOUR_API_KEY_HERE"
    static let baseURL = "[https://api.openweathermap.org/data/2.5/](https://api.openweathermap.org/data/2.5/)"
}

```

### Step 4: Secure Your API Key

To ensure you don't accidentally upload your private API key to GitHub, you need to ignore this file.

1. Open terminal and navigate to the root of your project directory.
2. Open the `.gitignore` file (or create one if it doesn't exist):
```sh
nano .gitignore

```


3. Add the following line to the end of the file:
```text
# API Keys and Secrets
Tempestia/APIConfig.swift

```


4. Save and exit (in nano, press `Ctrl+O`, `Enter`, then `Ctrl+X`).

---

## ⚙️ Build and Run

1. Select your preferred iOS Simulator or connect a physical iOS device in Xcode.
2. Wait for Xcode to finish indexing and resolving any dependencies.
3. Press `Cmd + R` or click the **Play** button in the top left corner of Xcode.
4. The app will build and launch on your selected device.

---

## 🏗 Architecture & Technologies

* **Language:** [Swift](https://developer.apple.com/swift/)
* **UI Framework:** UIKit / SwiftUI *(Update to whichever framework you used)*
* **Networking:** URLSession for asynchronous API calls
* **Architecture Pattern:** MVC / MVVM *(Update to reflect your app's architecture)*
* **JSON Parsing:** `Codable` protocol

---

## 🤝 Contributing

Contributions, issues, and feature requests are always welcome!

1. Fork the project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 📫 Contact

**Thaowpsta** - [GitHub Profile](https://www.google.com/search?q=https://github.com/Thaowpsta)

Project Link: [https://github.com/Thaowpsta/Tempestia-IOS-](https://www.google.com/search?q=https://github.com/Thaowpsta/Tempestia-IOS-)

```

```
