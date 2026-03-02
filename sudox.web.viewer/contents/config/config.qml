import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
        name: "general"
        icon: "configure"
        source: "configGeneral.qml"
    }
    ConfigCategory {
        name: "appearance"
        icon: "preferences-desktop-color"
        source: "configAppearance.qml"
    }
    ConfigCategory {
        name: "favorites"
        icon: "bookmarks"
        source: "configFavorites.qml"
    }
}
