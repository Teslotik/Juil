package juil.struct;

using juil.Utils;

class Area {
    public var x = 0.0;
    public var y = 0.0;
    public var w = 0.0;
    public var h = 0.0;

    public var left(get, set):Float;
    inline function get_left() { return x; }
    inline function set_left(v:Float) { return x = v; }

    public var right(get, set):Float;
    inline function get_right() { return x + w; }
    inline function set_right(v:Float) { return w = v - x; }

    public var top(get, set):Float;
    inline function get_top() { return y; }
    inline function set_top(v:Float) { return y = v; }

    public var bottom(get, set):Float;
    inline function get_bottom() { return y + h; }
    inline function set_bottom(v:Float) { return h = v - y; }

    public var isOver = false;
    public var isDown = false;
    public var wasDown = false;
    public var isPressed = false;
    public var isReleased = false;
    
    public var isEntered = false;
    public var isExit = false;
    public var isHolding = false;
    public var isSame = false; // @todo rename

    public var isDragging = false;
    public var isDragStarted = false;
    public var isDropped = false;
    public var isMoved = false;
    public var drag = {
        x: 0.0,
        y: 0.0
    };

    public var mouse = {
        x: 0.0,
        y: 0.0
    };
    public var mouseLocal = {
        x: 0.0,
        y: 0.0
    };
    public var mouseRelative = {
        x: 0.0,
        y: 0.0
    };
    public var mouseDelta = {
        x: 0.0,
        y: 0.0
    };

    public function new(x = 0.0, y = 0.0, w = 0.0, h = 0.0) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }

    public static function Center(x:Float, y:Float, xr:Float, yr:Float) {
        return new Area(x - xr, y - yr, x + xr, y + yr);
    }

    public function toString() {
        return "{" +
            'x: ${x}, y: ${y}, w: ${w}, h: ${h}, ' +
            'isOver: ${isOver}, ' +
            'isDown: ${isDown}, ' +
            'wasDown: ${wasDown}, ' +
            'isPressed: ${isPressed}, ' +
            'isReleased: ${isReleased}, ' +
            'isEntered: ${isEntered}, ' +
            'isExit: ${isExit}, ' +
            'isHolding: ${isHolding}, ' +
            'isDragging: ${isDragging}, ' +
            'isDropped: ${isDropped}, ' +
            'drag: ${drag}, ' +
            'mouse: ${mouse}, ' +
            'mouseDelta : ${mouseDelta}' +
        "}";
    }

    public function update(x:Float, y:Float, isDown:Bool) {
        var wasOver = isOver;
        var prevDown = wasDown;
        
        // Press checks
        isOver = isInside(x, y);
        isPressed = isOver && isDown && !this.isDown;
        isReleased = !isDown && wasDown;

        if (isDown) {
            wasDown = wasDown || isOver && !this.isDown;
        } else {
            wasDown = false;
        }

        this.isDown = isDown;
        
        // Area checks
        isEntered = !wasOver && isOver;
        isExit = wasOver && !isOver;
        
        // Holding
        isHolding = isDown && !wasDown;
        isSame = isDown && prevDown;
        
        // Drag checks
        if (isPressed) drag.set(x, y);

        isDragStarted = isSame && !isDragging && (Math.abs(drag.x - x) > 3 || Math.abs(drag.y - y) > 3);
        isDropped = isDragging && isReleased;
        isDragging = isDragStarted || isDragging && !isDropped;
        isMoved = x != mouse.x || y != mouse.y;
        
        // Mouse
        mouseDelta.set(x - mouse.x, y - mouse.y);
        mouse.set(x, y);
        mouseLocal.set(x - left - w / 2, y - top - h / 2);
        mouseRelative.set(mouse.x - left, mouse.y - top);

        return true;
    }

    public function toLocal(x:Float, y:Float) {
        return {
            x: x - (left + right) / 2,
            y: y - (top + bottom) / 2
        };
    }

    public function isInside(x:Float, y:Float) {
        return
            x >= this.x && x <= this.x + w &&
            y >= this.y && y <= this.y + h;
    }
}