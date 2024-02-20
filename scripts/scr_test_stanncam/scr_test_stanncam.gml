/// @ignore
function test_stanncam_moveWith0duration_shouldBeAtNewMovePosition() {
    var _ = parent.cam;
    var _new_x = 100;
    var _new_y = 100;
    _.move(_new_x, _new_y, 0);
    assertEqual(_.x, _new_x);
    assertEqual(_.y, _new_y);
}

/// @ignore
function test_stanncam_moveWith1duration_shouldBeAtTheSamePosition() {
    var _ = parent.cam;
    var _x_previous = _.x;
    var _y_previous = _.y;
    var _new_x = 100;
    var _new_y = 100;
    _.move(_new_x, _new_y, 1);
    assertEqual(_.x, _x_previous);
    assertEqual(_.y, _y_previous);
}

/// @ignore
function test_stanncam_moveWith1durationAndInvokingStepOnce_shouldNotBeAtNewPosition() {
    var _ = parent.cam;
    var _new_x = 100;
    var _new_y = 100;
    _.move(_new_x, _new_y, 1);
    _.__step();
    assertEqual(_.x, _new_x);
    assertEqual(_.y, _new_y);
}

/// @ignore
function test_stanncam_moveWith1durationAndInvokingStepTwice_shouldBeAtNewMovePosition() {
    var _ = parent.cam;
    var _new_x = 100;
    var _new_y = 100;
    _.move(_new_x, _new_y, 1);
    _.__step();
    _.__step();
    assertEqual(_.x, _new_x);
    assertEqual(_.y, _new_y);
}

/// @ignore
function test_stanncam_moveToSamePositionUntilNotMoving_shouldHaveTimeAndDurationEqual() {
    var _ = parent.cam;
    _.move(_.x, _.y, 5);
    // Keep track of time to prevent infinite loop
    var _start = get_timer();
    var _end = _start + 10_000_000;
    while(get_timer() < _end) {
        if !_.__moving {
            break;
        }
        _.__step();
    }
    assertEqual(_.__t, _.__duration);
}

/// @ignore
function test_stanncam_creatingSecondStanncam_camIdShouldBe1() {
    var _ = new stanncam();
    assertEqual(_.cam_id, 1);
    _.destroy();
}

/// @ignore
function test_stanncam_newStanncam_camIdShouldBe0() {
    var _ = parent.cam;
    assertEqual(_.cam_id, 0);
}
