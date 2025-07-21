package juil.iterator;

import juil.struct.Widget;

class SpanIterator<T:Widget> {
    var data:Array<T>;
    var index:Int;
    var remaining:Int;

    inline public function new(data:Array<T>, start:Int, count:Int) {
        this.data = data;
        this.remaining = count;
        this.index = findEnabledIndex(start);
    }

    inline public function hasNext() {
        return remaining > 0 && index < data.length;
    }

    inline public function next() {
        var item = data[index];
        remaining--;
        index = findNextEnabled(index + 1);
        return item;
    }

    function findEnabledIndex(enabledPos:Int) {
        // We start counting from enabledPos as optimization
        // assuming searching index can't be found before
        var count = enabledPos - 1;
        for (i in enabledPos...data.length) {
            if (data[i].isEnable && ++count == enabledPos)
                return i;
        }
        return data.length;     // hasNext() == false
    }

    function findNextEnabled(start:Int) {
        for (i in start...data.length) {
            if (data[i].isEnable)
                return i;
        }
        return data.length;
    }
}
