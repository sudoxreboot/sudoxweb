<table word-break="normal">
  <tr>
    <td width="250" height="150" align="center" valign="middle">
      <img src="screenshots/sudoxweb_landing.png" width="250" height="150" style="object-fit: contain;">
    </td>
    <td width="250" height="150" align="center" valign="middle">
      <img src="screenshots/sudoxweb_general_settings.png" width="250" height="150" style="object-fit: contain;">
    </td>
    <td width="250" height="150" align="center" valign="middle">
      <img src="screenshots/sudoxweb_appearance_settings.png" width="250" height="150" style="object-fit: contain;">
    </td>
    <td width="250" height="150" align="center" valign="middle">
      <img src="screenshots/sudoxweb_favorites_settings.png" width="250" height="150" style="object-fit: contain;">
    </td>
  </tr>
</table>


# sudoxweb

a collection of plasma 6 desktop widgets built by [sudoxreboot](https://sudoxreboot.com).

---

## widgets

### sudox web viewer
embed any webpage directly on your plasma 6 desktop. built for frigate but works with anything — dashboards, cameras, local services, whatever.

**features**
- persistent sessions and cookies
- configurable url with settings panel
- favorites (up to 5) with custom names
- optional address bar with back, forward, home buttons
- transparent background support
- widget, button, and text opacity sliders
- text color picker
- private mode
- hideable toolbar overlay
- clear cache button

### sudox steam launcher
a compact plasma 6 widget for launching and stopping steam games. auto-detects your steam library regardless of install method (native, flatpak, snap).

**features**
- auto-discovers all installed steam games
- works with native, flatpak, and snap steam installs
- launch/stop toggle with live running state detection
- liquid glass aesthetic
- refresh button to rescan library

---

## requirements
- kde plasma 6
- `plasma5support` package (usually installed by default)
- for steam launcher: python3 (standard on most distros)

## install
```bash
git clone https://github.com/sudoxreboot/sudoxweb
cd sudoxweb
bash install.sh
```

then restart plasmashell:
```bash
kquitapp6 plasmashell && plasmashell > /dev/null 2>&1 &
```

add widgets by right-clicking your desktop → "add widgets" → search "sudox"

## uninstall
```bash
bash uninstall.sh
```

## more projects
[sudoxreboot.com](https://sudoxreboot.com)
