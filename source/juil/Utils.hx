package juil;

import juil.struct.Widget;
import juil.types.Anchor;

class Utils {
    @:noUsing
    public static function lerp(t:Float, x0:Float, y0:Float, x1:Float, y1:Float) {
        return y0 + (t - x0) * (y1 - y0) / (x1 - x0);
    }

    @:noUsing
    public static function clamp(v:Null<Float>, min:Null<Float>, max:Null<Float>) {
        if (v == null) return null;
        v = Math.max(v, min ?? v);
        v = Math.min(v, max ?? v);
        return v;
    }

    @:noUsing
    public static function space(spacing:Float, count:Int) {
        return Math.max(count - 1, 0.0) * spacing;
    }

    @:noUsing
    public static function distribute(space:Float, count:Int) {
        return space / Math.max(count - 1, 1.0);
    }

    @:noUsing
    public static function locate(f:Float, pos:Float, size:Float, content:Float) {
        return lerp(f, -1, pos, 1, pos + size - content);
    }

    @:noUsing
    public static function anchor(?left:Anchor, ?right:Anchor, size:Float, content:Float, ?setLeft:Float->Void = null, ?setRight:Float->Void = null) {
        if (left == null && right == null) {
            if (setLeft != null) setLeft(0);
            if (setRight != null) setRight(size);
            return;
        }
        
        // Calculating offsets relative to the borders
        // left
        var dl = switch (left) {
            case null: 0;
            case Fixed(v): v;
            case Scale(v): size - size * v;
            case Center(v): size / 2 - v;
        }
        // right
        var dr = switch (right) {
            case null: 0;
            case Fixed(v): v;
            case Scale(v): size - size * v;
            case Center(v): size / 2 - v;
        }

        // Converting offsets to absolute values
        var l = 0.0;
        var r = 0.0;
        if (left != null && right != null) {
            l = dl;
            r = size - dl - dr;
        } else if (left != null) {
            l = dl;
            r = content;
        } else if (right != null) {
            r = content;
            l = size - r - dr;
        }

        if (setLeft != null) setLeft(l);
        if (setRight != null) setRight(r);
    }
}