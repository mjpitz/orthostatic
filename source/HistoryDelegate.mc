// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.WatchUi;

class HistoryDelegate extends WatchUi.BehaviorDelegate {
    private var _view;

    function initialize(view as HistoryView) {
        BehaviorDelegate.initialize();

        _view = view;
    }
}
