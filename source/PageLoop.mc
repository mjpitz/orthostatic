// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Lang;
import Toybox.WatchUi;

class PageLoop extends ViewLoopFactory {
    private var _views as Array<[ WatchUi.View, WatchUi.BehaviorDelegate ]> = [];

    function initialize() {
        ViewLoopFactory.initialize();

        var last = new LastView();
        var recording = new RecordingView();
        var history = new HistoryView();

        _views.add([ last, new LastDelegate(last) ]);
        _views.add([ recording, new RecordingDelegate(recording) ]);
        //_views.add([ history, new HistoryDelegate(history) ]);
    }

    function getSize() as Number {
        return _views.size();
    }

    function getView(page as Number) as [ WatchUi.View ] or [ WatchUi.View, WatchUi.BehaviorDelegate ] {
        return _views[page];
    }
}
