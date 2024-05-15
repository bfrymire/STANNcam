runner = new TestRunner("runner");

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
_s.create_zone = method(_s, function(_zone_width=100, _zone_height=100) {
    return instance_create_layer(
        room_width * 0.5 - _zone_width * 0.5,
        room_height * 0.5 - _zone_height * 0.5,
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
    zone = create_zone();
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
