# KDE Bismuth setup for an i3-like experience
### Enabling Bismuth
Within KDE Settings, go to **Window Management** :arrow_right: **Window Tiling** :arrow_right: **Behavior** and check _Enable window tiling_. Make sure to customize the options as one pleases but the included screenshot contains sensible defaults coming from i3: 
![Window Tiling Settings](window_tiling.png)

#### Customized Layouts
Selected layouts are left as an exercise for the configurator but sensible defaults include the following:
* Tile Layout
* Monocle Layout
* Three Column Layout
* Quarter Layout

#### Window Rules
Window rules are also left as an exercise for the configurator. Sensible suggestions are to ensure the following window classes are added to **Float Windows**:
<pre>
systemsettings,plasma-discover,dolphin
</pre>

#### Appearance
Tiling appearance is an exercise left to the reader but for uniformity, the following settings are used:
![KDE Appearance Dialog](kde_appearance.png)
> **NOTE:** __No borders around tiled windows__ option may need to be unchecked for VMs running with a MacOS host. `Alt-Shift` modifier does not seem to work on MacOS Ventura for certain key combinations.

### Setting up keyboard shortcuts

#### KWin and Tiling Shortcuts
![Import Shortcuts Scheme](import_shortcuts_scheme.png)
Select `kde/kde-wm.kksrc` as the scheme to import. Alternatively, you can load `kde/kde-amethyst.kksrc` to match Amethyst keyboard layout.

#### Open Terminal Shortcut
Previously, **Custom Shortcuts** was used to define a global shortcut for opening a terminal. However, this settings option does not exist on KDE Wayland. To mitigate, we set up an `wezterm` New Terminal shortcut that works just as well.

First, add `wezterm` as an application shortcut.
![Add Application Shortcut](kde_shortcut.png)

Then, set preferred shortcut, `Alt-Enter`, to spawn a new terminal.
![Set Keyboard Shortcut](kde_term.png)

