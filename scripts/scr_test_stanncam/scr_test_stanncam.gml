/// @ignore
function test_stanncam_move_with_0_duration_should_be_at_new_move_position() {
    var _ = parent.cam;
    var _new_x = 100;
    var _new_y = 100;
    _.move(_new_x, _new_y, 0);
    assertEqual(_.x, _new_x);
    assertEqual(_.y, _new_y);
}

/// @ignore
function test_stanncam_move_with_1_duration_should_be_at_the_same_position() {
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
function test_stanncam_move_with_1_duration_and_invoking_step_once_should_not_be_at_new_position() {
    var _ = parent.cam;
    var _new_x = 100;
    var _new_y = 100;
    _.move(_new_x, _new_y, 1);
    _.__step();
    assertEqual(_.x, _new_x);
    assertEqual(_.y, _new_y);
}

/// @ignore
function test_stanncam_move_with_1_duration_and_invoking_step_twice_should_be_at_new_move_position() {
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
function test_stanncam_move_to_same_position_until_not_moving_should_have_time_and_duration_equal() {
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
function test_stanncam_creating_second_stanncam_cam_id_should_be_1() {
    var _ = new stanncam();
    assertEqual(_.cam_id, 1);
    _.destroy();
}

/// @ignore
function test_stanncam_new_stanncam_cam_id_should_be_0() {
    var _ = parent.cam;
    assertEqual(_.cam_id, 0);
}

/// @ignore
function test_stanncam_move_with_0_duration_while_following_object_should_be_at_previous_position() {
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
function test_stanncam_move_with_1_duration_while_following_object_should_be_at_previous_position() {
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
