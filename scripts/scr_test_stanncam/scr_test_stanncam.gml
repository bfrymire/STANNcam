// Feather disable all

#region Test stanncam move

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
    var _start = current_time;
    var _end = _start + 10_000;
    while (current_time < _end) {
        if !_.__moving {
            show_debug_message($"Stopped moving in {current_time - _start}ms");
            break;
        }
        _.__step();
    }
    assertEqual(_.__t, _.__duration);
}

/// @ignore
function test_stanncam_moveWith0DurationWhileFollowingObject_shouldBeAtPreviousPosition() {
    var _ = parent.cam;
    var _dummy = parent.dummy;
    _.move(_dummy.x, _dummy.y);
    var _x_previous = _.x;
    var _y_previous = _.y;
    _.follow = _dummy;
    _.move(1000, 1000);
    _.__step();
    assertEqual(_.x, _x_previous);
    assertEqual(_.y, _y_previous);
}

/// @ignore
function test_stanncam_moveWith1DurationWhileFollowingObject_shouldBeAtPreviousPosition() {
    var _ = parent.cam;
    var _dummy = parent.dummy;
    _.move(_dummy.x, _dummy.y);
    var _x_previous = _.x;
    var _y_previous = _.y;
    _.follow = _dummy;
    _.move(1000, 1000, 1);
    _.__step();
    assertEqual(_.x, _x_previous);
    assertEqual(_.y, _y_previous);
}

#endregion
#region Test stanncam cam_id

/// @ignore
function test_stanncam_creatingSecondStanncamCamId_shouldBe1() {
    var _ = new stanncam();
    assertEqual(_.cam_id, 1);
    _.destroy();
}

/// @ignore
function test_stanncam_newStanncamCamId_shouldBe0() {
    var _ = parent.cam;
    assertEqual(_.cam_id, 0);
}

#endregion
#region Test stanncam pause

/// @ignore
function test_stanncam_getPausedOnNewStanncam_shouldBeFalse() {
    var _ = parent.cam;
    assertFalse(_.get_paused());
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
function test_stanncam_togglePausedOnNewStanncam_shouldBeTrue() {
    var _ = parent.cam;
    _.toggle_paused();
    assertTrue(_.paused);
}

#endregion
#region Test stanncam __update_view_size

/// @ignore
function test_stanncamUpdateViewSize_invokeUpdateViewSize_shouldCreateSurface() {
    var _ = parent.cam;
    _.use_app_surface = false;
    _.__update_view_size();
    assertTrue(surface_exists(_.surface), "Expected stanncam.surface to exist.");
}

/// @ignore
function test_stanncamUpdateViewSize_invokeUpdateViewSize_shouldCreateSurfaceUsingWidthAndHeight() {
    var _ = parent.cam;
    _.use_app_surface = false;
    _.__update_view_size();
    assertEqual(_.width, surface_get_width(_.surface));
    assertEqual(_.height, surface_get_height(_.surface));
}

/// @ignore
function test_stanncamUpdateViewSize_updateZoomToHalf_shouldResizeSurfaceToHalf() {
    var _ = parent.cam;
    _.use_app_surface = false;
    var _zoom_amount = 0.5;
    _.zoom(_zoom_amount);
    _.__update_view_size();
    assertEqual(_.width * _zoom_amount, surface_get_width(_.surface));
    assertEqual(_.height * _zoom_amount, surface_get_height(_.surface));
}

/// @ignore
function test_stanncamUpdateViewSize_invokeUpdateViewSizeZoomXAndY_shouldBeEqualTo0() {
    var _ = parent.cam;
    _.use_app_surface = false;
    _.__update_view_size();
    assertEqual(_.zoom_x, 0, "Expected a stanncam with no zoom modifications to have a zoom_x of 0, actual " + string(_.zoom_x) + ".");
    assertEqual(_.zoom_y, 0, "Expected a stanncam with no zoom modifications to have a zoom_y of 0, actual " + string(_.zoom_y) + ".");
}

/// @ignore
function test_stanncamUpdateViewSize_updateZoomToHalf_shouldUpdateZoomXAndY() {
    var _ = parent.cam;
    _.use_app_surface = false;
    var _zoom_amount = 0.5;
    _.zoom(_zoom_amount);
    _.__update_view_size();
    assertEqual(_.zoom_x, _.width * _zoom_amount * 0.5 * -1);
    assertEqual(_.zoom_y, _.height * _zoom_amount * 0.5 * -1);
}

/// @ignore
function test_stanncamUpdateViewSize_updateWidthAndHeightToHalf_shouldUpdateSurfaceSizeZoomXAndY() {
    var _ = parent.cam;
    _.use_app_surface = false;
    var _zoom_amount = 0.5;
    _.zoom(_zoom_amount);
    _.__update_view_size();
    assertEqual(_.zoom_x, _.width * _zoom_amount * 0.5 * -1);
    assertEqual(_.zoom_y, _.height * _zoom_amount * 0.5 * -1);
}

#endregion
#region Test stanncam zoom

/// @ignore
function test_stanncamZoom_whenZoomingOnInstance_shouldUpdateXAndYPositionsToInstance() {
    var _ = parent.cam;
    var _dummy = parent.dummy;
    _.bounds_w = 0;
    _.bounds_h = 0;
    _.follow = _dummy;
    _.zoom(0.25);
    repeat (100) {
        _.__step();
    }
    assertEqual(_.x, _dummy.x);
    assertEqual(_.y, _dummy.y);
}

#endregion
