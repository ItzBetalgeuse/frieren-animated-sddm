import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Effects

Item {
    id: root
    width: Screen.width
    height: Screen.height

    // 1. OTF Custom font
    FontLoader {
        id: frierenFont
        source: Qt.resolvedUrl("fonts/Frieren.otf")
    }

    // 2. Dynamic bg
    MediaPlayer {
        id: bgVideo
        source: "assets/frieren-loop.webm"
        loops: MediaPlayer.Infinite
        autoPlay: true
        videoOutput: outputDeVideo
    }

    VideoOutput {
        id: outputDeVideo
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectCrop
    }

    Component {
        id: decorativeLineComponent
        Item {
            Rectangle {
                anchors.left: parent.left
                anchors.right: centerIcon.left
                anchors.rightMargin: 12
                anchors.verticalCenter: parent.verticalCenter
                height: 2
                color: "#ffffff"
                layer.enabled: true
                layer.effect: MultiEffect { shadowEnabled: true; shadowColor: "#ffffff"; shadowBlur: 0.6; shadowHorizontalOffset: 0; shadowVerticalOffset: 0 }
            }

            Rectangle {
                id: centerIcon
                anchors.centerIn: parent
                width: 8
                height: 8
                rotation: 45
                color: "transparent"
                border.color: "#ffffff"
                border.width: 1.5
                layer.enabled: true
                layer.effect: MultiEffect { shadowEnabled: true; shadowColor: "#ffffff"; shadowBlur: 0.6; shadowHorizontalOffset: 0; shadowVerticalOffset: 0 }
            }

            Rectangle {
                anchors.left: centerIcon.right
                anchors.leftMargin: 12
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                height: 2
                color: "#ffffff"
                layer.enabled: true
                layer.effect: MultiEffect { shadowEnabled: true; shadowColor: "#ffffff"; shadowBlur: 0.6; shadowHorizontalOffset: 0; shadowVerticalOffset: 0 }
            }
        }
    }

    // 3. Session selector
    ComboBox {
        id: sessionSelector
        anchors {
            top: parent.top
            right: parent.right
            topMargin: 40
            rightMargin: 50
        }

        model: sessionModel
        textRole: "name"
        currentIndex: sessionModel.lastIndex
        hoverEnabled: true
        background: Item {}
        indicator: Item {}

        contentItem: Text {
            text: sessionSelector.currentText
            font.family: frierenFont.name
            font.pixelSize: 18
            color: sessionSelector.hovered ? "#e6d9ff" : "#ffffff"
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter

            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: "#ffffff"
                shadowBlur: 0.6
                shadowHorizontalOffset: 0
                shadowVerticalOffset: 0
            }
        }
    }

    // 4. Login
    Rectangle {
        id: loginPanel
        width: 450

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: 80
            topMargin: 100
            bottomMargin: 100
        }

        color: "transparent"

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 25
            width: parent.width * 0.85

            Image {
                source: "assets/frieren-logo.png"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 375
                Layout.maximumHeight: 180
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 380
                implicitHeight: formLayout.implicitHeight + 50
                radius: 20
                color: "#0D000000"
                border.width: 0

                ColumnLayout {
                    id: formLayout
                    anchors.centerIn: parent
                    spacing: 18
                    width: 320

                    Loader {
                        sourceComponent: decorativeLineComponent
                        Layout.fillWidth: true
                        Layout.preferredHeight: 12
                    }

                    ComboBox {
                        id: userSelector
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 280

                        model: userModel
                        textRole: "name"
                        currentIndex: userModel.lastIndex

                        background: Item {}
                        indicator: Item {}

                        contentItem: Text {
                            text: userSelector.currentText.toUpperCase()
                            font.family: frierenFont.name
                            font.pixelSize: 26
                            font.letterSpacing: 2
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            layer.enabled: true
                            layer.effect: MultiEffect {
                                shadowEnabled: true
                                shadowColor: "#ffffff"
                                shadowBlur: 0.6
                                shadowHorizontalOffset: 0
                                shadowVerticalOffset: 0
                            }
                        }
                    }

                    TextField {
                        id: passwordField
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        placeholderText: "Password"
                        placeholderTextColor: "#b3ffffff"

                        echoMode: TextInput.Password
                        passwordCharacter: "*"

                        font.family: frierenFont.name
                        font.pixelSize: 28
                        color: "#ffffff"
                        focus: true

                        horizontalAlignment: TextInput.AlignHCenter
                        verticalAlignment: TextInput.AlignVCenter
                        topPadding: 8
                        hoverEnabled: true

                        background: Rectangle {
                            radius: 22.5
                            color: passwordField.activeFocus ? "#33000000" : (passwordField.hovered ? "#26000000" : "#1A000000")
                            border.color: passwordField.activeFocus ? "#99ffffff" : "#4Dffffff"
                            border.width: 1
                        }

                        onAccepted: sddm.login(userSelector.currentText, passwordField.text, sessionSelector.currentIndex)
                    }

                    Loader {
                        sourceComponent: decorativeLineComponent
                        Layout.fillWidth: true
                        Layout.preferredHeight: 12
                    }

                    Button {
                        id: loginBtn
                        Layout.fillWidth: false
                        Layout.preferredWidth: 160
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredHeight: 45
                        hoverEnabled: true

                        contentItem: Text {
                            text: "LOGIN"
                            font.family: frierenFont.name
                            font.pixelSize: 18
                            font.letterSpacing: 2
                            color: "#ffffff"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        background: Rectangle {
                            radius: 22.5
                            color: loginBtn.down ? "#33000000" : (loginBtn.hovered ? "#26000000" : "#1A000000")
                            border.color: loginBtn.hovered ? "#99ffffff" : "#4Dffffff"
                            border.width: 1
                        }

                        onClicked: sddm.login(userSelector.currentText, passwordField.text, sessionSelector.currentIndex)
                    }
                }
            }
        }
    }

    // 5. Power control
    RowLayout {
        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: 40
            rightMargin: 50
        }
        spacing: 15

        Button {
            id: sleepBtn
            Layout.preferredHeight: 60
            Layout.preferredWidth: 60
            hoverEnabled: true

            contentItem: Item {
                Image {
                    anchors.centerIn: parent
                    source: "assets/sleep.svg"
                    sourceSize: Qt.size(64, 64)
                    width: 32
                    height: 32
                    fillMode: Image.PreserveAspectFit
                    opacity: sleepBtn.hovered ? 1.0 : 0.8

                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: "#ffffff"
                        shadowBlur: 0.4
                    }
                }
            }

            background: Rectangle {
                radius: 30
                color: sleepBtn.down ? "#33000000" : (sleepBtn.hovered ? "#26000000" : "transparent")
                border.color: sleepBtn.hovered ? "#4Dffffff" : "transparent"
                border.width: 1
            }

            onClicked: sddm.suspend()
        }

        Button {
            id: rebootBtn
            Layout.preferredHeight: 60
            Layout.preferredWidth: 60
            hoverEnabled: true

            contentItem: Item {
                Image {
                    anchors.centerIn: parent
                    source: "assets/reboot.svg"
                    sourceSize: Qt.size(64, 64)
                    width: 32
                    height: 32
                    fillMode: Image.PreserveAspectFit
                    opacity: rebootBtn.hovered ? 1.0 : 0.8

                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: "#ffffff"
                        shadowBlur: 0.4
                    }
                }
            }

            background: Rectangle {
                radius: 30
                color: rebootBtn.down ? "#33000000" : (rebootBtn.hovered ? "#26000000" : "transparent")
                border.color: rebootBtn.hovered ? "#4Dffffff" : "transparent"
                border.width: 1
            }

            onClicked: sddm.reboot()
        }

        Button {
            id: shutdownBtn
            Layout.preferredHeight: 60
            Layout.preferredWidth: 60
            hoverEnabled: true

            contentItem: Item {
                Image {
                    anchors.centerIn: parent
                    source: "assets/power.svg"
                    sourceSize: Qt.size(64, 64)
                    width: 32
                    height: 32
                    fillMode: Image.PreserveAspectFit
                    opacity: shutdownBtn.hovered ? 1.0 : 0.8

                    layer.enabled: true
                    layer.effect: MultiEffect {
                        shadowEnabled: true
                        shadowColor: "#ffffff"
                        shadowBlur: 0.4
                    }
                }
            }

            background: Rectangle {
                radius: 30
                color: shutdownBtn.down ? "#33000000" : (shutdownBtn.hovered ? "#26000000" : "transparent")
                border.color: shutdownBtn.hovered ? "#4Dffffff" : "transparent"
                border.width: 1
            }

            onClicked: sddm.powerOff()
        }
    }
}
