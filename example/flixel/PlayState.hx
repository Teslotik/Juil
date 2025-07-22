package;

import juil.Utils;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import juil.Form;
import juil.struct.Widget;

class PlayState extends FlxState {
    // --------------------------------------------------------------------------------
    // Minimal layout
    // --------------------------------------------------------------------------------

    var minimalLayout = {
        form: null,
        widget1: null,
        widget2: null,
        sprite1: null,
        sprite2: null
    }

    function createMinimalLayout() {
        // Create renderer
        minimalLayout.sprite1 = createSprite(0, 0, 10, 10, FlxColor.RED);
        minimalLayout.sprite2 = createSprite(0, 0, 10, 10, FlxColor.GREEN);
        
        // Create widgets
        minimalLayout.widget1 = Form.CreateWidget(widget -> {
            widget.x = 10;
            widget.y = 10;
            widget.horizontal = Fixed(100);
            widget.vertical = Fixed(40);
            widget.minW = 50;
            widget.minH = 100;
        });
        minimalLayout.widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(40);
            widget.vertical = Fill;
        });
        
        // Create form
        minimalLayout.form = new Form(minimalLayout.widget1);

        // Add and link widgets
        minimalLayout.form.addWidget(minimalLayout.widget1);
        minimalLayout.form.addWidget(minimalLayout.widget2, minimalLayout.widget1);
    }

    public function updateMinimalLayout() {
        // Recalculate
        minimalLayout.form.update();

        // Update size and position of sprites
        transform(minimalLayout.sprite1, minimalLayout.widget1.x, minimalLayout.widget1.y, minimalLayout.widget1.w, minimalLayout.widget1.h);
        transform(minimalLayout.sprite2, minimalLayout.widget2.x, minimalLayout.widget2.y, minimalLayout.widget2.w, minimalLayout.widget2.h);

        // Resize root widget (if it fixed)
        if (FlxG.mouse.pressed) {
            resize(minimalLayout.widget1);
        }
    }

    // --------------------------------------------------------------------------------
    // Demo 1
    // --------------------------------------------------------------------------------

    var demo1 = {
        form: null,
        widget1: null,
        widget2: null,
        widget3: null,
        widget4: null,
        sprite1: null,
        sprite2: null,
        sprite3: null,
        sprite4: null
    }

    function createDemo1() {
        demo1.sprite1 = createSprite(0, 0, 10, 10, FlxColor.RED);
        demo1.sprite2 = createSprite(0, 0, 10, 10, FlxColor.GREEN);
        demo1.sprite3 = createSprite(0, 0, 10, 10, FlxColor.BLUE);
        demo1.sprite4 = createSprite(0, 0, 10, 10, FlxColor.YELLOW);

        demo1.widget1 = Form.CreateWidget(widget -> {
            widget.x = 200;
            widget.y = 10;
            widget.horizontal = Fixed(100);
            widget.vertical = Fixed(40);
            widget.wrap = true;
            widget.padding = All(5);
            widget.minW = 50;
            widget.minH = 100;
        });
        demo1.widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(40);
            widget.vertical = Fixed(20);
        });
        demo1.widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(20);
            widget.vertical = Fill;
        });
        demo1.widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fixed(20);
            widget.minW = 30;
            widget.maxW = 90;
        });
        
        demo1.form = new Form(demo1.widget1);

        demo1.form.addWidget(demo1.widget1);
        demo1.form.addWidget(demo1.widget2, demo1.widget1);
        demo1.form.addWidget(demo1.widget3, demo1.widget1);
        demo1.form.addWidget(demo1.widget4, demo1.widget1);
    }

    public function updateDemo1() {
        demo1.form.update();

        transform(demo1.sprite1, demo1.widget1.x, demo1.widget1.y, demo1.widget1.w, demo1.widget1.h);
        transform(demo1.sprite2, demo1.widget2.x, demo1.widget2.y, demo1.widget2.w, demo1.widget2.h);
        transform(demo1.sprite3, demo1.widget3.x, demo1.widget3.y, demo1.widget3.w, demo1.widget3.h);
        transform(demo1.sprite4, demo1.widget4.x, demo1.widget4.y, demo1.widget4.w, demo1.widget4.h);

        if (FlxG.mouse.pressed) {
            resize(demo1.widget1);
        }
    }

    // --------------------------------------------------------------------------------
    // Demo 2
    // --------------------------------------------------------------------------------

    var demo2 = {
        form: null,
        widget1: null,
        widget2: null,
        widget3: null,
        widget4: null,
        widget5: null,
        sprite1: null,
        sprite2: null,
        sprite3: null,
        sprite4: null,
        sprite5: null
    }

    function createDemo2() {
        demo2.sprite1 = createSprite(0, 0, 10, 10, FlxColor.RED);
        demo2.sprite2 = createSprite(0, 0, 10, 10, FlxColor.GREEN);
        demo2.sprite3 = createSprite(0, 0, 10, 10, FlxColor.BLUE);
        demo2.sprite4 = createSprite(0, 0, 10, 10, FlxColor.YELLOW);
        demo2.sprite5 = createSprite(0, 0, 10, 10, FlxColor.MAGENTA);

        demo2.widget1 = Form.CreateWidget(widget -> {
            widget.x = 10;
            widget.y = 200;
            widget.horizontal = Fixed(100);
            widget.vertical = Hug;
            widget.wrap = true;
            widget.padding = All(5);
            widget.minW = 50;
            widget.minH = 100;
        });
        demo2.widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(40);
            widget.vertical = Fixed(20);
        });
        demo2.widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = null;
            widget.aspect = 1.5;
            widget.minW = 30;
        });
        demo2.widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(20);
            widget.vertical = Fixed(20);
            widget.minW = 30;
            widget.maxW = 60;
            widget.padding = All(5);
        });
        demo2.widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fill;
        });
        
        demo2.form = new Form(demo2.widget1);

        demo2.form.addWidget(demo2.widget1);
        demo2.form.addWidget(demo2.widget2, demo2.widget1);
        demo2.form.addWidget(demo2.widget3, demo2.widget1);
        demo2.form.addWidget(demo2.widget4, demo2.widget1);
        demo2.form.addWidget(demo2.widget5, demo2.widget4);
    }

    public function updateDemo2() {
        demo2.form.update();

        transform(demo2.sprite1, demo2.widget1.x, demo2.widget1.y, demo2.widget1.w, demo2.widget1.h);
        transform(demo2.sprite2, demo2.widget2.x, demo2.widget2.y, demo2.widget2.w, demo2.widget2.h);
        transform(demo2.sprite3, demo2.widget3.x, demo2.widget3.y, demo2.widget3.w, demo2.widget3.h);
        transform(demo2.sprite4, demo2.widget4.x, demo2.widget4.y, demo2.widget4.w, demo2.widget4.h);
        transform(demo2.sprite5, demo2.widget5.x, demo2.widget5.y, demo2.widget5.w, demo2.widget5.h);

        if (FlxG.mouse.pressed) {
            resize(demo2.widget1);
        }
    }

    // --------------------------------------------------------------------------------
    // Demo 3
    // --------------------------------------------------------------------------------

    var demo3 = {
        form: null,
        widget1: null,
        widget2: null,
        widget3: null,
        widget4: null,
        widget5: null,
        sprite1: null,
        sprite2: null,
        sprite3: null,
        sprite4: null,
        sprite5: null
    }

    function createDemo3() {
        demo3.sprite1 = createSprite(0, 0, 10, 10, FlxColor.RED);
        demo3.sprite2 = createSprite(0, 0, 10, 10, FlxColor.GREEN);
        demo3.sprite3 = createSprite(0, 0, 10, 10, FlxColor.BLUE);
        demo3.sprite4 = createSprite(0, 0, 10, 10, FlxColor.YELLOW);
        demo3.sprite5 = createSprite(0, 0, 10, 10, FlxColor.CYAN);

        demo3.widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(300);
            widget.vertical = Fixed(100);
            widget.x = 200;
            widget.y = 200;
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Fixed(5);
            widget.minW = 50;
            widget.minH = 100;
        });
        demo3.widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fill;
        });
        demo3.widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fill;
            widget.margin = All(15);
        });
        demo3.widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(25);
            widget.top = Fixed(10);
            widget.bottom = Fixed(10);
            widget.direction = Stack;
        });
        demo3.widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(18);
            widget.vertical = Fixed(18);
            widget.top = Fixed(-9);
            widget.right = Fixed(-9);
        });
        
        demo3.form = new Form(demo3.widget1);

        demo3.form.addWidget(demo3.widget1);
        demo3.form.addWidget(demo3.widget2, demo3.widget1);
        demo3.form.addWidget(demo3.widget3, demo3.widget2);
        demo3.form.addWidget(demo3.widget4, demo3.widget1);
        demo3.form.addWidget(demo3.widget5, demo3.widget4);
    }

    public function updateDemo3() {
        demo3.form.update();

        transform(demo3.sprite1, demo3.widget1.x, demo3.widget1.y, demo3.widget1.w, demo3.widget1.h);
        transform(demo3.sprite2, demo3.widget2.x, demo3.widget2.y, demo3.widget2.w, demo3.widget2.h);
        transform(demo3.sprite3, demo3.widget3.x, demo3.widget3.y, demo3.widget3.w, demo3.widget3.h);
        transform(demo3.sprite4, demo3.widget4.x, demo3.widget4.y, demo3.widget4.w, demo3.widget4.h);
        transform(demo3.sprite5, demo3.widget5.x, demo3.widget5.y, demo3.widget5.w, demo3.widget5.h);

        if (FlxG.mouse.pressed) {
            resize(demo3.widget1);
        }
    }

    // --------------------------------------------------------------------------------
    // Input Demo
    // --------------------------------------------------------------------------------

    var inputDemo = {
        form: null,
        widget1: null,
        widget2: null,
        sprite1: null,
        sprite2: null,
        animation: 0.0
    }

    function createInputDemo() {
        inputDemo.sprite1 = createSprite(0, 0, 10, 10, FlxColor.RED);
        inputDemo.sprite2 = createSprite(0, 0, 10, 10, FlxColor.GREEN);

        inputDemo.widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(100);
            widget.vertical = Fixed(100);
            widget.x = 10;
            widget.y = 400;
            widget.direction = Stack;
            widget.padding = All(15);
        });
        inputDemo.widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fill;
        }, true);   // Receive input
        
        inputDemo.form = new Form(inputDemo.widget1);

        inputDemo.form.addWidget(inputDemo.widget1);
        inputDemo.form.addWidget(inputDemo.widget2, inputDemo.widget1);

        // React on input
        inputDemo.form.onInput = widget -> {
            if (widget.area.isReleased && !widget.area.isDropped) {
                inputDemo.animation = 3;
            }
        };
    }

    public function updateInputDemo() {
        // Animate if pressed
        inputDemo.widget1.x += Math.sin(inputDemo.animation * 2 * Math.PI) * 5;

        inputDemo.form.update();
        inputDemo.form.input(FlxG.mouse.x, FlxG.mouse.y, FlxG.mouse.pressed);
        inputDemo.animation = Math.max(inputDemo.animation - 0.1, 0.0);

        transform(inputDemo.sprite1, inputDemo.widget1.x, inputDemo.widget1.y, inputDemo.widget1.w, inputDemo.widget1.h);
        transform(inputDemo.sprite2, inputDemo.widget2.x, inputDemo.widget2.y, inputDemo.widget2.w, inputDemo.widget2.h);

        // Access clickable area to grab widget
        if (inputDemo.widget2.area.isDragging) {
            inputDemo.widget1.x += inputDemo.widget2.area.mouseDelta.x;
            inputDemo.widget1.y += inputDemo.widget2.area.mouseDelta.y;
        }
    }

    // --------------------------------------------------------------------------------

    override public function create() {
        super.create();

        createMinimalLayout();
        createDemo1();
        createDemo2();
        createDemo3();
        createInputDemo();
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        updateMinimalLayout();
        updateDemo1();
        updateDemo2();
        updateDemo3();
        updateInputDemo();
    }

    function resize(widget:Widget) {
        widget.horizontal = switch widget.horizontal {
            case Fixed(v): Fixed(v + FlxG.mouse.deltaX);
            case o: o;
        }
        widget.vertical = switch widget.vertical {
            case Fixed(v): Fixed(v + FlxG.mouse.deltaY);
            case o: o;
        }
    }

    function createSprite(x:Float, y:Float, w:Int, h:Int, add = true, color:FlxColor) {
        var sprite = new FlxSprite();
        sprite.makeGraphic(w, h, color);
        if (add)
            this.add(sprite);
        sprite.setPosition(x, y);
        return sprite;
    }

    function transform(sprite:FlxSprite, x:Float, y:Float, w:Float, h:Float) {
        var w = Math.round(w);
        var h = Math.round(h);
        sprite.setPosition(x + w / 2.0, y + h / 2.0);
        sprite.setGraphicSize(
            w == 0 ? 1 : w,
            h == 0 ? 1 : h
        );
    }
}
