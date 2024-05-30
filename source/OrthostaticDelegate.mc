// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Lang;
import Toybox.WatchUi;

class OrthostaticDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        // start the test, do not allow it to be aborted
        return true;
    }

    function onMenu() as Boolean {
        // use to abort the task if started, otherwise
        return true;
    }

    function start() {

    }

    function stop() {

    }
}
