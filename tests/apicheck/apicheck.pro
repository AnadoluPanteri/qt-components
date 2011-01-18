include (../../qt-components.pri)
include (../tests.pri)

TEMPLATE = app
TARGET = tst_apicheck

INCLUDEPATH += base

HEADERS += base/apicheckbase.h \
           button/apicheck_button.h \
           checkbox/apicheck_checkbox.h \
           slider/apicheck_slider.h \
           textfield/apicheck_textfield.h \
           progressbar/apicheck_progressbar.h \
           radiobutton/apicheck_radiobutton.h \
           busyindicator/apicheck_busyindicator.h \
           textarea/apicheck_textarea.h \
           scrolldecorator/apicheck_scrolldecorator.h \
           buttoncolumn/apicheck_buttoncolumn.h \
           buttonrow/apicheck_buttonrow.h

SOURCES += main.cpp \
           base/apicheckbase.cpp \
           button/apicheck_button.cpp \
           checkbox/apicheck_checkbox.cpp \
           slider/apicheck_slider.cpp \
           textfield/apicheck_textfield.cpp \
           radiobutton/apicheck_radiobutton.cpp \
           busyindicator/apicheck_busyindicator.cpp \
           textarea/apicheck_textarea.cpp \
           buttoncolumn/apicheck_buttoncolumn.cpp \
           buttonrow/apicheck_buttonrow.cpp
