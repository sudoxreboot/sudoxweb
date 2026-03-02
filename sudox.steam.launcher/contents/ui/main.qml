import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasma5support as Plasma5Support

PlasmoidItem {
    id: root
    width: 320
    height: 60

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    property var games: []
    property string runningAppId: ""

    function loadGames() {
        var script = "python3 -c \"\nimport os,glob,re\n" +
            "home=os.path.expanduser('~')\n" +
            "paths=[\n" +
            "  home+'/.steam/steam/steamapps',\n" +
            "  home+'/.local/share/Steam/steamapps',\n" +
            "  home+'/.var/app/com.valvesoftware.Steam/data/Steam/steamapps',\n" +
            "]\n" +
            "found=set()\n" +
            "for p in paths:\n" +
            "  for f in glob.glob(os.path.join(p,'appmanifest_*.acf')):\n" +
            "    try:\n" +
            "      t=open(f).read()\n" +
            "      a=re.search(r'\\\\\"appid\\\\\"\\\\s+\\\\\"(\\\\d+)\\\\\"',t)\n" +
            "      n=re.search(r'\\\\\"name\\\\\"\\\\s+\\\\\"([^\\\\\"]+)\\\\\"',t)\n" +
            "      if a and n:\n" +
            "        k=a.group(1)\n" +
            "        if k not in found:\n" +
            "          found.add(k)\n" +
            "          print(k+'|'+n.group(1))\n" +
            "    except: pass\n" +
            "\""
        gameLoader.connectSource(script)
    }

    Plasma5Support.DataSource {
        id: gameLoader
        engine: "executable"
        onNewData: function(source, data) {
            var lines = (data["stdout"] || "").trim().split("\n")
            var result = []
            for (var i = 0; i < lines.length; i++) {
                var parts = lines[i].split("|")
                if (parts.length === 2 && parts[0].trim() !== "")
                    result.push({ appid: parts[0].trim(), name: parts[1].trim() })
            }
            result.sort(function(a,b){ return a.name.localeCompare(b.name) })
            games = result
            disconnectSource(source)
        }
    }

    Plasma5Support.DataSource {
        id: runChecker
        engine: "executable"
        connectedSources: ["bash -c \"ps aux | grep -oP '(?<=AppId=)[0-9]+' | head -1\""]
        interval: 5000
        onNewData: function(source, data) {
            runningAppId = (data["stdout"] || "").trim()
        }
    }

    Plasma5Support.DataSource {
        id: cmdRunner
        engine: "executable"
        onNewData: function(source, data) { disconnectSource(source) }
        function run(cmd) { connectSource(cmd) }
    }

    Component.onCompleted: loadGames()

    fullRepresentation: Item {
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            radius: 16
            color: Qt.rgba(0.05, 0.05, 0.1, 0.85)
            border.color: Qt.rgba(1,1,1,0.08)
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height * 0.4
                radius: 16
                color: Qt.rgba(1,1,1,0.04)
            }
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 8

            ComboBox {
                id: gameCombo
                Layout.fillWidth: true
                model: games
                textRole: "name"
                displayText: games.length === 0 ? "no games found" : (currentIndex >= 0 && currentIndex < games.length ? games[currentIndex].name : "select game...")
                background: Rectangle { radius: 8; color: Qt.rgba(1,1,1,0.07); border.color: Qt.rgba(1,1,1,0.12) }
                contentItem: Text {
                    leftPadding: 8
                    text: gameCombo.displayText
                    color: "white"; font.pixelSize: 13
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            }

            Button {
                width: 80; height: 36
                enabled: gameCombo.currentIndex >= 0 && games.length > 0
                background: Rectangle {
                    radius: 8
                    color: {
                        if (!parent.enabled) return Qt.rgba(0.3,0.3,0.3,0.4)
                        var appid = games[gameCombo.currentIndex]?.appid
                        return appid && appid === runningAppId ? Qt.rgba(0.8,0.1,0.1,0.7) : Qt.rgba(0.1,0.6,0.3,0.7)
                    }
                    border.color: Qt.rgba(1,1,1,0.15)
                }
                contentItem: Text {
                    text: {
                        var appid = games[gameCombo.currentIndex]?.appid
                        return appid && appid === runningAppId ? "stop" : "launch"
                    }
                    color: "white"; font.pixelSize: 13; font.bold: true
                    horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    var appid = games[gameCombo.currentIndex]?.appid
                    if (!appid) return
                    if (appid === runningAppId) {
                        cmdRunner.run("bash -c \"pkill -f 'AppId=" + appid + "' 2>/dev/null; true\"")
                    } else {
                        cmdRunner.run("bash -c \"(which steam >/dev/null 2>&1 && steam steam://rungameid/" + appid + ") || (flatpak run com.valvesoftware.Steam steam://rungameid/" + appid + " 2>/dev/null) || (snap run steam steam://rungameid/" + appid + " 2>/dev/null) &\"")
                    }
                }
            }

            Button {
                width: 36; height: 36
                background: Rectangle { radius: 8; color: Qt.rgba(1,1,1,0.07); border.color: Qt.rgba(1,1,1,0.12) }
                contentItem: Text { text: "↻"; color: "white"; font.pixelSize: 16; horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter }
                onClicked: loadGames()
            }
        }
    }
}
