/// @ignore
function test_stanncam_moveWith0Duration_shouldBeAtNewMovePosition() {
    var _ = parent.cam;
    var _new_x = 100;
    var _new_y = 100;
    _.move(_new_x, _new_y, 0);
    assertEqual(_.x, _new_x);
    assertEqual(_.y, _new_y);
}

/// @ignore
function test_stanncam_moveWith1Duration_shouldBeAtTheSamePosition() {
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
function test_stanncam_moveWith1DurationAndInvokingStepOnce_shouldNotBeAtNewPosition() {
    var _ = parent.cam;
    var _new_x = 100;
    var _new_y = 100;
    _.move(_new_x, _new_y, 1);
    _.__step();
    assertEqual(_.x, _new_x);
    assertEqual(_.y, _new_y);
}

/// @ignore
function test_stanncam_moveWith1DurationAndInvokingStepTwice_shouldBeAtNewMovePosition() {
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
function test_stanncam_creatingSecondStanncam_shouldHavecamIdBe1() {
    var _ = new stanncam();
    assertEqual(_.cam_id, 1);
    _.destroy();
}

/// @ignore
function test_stanncam_newStanncam_shouldHaveCamIdBe0() {
    var _ = parent.cam;
    assertEqual(_.cam_id, 0);
}

/// @ignore
function test_stanncam_moveWith0DurationWhileFollowingObject_shouldBeAtPreviousPosition() {
    var _ = parent.cam;
    var _dummy = instance_create_layer(0, 0, "Instances", obj_dummy_object);
    _.move(_dummy.x, _dummy.y);
    var _x_previous = _.x;
    var _y_previous = _.y;
    _.follow = _dummy;
    _.move(1000, 1000);
    _.__step();
    assertEqual(_.x, _x_previous);
    assertEqual(_.y, _y_previous);
    instance_destroy(_dummy);
}

/// @ignore
function test_stanncam_moveWith1DurationWhileFollowingObject_shouldBeAtPreviousPosition() {
    var _ = parent.cam;
    var _dummy = instance_create_layer(0, 0, "Instances", obj_dummy_object);
    _.move(_dummy.x, _dummy.y);
    var _x_previous = _.x;
    var _y_previous = _.y;
    _.follow = _dummy;
    _.move(1000, 1000, 1);
    _.__step();
    assertEqual(_.x, _x_previous);
    assertEqual(_.y, _y_previous);
    instance_destroy(_dummy);
}

/// @ignore
function test_stanncam_setPausedToTrue_shouldBeTrue() {
    var _ = parent.cam;
    _.set_paused(true);
    assertTrue(_.paused);
}

/// @ignore
function test_stanncam_setPausedToFalse_shouldBeFalse() {
    var _ = parent.cam;
    _.set_paused(false);
    assertFalse(_.paused);
}

/// @ignore
function test_stanncam_getPausedOnNewStanncam_shouldBeFalse() {
    var _ = parent.cam;
    assertFalse(_.get_paused());
}

/// @ignore
function test_stanncam_togglePausedOnNewStanncam_shouldBeTrue() {
    var _ = parent.cam;
    _.toggle_paused();
    assertTrue(_.paused);
}
