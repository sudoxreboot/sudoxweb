import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    property alias cfg_fav1url: fav1url.text
    property alias cfg_fav1name: fav1name.text
    property alias cfg_fav2url: fav2url.text
    property alias cfg_fav2name: fav2name.text
    property alias cfg_fav3url: fav3url.text
    property alias cfg_fav3name: fav3name.text
    property alias cfg_fav4url: fav4url.text
    property alias cfg_fav4name: fav4name.text
    property alias cfg_fav5url: fav5url.text
    property alias cfg_fav5name: fav5name.text
    spacing: 16

    Rectangle {
        Layout.fillWidth: true
        height: favCol.implicitHeight + 24
        radius: 8
        color: Qt.rgba(1,1,1,0.05)

        ColumnLayout {
            id: favCol
            anchors { fill: parent; margins: 12 }
            spacing: 8

            Label { text: "favorites"; font.bold: true; color: "#87ffea" }

            RowLayout {
                Label { text: "1:"; Layout.preferredWidth: 20 }
                TextField { id: fav1name; Layout.preferredWidth: 120; placeholderText: "name" }
                TextField { id: fav1url; Layout.fillWidth: true; placeholderText: "https://..." }
            }
            RowLayout {
                Label { text: "2:"; Layout.preferredWidth: 20 }
                TextField { id: fav2name; Layout.preferredWidth: 120; placeholderText: "name" }
                TextField { id: fav2url; Layout.fillWidth: true; placeholderText: "https://..." }
            }
            RowLayout {
                Label { text: "3:"; Layout.preferredWidth: 20 }
                TextField { id: fav3name; Layout.preferredWidth: 120; placeholderText: "name" }
                TextField { id: fav3url; Layout.fillWidth: true; placeholderText: "https://..." }
            }
            RowLayout {
                Label { text: "4:"; Layout.preferredWidth: 20 }
                TextField { id: fav4name; Layout.preferredWidth: 120; placeholderText: "name" }
                TextField { id: fav4url; Layout.fillWidth: true; placeholderText: "https://..." }
            }
            RowLayout {
                Label { text: "5:"; Layout.preferredWidth: 20 }
                TextField { id: fav5name; Layout.preferredWidth: 120; placeholderText: "name" }
                TextField { id: fav5url; Layout.fillWidth: true; placeholderText: "https://..." }
            }
        }
    }
}
