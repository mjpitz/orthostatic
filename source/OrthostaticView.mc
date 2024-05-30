// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.WatchUi;

class OrthostaticView extends WatchUi.View {
    private var _status;
    private var _duration;
    private var _position;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _status = findDrawableById("status");
        _duration = findDrawableById("duration");
        _position = findDrawableById("position");

        setStatus(Status.Initial);
        setDuration(300);
        setPosition(Position.LayingDown);
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

        switch(status) {
            case Status.Initial:
                label = "Select to start";
                break;
            case Status.InProgress:
                label = "Test in progress";
                break;
            case Status.Finished:
                label = "Finished";
                break;
        }

        _status.setText(label);

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
            case Position.LayingDown:
                label = "Laying down";
                break;
            case Position.Sitting:
                label = "Sitting";
                break;
            case Position.Standing:
                label = "Standing up";
                break;
        }

        _position.setText(label);

        WatchUi.requestUpdate();
    }
}
