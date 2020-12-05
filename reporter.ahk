#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

class Reporter {
    ; Outputs results of the runner to DebugOutput
    static report(runner) {
        OutputDebug(Jolly.Reporter.getReport(runner))
    }

    static getReport(runnerResults) {
        report := ""
        itResults := runnerResults.itResults
        if (itResults.length == 0) {
            return "No tests found"
        }
        testCount := itResults.length
        passCount := testCount
        for (itResult in itResults) {
            report .= (itResult.passed ? "PASS" : "FAIL") ": " itResult.name "`n"
            if (!itResult.passed) {
                report .= "    " "#" itResult.failedIndex ": " itResult.failedMessage "`n"
                passCount--
            }
        }
        failCount := testCount - passCount
        allTestsPassed := passCount == testCount
        report .= "`n"
        report .= (passCount == testCount ? "PASS" : "FAIL") ":`n"
        report .= "    Tests: "
        if (failCount > 0) {
            report .= failCount " failed, "
        }
        if (passCount > 0) {
            report .= passCount " passed, "
        }
        report .= testCount " total"
        return report
    }
}
