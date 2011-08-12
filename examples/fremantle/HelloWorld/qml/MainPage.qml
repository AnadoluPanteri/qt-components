import QtQuick 1.0
import org.maemo.fremantle 1.0

Page {
    id: mainPage
    tools: commonTools

    Label {
        id: label
        anchors.centerIn: parent
        text: qsTr("Hello world!")
        visible: false
    }
    Button{
        id: button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: label.bottom
        anchors.topMargin: 10
        text: qsTr("Click here!")
        onClicked: label.visible=true
    }
    TextField{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: button.bottom
        anchors.topMargin: 20
        placeholderText: qsTr("Insert some text here")
    }
}