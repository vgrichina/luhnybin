Sequence luhnCheck := method(
    i := 0
    sum := 0
    reverse foreach(c,
        if (c isDigit,
            digit := c asCharacter asNumber
            if (i isOdd, digit := digit * 2)
            if (digit >= 10,
                sum := sum + 1 + digit % 10,
                sum := sum + digit
            )
            i := i + 1
        )
    )

    return sum % 10 == 0
)

Sequence creditCardNumbers := method(
    results := list()
    digitCount := 0
    foreach(i, c,
        if (c isDigit,
            digitCount := digitCount + 1,
            if (not(" -" contains(c)), return list()))

        if (digitCount >= 14, results append(list(0, i)))
        if (digitCount >= 16, break)
    )

    return results select(r, inclusiveSlice(r at(0), r at(1)) luhnCheck)
)

File standardInput readLines foreach(line,
    newLine := line asMutable

    for(i, 0, line size - 14,
        if(line at(i) isDigit,
            ranges := line inclusiveSlice(i, line size - 1) creditCardNumbers
            ranges foreach(range,
                for(j, range at(0) + i, range at(1) + i,
                    if (newLine at(j) isDigit,
                        newLine atPut(j, "X" at(0)))
                )
            )
        )
    )

    newLine println
)
