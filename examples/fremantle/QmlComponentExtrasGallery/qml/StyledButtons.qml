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

import QtQuick 1.0
import Qt.labs.components 1.0
import org.maemo.fremantle 1.0
import org.maemo.extras 1.0


Page {
    id: buttonsPage
    anchors.margins: UiConstants.DefaultMargin
    tools: commonTools

    Flickable {
        anchors.fill: parent
        contentWidth: col1.width
        contentHeight: col1.height
        flickableDirection: Flickable.VerticalFlick

        Column {
            id: col1
            spacing: 30

            Label {
                width: 370
                text: "Enabled buttons of different styles"
                font.bold: true
                wrapMode: Text.Wrap
            }

            Button {
                text: "No style"
            }

            Button {
                text: "ListButtonStyle"
                platformStyle: ListButtonStyle {}
            }

            Button {
                text: "NegativeButtonStyle"
                platformStyle: NegativeButtonStyle {}
            }

            Button {
                text: "PositiveButtonStyle"
                platformStyle: PositiveButtonStyle {}
            }

            TumblerButton {
                text: "TumblerButtonStyle"
            }

            TumblerButton {
                text: "InvertedTumblerButtonStyle"
                platformStyle: TumblerButtonStyle { inverted: true }
            }
        }

        Column {
            id: col2
            spacing: 30
            anchors {left: col1.right}

            Label {
                width: 370
                text: "Disabled buttons of different styles"
                font.bold: true
                wrapMode: Text.Wrap
            }

            Button {
                text: "No style"
                enabled: false
            }

            Button {
                text: "ListButtonStyle"
                platformStyle: ListButtonStyle {}
                enabled: false
            }

            Button {
                text: "NegativeButtonStyle"
                platformStyle: NegativeButtonStyle {}
                enabled: false
            }

            Button {
                text: "PositiveButtonStyle"
                platformStyle: PositiveButtonStyle {}
                enabled: false
            }

            TumblerButton {
                text: "TumblerButtonStyle"
                enabled: false
            }

            TumblerButton {
                text: "InvertedTumblerButtonStyle"
                platformStyle: TumblerButtonStyle { inverted: true }
                enabled: false
            }
        }

    }
}