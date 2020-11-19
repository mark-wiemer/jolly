# Troubleshooting

## Runtime Errors

If you ever get the runtime error `This value of type "String" has no method named "it"` / `This value of type "String" has no method named "describe"`, check to make sure you have a comma between the two arguments. For example, notice the missing comma in this snippet:

```AutoHotkey
j.it("incorrect it" () => ( ; INCORRECT, we need a comma on this line
    j.expect(1).toBe(1)
))

j.it("correct it", () => ( ; CORRECT
    j.expect(1).toBe(1)
))
```
