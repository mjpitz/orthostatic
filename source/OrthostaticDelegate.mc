// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Attention;
import Toybox.Lang;
import Toybox.Sensor;
import Toybox.System;
import Toybox.Time;
import Toybox.Timer;
import Toybox.WatchUi;

const MINUTE = 5;

class OrthostaticDelegate extends WatchUi.BehaviorDelegate {
    private var _steps as Array<Dictionary<Symbol, Number>> = [
        {:position => Position.LAYING_DOWN, :status => Status.ACCLIMATION, :duration => 5 * MINUTE},
        {:position => Position.LAYING_DOWN, :status => Status.MEASUREMENT, :duration => MINUTE},
        {:position => Position.SITTING, :status => Status.ACCLIMATION, :duration => MINUTE},
        {:position => Position.SITTING, :status => Status.MEASUREMENT, :duration => MINUTE},
        {:position => Position.STANDING, :status => Status.ACCLIMATION, :duration => MINUTE},
        {:position => Position.STANDING, :status => Status.MEASUREMENT, :duration => MINUTE},
        {:position => Position.STANDING, :status => Status.ACCLIMATION, :duration => 3 * MINUTE},
        {:position => Position.STANDING, :status => Status.MEASUREMENT, :duration => MINUTE},
    ];
    private var _step = 0;

    private var _started;
    private var _timer;
    private var _elapsed;

    private var _data = [];

    private var _view;
    private var _lastPosition;

    function initialize(view as OrthostaticView) {
        BehaviorDelegate.initialize();
        
        _timer = new Timer.Timer();
        _elapsed = 0;

        _view = view;
    }

    function onSelect() as Boolean {
        if (_started) {
            return true;
        }
        
        var step = _steps[_step];
        
        _started = Time.now();
        _timer.start(method(:tick), 1000, true);

        _data.add({:step => step});

        _view.setStatus(step[:status]);
        _lastPosition = step[:position];

        Sensor.setEnabledSensors([Sensor.SENSOR_ONBOARD_HEARTRATE]);

        return true;
    }

    function tick() as Void {
        var sensorInfo = Sensor.getInfo();
        if (sensorInfo has :heartRate && sensorInfo.heartRate != null) {
            _data.add({:reading => sensorInfo.heartRate});
        }
        
        if (_elapsed == _steps[_step][:duration]) {
            _step++;
            _elapsed = 0;

            if (_step == _steps.size()) {
                _timer.stop();

                _view.setStatus(Status.FINISHED);

                _notify();

                return;
            }

            var step = _steps[_step];

            _data.add({:step => step});

            _view.setPosition(step[:position]);
            _view.setStatus(step[:status]);

            if (_lastPosition != step[:position]) {
                _lastPosition = step[:position];

                _notify();
            }
        } else {
            _elapsed++;
        }

        _view.setDuration(_steps[_step][:duration] - _elapsed);
    }

    private function _notify() {
        // todo: make this a configurable property for preferred notification method
        if (Attention has :vibrate) {
            Attention.vibrate([
                new Attention.VibeProfile(50, 500),
                new Attention.VibeProfile(0, 500),
                new Attention.VibeProfile(50, 500),
            ]);
        } else if (Attention has :playTone) {
            Attention.playTone(Attention.TONE_TIME_ALERT);
        }
    }
}
