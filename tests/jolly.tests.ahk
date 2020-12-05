#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

j := Jolly.Runner.New()

; Runner tests

j.it("should have correct state when test fails", () => (
    k := Jolly.Runner.New(),
    k.it("fails", () => (
        k.expect(true).toBe(false)
    )),
    j.expect(k.itResults.length).toBe(1)
    j.expect(k.itResults[1].failedIndex).toBe(1)
    j.expect(k.itResults[1].failedMessage).toBe("expect(1).toBe(0) `; == equality")
    j.expect(k.itResults[1].name).toBe("fails")
    j.expect(k.itResults[1].passed).toBe(false)
))

; Runner > It tests

j.it("should fail when expect fails", () => (
    k := Jolly.Runner.New(),
    k.it("fails", () => (k.expect(true).toBe(false)))
    j.expect(k.itResults[1].passed).toBe(false)
))

j.it("should pass when expect passes", () => (
    k := Jolly.Runner.New(),
    k.it("passes", () => (k.expect(true).toBe(true)))
    j.expect(k.itResults[1].passed).toBe(true)
))

j.it("should fail on second expect when first expect passes", () => (
    k := Jolly.Runner.New(),
    k.it("fails", () => (
        k.expect(true).toBe(true)
        k.expect(true).toBe(false)
    ))
    j.expect(k.itResults[1].passed).toBe(false)
    j.expect(k.itResults[1].failedIndex).toBe(2)
))

j.it("should pass when negated expect passes", () => (
    k := Jolly.Runner.New(),
    k.it("passes", () => (k.expect(true).not().toBe(false)))
    j.expect(k.itResults[1].passed).toBe(true)
))

j.it("should fail when negated expect fails", () => (
    k := Jolly.Runner.New(),
    k.it("fails", () => (k.expect(true).not().toBe(true)))
    j.expect(k.itResults[1].passed).toBe(false)
))

; Calling expect outside of an it should throw an exception
try {
    j.expect(true).toBe(false)
    OutputDebug("ERROR: 'expect' outside of 'it' did not throw exception")
} catch {
    ; nothing went wrong, don't log anything
}

; Reporter tests

j.it("should not report fail count when all tests pass", () => (
    results := Jolly.RunnerResults.New([
        Jolly.ItResult.New("<name>", true)
    ]),
    j.expect(Jolly.Reporter.getReport(results)).toBe(
        "PASS: <name>`n"
        "`n"
        "PASS:`n"
        "    Tests: 1 passed, 1 total"
    )
))

j.it("should report failure and not report pass count when all tests fail", () => (
    results := Jolly.RunnerResults.New([
        Jolly.ItResult.New("<name>", false, "<fail message>", 1)
    ]),
    j.expect(Jolly.Reporter.getReport(results)).toBe(
        "FAIL: <name>`n"
        "    #1: <fail message>`n"
        "`n"
        "FAIL:`n"
        "    Tests: 1 failed, 1 total"
    )
))

j.it("should report both fail and pass count when some but not all tests fail", () => (
    results := Jolly.RunnerResults.New([
        Jolly.ItResult.New("<fail name>", false, "<fail message>", 1),
        Jolly.ItResult.New("<pass name>", true)
    ]),
    j.expect(Jolly.Reporter.getReport(results)).toBe(
        "FAIL: <fail name>`n"
        "    #1: <fail message>`n"
        "PASS: <pass name>`n"
        "`n"
        "FAIL:`n"
        "    Tests: 1 failed, 1 passed, 2 total"
    )
))

j.it("should report 'no tests found' message when given empty array", () => (
    emptyResults := Jolly.RunnerResults.New([]),
    j.expect(Jolly.Reporter.getReport(emptyResults)).toBe("No tests found")
))

j.report()

#Include ../jolly.ahk