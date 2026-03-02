import QtQuick
import QtWebEngine
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root
    width: 400
    height: 300

    Plasmoid.backgroundHints: Plasmoid.configuration.transparentBg ? PlasmaCore.Types.NoBackground : PlasmaCore.Types.DefaultBackground

    fullRepresentation: Item {
        anchors.fill: parent
        opacity: Plasmoid.configuration.widgetOpacity / 100

        property color btnTextColor: Qt.rgba(
            parseInt(Plasmoid.configuration.textColor.substring(1,3), 16) / 255,
            parseInt(Plasmoid.configuration.textColor.substring(3,5), 16) / 255,
            parseInt(Plasmoid.configuration.textColor.substring(5,7), 16) / 255,
            Plasmoid.configuration.textOpacity / 100
        )

        WebEngineProfile {
            id: webProfile
            storageName: Plasmoid.configuration.privateMode ? "" : "sudoxweb"
            persistentStoragePath: Plasmoid.configuration.privateMode ? "" : "$HOME/.local/share/sudoxweb"
            httpCacheType: Plasmoid.configuration.privateMode ? WebEngineProfile.MemoryHttpCache : WebEngineProfile.DiskHttpCache
            persistentCookiesPolicy: Plasmoid.configuration.privateMode ? WebEngineProfile.NoPersistentCookies : WebEngineProfile.ForcePersistentCookies
            offTheRecord: Plasmoid.configuration.privateMode
        }

        WebEngineView {
            id: webview
            anchors.fill: parent
            profile: webProfile
            url: Plasmoid.configuration.url !== "" ? Plasmoid.configuration.url : Qt.resolvedUrl("landing.html")
        }

        Item {
            id: toolbar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: Math.max(36, parent.width * 0.05)
            z: 10
            visible: !Plasmoid.configuration.hideToolbar

            property int btnSize: Math.min(toolbar.height - 6, toolbar.height - 6)
            property real btnFontSize: btnSize * 0.45
            property color tc: parent.btnTextColor
            property real bop: Plasmoid.configuration.buttonOpacity / 100

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 4
                anchors.rightMargin: 4
                spacing: 2

                Button {
                    Layout.preferredWidth: toolbar.btnSize
                    Layout.preferredHeight: toolbar.btnSize
                    background: Rectangle { radius: width/2; color: Qt.rgba(1,1,1, toolbar.bop) }
                    contentItem: Text { text: "‹"; color: toolbar.tc; font.pixelSize: toolbar.btnFontSize; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                    onClicked: webview.goBack()
                }
                Button {
                    Layout.preferredWidth: toolbar.btnSize
                    Layout.preferredHeight: toolbar.btnSize
                    background: Rectangle { radius: width/2; color: Qt.rgba(1,1,1, toolbar.bop) }
                    contentItem: Text { text: "›"; color: toolbar.tc; font.pixelSize: toolbar.btnFontSize; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                    onClicked: webview.goForward()
                }
                Button {
                    Layout.preferredWidth: toolbar.btnSize
                    Layout.preferredHeight: toolbar.btnSize
                    background: Rectangle { radius: width/2; color: Qt.rgba(1,1,1, toolbar.bop) }
                    contentItem: Text { text: "↻"; color: toolbar.tc; font.pixelSize: toolbar.btnFontSize; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                    onClicked: webview.reload()
                }
                Button {
                    Layout.preferredWidth: toolbar.btnSize
                    Layout.preferredHeight: toolbar.btnSize
                    visible: Plasmoid.configuration.showAddressBar
                    background: Rectangle { radius: width/2; color: Qt.rgba(1,1,1, toolbar.bop) }
                    contentItem: Text { text: "⌂"; color: toolbar.tc; font.pixelSize: toolbar.btnFontSize; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                    onClicked: webview.url = Plasmoid.configuration.url
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: toolbar.btnSize
                    radius: height / 2
                    color: Qt.rgba(1,1,1, toolbar.bop)
                    visible: Plasmoid.configuration.showAddressBar

                    TextInput {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        verticalAlignment: TextInput.AlignVCenter
                        color: toolbar.tc
                        font.pixelSize: toolbar.btnFontSize * 0.8
                        clip: true
                        text: webview.url
                        onAccepted: webview.url = text
                    }
                }

                Item { Layout.fillWidth: true; visible: !Plasmoid.configuration.showAddressBar }

                Button {
                    Layout.preferredWidth: toolbar.btnSize
                    Layout.preferredHeight: toolbar.btnSize
                    visible: Plasmoid.configuration.showAddressBar && (
                        Plasmoid.configuration.fav1url !== "" || Plasmoid.configuration.fav2url !== "" ||
                        Plasmoid.configuration.fav3url !== "" || Plasmoid.configuration.fav4url !== "" ||
                        Plasmoid.configuration.fav5url !== "")
                    background: Rectangle { radius: width/2; color: Qt.rgba(1,1,1, toolbar.bop) }
                    contentItem: Text { text: "★"; color: toolbar.tc; font.pixelSize: toolbar.btnFontSize; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                    onClicked: favsMenu.open()
                    Menu {
                        id: favsMenu
                        MenuItem { text: Plasmoid.configuration.fav1name || Plasmoid.configuration.fav1url; visible: Plasmoid.configuration.fav1url !== ""; onTriggered: webview.url = Plasmoid.configuration.fav1url }
                        MenuItem { text: Plasmoid.configuration.fav2name || Plasmoid.configuration.fav2url; visible: Plasmoid.configuration.fav2url !== ""; onTriggered: webview.url = Plasmoid.configuration.fav2url }
                        MenuItem { text: Plasmoid.configuration.fav3name || Plasmoid.configuration.fav3url; visible: Plasmoid.configuration.fav3url !== ""; onTriggered: webview.url = Plasmoid.configuration.fav3url }
                        MenuItem { text: Plasmoid.configuration.fav4name || Plasmoid.configuration.fav4url; visible: Plasmoid.configuration.fav4url !== ""; onTriggered: webview.url = Plasmoid.configuration.fav4url }
                        MenuItem { text: Plasmoid.configuration.fav5name || Plasmoid.configuration.fav5url; visible: Plasmoid.configuration.fav5url !== ""; onTriggered: webview.url = Plasmoid.configuration.fav5url }
                    }
                }

                Button {
                    Layout.preferredWidth: toolbar.btnSize
                    Layout.preferredHeight: toolbar.btnSize
                    background: Rectangle { radius: width/2; color: Qt.rgba(1,1,1, toolbar.bop) }
                    contentItem: Text { text: "⌫"; color: toolbar.tc; font.pixelSize: toolbar.btnFontSize; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                    onClicked: { webProfile.clearHttpCache(); webProfile.clearAllVisitedLinks(); webview.reload() }
                }
            }
        }
    }
}
