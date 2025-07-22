package juil;

import juil.struct.Area;
import juil.struct.Widget;
import juil.types.Resizing;

using Lambda;
using juil.Utils;

class Form {
    public var widgets = new Map<Int, Widget>();

    public var children = new Map<Widget, Array<Widget>>();

    public var onInput:Widget->Void = null;

    var root:Widget = null;

    var context = new Context();

    public static function CreateWidget(?build:Widget->Void, input = false):Widget {
        var widget:Widget = {
            x: 0,
            y: 0,
            w: 0,
            h: 0,
            area: input ? new Area() : null,
            isEnable: true,
            // order: 0,
            pivotX: 0.0,
            pivotY: 0.0,
            minW: null,
            maxW: null,
            minH: null,
            maxH: null,
            align: -1,
            aspect: null,
            margin: All(0),
            padding: All(0),
            horizontal: Fill,
            vertical: Fill,
            hjustify: -1,
            vjustify: -1,
            direction: Row,
            hgap: Fixed(0),
            vgap: Fixed(0),
            wrap: false,
            left: null,
            top: null,
            right: null,
            bottom: null
        }
        
        if (build != null)
            build(widget);

        return widget;
    }

    public function new(root:Widget) {
        this.root = root;
    }

    public function update() {
        calcAspect(root);
        calcFixed(root);
        calcSize(root);
        calcLayout(root);
        calcPosition(root);
    }

    public function input(x:Float, y:Float, isDown:Bool) {
        calcArea(root, x, y, isDown);
    }

    public function addWidget(widget:Widget, ?parent:Widget) {
        if (children.exists(widget))
            return false;
        if (parent != null && !children.exists(parent))
            return false;
        children.set(widget, []);
        if (parent != null) {
            children.get(parent).push(widget);
        }
        return true;
    }

    function calcArea(widget:Widget, x:Float, y:Float, isDown:Bool) {
        if (!widget.isEnable)
            return false;
        var children = children.get(widget);
        
        if (children != null) {
            for (i in 0...children.length) {
                var child = children[children.length - i - 1];
                if (calcArea(child, x, y, isDown)) {
                    return true;
                }
            }
        }

        if (widget.area != null) {
            widget.area.x = widget.x;
            widget.area.y = widget.y;
            widget.area.w = widget.w;
            widget.area.h = widget.h;
            widget.area.update(x, y, isDown);
            if (onInput != null && widget.area.isPressed || widget.area.isReleased || widget.area.isDragStarted || widget.area.isDropped) 
                onInput(widget);
            return widget.area.isOver || widget.area.isDragging;
        }
        
        return false;
    }

    function calcAspect(widget:Widget) {
        if (!widget.isEnable)
            return;
        var children = children.get(widget);
        if (children == null)
            return;

        context.of(widget, children);
        context.fill();
        context.aspect();

        for (child in children) {
            calcAspect(child);
        }
    }

    function calcFixed(widget:Widget) {
        if (!widget.isEnable)
            return;
        var children = children.get(widget);
        if (children != null) {
            for (child in children) {
                calcFixed(child);
            }
        }

        switch widget.horizontal {
            case Fixed(v): widget.w = Utils.clamp(v, widget.minW, widget.maxW);
            default:
        }
        switch widget.vertical {
            case Fixed(v): widget.h = Utils.clamp(v, widget.minH, widget.maxH);
            default:
        }
    }

