#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; +------+
; | DEMO |
; +------+
/*
    Debug this script and inspect the debug output to see matcher results.
*/

; +--------+
; | BASICS |
; +--------+
/*
    Jolly uses matchers to compare two values. The values can be of any type.
    The 'toBe' matcher compares values using the == operator.
    Matchers are quiet by default and only log if they fail.
    "Logging" means "sending a string to the debugger".
    Loud matchers log even when they pass.
    Negate matchers with the 'not' modifier.
    Multiple negations cancel each other out.
*/
expect("Jolly").toBe("Jolly") ; Does not log anything
expect(1).toBe(2) ; Logs "FAIL: expect(1).toBe(2) ; == equality"

; Logs "PASS: expect(18).toBe(18) ; == equality":
expect(StrLen("Testing with Jolly")).loud.toBe(StrLen("suprisingly easy!!"))

expect(true).not.toBe(true) ; Logs "FAIL: expect(1).not.toBe(1) ; == equality"
expect(1).not.not.toBe(2) ; Logs "FAIL: expect(1).toBe(2) ; == equality"

; +----------+
; | CHAINING |
; +----------+
/*
    You can order matcher modifiers however you want, it doesn't affect functionality.
    We recommend putting 'loud' first for clarity.
*/
; Both log "PASS: expect(1).not.toBe(0) ; == equality":
expect(true).loud.not.toBe(false)
expect(true).not.loud.toBe(false)

/*
    Loudness is a boolean property, you cannot make your matcher "louder than loud".
    Repeating the 'loud' modifier does nothing more than using it once.
*/
; Both log "PASS: expect(1).toBe(1) ; == equality":
expect(1).loud.toBe(1)
expect(1).loud.loud.toBe(1)

; +-------------+
; | NAMESPACING |
; +-------------+

/*
    In case you already have an 'expect' function, you can use the 'Jolly' class.
    It has all the functionality and none of the duplicate function problems.
    To use it, include 'jollyClass.ahk' and not 'jolly.ahk'
*/
; Logs "PASS: expect(Jolly).toBe(Jolly) ; == equality":
Jolly.expect("Jolly").loud.toBe("Jolly")

; If you have no duplicate function problems, you can include only 'jolly.ahk'
; Otherwise, you can change this to "#Include path/to/Jolly/jollyClass.ahk"
#Include ../jolly.ahk