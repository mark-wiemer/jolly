#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; Handles value comparison. Currently also handles results.
class Matcher {
    ; Whether to negate the matcher
    isNegated := false
    message := ""
    passed := ""
    ; The received value for the matcher
    received := ""

    ; Creates a new matcher. Private: Use `Jolly.Runner.expect`
    __New(received) {
        this.received := received
    }

    ; Returns message describing this matcher. Pure. Private.
    msg(isNegated, matcherName, received, expected, comment := "") {
        message := "expect(" received ")."
        message .= (isNegated ? "not." : "")
        message .= matcherName
        message .= "(" expected ")"
        message .= (comment ? " `; " comment : "")
        return message
    }

    ; Negates the matcher. Returns this. Multiple calls cancel each other out.
    not() {
       this.isNegated := !this.isNegated
       return this
    }

    ; Expects two values to have == equality.
    toBe(expected) {
        pass := (this.received == expected) 
        this.passed := this.isNegated ? !pass : pass
        this.message := this.msg(this.isNegated, "toBe", this.received, expected, "== equality")
    }
}