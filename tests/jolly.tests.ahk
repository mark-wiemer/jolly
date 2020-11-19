#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

j := Jolly.Runner.New()

j.it("should do math", () => (
    j.expect(2+ 2).loud.toBe(4)
    1
))

OutputDebug("😊")

#Include ../jolly.ahk