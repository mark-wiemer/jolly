#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; Handles value comparison. Currently also handles results.
class Matcher {
    ; The received value for the matcher
    received := ""
    ; Whether to print on PASS
    isLoud := false
    ; Whether to negate the matcher
    isNegated := false

    ; Creates a new matcher. Private: Use `expect(value)` to create a matcher.
    __New(received) {
        this.received := received
    }

    ; Logs a message to the current output (currently hardcoded OutputDebug). Private.
    log(message) {
        OutputDebug(message)
    }

    ; Returns message describing this matcher. Pure. Private.
    msg(pass, isNegated, matcherName, received, expected, comment := "") {
        message := pass ? "PASS" : "FAIL"
        message .= ": expect(" received ")." (isNegated ? "not." : "") matcherName "(" expected ")"
        message .= (comment ? " `; " comment : "")
        return message
    }

    ; Performs action corresponding to results of the test (for now, log or do nothing). Private.
    results(pass, message, loud) {
        if (this.shouldLog(pass, loud)) {
            this.log(message)
        }
    }

    ; Returns whether this matcher should log its results. Pure. Private. 
    shouldLog(pass, loud) {
        return (!pass or loud)
    }

    ; Updates this to print on success. Returns this. Idempotent.
    loud[] => (this.isLoud := true, this)

    ; Negates the matcher. Returns this. Multiple calls cancel each other out.
    not[] => (this.isNegated := !this.isNegated, this)

    ; Expects two values to have == equality.
    toBe(expected) {
        pass := (this.received == expected) 
        pass := this.isNegated ? !pass : pass
        message := this.msg(pass, this.isNegated, "toBe", this.received, expected, "== equality")
        this.results(pass, message, this.isLoud)
    }
}