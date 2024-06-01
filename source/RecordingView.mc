// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.WatchUi;

class RecordingView extends WatchUi.View {
    private var _status;
    private var _duration;
    private var _position;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.Recording(dc));

        _status = findDrawableById("status");
        _duration = findDrawableById("duration");
        _position = findDrawableById("position");

        setDuration(300);
        setPosition(Position.LAYING_DOWN);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        
    }

    function setStatus(status as Lang.Number) {
        var label = "";
        var color = Graphics.COLOR_WHITE;

        switch(status) {
            case Status.ACCLIMATION:
                label = "Acclimating";
                color = Graphics.COLOR_BLUE;
                break;
            case Status.MEASUREMENT:
                label = "Measuring";
                color = Graphics.COLOR_YELLOW;
                break;
            case Status.FINISHED:
                label = "Finished";
                color = Graphics.COLOR_GREEN;
                break;
        }

        _status.setText(label);
        _status.setColor(color);

        WatchUi.requestUpdate();
    }

    function setDuration(val as Lang.Number) {
        var minutes = Math.floor(val / 60);
        var seconds = val % 60;
        var label = minutes + ":" + seconds;

        if (seconds < 10) {
            label = minutes + ":0" + seconds;
        }

        _duration.setText(label);
        
        WatchUi.requestUpdate();
    }

    function setPosition(position as Lang.Number) {
        var label = "";

        switch(position) {
            case Position.LAYING_DOWN:
                label = "Laying down";
                break;
            case Position.SITTING:
                label = "Sitting";
                break;
            case Position.STANDING:
                label = "Standing up";
                break;
        }

        _position.setText(label);

        WatchUi.requestUpdate();
    }
}
