/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project on Qt Labs.
**
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions contained
** in the Technology Preview License Agreement accompanying this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
****************************************************************************/

#include "sdeclarative.h"
#include "sstylefactory.h"
#include "sstylewrapper.h"
#include "sdeclarativeicon.h"
#include "sdeclarativeframe.h"
#include "sdeclarativeimplicitsizeitem.h"
#include "sdeclarativeimageprovider.h"
#include "sdeclarativemaskedimage.h"
#include "sdeclarativescreen.h"
#include "sdeclarativewindowdecoration.h"
#include "sbatteryinfo.h"

#include <QCoreApplication>
#include <QtDeclarative>

class SymbianPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT

public:

    void initializeEngine(QDeclarativeEngine *engine, const char *uri) {
        QDeclarativeExtensionPlugin::initializeEngine(engine, uri);
        engine->addImageProvider(QLatin1String("theme"), new SDeclarativeImageProvider);
        QDeclarativeContext *context = engine->rootContext();

        SDeclarativeScreen *screen = new SDeclarativeScreen(context);
        context->setContextProperty("screen", screen);

        SStyleFactory *style = new SStyleFactory(screen, context);
        context->setContextProperty("platformStyle", style->platformStyle());
        context->setContextProperty("privateStyle", style->privateStyle());

        SDeclarative *declarative = new SDeclarative(context);
        context->setContextProperty("symbian", declarative);

        SBatteryInfo *batteryInfo = new SBatteryInfo(context);
        context->setContextProperty("batteryInfo", batteryInfo);
        QObject::connect(engine, SIGNAL(quit()), QCoreApplication::instance(), SLOT(quit()));
    }

    void registerTypes(const char *uri) {
        qmlRegisterType<SDeclarativeWindowDecoration>(uri, 1, 0, "WindowDecoration");
        qmlRegisterType<SDeclarativeIcon>(uri, 1, 0, "Icon");
        qmlRegisterType<SDeclarativeFrame>(uri, 1, 0, "Frame");
        qmlRegisterType<SDeclarativeMaskedImage>(uri, 1, 0, "MaskedImage");
        qmlRegisterType<SStyleWrapper>(uri, 1, 0, "Style");
        qmlRegisterType<SDeclarativeImplicitSizeItem>(uri, 1, 0, "ImplicitSizeItem");
        qmlRegisterUncreatableType<SDeclarative>(uri, 1, 0, "Symbian", "");
        qmlRegisterUncreatableType<SDeclarativeScreen>(uri, 1, 0, "Screen", "");
        qmlRegisterUncreatableType<SDialogStatus>(uri, 1, 0, "DialogStatus", "");
        qmlRegisterUncreatableType<SPageOrientation>(uri, 1, 0, "PageOrientation", "");
        qmlRegisterUncreatableType<SPageStatus>(uri, 1, 0, "PageStatus", "");
        qmlRegisterUncreatableType<SBatteryInfo>(uri, 1, 0, "BatteryInfo", "");
    }
};

#include "plugin.moc"

Q_EXPORT_PLUGIN2(symbianplugin, SymbianPlugin)
