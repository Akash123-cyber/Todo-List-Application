# 🚀 ToDo: AI-Powered Todo List Android Application

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Hive](https://img.shields.io/badge/Hive-database-orange?style=for-the-badge)
![AI](https://img.shields.io/badge/AI-Gemini-8E75B2?style=for-the-badge)

A modern, feature-rich todo list application built with **Flutter**. This app goes beyond simple lists by integrating **Google's Generative AI** to assist with tasks, offering robust local storage via **Hive**, and providing a fully customizable user profile system.

## ✨ Key Features

### 📝 Task Management
* **Create & Track:** Easily add new tasks and mark them as complete.
* **Swipe Actions:** Intuitive swipe gestures to manage or delete tasks (powered by `flutter_slidable`).
* **Persistence:** Tasks are saved instantly using the high-performance **Hive** NoSQL database, ensuring data is never lost even when the app closes.

### 🤖 AI Integration
* **Smart Assistant:** Integrated with **Google Generative AI (Gemini)**.
* **Contextual Help:** Access AI assistance directly from specific tasks (via `AiPage`) to get suggestions, breakdowns, or creative ideas related to your to-dos.
* **Rich Text Rendering:** AI responses are rendered beautifully using Markdown and LaTeX support.

### 👤 User Profile & Customization
* **Personalized Dashboard:** Set up your profile with a name, bio, occupation, and location.
* **Profile Picture:** Upload and persist profile images using `image_picker`.
* **Data Persistence:** User preferences are stored securely using `shared_preferences`.

### 🎨 Modern UI/UX
* **Gradient Aesthetics:** A sleek, dark-themed UI with custom gradients (Deep Violet to Midnight Blue).
* **Glassmorphism:** Modern drawer design with transparent layers and blur effects.
* **Responsive Design:** Optimized layouts for various screen sizes.

---

## 🛠️ Tech Stack & Dependencies

This project relies on a robust set of packages to deliver performance and functionality:

| Category | Package | Purpose |
| :--- | :--- | :--- |
| **Framework** | `flutter` | UI Toolkit |
| **Database** | `hive`, `hive_flutter` | Fast, lightweight NoSQL database for tasks |
| **Preferences** | `shared_preferences` | Storing simple user data (Name, Age, Bio) |
| **AI** | `google_generative_ai` | Integration with Gemini API |
| **Rendering** | `flutter_markdown_latex`, `gpt_markdown` | Rendering complex AI text output |
| **Utilities** | `path_provider` | Finding filesystem paths |
| **Media** | `image_picker` | Selecting profile pictures from gallery/camera |
| **Environment** | `flutter_dotenv` | Managing API keys securely |

---

## 🚀 Getting Started

Follow these steps to get a local copy up and running.

### Prerequisites
* Flutter SDK (Version `^3.8.1` or higher)
* Dart SDK

### Installation

1.  **Clone the repository**
    ```bash
    git clone [https://github.com/yourusername/todo-app.git](https://github.com/yourusername/todo-app.git)
    cd todo-app
    ```

2.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Environment Setup (Crucial)**
    This app uses `flutter_dotenv` to manage sensitive keys (like the AI API key).
    * Create a file named `secrets.env` in the root directory.
    * Add your API keys:
        ```env
        API_KEY=your_google_ai_api_key_here
        ```

4.  **Run Code Generation**
    Since the project uses Hive with generators:
    ```bash
    dart run build_runner build
    ```

5.  **Run the App**
    ```bash
    flutter run
    ```

---

## 📂 Project Structure

```text
lib/
├── AI/
│   └── ai_page.dart         # AI Interaction logic
├── assets/
│   └── images/              # Static assets and icons
├── database/
│   └── database.dart        # Hive database methods
├── pages/
│   ├── about_page.dart      # Developer info
│   ├── home_page.dart       # Main Dashboard (Task List)
│   ├── profile_page.dart    # User Profile editing
│   └── settings.dart        # App settings
├── util/
│   ├── dialog_box.dart      # Custom dialogs for input
│   ├── todo_tile.dart       # Task list item widget
│   └── ...                  # Other UI utilities
└── main.dart                # Entry point
