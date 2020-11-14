#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; Example of duplicate function definition troubleshooting

; User-defined expect function conflicts with `jolly.ahk`
expect(value) {
    MsgBox("I'm not part of Jolly, here is my value: " value)
}

; Should run user-defined function
expect("hello")

; Import only 'jollyClass.ahk' to avoid duplicate function definition errors.
#Include ../jollyClass.ahk