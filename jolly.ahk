#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; All Jolly functionality, brought into the global namespace

; Returns a Matcher for the value.
expect(value) {
    return Jolly.Matcher.new(value)
}

#Include ./jollyClass.ahk