package juil;

import Math;
import utest.Assert;
import utest.Test;

class FormTest extends Test {
    /// @todo min max

    // --------------------------------------------------------------------------------
    // Generic
    // --------------------------------------------------------------------------------

    public function testEnable() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(100);
            widget.vertical = Hug;
            widget.x = 5;
            widget.y = 10;
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Even;
            widget.vgap = Even;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(50);
            widget.vertical = Fixed(60);
            widget.isEnable = false;
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fixed(5);
            widget.maxW = 35;
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(20, Math.round(widget1.h));
        
        Assert.equals(0, Math.round(widget2.x));
        Assert.equals(0, Math.round(widget2.y));
        Assert.equals(0, Math.round(widget2.w));
        Assert.equals(0, Math.round(widget2.h));
        
        Assert.equals(10, Math.round(widget3.x));
        Assert.equals(15, Math.round(widget3.y));
        Assert.equals(35, Math.round(widget3.w));
        Assert.equals(5, Math.round(widget3.h));

        Assert.equals(63, Math.round(widget4.x));
        Assert.equals(15, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(90, Math.round(widget5.x));
        Assert.equals(15, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testAspect() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(100);
            widget.vertical = Hug;
            widget.x = 5;
            widget.y = 10;
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Even;
            widget.vgap = Even;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(50);
            widget.vertical = Fixed(60);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = null;
            widget.aspect = 2;
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();
        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(70, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(50, Math.round(widget2.w));
        Assert.equals(60, Math.round(widget2.h));
        
        Assert.equals(60, Math.round(widget3.x));
        Assert.equals(15, Math.round(widget3.y));
        Assert.equals(20, Math.round(widget3.w));
        Assert.equals(40, Math.round(widget3.h));

        Assert.equals(80, Math.round(widget4.x));
        Assert.equals(15, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(90, Math.round(widget5.x));
        Assert.equals(15, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testFixed() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 5;
            widget.y = 10;
            widget.horizontal = Fixed(300);
            widget.vertical = Fixed(100);
        });

        var form = new Form(widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(300, Math.round(widget1.w));
        Assert.equals(100, Math.round(widget1.h));
    }

    // --------------------------------------------------------------------------------
    // Row
    // --------------------------------------------------------------------------------

    public function testRow() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 5;
            widget.y = 10;
            widget.horizontal = Fixed(300);
            widget.vertical = Fixed(100);
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Fixed(2);
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(300, Math.round(widget1.w));
        Assert.equals(100, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(22, Math.round(widget3.x));
        Assert.equals(15, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testRowHug() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 5;
            widget.y = 10;
            widget.horizontal = Hug;
            widget.vertical = Hug;
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Fixed(2);
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(32, Math.round(widget1.w));
        Assert.equals(20, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(22, Math.round(widget3.x));
        Assert.equals(15, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testRowHugFill() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 5;
            widget.y = 10;
            widget.horizontal = Fixed(100);
            widget.vertical = Hug;
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Fixed(2);
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(20, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(22, Math.round(widget3.x));
        Assert.equals(15, Math.round(widget3.y));
        Assert.equals(78, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testRowWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 5;
            widget.y = 10;
            widget.horizontal = Fixed(300);
            widget.vertical = Fixed(100);
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Fixed(2);
            widget.wrap = true;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(300, Math.round(widget1.w));
        Assert.equals(100, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(22, Math.round(widget3.x));
        Assert.equals(15, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testRowHugWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 5;
            widget.y = 10;
            widget.horizontal = Hug;
            widget.vertical = Hug;
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Fixed(2);
            widget.vgap = Fixed(2);
            widget.wrap = true;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(20, Math.round(widget1.w));
        Assert.equals(32, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(10, Math.round(widget3.x));
        Assert.equals(27, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testRowHugFillWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Hug;
            widget.vertical = Hug;
            widget.x = 5;
            widget.y = 10;
            widget.direction = Row;
            widget.wrap = true;
            widget.padding = All(5);
            widget.hgap = Even;
            widget.vgap = Even;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(50);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fixed(5);
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(60, Math.round(widget1.w));
        Assert.equals(35, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(50, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(10, Math.round(widget3.x));
        Assert.equals(25, Math.round(widget3.y));
        Assert.equals(50, Math.round(widget3.w));
        Assert.equals(5, Math.round(widget3.h));

        Assert.equals(10, Math.round(widget4.x));
        Assert.equals(30, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(50, Math.round(widget5.x));
        Assert.equals(30, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testRowHugVerticalFillWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(100);
            widget.vertical = Hug;
            widget.x = 5;
            widget.y = 10;
            widget.direction = Row;
            widget.wrap = true;
            widget.padding = All(5);
            widget.hgap = Even;
            widget.vgap = Even;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(50);
            widget.vertical = Fixed(60);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fixed(5);
            widget.maxW = 50;
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(80, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(50, Math.round(widget2.w));
        Assert.equals(60, Math.round(widget2.h));
        
        Assert.equals(10, Math.round(widget3.x));
        Assert.equals(75, Math.round(widget3.y));
        Assert.equals(50, Math.round(widget3.w));
        Assert.equals(5, Math.round(widget3.h));

        Assert.equals(70, Math.round(widget4.x));
        Assert.equals(75, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(90, Math.round(widget5.x));
        Assert.equals(75, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testRowFillFillWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(100);
            widget.vertical = Hug;
            widget.x = 5;
            widget.y = 10;
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Even;
            widget.vgap = Even;
            widget.wrap = true;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(50);
            widget.vertical = Fixed(60);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fill;
            widget.maxW = 35;
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(80, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(50, Math.round(widget2.w));
        Assert.equals(60, Math.round(widget2.h));
        
        Assert.equals(65, Math.round(widget3.x));
        Assert.equals(15, Math.round(widget3.y));
        Assert.equals(35, Math.round(widget3.w));
        Assert.equals(60, Math.round(widget3.h));

        Assert.equals(10, Math.round(widget4.x));
        Assert.equals(75, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(90, Math.round(widget5.x));
        Assert.equals(75, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testRowAnchorsWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(100);
            widget.vertical = Hug;
            widget.x = 5;
            widget.y = 10;
            widget.direction = Row;
            widget.padding = All(5);
            widget.hgap = Even;
            widget.vgap = Even;
            widget.wrap = true;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(50);
            widget.vertical = Fixed(60);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fill;
            widget.maxW = 35;
            widget.top = Center(2);
            widget.bottom = Fixed(2);
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(5, Math.round(widget1.x));
        Assert.equals(10, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(80, Math.round(widget1.h));
        
        Assert.equals(10, Math.round(widget2.x));
        Assert.equals(15, Math.round(widget2.y));
        Assert.equals(50, Math.round(widget2.w));
        Assert.equals(60, Math.round(widget2.h));
        
        Assert.equals(65, Math.round(widget3.x));
        Assert.equals(43, Math.round(widget3.y));
        Assert.equals(35, Math.round(widget3.w));
        Assert.equals(30, Math.round(widget3.h));

        Assert.equals(10, Math.round(widget4.x));
        Assert.equals(75, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(90, Math.round(widget5.x));
        Assert.equals(75, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    // --------------------------------------------------------------------------------
    // Column
    // --------------------------------------------------------------------------------

    public function testColumn() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 10;
            widget.y = 5;
            widget.horizontal = Fixed(100);
            widget.vertical = Fixed(300);
            widget.direction = Column;
            widget.padding = All(5);
            widget.vgap = Fixed(2);
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(300, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(15, Math.round(widget3.x));
        Assert.equals(22, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testColumnHug() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 10;
            widget.y = 5;
            widget.horizontal = Hug;
            widget.vertical = Hug;
            widget.direction = Column;
            widget.padding = All(5);
            widget.vgap = Fixed(2);
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(20, Math.round(widget1.w));
        Assert.equals(32, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(15, Math.round(widget3.x));
        Assert.equals(22, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testColumnHugFill() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 10;
            widget.y = 5;
            widget.horizontal = Hug;
            widget.vertical = Fixed(100);
            widget.direction = Column;
            widget.padding = All(5);
            widget.vgap = Fixed(2);
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fill;
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(20, Math.round(widget1.w));
        Assert.equals(100, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(15, Math.round(widget3.x));
        Assert.equals(22, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(78, Math.round(widget3.h));
    }

    public function testColumnWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 10;
            widget.y = 5;
            widget.horizontal = Fixed(100);
            widget.vertical = Fixed(300);
            widget.direction = Column;
            widget.padding = All(5);
            widget.vgap = Fixed(2);
            widget.wrap = true;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(300, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(15, Math.round(widget3.x));
        Assert.equals(22, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testColumnHugWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.x = 10;
            widget.y = 5;
            widget.horizontal = Hug;
            widget.vertical = Hug;
            widget.direction = Column;
            widget.padding = All(5);
            widget.vgap = Fixed(2);
            widget.hgap = Fixed(2);
            widget.wrap = true;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(32, Math.round(widget1.w));
        Assert.equals(20, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(10, Math.round(widget2.h));
        
        Assert.equals(27, Math.round(widget3.x));
        Assert.equals(10, Math.round(widget3.y));
        Assert.equals(10, Math.round(widget3.w));
        Assert.equals(10, Math.round(widget3.h));
    }

    public function testColumnHugFillWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Hug;
            widget.vertical = Hug;
            widget.x = 10;
            widget.y = 5;
            widget.direction = Column;
            widget.wrap = true;
            widget.padding = All(5);
            widget.vgap = Even;
            widget.hgap = Even;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(50);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(5);
            widget.vertical = Fill;
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(35, Math.round(widget1.w));
        Assert.equals(60, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(10, Math.round(widget2.w));
        Assert.equals(50, Math.round(widget2.h));
        
        Assert.equals(25, Math.round(widget3.x));
        Assert.equals(10, Math.round(widget3.y));
        Assert.equals(5, Math.round(widget3.w));
        Assert.equals(50, Math.round(widget3.h));

        Assert.equals(30, Math.round(widget4.x));
        Assert.equals(10, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(30, Math.round(widget5.x));
        Assert.equals(50, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testColumnHugHorizontalFillWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Hug;
            widget.vertical = Fixed(100);
            widget.x = 10;
            widget.y = 5;
            widget.direction = Column;
            widget.wrap = true;
            widget.padding = All(5);
            widget.hgap = Even;
            widget.vgap = Even;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(60);
            widget.vertical = Fixed(50);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(5);
            widget.vertical = Fill;
            widget.maxH = 50;
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(80, Math.round(widget1.w));
        Assert.equals(100, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(60, Math.round(widget2.w));
        Assert.equals(50, Math.round(widget2.h));
        
        Assert.equals(75, Math.round(widget3.x));
        Assert.equals(10, Math.round(widget3.y));
        Assert.equals(5, Math.round(widget3.w));
        Assert.equals(50, Math.round(widget3.h));

        Assert.equals(75, Math.round(widget4.x));
        Assert.equals(70, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(75, Math.round(widget5.x));
        Assert.equals(90, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testColumnFillFillWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Hug;
            widget.vertical = Fixed(100);
            widget.x = 10;
            widget.y = 5;
            widget.direction = Column;
            widget.padding = All(5);
            widget.vgap = Even;
            widget.hgap = Even;
            widget.wrap = true;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(60);
            widget.vertical = Fixed(50);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fill;
            widget.maxH = 35;
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(80, Math.round(widget1.w));
        Assert.equals(100, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(60, Math.round(widget2.w));
        Assert.equals(50, Math.round(widget2.h));
        
        Assert.equals(15, Math.round(widget3.x));
        Assert.equals(65, Math.round(widget3.y));
        Assert.equals(60, Math.round(widget3.w));
        Assert.equals(35, Math.round(widget3.h));

        Assert.equals(75, Math.round(widget4.x));
        Assert.equals(10, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(75, Math.round(widget5.x));
        Assert.equals(90, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testColumnAnchorsWrap() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Hug;
            widget.vertical = Fixed(100);
            widget.x = 10;
            widget.y = 5;
            widget.direction = Column;
            widget.padding = All(5);
            widget.hgap = Even;
            widget.vgap = Even;
            widget.wrap = true;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(60);
            widget.vertical = Fixed(50);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fill;
            widget.maxH = 35;
            widget.left = Center(2);
            widget.right = Fixed(2);
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(80, Math.round(widget1.w));
        Assert.equals(100, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(60, Math.round(widget2.w));
        Assert.equals(50, Math.round(widget2.h));
        
        Assert.equals(43, Math.round(widget3.x));
        Assert.equals(65, Math.round(widget3.y));
        Assert.equals(30, Math.round(widget3.w));
        Assert.equals(35, Math.round(widget3.h));

        Assert.equals(75, Math.round(widget4.x));
        Assert.equals(10, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(75, Math.round(widget5.x));
        Assert.equals(90, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    // --------------------------------------------------------------------------------
    // Stack
    // --------------------------------------------------------------------------------

    public function testStack() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(100);
            widget.vertical = Fixed(100);
            widget.x = 10;
            widget.y = 5;
            widget.direction = Stack;
            widget.padding = All(5);
            widget.hjustify = 0;
            widget.vjustify = 1;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fixed(50);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(20);
            widget.vertical = Fixed(30);
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.vertical = Fixed(10);
            widget.align = 1;
            widget.left = Fixed(0);
            widget.right = Fixed(10);
            widget.top = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(100, Math.round(widget1.w));
        Assert.equals(100, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(50, Math.round(widget2.y));
        Assert.equals(90, Math.round(widget2.w));
        Assert.equals(50, Math.round(widget2.h));
        
        Assert.equals(50, Math.round(widget3.x));
        Assert.equals(70, Math.round(widget3.y));
        Assert.equals(20, Math.round(widget3.w));
        Assert.equals(30, Math.round(widget3.h));

        Assert.equals(15, Math.round(widget4.x));
        Assert.equals(20, Math.round(widget4.y));
        Assert.equals(80, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(55, Math.round(widget5.x));
        Assert.equals(90, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }

    public function testStackHug() {
        var widget1 = Form.CreateWidget(widget -> {
            widget.horizontal = Hug;
            widget.vertical = Hug;
            widget.x = 10;
            widget.y = 5;
            widget.direction = Stack;
            widget.padding = All(5);
            widget.hjustify = 0;
            widget.vjustify = 1;
        });
        var widget2 = Form.CreateWidget(widget -> {
            widget.horizontal = Fill;
            widget.vertical = Fixed(50);
        });
        var widget3 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(20);
            widget.vertical = Fixed(30);
        });
        var widget4 = Form.CreateWidget(widget -> {
            widget.vertical = Fixed(10);
            widget.align = 1;
            widget.left = Fixed(0);
            widget.right = Fixed(10);
            widget.top = Fixed(10);
        });
        var widget5 = Form.CreateWidget(widget -> {
            widget.horizontal = Fixed(10);
            widget.vertical = Fixed(10);
        });

        var form = new Form(widget1);
        form.addWidget(widget1);
        form.addWidget(widget2, widget1);
        form.addWidget(widget3, widget1);
        form.addWidget(widget4, widget1);
        form.addWidget(widget5, widget1);

        form.update();

        Assert.equals(10, Math.round(widget1.x));
        Assert.equals(5, Math.round(widget1.y));
        Assert.equals(30, Math.round(widget1.w));
        Assert.equals(60, Math.round(widget1.h));
        
        Assert.equals(15, Math.round(widget2.x));
        Assert.equals(10, Math.round(widget2.y));
        Assert.equals(20, Math.round(widget2.w));
        Assert.equals(50, Math.round(widget2.h));
        
        Assert.equals(15, Math.round(widget3.x));
        Assert.equals(30, Math.round(widget3.y));
        Assert.equals(20, Math.round(widget3.w));
        Assert.equals(30, Math.round(widget3.h));

        Assert.equals(15, Math.round(widget4.x));
        Assert.equals(20, Math.round(widget4.y));
        Assert.equals(10, Math.round(widget4.w));
        Assert.equals(10, Math.round(widget4.h));

        Assert.equals(20, Math.round(widget5.x));
        Assert.equals(50, Math.round(widget5.y));
        Assert.equals(10, Math.round(widget5.w));
        Assert.equals(10, Math.round(widget5.h));
    }
}