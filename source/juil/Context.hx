package juil;

import juil.iterator.SpanIterator;
import juil.struct.Widget;
import juil.types.Resizing;

using Lambda;
using juil.Utils;

class Context {
    // Span
    var widgets = new Array<Widget>();
    public var start(default, null):Int = 0;
    public var length(default, null):Int = 0;

    public var shifts(default, null):Int = 0;

    public var dx = 0.0;
    public var dy = 0.0;

    public var left = 0.0;
    public var top = 0.0;
    public var right = 0.0;
    public var bottom = 0.0;

    // Content width and height
    public var w = 0.0;
    public var h = 0.0;

    public var insetsHorizontal(get, never):Float;
    inline function get_insetsHorizontal() {
        return left + right;
    }
    public var insetsVertical(get, never):Float;
    inline function get_insetsVertical() {
        return top + bottom;
    }

    public var hgap:Null<Float> = null;
    public var vgap:Null<Float> = null;

    public function new() {
        
    }

    public function iterator() {
        return new SpanIterator<Widget>(widgets, start, length);
    }

    public function iteratorRest() {
        return new SpanIterator<Widget>(widgets, start, getTotalCount() - start);
    }

    inline public function of(widget:Widget, children:Array<Widget>) {
        reset();

        widgets = children;

        w = 0.0;
        h = 0.0;

        hgap = switch widget.hgap {
            case Fixed(v): hgap = v;
            default: null;
        }
        vgap = switch widget.vgap {
            case Fixed(v): vgap = v;
            default: null;
        }

        left = 0.0;
        top = 0.0;
        right = 0.0;
        bottom = 0.0;
        switch widget.padding {
            case All(v):
                left += v;
                top += v;
                right += v;
                bottom += v;
            case Only(l, t, r, b):
                left += l;
                top += t;
                right += r;
                bottom += b;
        }
        switch widget.margin {
            case All(v):
                left += v;
                top += v;
                right += v;
                bottom += v;
            case Only(l, t, r, b):
                left += l;
                top += t;
                right += r;
                bottom += b;
        }

        for (widget in children) {
            widget.x = 0.0;
            widget.y = 0.0;
        }
    }

    public function push() {
        if (start + length < getTotalCount()) {
            length++;
        }
    }

    inline public function shift() {
        start += length;
        length = 0;
        shifts++;
    }

    inline public function first() {
        start = 0;
        length = 0;
        shifts = 0;
    }
    
    inline public function fill() {
        start = 0;
        length = 0;
        for (widget in widgets) {
            if (widget.isEnable) {
                length++;
            }
        }
    }

    inline public function reset() {
        start = 0;
        length = 0;

        shifts = 0;

        widgets = null;

        dx = 0;
        dy = 0;

        left = 0.0;
        top = 0.0;
        right = 0.0;
        bottom = 0.0;

        hgap = null;
        vgap = null;
    }

    public function hasNext() {
        return iteratorRest().hasNext();
    }

    inline public function getTotalCount() {
        return widgets.count(i -> i.isEnable);
    }

    inline public function setWidth(v:Float) {
        w = Math.max(v - insetsHorizontal, 0.0);
    }

    inline public function getWidth(min:Null<Float>, max:Null<Float>) {
        return Utils.clamp(w + insetsHorizontal, min, max);
    }

    inline public function setHeight(v:Float) {
        h = Math.max(v - insetsVertical, 0.0);
    }

    inline public function getHeight(min:Null<Float>, max:Null<Float>) {
        return Utils.clamp(h + insetsVertical, min, max);
    }

    inline public function getContentHeight(min:Null<Float>, max:Null<Float>) {
        return Utils.clamp(h - insetsVertical, min, max);
    }

    inline public function getMaxWidth() {
        var w = 0.0;
        for (widget in iterator()) {
            w = Math.max(widget.w, w);
        }
        return w;
    }

    inline public function getTotalWidth() {
        var w = 0.0;
        for (widget in iterator()) {
            w += widget.w;
        }
        return w + Utils.space(hgap ?? 0.0, length);
    }

    inline public function getTotalHeight() {
        var h = 0.0;
        for (widget in iterator()) {
            h += widget.h;
        }
        return h + Utils.space(vgap ?? 0.0, length);
    }

    inline public function getMaxHeight() {
        var h = 0.0;
        for (widget in iterator()) {
            h = Math.max(widget.h, h);
        }
        return h;
    }

    public function fillHorizontal() {
        var dx = dx;
        var i = 0;
        for (widget in iteratorRest()) {
            var w = widget.horizontal.match(Resizing.Fill) ? (widget.minW ?? widget.maxW) : widget.w;
            var isFirst = i == 0;
            
            if (isFirst)
                push();
            if (w == null || dx + w > this.w) {
                break;
            }
            if (!isFirst)
                push();
            
            dx += (w ?? 0.0) + (hgap ?? 0.0);
            i++;
        }
    }

