# Jolly

```AutoHotkey
expect(StrLen("Testing with Jolly")).toBe(StrLen("suprisingly easy!!"))
```

Easy [pure function](https://en.wikipedia.org/wiki/Pure_function) testing in [AutoHotkey](https://www.autohotkey.com).

Jolly takes great inspiration from [Jest](https://jestjs.io).

> Written for [AutoHotkey 2.0-a122](https://github.com/Lexikos/AutoHotkey_L/releases/tag/v2.0-a122)

## What is Jolly?

Jolly is a testing library that allows scripts to compare two values at any time and log comparison results. It's useful for testing functions that don't depend on global variables. If you're writing utility functions, you should use Jolly to make sure your functionality is correct! With Jolly, you can run tests early and often and instantly know if you've introduced bugs into your code.

Jolly has no external dependencies. To use it, just add `#Include path/to/jolly.ahk` to your scripts! See [Getting Started](#getting-started) for more info.

## Getting Started

> See [demo.ahk](./examples/demo.ahk) for a runnable version of this demo.

### Basics

Jolly uses matchers to compare two values. The values can be of any type. The `toBe` matcher compares values using the `==` operator. Matchers are quiet by default and only log if they fail. "Logging" means "sending a string to the debugger". Loud matchers log even when they pass. Negate matchers with the `not` modifier. Multiple negations cancel each other out.

```AutoHotkey
expect("Jolly").toBe("Jolly") ; Does not log anything
expect(1).toBe(2) ; Logs "FAIL: expect(1).toBe(2) ; == equality"

; Logs "PASS: expect(18).toBe(18) ; == equality":
expect(StrLen("Testing with Jolly")).loud.toBe(StrLen("suprisingly easy!!"))

expect(true).not.toBe(true) ; Logs "FAIL: expect(1).not.toBe(1) ; == equality"
expect(1).not.not.toBe(2) ; Logs "FAIL: expect(1).toBe(2) ; == equality"
```

### Chaining

You can order matcher modifiers (like `loud` and `not`) however you want, it doesn't affect functionality. We recommend putting `loud` first for clarity.

```AutoHotkey
; Both log "PASS: expect(1).not.toBe(0) ; == equality":
expect(true).loud.not.toBe(false) ; Logs "PASS: expect(1).not.toBe(0) ; == equality"
expect(true).not.loud.toBe(false) ; Logs "PASS: expect(1).not.toBe(0) ; == equality"
```

Loudness is a boolean property, you cannot make your matcher "louder than loud". Repeating the `loud` modifier does nothing more than using it once.

```AutoHotkey
; Both log "PASS: expect(1).toBe(1) ; == equality":
expect(1).loud.toBe(1)
expect(1).loud.loud.toBe(1)
```

### Namespacing

In case you already have an `expect` function, you can use the `Jolly` class. It has all the functionality and none of the duplicate function problems. To use it, include `jollyClass.ahk` and not `jolly.ahk`. For a complete example, see [`duplicateFunction.ahk` (link)](./examples/duplicateFunction.ahk)

```AutoHotkey
; Logs "PASS: expect(Jolly).toBe(Jolly) ; == equality":
Jolly.expect("Jolly").loud.toBe("Jolly")
```
