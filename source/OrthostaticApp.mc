// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class OrthostaticApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var loop = new PageLoop();
        var view = new ViewLoop(loop, {:wrap => true});

        return [ view, new ViewLoopDelegate(view) ];
    }

}

function getApp() as OrthostaticApp {
    return Application.getApp() as OrthostaticApp;
}
