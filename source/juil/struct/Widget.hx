package juil.struct;

import juil.types.Anchor;
import juil.types.Direction;
import juil.types.Gap;
import juil.types.Insets;
import juil.types.Resizing;

typedef Widget = {
    x:Float,
    y:Float,
    w:Float,
    h:Float,

    isEnable:Bool,
    // order:Int,
    
    pivotX:Float,
    pivotY:Float,

    minW:Null<Float>,
    maxW:Null<Float>,
    minH:Null<Float>,
    maxH:Null<Float>,

    align:Float,
    aspect:Null<Float>,

    margin:Insets,
    padding:Insets,
    
    horizontal:Null<Resizing>,
    vertical:Null<Resizing>,
    hjustify:Float,
    vjustify:Float,
    direction:Direction,
    hgap:Gap,
    vgap:Gap,
    wrap:Bool,

    left:Null<Anchor>,
    top:Null<Anchor>,
    right:Null<Anchor>,
    bottom:Null<Anchor>
}