    function calcSize(widget:Widget) {
        if (!widget.isEnable)
            return;
        var children = children.get(widget);
        if (children == null)
            return;
        
        context.of(widget, children);

        if (widget.wrap) {
            switch widget.direction {
                case Row:
                    if (widget.horizontal.match(Resizing.Hug) && widget.vertical.match(Resizing.Hug)) {
                        while (context.hasNext()) {
                            context.fillHorizontal();
                            var w = context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? r + (i.minW ?? i.maxW ?? 0.0) : r + i.w, 0.0);
                            context.w = Math.max(context.w, w + Utils.space(context.hgap ?? 0.0, context.length));
                            context.h += context.fold((i, r) -> Math.max(r, i.vertical.match(Resizing.Fill) ? (i.minH ?? i.maxH ?? 0.0) : i.h), 0.0);
                            context.shift();
                        }
                        context.h += Utils.space(context.vgap ?? 0.0, context.shifts);
                        widget.w = context.getWidth(widget.minW, widget.maxW);
                        widget.h = context.getHeight(widget.minH, widget.maxH);
                    } else if (widget.horizontal.match(Resizing.Hug)) {
                        while (context.hasNext()) {
                            context.fillHorizontal();
                            var w = context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? r + (i.minW ?? i.maxW ?? 0.0) : r + i.w, 0.0);
                            context.w = Math.max(context.w, w + Utils.space(context.hgap ?? 0.0, context.length));
                            context.shift();
                        }
                        widget.w = context.getWidth(widget.minW, widget.maxW);
                    } else if (widget.vertical.match(Resizing.Hug)) {
                        context.setWidth(widget.w);
                        while (context.hasNext()) {
                            context.fillHorizontal();
                            context.h += context.fold((i, r) -> Math.max(r, i.vertical.match(Resizing.Fill) ? (i.minH ?? i.maxH ?? 0.0) : i.h), 0.0);
                            context.shift();
                        }
                        context.h += Utils.space(context.vgap ?? 0.0, context.shifts);
                        widget.h = context.getHeight(widget.minH, widget.maxH);
                    }

                case Column:
                    if (widget.horizontal.match(Resizing.Hug) && widget.vertical.match(Resizing.Hug)) {
                        while (context.hasNext()) {
                            context.fillVertical();
                            var h = context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? r + (i.minH ?? i.maxH ?? 0.0) : r + i.h, 0.0);
                            context.h = Math.max(context.h, h + Utils.space(context.vgap ?? 0.0, context.length));
                            context.w += context.fold((i, r) -> Math.max(r, i.horizontal.match(Resizing.Fill) ? (i.minW ?? i.maxW ?? 0.0) : i.w), 0.0);
                            context.shift();
                        }
                        context.w += Utils.space(context.hgap ?? 0.0, context.shifts);
                        widget.h = context.getHeight(widget.minH, widget.maxH);
                        widget.w = context.getWidth(widget.minW, widget.maxW);
                    } else if (widget.vertical.match(Resizing.Hug)) {
                        while (context.hasNext()) {
                            context.fillVertical();
                            var h = context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? r + (i.minH ?? i.maxH ?? 0.0) : r + i.h, 0.0);
                            context.h = Math.max(context.h, h + Utils.space(context.vgap ?? 0.0, context.length));
                            context.shift();
                        }
                        widget.h = context.getHeight(widget.minH, widget.maxH);
                    } else if (widget.horizontal.match(Resizing.Hug)) {
                        context.setHeight(widget.h);
                        while (context.hasNext()) {
                            context.fillVertical();
                            context.w += context.fold((i, r) -> Math.max(r, i.horizontal.match(Resizing.Fill) ? (i.minW ?? i.maxW ?? 0.0) : i.w), 0.0);
                            context.shift();
                        }
                        context.w += Utils.space(context.hgap ?? 0.0, context.shifts);
                        widget.w = context.getWidth(widget.minW, widget.maxW);
                    }

                default:
            }
        } else {
            context.fill();
            switch widget.direction {
                case Row:
                    if (widget.horizontal.match(Resizing.Hug)) {
                        context.w = context.fold((i, r) -> r + (i.horizontal.match(Resizing.Fill) ? (i.minW ?? i.maxW ?? 0.0) : i.w), 0.0);
                        context.w += Utils.space(context.hgap ?? 0.0, context.length);
                        widget.w = context.getWidth(widget.minW, widget.maxW);
                    }
                    if (widget.vertical.match(Resizing.Hug)) {
                        context.h = context.fold((i, r) -> Math.max(r, (i.vertical.match(Resizing.Fill) ? (i.minH ?? i.maxH ?? 0.0) : i.h)), 0.0);
                        widget.h = context.getHeight(widget.minH, widget.maxH);
                    }

                case Column:
                    if (widget.horizontal.match(Resizing.Hug)) {
                        context.w = context.fold((i, r) -> Math.max(r, (i.horizontal.match(Resizing.Fill) ? (i.minW ?? i.maxW ?? 0.0) : i.w)), 0.0);
                        widget.w = context.getWidth(widget.minW, widget.maxW);
                    }
                    if (widget.vertical.match(Resizing.Hug)) {
                        context.h = context.fold((i, r) -> r + (i.vertical.match(Resizing.Fill) ? (i.minH ?? i.maxH ?? 0.0) : i.h), 0.0);
                        context.h += Utils.space(context.vgap ?? 0.0, context.length);
                        widget.h = context.getHeight(widget.minH, widget.maxH);
                    }

                default:
            }
        }

        switch widget.direction {
            case Stack:
                if (widget.horizontal.match(Resizing.Hug)) {
                    context.w = context.fold((i, r) -> Math.max(r, (i.horizontal.match(Resizing.Fill) ? (i.minW ?? i.maxW ?? 0.0) : i.w)), 0.0);
                    widget.w = context.getWidth(widget.minW, widget.maxW);
                }
                if (widget.vertical.match(Resizing.Hug)) {
                    context.h = context.fold((i, r) -> Math.max(r, (i.vertical.match(Resizing.Fill) ? (i.minH ?? i.maxH ?? 0.0) : i.h)), 0.0);
                    widget.h = context.getHeight(widget.minH, widget.maxH);
                }

            default:
        }

        for (child in children) {
            calcSize(child);
        }
    }

    function calcLayout(widget:Widget) {
        if (!widget.isEnable)
            return;
        var children = children.get(widget);
        if (children == null)
            return;
        
        context.of(widget, children);

        if (widget.wrap) {
            switch widget.direction {
                case Row:
                    context.setWidth(widget.w);
                    while (context.hasNext()) {
                        context.fillHorizontal();
                        var free = context.w - context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? r : r + i.w, 0.0) - Utils.space(context.hgap ?? 0.0, context.length);
                        var min = context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? r + (i.minW ?? 0.0) : r, 0.0);
                        var max = context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? r + (i.maxW ?? widget.w) : r, 0.0);
                        var height = context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? Math.max(r, i.minH ?? 0.0) : Math.max(r, i.h), 0.0);
                        for (w in context) {
                            if (w.horizontal.match(Resizing.Fill))
                                w.w = Utils.clamp(Utils.lerp(Math.max(free, min), min, (w.minW ?? 0.0), max, (w.maxW ?? widget.w)), w.minW, w.maxW);
                            if (w.vertical.match(Resizing.Fill))
                                w.h = Utils.clamp(height, w.minH, w.maxH);
                        }
                        context.anchorsHeight(height);
                        context.shift();
                    }
                    
                case Column:
                    context.setHeight(widget.h);
                    while (context.hasNext()) {
                        context.fillVertical();
                        var free = context.h - context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? r : r + i.h, 0.0) - Utils.space(context.vgap ?? 0.0, context.length);
                        var min = context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? r + (i.minH ?? 0.0) : r, 0.0);
                        var max = context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? r + (i.maxH ?? widget.h) : r, 0.0);
                        var width = context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? Math.max(r, i.minW ?? 0.0) : Math.max(r, i.w), 0.0);
                        for (w in context) {
                            if (w.vertical.match(Resizing.Fill))
                                w.h = Utils.clamp(Utils.lerp(Math.max(free, min), min, (w.minH ?? 0.0), max, (w.maxH ?? widget.h)), w.minH, w.maxH);
                            if (w.horizontal.match(Resizing.Fill))
                                w.w = Utils.clamp(width, w.minW, w.maxW);
                        }
                        context.anchorsWidth(width);
                        context.shift();
                    }

                default:
            }
        } else {
            context.fill();
            switch widget.direction {
                case Row:
                    context.setWidth(widget.w);
                    context.setHeight(widget.h);
                    var free = context.w - context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? r : r + i.w, 0.0) - Utils.space(context.hgap ?? 0.0, context.length);
                    var min = context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? r + (i.minW ?? 0.0) : r, 0.0);
                    var max = context.fold((i, r) -> i.horizontal.match(Resizing.Fill) ? r + (i.maxW ?? widget.w) : r, 0.0);
                    var height = context.h;
                    for (w in context) {
                        if (w.horizontal.match(Resizing.Fill))
                            w.w = Utils.clamp(Utils.lerp(Math.max(free, min), min, (w.minW ?? 0.0), max, (w.maxW ?? widget.w)), w.minW, w.maxW);
                        if (w.vertical.match(Resizing.Fill))
                            w.h = Utils.clamp(height, w.minH, w.maxH);
                    }
                    context.anchorsHeight(height);

                case Column:
                    context.setHeight(widget.h);
                    context.setWidth(widget.w);
                    var free = context.h - context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? r : r + i.h, 0.0) - Utils.space(context.vgap ?? 0.0, context.length);
                    var min = context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? r + (i.minH ?? 0.0) : r, 0.0);
                    var max = context.fold((i, r) -> i.vertical.match(Resizing.Fill) ? r + (i.maxH ?? widget.h) : r, 0.0);
                    var width = context.w;
                    for (w in context) {
                        if (w.vertical.match(Resizing.Fill))
                            w.h = Utils.clamp(Utils.lerp(Math.max(free, min), min, (w.minH ?? 0.0), max, (w.maxH ?? widget.h)), w.minH, w.maxH);
                        if (w.horizontal.match(Resizing.Fill))
                            w.w = Utils.clamp(width, w.minW, w.maxW);
                    }
                    context.anchorsWidth(width);

                default:
            }
        }

        switch widget.direction {
            case Stack:
                context.setWidth(widget.w);
                context.setHeight(widget.h);
                for (w in context) {
                    if (w.horizontal.match(Resizing.Fill))
                        w.w = Utils.clamp(context.w, w.minW, w.maxW);
                    if (w.vertical.match(Resizing.Fill))
                        w.h = Utils.clamp(context.h, w.minH, w.maxH);
                }
                context.anchorsWidth(context.w);
                context.anchorsHeight(context.h);
        
            default:
        }

        for (child in children) {
            calcLayout(child);
        }
    }

    function calcPosition(widget:Widget) {
        if (!widget.isEnable)
            return;
        var children = children.get(widget);
        if (children == null)
            return;
        
        context.of(widget, children);
        context.setWidth(widget.w);
        context.setHeight(widget.h);

        if (widget.wrap) {
            switch widget.direction {
                case Row:
                    // Calculate vgap
                    var vgap = context.vgap;
                    var count = 0;
                    if (context.vgap == null) {
                        var free = context.h;
                        while (context.hasNext()) {
                            context.fillHorizontal();
                            free -= context.getMaxHeight();
                            context.shift();
                            count++;
                        }
                        vgap = Utils.distribute(free, count);
                        context.first();
                    }

                    // Position
                    var height = 0.0;
                    var width = 0.0;
                    while (context.hasNext()) {
                        context.fillHorizontal();
                        context.distributeHorizontal();
                        var w = context.getTotalWidth();
                        var h = context.getMaxHeight();
                        context.anchorsVertical(h);
                        context.alignVertical(h);
                        width = Math.max(width, w);
                        height += h;
                        context.shift();
                        context.dy += h + vgap;
                        context.dx = 0.0;
                        if (context.vgap != null)
                            count++;
                    }
                    context.fill();
                    context.justifyHorizontal(widget.hjustify, width);
                    context.justifyVertical(widget.vjustify, height + Utils.space(vgap, count));
                    context.fit(widget.x, widget.y);

                case Column:
                    // Calculate hgap
                    var hgap = context.hgap;
                    var count = 0;
                    if (context.hgap == null) {
                        var free = context.w;
                        while (context.hasNext()) {
                            context.fillVertical();
                            free -= context.getMaxWidth();
                            context.shift();
                            count++;
                        }
                        hgap = Utils.distribute(free, count);
                        context.first();
                    }

                    // Position
                    var width = 0.0;
                    var height = 0.0;
                    while (context.hasNext()) {
                        context.fillVertical();
                        context.distributeVertical();
                        var h = context.getTotalHeight();
                        var w = context.getMaxWidth();
                        context.anchorsHorizontal(w);
                        context.alignHorizontal(w);
                        height = Math.max(height, h);
                        width += w;
                        context.shift();
                        context.dx += w + hgap;
                        context.dy = 0.0;
                        if (context.hgap != null)
                            count++;
                    }
                    context.fill();
                    context.justifyVertical(widget.vjustify, height);
                    context.justifyHorizontal(widget.hjustify, width + Utils.space(hgap, count));
                    context.fit(widget.x, widget.y);

                default:
            }
        } else {
            context.fill();
            switch widget.direction {
                case Row:
                    context.distributeHorizontal();
                    context.justifyHorizontal(widget.hjustify, context.getTotalWidth());
                    context.justifyVertical(widget.vjustify, context.getMaxHeight());
                    context.anchorsVertical(context.getMaxHeight());
                    context.alignVertical(context.getMaxHeight());
                    context.fit(widget.x, widget.y);

                case Column:
                    context.distributeVertical();
                    context.justifyHorizontal(widget.hjustify, context.getMaxWidth());
                    context.justifyVertical(widget.vjustify, context.getTotalHeight());
                    context.anchorsHorizontal(context.getMaxWidth());
                    context.alignHorizontal(context.getMaxWidth());
                    context.fit(widget.x, widget.y);

                default:
            }
        }

        switch widget.direction {
            case Stack:
                context.distributeCorner();
                // Justify
                for (w in context) {
                    w.x = Utils.locate(widget.hjustify, 0, context.w, w.w);
                    w.y = Utils.locate(widget.vjustify, 0, context.h, w.h);
                }
                context.anchorsVertical(context.h);
                context.anchorsHorizontal(context.w);
                context.fit(widget.x, widget.y);

            default:
        }

        for (child in children) {
            calcPosition(child);
        }
    }
}
