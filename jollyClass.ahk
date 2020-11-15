#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; All Jolly functionality, namespaced within a class
class Jolly {    
    ; Returns a Matcher for the value.
    static expect(value) {
        return Jolly.Matcher.new(value)
    }

    #Include matcher.ahk
}

