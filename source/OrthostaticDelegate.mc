// Copyright (C) 2024 Mya Pitzeruse
// SPDX-License-Identifier: Apache-2.0

import Toybox.Attention;
import Toybox.Lang;
import Toybox.Timer;
import Toybox.WatchUi;

const MINUTE = 60;

class OrthostaticDelegate extends WatchUi.BehaviorDelegate {
    private var _steps = [
        {:position => Position.LayingDown, :status => Status.Acclimation, :duration => 5 * MINUTE},
        {:position => Position.LayingDown, :status => Status.Measurement, :duration => MINUTE},
        {:position => Position.Sitting, :status => Status.Acclimation, :duration => MINUTE},
        {:position => Position.Sitting, :status => Status.Measurement, :duration => MINUTE},
        {:position => Position.Standing, :status => Status.Acclimation, :duration => MINUTE},
        {:position => Position.Standing, :status => Status.Measurement, :duration => MINUTE},
        {:position => Position.Standing, :status => Status.Acclimation, :duration => 3 * MINUTE},
        {:position => Position.Standing, :status => Status.Measurement, :duration => MINUTE},
    ];
    
    private var _step = 0;

    private var _view;

    private var _started;
    private var _timer;
    private var _elapsed;

    private var _lastPosition;

    function initialize(view as OrthostaticView) {
        BehaviorDelegate.initialize();

        _view = view;
        
        _started = false;
        _timer = new Timer.Timer();
        _elapsed = 0;

        _lastPosition = _steps[_step][:position];
    }

    function onSelect() as Boolean {
        if (_started) {
            return true;
        }

        _view.setStatus(_steps[_step][:status]);
        
        _started = true;
        _timer.start(method(:tick), 1000, true);

        return true;
    }

    function tick() as Void {
        if (_elapsed == _steps[_step][:duration]) {
            _step++;
            _elapsed = 0;

            if (_step == _steps.size()) {
                _timer.stop();

                _view.setStatus(Status.Finished);

                _notify();

                return;
            }

            _view.setPosition(_steps[_step][:position]);
            _view.setStatus(_steps[_step][:status]);

            if (_lastPosition != _steps[_step][:position]) {
                _lastPosition = _steps[_step][:position];

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
