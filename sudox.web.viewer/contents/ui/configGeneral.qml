import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ColumnLayout {
    property alias cfg_url: urlField.text
    property alias cfg_showAddressBar: addressBarCheck.checked
    property alias cfg_hideToolbar: hideToolbarCheck.checked
    property alias cfg_privateMode: privateModeCheck.checked
    spacing: 16

    Rectangle {
        Layout.fillWidth: true
        height: urlCol.implicitHeight + 24
        radius: 8
        color: Qt.rgba(1,1,1,0.05)

        ColumnLayout {
            id: urlCol
            anchors { fill: parent; margins: 12 }
            spacing: 8

            Label { text: "home url"; font.bold: true; color: "#87ffea" }

            TextField {
                id: urlField
                Layout.fillWidth: true
                placeholderText: "https://..."
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        height: optCol.implicitHeight + 24
        radius: 8
        color: Qt.rgba(1,1,1,0.05)

        ColumnLayout {
            id: optCol
            anchors { fill: parent; margins: 12 }
            spacing: 8

            Label { text: "browser"; font.bold: true; color: "#87ffea" }
            CheckBox { id: addressBarCheck; text: "show address bar" }
            CheckBox { id: hideToolbarCheck; text: "hide toolbar overlay" }
            CheckBox { id: privateModeCheck; text: "private mode" }
        }
    }
}
