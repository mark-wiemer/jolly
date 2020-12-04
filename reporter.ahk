#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

class Reporter {
    ; Outputs results of the runner to DebugOutput
    static report(itResults) {
        OutputDebug("Reporting...`n")
        for (itResult in itResults) {
            if (!itResult.passed) {
                OutputDebug("FAIL: " itResult.name)
                OutputDebug("    " "#" itResult.failedIndex ": " itResult.failedMessage)
            }
        }
        OutputDebug("`nReporting complete.")
    }
}
