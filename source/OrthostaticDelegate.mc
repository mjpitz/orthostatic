// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Lang;
import Toybox.WatchUi;

class OrthostaticDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new OrthostaticMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}