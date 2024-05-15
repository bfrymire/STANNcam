// Feather disable all

#region Test zone angles

// @ignore
function test_zones_imageAngleOf360_shouldBeWrappedTo0() {
    var _zone = instance_create_layer(0, 0, "Instances", obj_stanncam_zone, { image_angle: 360});
    assertEqual(_zone.image_angle, 0);
}

// @ignore
function test_zones_imageAngleOfNegative360_shouldBeWrappedTo0() {
    var _zone = instance_create_layer(0, 0, "Instances", obj_stanncam_zone, { image_angle: -360});
    assertEqual(_zone.image_angle, 0);
}

// @ignore
function test_zones_createdAtAnAngle_shouldRaiseError() {
    assertRaises(function() {
        instance_create_layer(0, 0, "Instances", obj_stanncam_zone, { image_angle: 15 });
    });
}

// @ignore
function test_zones_createdAtAnAngle_shouldRaiseErrorMessageValue() {
    assertRaiseErrorValue(function() {
        instance_create_layer(0, 0, "Instances", obj_stanncam_zone, { image_angle: 15});
    }, "obj_stanncam_zone.image_angle must be a multiple of 90 degrees, got 15.");
}

#endregion
