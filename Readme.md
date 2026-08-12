# Frieren Animated SDDM Theme

<video src="https://github.com/itzbetalgeuse/frieren-animated-sddm/raw/main/preview.webm" controls="controls" muted="muted" width="100%"></video>

An animated, minimalist, and elegant (glassmorphism style) SDDM login theme based on *Sousou no Frieren*, built with Qt6.

## Dependencies

Make sure you have the Qt6 multimedia components installed in your system so the looping video and visual effects work correctly.

* **Fedora:**
  ```bash
  sudo dnf install qt6-qtmultimedia qt6-qtdeclarative
  ```

* **Arch Linux:**
  ```bash
  sudo pacman -S qt6-multimedia qt6-declarative
  ```

* **Ubuntu/Kubuntu/Debian (Qt6):**
  ```bash
  sudo apt install qml6-module-qtmultimedia qml6-module-qtquick-effects gstreamer1.0-libav gstreamer1.0-plugins-bad ubuntu-restricted-extras
  ```

## Automatic Installation

Clone the repository and run the installation script with root privileges:

```bash
git clone https://github.com/ItzBetalgeuse/frieren-animated-sddm.git
cd frieren-animated-sddm
chmod +x install.sh
sudo ./install.sh
```

## Preview without rebooting

If you want to test how the theme looks before logging out or rebooting your system, you can run the SDDM greeter in test mode:

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/frieren-animated
```

## Note

This theme is designed for **Qt6-based SDDM** (which is the default on modern distributions like Fedora 40+, KDE Neon, and Arch Linux with Plasma 6). If your system still uses Qt5 for SDDM, some visual effects (like the glow and glassmorphism) or video rendering might not work as intended.
