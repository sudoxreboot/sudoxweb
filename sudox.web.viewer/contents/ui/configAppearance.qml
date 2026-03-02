import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

ColumnLayout {
    property alias cfg_widgetOpacity: widgetSlider.value
    property alias cfg_textOpacity: textSlider.value
    property alias cfg_buttonOpacity: buttonSlider.value
    property alias cfg_transparentBg: transparentCheck.checked
    property alias cfg_textColor: colorField.text
    spacing: 16

    Rectangle {
        Layout.fillWidth: true
        height: opCol.implicitHeight + 24
        radius: 8
        color: Qt.rgba(1,1,1,0.05)

        ColumnLayout {
            id: opCol
            anchors { fill: parent; margins: 12 }
            spacing: 12

            Label { text: "appearance"; font.bold: true; color: "#87ffea" }

            CheckBox { id: transparentCheck; text: "transparent widget background" }

            RowLayout {
                Label { text: "widget opacity"; Layout.preferredWidth: 140 }
                Slider { id: widgetSlider; from: 1; to: 100; stepSize: 1; Layout.fillWidth: true }
                Label { text: widgetSlider.value + "%"; Layout.preferredWidth: 36 }
            }

            RowLayout {
                Label { text: "text opacity"; Layout.preferredWidth: 140 }
                Slider { id: textSlider; from: 0; to: 100; stepSize: 1; Layout.fillWidth: true }
                Label { text: textSlider.value + "%"; Layout.preferredWidth: 36 }
            }

            RowLayout {
                Label { text: "button opacity"; Layout.preferredWidth: 140 }
                Slider { id: buttonSlider; from: 0; to: 100; stepSize: 1; Layout.fillWidth: true }
                Label { text: buttonSlider.value + "%"; Layout.preferredWidth: 36 }
            }

            RowLayout {
                Label { text: "text color"; Layout.preferredWidth: 140 }
                TextField {
                    id: colorField
                    Layout.preferredWidth: 100
                    placeholderText: "#ffffff"
                }
                Rectangle {
                    width: 28; height: 28
                    radius: 4
                    color: colorField.text || "#ffffff"
                    border.color: Qt.rgba(1,1,1,0.2)
                    MouseArea {
                        anchors.fill: parent
                        onClicked: colorDialog.open()
                    }
                }
            }
        }
    }

    ColorDialog {
        id: colorDialog
        onAccepted: colorField.text = selectedColor
    }
}
