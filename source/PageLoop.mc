// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Lang;
import Toybox.WatchUi;

class PageLoop extends ViewLoopFactory {
    function initialize() {
        ViewLoopFactory.initialize();
    }

    function getSize() as Number {
        return 2;
    }

    function getView(page as Number) as [ WatchUi.View ] or [ WatchUi.View, WatchUi.BehaviorDelegate ] {
        switch (page) {
            case 0:
                var last = new LastView();
                return [ last, new LastDelegate(last) ];
            case 1:
                var recording = new RecordingView();
                return [ recording, new RecordingDelegate(recording) ];
            case 2:
                var history = new HistoryView();
                return [ history, new HistoryDelegate(history) ];
        }

        return [ null ] as [ WatchUi.View ];
    }
}
