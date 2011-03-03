TEMPLATE = subdirs

meego {
    SUBDIRS += \
        api_button \
        api_checkbox \
        api_slider \
        api_busyindicator \
        #api_radiobutton \ #TODO missing component
        api_pagestack \
        api_progressbar \
        #api_scrolldecorator \ #TODO fix flickableItem
        #api_choicelist \ #TODO missing component
        #api_buttoncolumn \ #TODO not yet finalized
        #api_buttonrow \ #TODO not yet finalized
        #api_textfield \ #TODO not yet finalized
        #api_textarea \ #TODO not yet finalized
        #api_toolbar #TODO not yet finalized
}

symbian3 {
    SUBDIRS += \
        api_button \
        api_checkbox \
        api_dialog \
        api_slider \
        #api_pagestack \
        api_progressbar \
        api_scrolldecorator \
        api_textfield \ #TODO not yet finalized
        api_textarea \ #TODO not yet finalized
        #api_toolbar
}