    public function fillVertical() {
        var dy = dy;
        var i = 0;
        for (widget in iteratorRest()) {
            var h = widget.vertical.match(Resizing.Fill) ? (widget.minH ?? widget.maxH) : widget.h;
            var isFirst = i == 0;
            
            if (isFirst)
                push();
            if (h == null || dy + h > this.h) {
                break;
            }
            if (!isFirst)
                push();
            
            dy += (h ?? 0.0) + (vgap ?? 0.0);
            i++;
        }
    }

    inline public function justifyHorizontal(f:Float, w:Float) {
        for (widget in iterator()) {
            widget.x += Utils.locate(f, 0, this.w, w);
        }
    }

    inline public function justifyVertical(f:Float, h:Float) {
        for (widget in iterator()) {
            widget.y += Utils.locate(f, 0, this.h, h);
        }
    }

    inline public function alignVertical(h:Float) {
        for (widget in iterator()) {
            // widget.y += Utils.locate(widget.align, dy, h, widget.h);
            widget.y += Utils.locate(widget.align, 0, h, widget.h);
        }
    }

    inline public function alignHorizontal(w:Float) {
        for (widget in iterator()) {
            // widget.x += Utils.locate(widget.align, dx, w, widget.w);
            widget.x += Utils.locate(widget.align, 0, w, widget.w);
        }
    }

    public function distributeHorizontal() {
        var dx = dx;
        var free = w - this.fold((i, r) -> r + i.w, 0.0);
        var gap = hgap ?? Utils.distribute(free, length);
        for (widget in iterator()) {
            widget.x = dx;
            widget.y = dy;
            dx += widget.w + gap;
        }
    }

    inline public function distributeVertical() {
        var dy = dy;
        var free = h - this.fold((i, r) -> r + i.h, 0.0);
        var gap = vgap ?? Utils.distribute(free, length);
        for (widget in iterator()) {
            widget.x = dx;
            widget.y = dy;
            dy += widget.h + gap;
        }
    }

    public function distributeCorner() {
        var dx = dx;
        var dy = dy;
        for (widget in iterator()) {
            widget.x = dx;
            widget.y = dy;
        }
    }

    inline public function anchorsWidth(size:Float) {
        for (widget in iterator()) {
            // if (widget.horizontal.match(Resizing.Fill))
            //     continue;
            if (widget.left != null || widget.right != null)
                Utils.anchor(widget.left, widget.right, size, widget.horizontal.match(Resizing.Fill) ? 0.0 : widget.w, null, v -> widget.w = Utils.clamp(v, widget.minW ?? 0.0, widget.maxW));
        }
    }

    inline public function anchorsHorizontal(size:Float) {
        for (widget in iterator()) {
            // if (widget.horizontal.match(Resizing.Fill))
            //     continue;
            if (widget.left != null || widget.right != null)
                Utils.anchor(widget.left, widget.right, size, widget.w, v -> widget.x = dx + v);
        }
    }

    inline public function anchorsHeight(size:Float) {
        for (widget in iterator()) {
            // if (widget.vertical.match(Resizing.Fill))
            //     continue;
            if (widget.top != null || widget.bottom != null)
                Utils.anchor(widget.top, widget.bottom, size, widget.vertical.match(Resizing.Fill) ? 0.0 : widget.h, null, v -> widget.h = Utils.clamp(v, widget.minH ?? 0.0, widget.maxH));
        }
    }

    inline public function anchorsVertical(size:Float) {
        for (widget in iterator()) {
            // if (widget.vertical.match(Resizing.Fill))
            //     continue;
            if (widget.top != null || widget.bottom != null)
                Utils.anchor(widget.top, widget.bottom, size, widget.h, v -> widget.y = dy + v);
        }
    }

    inline public function aspect() {
        for (widget in iterator()) {
            if (widget.aspect == null)
                continue;
            if (widget.vertical == null) {
                widget.h = widget.w * widget.aspect;
            } else if (widget.horizontal == null) {
                widget.w = widget.h * widget.aspect;
            }
        }
    }

    inline public function fit(x:Float, y:Float) {
        for (widget in iterator()) {
            var mleft = 0.0;
            var mtop = 0.0;
            var mright = 0.0;
            var mbottom = 0.0;
            switch widget.margin {
                case All(v):
                    mleft += v;
                    mtop += v;
                    mright += v;
                    mbottom += v;
                case Only(l, t, r, b):
                    mleft += l;
                    mtop += t;
                    mright += r;
                    mbottom += b;
            }

            widget.x += x + left + mleft;
            widget.y += y + top + mtop;
            widget.w -= mleft + mright;
            widget.h -= mtop + mbottom;
        }
    }
}