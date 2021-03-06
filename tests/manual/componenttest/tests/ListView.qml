/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.1
import com.nokia.symbian 1.1
import Qt.labs.components 1.1
import "../components"

Item {
    id: root
    anchors.fill: parent
    property variant imageSizes: ["Undefined", "Tiny", "Small", "Medium", "Large"]
    property bool platformInverted: false
    Connections {
        target: platformPopupManager
        onPopupStackDepthChanged: if (platformPopupManager.popupStackDepth == 0) listView.forceActiveFocus()
    }

    Column {
        anchors.fill: parent

        ListView {
            id: listView
            height: parent.height - statusBar.height
            width: parent.width
            focus: true
            clip: true
            model: ListModel { id: model }
            delegate: defaultDelegate
            Component.onCompleted: {
                 initializeDefault() // Initial fill of the model
             }
            ScrollBar {
                flickableItem: listView
                anchors { top: listView.top; right: listView.right }
            }
        }
        Rectangle {
            id: statusBar
            height: 40
            width: parent.width
            color: "darkgray"
            border.color: "gray"

            // Do not mirror so that the menu button remains in the right side always
            LayoutMirroring.enabled: false
            LayoutMirroring.childrenInherit: true

            Label {
                anchors { left: parent.left; leftMargin: 10; verticalCenter: parent.verticalCenter }
                text: "Current item: " + listView.currentIndex
            }

            Button {
                text: "Menu"
                width: 100
                anchors { right: parent.right; rightMargin: 10; verticalCenter: parent.verticalCenter }
                onClicked: menu.open()
            }
        }
    }

    ContextMenu {
        id: contextMenu

        content: MenuLayout {
            MenuItem {
                text: "Set disabled"
                onClicked: {
                    listView.model.set(listView.currentIndex, {"disabled": true})
                }
            }
            MenuItem {
                text: "Toggle subitem indicator"
                onClicked: {
                    var indicatorState = listView.model.get(listView.currentIndex).indicator
                    listView.model.set(listView.currentIndex, {"indicator": !indicatorState})
                }
            }
            MenuItem {
                text: "Add item"
                onClicked: createItemDialog.open()
            }
            MenuItem {
                text: "Delete item"
                onClicked: {
                    if (listView.currentIndex >= 0)
                        listView.model.remove(listView.currentIndex)
                }
            }
        }
    }

    Menu {
        id: menu

        content: MenuLayout {
            MenuItem {
                text: "Show/Hide List header"
                onClicked: listView.header = listView.header ? null : listHeader
            }
            MenuItem {
                text: "Show/Hide Sections"
                onClicked: {
                    // Models field to group by
                    listView.section.property = "image"
                    // Delegate for section heading
                    listView.section.delegate = listView.section.delegate ? null : sectionDelegate
                }
            }
            MenuItem {
                text: "Back"
                onClicked: pageStack.pop()
            }
        }
    }

    Dialog {
        id: notificationDialog
        property string notificationText: ""
        title: Label {
            text: "Item clicked"
            anchors.fill: parent
        }
        buttons: Button {
            text: "Ok"
            width: parent.width
            height: 50
            onClicked: notificationDialog.accept()
        }
        content: Text {
            text: notificationDialog.notificationText
            font { bold: true; pixelSize: 16 }
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Dialog {
        id: createItemDialog
        title: Label {
            text: "Create new list item"
            anchors.fill: parent
        }
        buttons: Row {
            height: 60
            width: parent.width

            Button {
                text: "Ok"
                width: parent.width / 2
                height: parent.height
                onClicked: createItemDialog.accept()
            }

            Button {
                text: "Cancel"
                width: parent.width / 2
                height: parent.height
                onClicked: createItemDialog.reject()
            }
        }
        content: Item {
            id: createItemContainer
            height: createItemGrid.height
            width: createItemDialog.platformContentMaximumWidth
            CheckableGroup { id: imageSizeGroup }

            Grid {
                id: createItemGrid
                columns: 2
                spacing: platformStyle.paddingSmall
                property int cellWidth: (createItemContainer.width / 2) - spacing

                Label {
                    id: titleLabel
                    text: "Title:"
                    width: createItemGrid.cellWidth
                }

                TextField {
                    id: titleField
                    text: "New item - Title"
                    width: createItemGrid.cellWidth
                }

                Label {
                    id: subTitleLabel
                    text: "Subtitle:"
                    width: createItemGrid.cellWidth
                }

                TextField {
                    id: subTitleField
                    text: "New item - SubTitle"
                    width: createItemGrid.cellWidth
                }

                Label {
                    id: imageSizeLabel
                    text: "Image size:"
                    width: createItemGrid.cellWidth
                }

                Column {
                    spacing: platformStyle.paddingSmall
                    RadioButton {
                        text: root.imageSizes[0]
                        platformExclusiveGroup: imageSizeGroup
                        width: createItemGrid.cellWidth
                    }
                    RadioButton {
                        text: root.imageSizes[1]
                        platformExclusiveGroup: imageSizeGroup
                        width: createItemGrid.cellWidth
                    }
                    RadioButton {
                        text: root.imageSizes[2]
                        platformExclusiveGroup: imageSizeGroup
                        width: createItemGrid.cellWidth
                    }
                    RadioButton {
                        text: root.imageSizes[3]
                        platformExclusiveGroup: imageSizeGroup
                        width: createItemGrid.cellWidth
                    }
                    RadioButton {
                        text: root.imageSizes[4]
                        platformExclusiveGroup: imageSizeGroup
                        checked: true
                        width: createItemGrid.cellWidth
                    }
                }
            }
        }
        onAccepted: {
            listView.model.insert(listView.currentIndex + 1, {
                                  "title": titleField.text,
                                  "subTitle": subTitleField.text,
                                  // Fetch actual size in pixels based on index
                                  "imageSize": root.getSize(imageSizeGroup.selectedValue),
                                  "image": "image://theme/:/list1.svg",
                                  "disabled": false,
                                  "selected": false,
                                  "indicator": false
        } )
        }
    }

    function initializeDefault() {
        listView.header = listHeader
        listView.section.property = "image" // Models field to group by
        listView.section.delegate = sectionDelegate // Delegate for section headings
        for (var i = 0; i < 4; i++) {
            for (var j = 0; j < root.imageSizes.length; j++) {
                listView.model.append( {
                                      "title": "Title text - " + (5 * i + j),
                                      "subTitle": "SubTitle " + (5 * i + j),
                                      "imageSize": root.getSize(root.imageSizes[j]), // Fetch actual size in pixels based on index
                                      "image": "image://theme/:/list" + (i + 1) + ".svg",
                                      "disabled": false,
                                      "selected": false,
                                      "indicator": false
            } )
            }
        }
    }

    Component {
        id: defaultDelegate

        ListItem {
            id: listItem
            objectName: title
            width: listView.width
            enabled: !disabled // State from model
            subItemIndicator: indicator
            platformInverted: root.platformInverted

            Image {
                id: imageItem
                anchors {
                    left: imageSize == platformStyle.graphicSizeLarge ? listItem.left : listItem.paddingItem.left
                    top: imageSize == platformStyle.graphicSizeLarge ? listItem.top : listItem.paddingItem.top
                }
                sourceSize.height: imageSize
                sourceSize.width: imageSize
                source: imageSize == 0 ? "" : image
            }
            Column {
                anchors {
                    top: listItem.paddingItem.top
                    left: imageItem.right
                    leftMargin: platformStyle.paddingMedium
                    right: listItem.paddingItem.right
                }

                ListItemText {
                    width: parent.width
                    mode: listItem.mode
                    role: "Title"
                    text: title // Title from model
                    platformInverted: root.platformInverted
                }

                ListItemText {
                    width: parent.width
                    mode: listItem.mode
                    role: "SubTitle"
                    text: subTitle // SubTitle from model
                    platformInverted: root.platformInverted
                }
            }

            onClicked: {
                notificationDialog.notificationText = "Activated item: " + title
                notificationDialog.open()
            }
            onPressAndHold: contextMenu.open()

            Keys.onPressed: {
                if (event.key == Qt.Key_Backspace ||event.key == Qt.Key_Delete) {
                    if (listView.currentIndex >= 0)
                        listView.model.remove(listView.currentIndex)
                }
            }
        }
    }

    Component {
        id: listHeader

        ListHeading {
            id: listHeader
            width: listView.width
            platformInverted: root.platformInverted

            ListItemText {
                id: txtHeading
                anchors.fill: listHeader.paddingItem
                role: "Heading"
                text: "Test list"
                platformInverted: root.platformInverted
            }
        }
    }

    Component {
        id: sectionDelegate

        ListHeading {
            width: listView.width
            id: sectionHeader
            platformInverted: root.platformInverted

            ListItemText {
                id: txtHeading
                anchors.fill: sectionHeader.paddingItem
                role: "Heading"
                text: "Section: " + section
                platformInverted: root.platformInverted
            }
        }
    }

    function getSize(size) {
        switch (size) {
            case "Undefined": return 0; break
            case "Tiny": return platformStyle.graphicSizeTiny; break
            case "Small": return platformStyle.graphicSizeSmall; break
            case "Medium": return platformStyle.graphicSizeMedium; break
            case "Large": return platformStyle.graphicSizeLarge; break
            default: return 0
        }
    }
}
