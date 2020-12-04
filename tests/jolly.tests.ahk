#Requires AutoHotkey v2.0-a ; a122
#SingleInstance Force

j := Jolly.Runner.New()

j.it("should fail only once with two failed expects", () => (
    j.expect(2 + 3).toBe(4)
    j.expect(2 + 2).toBe(3)
))

j.it("should pass and not be reported", () => (
    j.expect(1 + 1).toBe(2)
))

j.it("should fail on second expect when first expect passes", () => (
    j.expect(1 + 1).toBe(2)
    j.expect(3).toBe(5)
))

j.it("should pass with negated expect", () => (
    j.expect("to be, or").not().toBe(", that is the question")
))

j.it("should fail with failed negated expect", () => (
    j.expect(1).not().toBe(1)
))

; Calling expect outside of an it should throw an exception
try {
    j.expect(true).toBe(false)
    OutputDebug("ERROR: expect outside of it did not throw exception")
} catch {
    ; nothing went wrong, don't log anything
}

j.it("should pass with runner in correct state after running tests", () => (
    k := Jolly.Runner.New(),
    k.it("should be a test", () => (
        k.expect(1).toBe(0)
    )),
    firstItResult := k.itResults[1],
    j.expect(k.itResults.length).toBe(1)
    j.expect(firstItResult.failedIndex).toBe(1)
    j.expect(firstItResult.failedMessage).toBe("expect(1).toBe(0) `; == equality")
    j.expect(firstItResult.name).toBe("should be a test")
    j.expect(firstItResult.passed).toBe(false)
))

OutputDebug("Should report 3 failed its, each with exactly one failure.")
OutputDebug("It names should start with 'should fail':")
j.report()

; just for breakpoint insertion
x := 1
OutputDebug(":)")

#Include ../jolly.ahk