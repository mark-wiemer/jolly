#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; Runs tests
class Runner {
    ; Jolly.Matcher[]
    matchers := []

    it(name, callback) {
        callback.Call()
    }

    expect(value) {
        matcher := Jolly.Matcher.new(value)
        this.matchers.push(matcher)
        return matcher
    }
}