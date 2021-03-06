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

import Qt 4.7
import org.maemo.fremantle 1.0

PageStackWindow {
    id: rootWindow

    platformStyle: defaultStyle;

    PageStackWindowStyle { id: defaultStyle }
    PageStackWindowStyle {
        id: customStyle;
        background: "image://theme/meegotouch-wallpaper-portrait";
        backgroundFillMode: Image.PreserveAspectCrop
    }

    // ListPage is what we see when the app starts, it links to the component specific pages
    initialPage: ListPage { }

    // These tools are shared by most sub-pages by assigning the id to a page's tools property
    ToolBarLayout {
        id: commonTools
        visible: false
        ToolIcon { iconId: "toolbar-back"; onClicked: { myMenu.close(); pageStack.pop(); } }
        ToolIcon { iconId: "toolbar-view-menu"; onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close() }
    }

    Menu {
        id: myMenu
//        visualParent: pageStack
        MenuLayout {
            MenuItem { text: "List title #1" }
            MenuItem { text: "List title #2" }
            MenuItem { text: "List title #3" }
            MenuItem { text: "List title #4" }
            MenuItem { text: "List title #5" }
            MenuItem { text: "List title #6" }
            MenuItem { text: "List title #7" }
            MenuItem { text: "List title #8" }
            MenuItem { text: "List title #9" }
            MenuItem { text: "List title #10" }
            MenuItem { text: "List title #11" }
            MenuItem { text: "List title #12" }
            MenuItem { text: "List title #14" }
            MenuItem { text: "List title #15" }
            MenuItem { text: "List title #16" }
            MenuItem { text: "List title #17" }
            MenuItem { text: "List title #18" }
            MenuItem { text: "List title #19" }
            MenuItem { text: "Very long and extremely verbose ListTitle #20" }
        }
    }
}

