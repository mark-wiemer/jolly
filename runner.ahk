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
        Jolly.Reporter.report(Jolly.RunnerResults.New(this.itResults))
    }
}

; Private class for evaluating an it
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