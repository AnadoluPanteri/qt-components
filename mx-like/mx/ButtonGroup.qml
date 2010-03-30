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

Item {
    id: group

    property var checkedItem
    property bool allowNoChecked: false

    function onItemChecked(item) {
        // Non-checkable buttons do not affect other buttons
        if (!item.checkable) {
            return;
        }

        // ### we rely on clicked happening after property 'checked' changed.

        // item was checked!
        if (item.checked) {
            // Uncheck the old checked item
            if (checkedItem) {
                checkedItem.checked = false;
            }
            checkedItem = item;


        } else { // item was "unchecked"
            if (allowNoChecked) {
                checkedItem = undefined;
            } else {
                item.checked = true;
            }
        }
    }

    function bindFunction(fun, arg) {
        return function() { fun(arg); };
    }

    function isCheckableButton(item) {
        // ### "Duck-typing" to identify button...
        return item.clicked && (item.checkable !== undefined) && (item.checked !== undefined);
    }

    function connectChildren(item) {
        // ### We could be smarter here, see related discussion in "ButtonModel".

        for (var i = 0; i < item.children.length; ++i) {
            var c = item.children[i];

            if (isCheckableButton(c)) {
                var callback = bindFunction(group.onItemChecked, c);
                c.clicked.connect(callback);

                // ### When multiple checked, the last will be the one used
                if (c.checked) {
                    if (checkedItem) {
                        checkedItem.checked = false;
                    }
                    checkedItem = c;
                }

            } else if (c.children) {
                // If it's a container, recurse...
                connectChildren(c);
            }
        }
    }

    Component.onCompleted: {
        connectChildren(group);
    }
}
