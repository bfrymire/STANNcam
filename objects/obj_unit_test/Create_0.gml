runner = new TestRunner("runner");

var _s = new TestSuite("suite_stanncam");
_s.onRunBegin(function() {
    stanncam_init(1920, 1080);
    cam = new stanncam();
});
_s.onRunEnd(function() {
    if !is_undefined(cam) {
        cam.destroy();
        cam = undefined;
    }
});
runner.addTestSuite(_s);
runner.discover(_s, "test_stanncam_");

runner.run();
