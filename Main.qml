import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Effects

Item {
    id: root
    width: 1920
    height: 1080

    // 1. Carga de tu fuente OTF
    FontLoader {
        id: frierenFont
        source: Qt.resolvedUrl("fonts/Frieren.otf") // <-- RECUERDA PONER TU ARCHIVO AQUÍ
    }

    // 2. Fondo dinámico en bucle
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

    // --- COMPONENTE: Línea decorativa estilo Frieren (con rombo en el centro) ---
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

    // 3. Gestor de Sesiones (Esquina superior derecha)
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

    // 4. Panel de Login
    Rectangle {
        id: loginPanel
        width: 450

        // Variable del usuario alojada aquí para evitar problemas de alcance
        property string userNameStr: "itzbetalgeuse"

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: 80
            topMargin: 100
            bottomMargin: 100
        }

        color: "transparent"

        // Disposición Principal (Logo + Contenedor)
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 25 // Espacio entre el logo y el contenedor gris
            width: parent.width * 0.85

            // --- Logo de Frieren ---
            Image {
                source: "assets/frieren-logo.png"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 375
                Layout.maximumHeight: 180
                fillMode: Image.PreserveAspectFit
            }

            // --- NUEVO CONTENEDOR ENCAPSULADO (5% de visibilidad) ---
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 380
                implicitHeight: formLayout.implicitHeight + 50 // 25px de padding superior e inferior
                radius: 20 // Esquinas redondeadas
                color: "#0D000000" // Negro al 5% (actúa como un gris extremadamente sutil)
                border.width: 0 // Sin contorno

                // Disposición Interna (Formulario)
                ColumnLayout {
                    id: formLayout
                    anchors.centerIn: parent
                    spacing: 18
                    width: 320 // Ancho del contenido interno (deja 30px de margen simétrico a los lados)

                    // --- LÍNEA DECORATIVA SUPERIOR ---
                    Loader {
                        sourceComponent: decorativeLineComponent
                        Layout.fillWidth: true
                        Layout.preferredHeight: 12
                    }

                    // --- Nombre de Usuario ---
                    Text {
                        text: loginPanel.userNameStr.toUpperCase()
                        font.family: frierenFont.name
                        font.pixelSize: 26
                        font.letterSpacing: 2
                        color: "#ffffff"

                        Layout.alignment: Qt.AlignHCenter
                        horizontalAlignment: Text.AlignHCenter

                        layer.enabled: true
                        layer.effect: MultiEffect {
                            shadowEnabled: true
                            shadowColor: "#ffffff"
                            shadowBlur: 0.6
                            shadowHorizontalOffset: 0
                            shadowVerticalOffset: 0
                        }
                    }

                    // --- Campo de Contraseña ---
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

                        onAccepted: sddm.login(loginPanel.userNameStr, passwordField.text, sessionSelector.currentIndex)
                    }

                    // --- LÍNEA DECORATIVA INFERIOR ---
                    Loader {
                        sourceComponent: decorativeLineComponent
                        Layout.fillWidth: true
                        Layout.preferredHeight: 12
                    }

                    // --- Botón de Login ---
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

                        onClicked: sddm.login(loginPanel.userNameStr, passwordField.text, sessionSelector.currentIndex)
                    }
                }
            }
        }
    }
}
