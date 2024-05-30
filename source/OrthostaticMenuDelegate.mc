// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class OrthostaticMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            System.println("item 1");
        } else if (item == :item_2) {
            System.println("item 2");
        }
    }

}