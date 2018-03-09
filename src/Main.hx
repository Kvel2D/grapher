import haxegon.*;
import haxe.ds.Vector;

using haxegon.MathExtensions;

@:publicFields
class Main {
    static inline var screen_width = 1000;
    static inline var screen_height = 1000;


    function new() {
        Gfx.resize_screen(screen_width, screen_height);

        Gfx.create_image("canvas", screen_width, screen_height);
    }

    

    function f(x: Float) {
        return 0.01*2/0.033*Math.exp(-2879*x)*Math.cos((4692*x-Math.deg_to_rad(34)));
    }

    var x_max = 1.0;
    var y_max = 1.0;
    var points = 100.0;

    var x_offset = 100;
    var y_offset = 500;
    var x_min = 0;

    function draw() {
        Gfx.clear_screen(Col.WHITE);

        Gfx.draw_line(x_offset - 10, y_offset, x_offset + 1000, y_offset, Col.GREEN);
        Gfx.draw_line(x_offset, y_offset - 1000, x_offset, y_offset + 1000, Col.GREEN);
        Gfx.draw_line(x_offset + screen_width / 2, y_offset - 10, x_offset + screen_width / 2, y_offset + 10, Col.GREEN);
        for (i in 0...Std.int(points)) {
            var x = i / points * x_max;

            Gfx.fill_circle(x_offset + i / points * screen_width / 2, y_offset - f(x) / y_max * screen_height / 2, 1, Col.BLACK);
        }
    }

    var prev_x_max = 0.0;
    var prev_y_max = 0.0;
    var prev_points = 0.0;

    function update() {


        if (points != prev_points || x_max != prev_x_max || y_max != prev_y_max) {
            Gfx.draw_to_image("canvas");
            draw();
            Gfx.draw_to_screen();
            
            prev_points = points;
            prev_x_max = x_max;
            prev_y_max = y_max;
        }

        Gfx.draw_image(0, 0, "canvas");

        GUI.set_pallete(Col.BLACK, Col.BLACK, Col.BLACK, Col.BLACK);

        GUI.editable_number(700, 100, "x_max = ", function(x) {x_max = x;}, x_max);
        GUI.editable_number(700, 150, "y_max = ", function(x) {y_max = x;}, y_max);
        GUI.editable_number(700, 200, "points = ", function(x) {points = x;}, points);

        var x = (Mouse.x - x_offset) / (screen_width / 2) * x_max;
        var y = -(Mouse.y - y_offset) / (screen_height / 2) * y_max;
        Text.display(10, 500, 'x = $x', Col.BLACK);
        Text.display(10, 530, 'y = $y', Col.BLACK);
    }
}
