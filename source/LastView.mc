// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Application;
import Toybox.Lang;
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

        var laying = orDefault(Application.Storage.getValue("last_laying"), 0);
        var sitting = orDefault(Application.Storage.getValue("last_sitting"), 0);
        var standing = orDefault(Application.Storage.getValue("last_standing"), 0);
        var after3min = orDefault(Application.Storage.getValue("last_after3min"), 0);

        setDelta(after3min - laying);
        setLaying(laying);
        setSitting(sitting);
        setStanding(standing, sitting);
        setAfter3Min(after3min, standing);
    }

    function orDefault(test as Number, val as Number) as Number {
        if (test == null) {
            return val;
        }

        return test;
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
