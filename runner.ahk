#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

; Runs tests
class Runner {
    currentIt := ""
    itResults := []

    expect(value) {
        if (!this.currentIt) {
            throw Exception("'expect' must be called from within an 'it'")
        }

        matcher := Jolly.Matcher.new(value)
        this.currentIt.matchers.push(matcher)
        return matcher
    }

    it(name, callback) {
        this.currentIt := Jolly.It.New()
        callback.Call()
        this.itResults.push(this.currentIt.evaluate(name))
        this.currentIt := ""
    }

    ; Reports results, currently to OutputDebug
    report() {
        Jolly.Reporter.report(this.itResults)
    }
}

class ItResult {
    ; If passed, then -1, else 1-based index of failing matcher
    failedIndex := -1
    ; If passed, then empty string, else matcher message
    failedMessage := ""
    name := ""
    passed := ""

    __New(name, passed, failedMessage := "", failedIndex := -1) {
        this.name := name
        this.passed := passed
        this.failedMessage := failedMessage
        this.failedIndex := failedIndex
    }
}

class It {
    failedIndex := -1
    matchers := []
    passed := ""

    ; Returns result of this test
    evaluate(name := "") {
        this.passed := true
        for (index, matcher in this.matchers) {
            if (!matcher.passed) {
                this.failedIndex := index
                this.passed := false
                break
            }
        }
        failedMessage := this.passed ? "" : this.matchers[this.failedIndex].message
        return Jolly.ItResult.New(name, this.passed, failedMessage, this.failedIndex)
    }
}