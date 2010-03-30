/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the FOO module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL-ONLY$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
** $QT_END_LICENSE$
**
****************************************************************************/
import Qt 4.7

Item{//This should be ROOT element in a QML/MX app
    property int headerBottom: header.height //Children should have at least this y
    WindowModel{id:wm}
    Rectangle{
        id:background
        anchors.fill: parent
        anchors.rightMargin: 1
        anchors.bottomMargin: 1
        color: "white"
        border.color: "black"
    }
    Rectangle{
            z:10
        id:header
        width: parent.width
        height:64
        color:'#333333'
        TitlebarCombobox{id:combo;//API redesign required after I figure out what
                                  //on earth this this is SUPPOSED to do.
            anchors.centerIn: parent
            current: 'Select'
            model: ListModel{
                ListElement{
                    content: 'Hello'
                }
                ListElement{
                    content: 'World'
                }
            }
            z:1
        }
        Image{id:closeImg
            anchors.right:parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            source: 'images/close' + (closeMA.containsMouse?'-hover':'') + '.png'
            MouseArea{ id: closeMA
                anchors.fill: parent
                hoverEnabled:true
                onClicked: Qt.quit()
            }
            z:1
        }
        MouseArea{
            anchors.fill: parent
            onReleased: wm.resetMove();
            onPositionChanged: wm.dragPointMove(mouse.x, mouse.y);
            z:0
        }
    }
    Image{id:resizeImg
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 1
        source: 'images/resize-grip.png'
        MouseArea{ id: resizeMA
            anchors.fill: parent
            onReleased: wm.resetResize();
            onPositionChanged: wm.dragPointResize(mouse.x, mouse.y);
        }
        z:10
    }
}
