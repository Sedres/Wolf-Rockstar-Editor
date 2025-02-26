# w_reditor - Rockstar Editor Script for FiveM

This script allows FiveM players to access the Rockstar Editor directly in-game using the `/editor` command. It includes functionalities for recording, saving, and deleting clips, as well as taking high-quality photos.

The user interface is built using **Vue.js**, providing a modern and responsive experience. It also includes live reloading during development with `npm run watch`.

---

## 🚀 Features

- **Open Rockstar Editor:** Access the Rockstar Editor to edit recorded clips.
- **Record Clips:** Start recording in-game footage.
- **Save Clips:** Save the recorded clip to the Rockstar Editor.
- **Delete Clips:** Discard the recorded clip.
- **Take Photos:** Capture high-quality photos in-game.
- **Vue.js UI:** A responsive and dynamic user interface built with Vue.js.

---

## 📦 Installation

1. **Download and Extract:** Download this repository and extract the folder into your FiveM server under `resources/[your-folder]/w_reditor`.
2. **Add to `server.cfg`:**
   ```cfg
   ensure w_reditor
   ```
3. **Restart the server** to load the resource.

---

## 📋 Usage

- To open the editor, use the command:
  ```plaintext
  /editor
  ```

- From the NUI menu, you can:
  - **Record**: Start recording in-game.
  - **Save**: Save the recorded clip.
  - **Delete**: Discard the recorded clip.
  - **Photo**: Capture a high-quality screenshot.
  - **Open Rockstar Editor**: Launch the Rockstar Editor to edit saved clips.

---

## ⚙️ Configuration

The script uses a global configuration for language. Make sure to define the variable in `Config.languale`.

Example configuration:
```lua
Config = {
    languale = "en" -- Change to your preferred language
}
```

---

## 🛠️ Development Guide

### Prerequisites

- **Node.js** and **npm** installed on your system.
- **Vue.js** knowledge (basic level).

### Install Dependencies

Navigate to the Vue folder and install the dependencies:
```bash
cd w_reditor/vue
npm install
```

### Local Development with Live Reload

To enable live reloading during development, use:
```bash
npm run watch
```
This will automatically rebuild the project when changes are made.

### Building the UI

When you're ready to build the UI for production, use:
```bash
npm run build
```
This will compile the Vue.js project into static files **inside the `ui` folder**.

The compiled files will be located in:
```
w_reditor/ui
```

> **Note:** The `ui` folder is directly used by FiveM as the NUI interface.

### Deployment

After building the UI, make sure the contents of the `ui` folder are present on the server. This is where the compiled HTML, CSS, and JavaScript files are stored, which the NUI uses to display the interface.

---

## 🎨 Customization

You can customize the UI by modifying the Vue components in `w_reditor/vue/src/`. The main entry point is:
```js
w_reditor/vue/src/App.vue
```

Feel free to add your own styles and components to tailor the editor to your server's needs.

---

## ❗ Notes

- **Rockstar Editor** is only available in **Single Player** mode. When using this script in FiveM, **you will not be able to view the recorded clips until you switch back to Single Player.**
- This script only manages recording and capturing functions; **editing of clips is done outside of FiveM.**

---

## 🔧 Support

If you encounter any issues or have suggestions to improve this script, open an **issue** or make a **pull request** on the repository.

---

## 📄 License

This project is licensed under the **MIT License**. You are free to modify and distribute it as long as you credit the original author.

---

Enjoy creating epic content with Rockstar Editor in FiveM! 🎥

