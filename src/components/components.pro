include (../../qt-components.pri)

TARGETPATH = Qt/labs/components.1.1
TEMPLATE = lib
TARGET = $$qtLibraryTarget(qtcomponentsplugin_1_1)
INCLUDEPATH += $$PWD $$PWD/models

win32|mac:!wince*:!win32-msvc:!macx-xcode:CONFIG += debug_and_release build_all
CONFIG += qt plugin
QT += declarative

DEFINES += QT_BUILD_COMPONENTS_LIB

QML_FILES += \
    qmldir \
    Checkable.qml \
    CheckableGroup.qml \
    CheckableGroup.js

fremantle|maemo5 {
    TARGETPATH = Qt/labs/components
    TARGET = $$qtLibraryTarget(qtcomponentsplugin_1_0)
}

symbian {
    TARGET.EPOCALLOWDLLDATA = 1
    TARGET.CAPABILITY = ALL -TCB
    TARGET.UID3 = 0x2003DF67
    MMP_RULES += EXPORTUNFROZEN
    MMP_RULES += SMPSAFE

    stubsis = \
        "START EXTENSION app-services.buildstubsis" \
        "OPTION SISNAME qtcomponentsplugin_1_1_stub" \
        "OPTION SRCDIR ."\
        "END"
    BLD_INF_RULES.prj_extensions = stubsis

    vendor_info = \
            " " \
            "; Localised Vendor name" \
            "%{\"Nokia\"}" \
            " " \
            "; Unique Vendor name" \
            ":\"Nokia\"" \
            " "

    # Reminder: SIS UID must remain the same between versions 1.x
    header = "$${LITERAL_HASH}{\"qtcomponentsplugin_1_1\"},(0x200346E1),1,1,0,TYPE=SA,RU"
    package.pkg_prerules += vendor_info header
    DEPLOYMENT += package
}

HEADERS += qglobalenums.h

SOURCES += plugin.cpp

include(kernel/kernel.pri)

include(models/models.pri)

include(../../qml.pri)
