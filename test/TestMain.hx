package;

import juil.FormTest;
import utest.Runner;
import utest.ui.Report;

class TestMain {
    static function main() {
        var runner = new Runner();

        runner.addCase(new FormTest());

        Report.create(runner);

        runner.run();
    }
}