#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; Runs tests
class Runner {
    currentIt := ""
    its := []
    matchers := []

    expect(value) {
        if (!this.currentIt) {
            throw Exception("'expect' must be called from within an 'it'")
        }

        matcher := Jolly.Matcher.new(value)
        this.currentIt.matchers.push(matcher)
        return matcher
    }

    it(name, callback) {
        newIt := Jolly._It.New(name)
        this.currentIt := newIt
        this.its.push(newIt)
        callback.Call()
        this.currentIt.evaluate()
        this.currentIt := ""
    }

    ; TODO move logic to own class, keeping this in interface is nice though
    ; Reports results, currently to OutputDebug
    ; report() {
    ;     for (it in this.its) {
    ;         if (!it.passed) {
    ;             OutputDebug("FAIL: " it.name)
    ;             OutputDebug("    " it.matchers[it.failedIndex].message)
    ;         }
    ;     }
    ; }
            }
        }
    }
}

class _It {
    failedIndex := -1
    matchers := []
    name := ""
    passed := ""

    __New(name) {
        this.name := name
    }

    ; Execute the callback and update state of this
    evaluate() {
        this.passed := true
        for (index, matcher in this.matchers) {
            if (!matcher.passed) {
                this.failedIndex := index
                this.passed := false
                break
            }
        }
    }
}