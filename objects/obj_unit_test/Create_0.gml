runner = new TestRunner("runner");
runner.tearDown(function() {
    // Quiet on success, verbose on failure
    var _failed_tests = 0;
    var _failed_test_names = "";
    var _len = array_length(logs);
    var i = 0;
    repeat (_len) {
        var _log = logs[i];
        if !_log.pass {
            ++_failed_tests;
            _failed_test_names += "• " + _log.name + (is_undefined(_log.helper_text) ? "" : "  -  " + _log.helper_text);
            if i != _len - 1 {
                _failed_test_names += "\n";
            }
        }
        ++i;
    }
    if _failed_tests {
        var _text = "\n\nSTANNcam v" + STANNCAM_VERSION;
        _text += "\nCrispy v" + CRISPY_VERSION + ", released on " + CRISPY_DATE
        _text += "\n\nFailed Tests (" + string(_failed_tests) + "):\n" + _failed_test_names;
        output(_text);
    }
});

var _s = new TestSuite("suite_stanncam");
_s.onRunBegin(function() {
    stanncam_init(1920, 1080);
    cam = new stanncam();
    dummy = instance_create_layer(room_width * 0.5, room_height * 0.5, "Instances", obj_dummy_object);
});
_s.onRunEnd(function() {
    if !is_undefined(cam) {
        cam.destroy();
        cam = undefined;
    }
    instance_destroy(dummy);
});
runner.addTestSuite(_s);
runner.discover(_s, "test_stanncam_constructor_");
runner.discover(_s, "test_stanncam_");
runner.discover(_s, "test_stanncamUpdateViewSize_");
runner.discover(_s, "test_stanncamZoom_");

_s = new TestSuite("suite_zones");
/**
 * @function create_zone
 * @param {Real} [_x=0]
 * @param {Real} [_y=0]
 * @param {Real} [_zone_width=100]
 * @param {Real} [_zone_height=100]
 */
_s.create_zone = method(_s, function(_x=0, _y=0, _zone_width=100, _zone_height=100) {
    return instance_create_layer(
        _x,
        _y,
        "Instances",
        obj_stanncam_zone,
        { width: _zone_width, height: _zone_height }
    );
});
_s.onRunBegin(function() {
    stanncam_init(1920, 1080);
    cam = new stanncam();
    dummy = instance_create_layer(room_width * 0.5, room_height * 0.5, "Instances", obj_dummy_object);
    var _zone_width = 100;
    var _zone_height = _zone_width;
    zone = create_zone(room_width * 0.5 - _zone_width * 0.5, room_height * 0.5 - _zone_height * 0.5, _zone_width, _zone_height);
});
_s.onRunEnd(function() {
    if !is_undefined(cam) {
        cam.destroy();
        cam = undefined;
    }
    instance_destroy(dummy);
    instance_destroy(obj_stanncam_zone);
});
runner.addTestSuite(_s);
runner.discover(_s, "test_zones_");

runner.run();

game_end();
