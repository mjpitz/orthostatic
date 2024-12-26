// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Application;
import Toybox.Lang;
import Toybox.Math;
import Toybox.Graphics;
import Toybox.WatchUi;

class LastView extends WatchUi.View {
    private var _delta;
    private var _laying;
    private var _sitting;
    private var _standing;
    private var _after3min;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Last(dc));

        _delta = findDrawableById("delta");
        _laying = findDrawableById("laying");
        _sitting = findDrawableById("sitting");
        _standing = findDrawableById("standing");
        _after3min = findDrawableById("after3min");

        var laying = median(Application.Storage.getValue("last_laying"));
        var sitting = median(Application.Storage.getValue("last_sitting"));
        var standing = median(Application.Storage.getValue("last_standing"));
        var after3min = median(Application.Storage.getValue("last_after3min"));

        setDelta(after3min - laying);
        setLaying(laying);
        setSitting(sitting);
        setStanding(standing, sitting);
        setAfter3Min(after3min, standing);
    }

    function median(val as Array<Number>) as Number {
        if (val == null || val.size() == 0) {
            return 0;
        }

        val.sort(null);

        var count = val.size();
        if (count % 2 == 0) {
            var low = val[count/2];
            var high = val[(count/2)+1];

            return Math.floor((high + low) / 2);
        } else {
            return val[(count + 1) / 2];
        }
    }

    function setDelta(val as Number) {
        if (val >= 30) {
            _delta.setColor(Graphics.COLOR_RED);
        } else if (val >= 20) {
            _delta.setColor(Graphics.COLOR_YELLOW);
        } else {
            _delta.setColor(Graphics.COLOR_BLUE);
        }

        _setHeartRate(_delta, val);
    }

    function setLaying(val as Number) {
        _setHeartRate(_laying, val);
    }

    function setSitting(val as Number) {
        _setHeartRate(_sitting, val);
    }

    function setStanding(val as Number, sitting as Number) {
        if (val - sitting >= 20) {
            _after3min.setColor(Graphics.COLOR_YELLOW);
        } else {
            _after3min.setColor(Graphics.COLOR_WHITE);
        }

        _setHeartRate(_standing, val);
    }

    function setAfter3Min(val as Number, standing as Number) {
        if (val > 0 && val >= standing) {
            _after3min.setColor(Graphics.COLOR_YELLOW);
        } else {
            _after3min.setColor(Graphics.COLOR_WHITE);
        }

        _setHeartRate(_after3min, val);
    }

    private function _setHeartRate(target as Text, value as Number) {
        target.setText(value + " bpm");

        WatchUi.requestUpdate();
    }
}
