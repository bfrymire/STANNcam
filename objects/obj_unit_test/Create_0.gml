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
runner.discover(_s, "test_stanncam_");
runner.discover(_s, "test_stanncamUpdateViewSize_");
runner.discover(_s, "test_stanncamZoom_");

runner.run();
