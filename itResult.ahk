#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

class ItResult {
    ; If passed, then -1, else 1-based index of failing matcher
    failedIndex := -1
    ; If passed, then empty string, else matcher message
    failedMessage := ""
    name := ""
    passed := ""

    __New(name, passed, failedMessage := "", failedIndex := -1) {
        this.name := name
        this.passed := passed
        this.failedMessage := failedMessage
        this.failedIndex := failedIndex
    }
}