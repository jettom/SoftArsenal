function isValidMailAddress(mail) {
    if (mail == null || mail === "") {
        return false;
    }

    var mailRegexStr = "^(?!.*\\.\\.)[A-Za-z0-9%_+-]+(?:\\.[A-Za-z0-9%_+-]+)*@(?=[A-Za-z0-9%_+.\\-]*\\.)[A-Za-z0-9%_+](?:[A-Za-z0-9%_+.\\-]*[A-Za-z0-9%_+])?$";
    var mailRegex = new RegExp(mailRegexStr);

    return mail.match(mailRegex) != null;
}

function testMailAddress() {
    var testList = [
        { mail: "abc@test.com", expected: true },
        { mail: "ABC@test.com", expected: true },
        { mail: "abc123@test.com", expected: true },
        { mail: "abc.def@test.com", expected: true },
        { mail: "abc_def@test.com", expected: true },
        { mail: "abc+def@test.com", expected: true },
        { mail: "abc-def@test.com", expected: true },
        { mail: "abc%def@test.com", expected: true },
        { mail: "abc@test.co.jp", expected: true },
        { mail: "a@b.c", expected: true },

        { mail: "", expected: false },
        { mail: null, expected: false },
        { mail: "abctest.com", expected: false },
        { mail: "abc@@test.com", expected: false },
        { mail: "abc@test@com", expected: false },
        { mail: ".abc@test.com", expected: false },
        { mail: "abc.@test.com", expected: false },
        { mail: "abc..def@test.com", expected: false },
        { mail: "abc@test", expected: false },
        { mail: "abc@.test.com", expected: false },
        { mail: "abc@test.com.", expected: false },
        { mail: "abc@test..com", expected: false },
        { mail: "abc@-test.com", expected: false },
        { mail: "abc@test.com-", expected: false },
        { mail: "abc test@test.com", expected: false },
        { mail: "abc@test com", expected: false },
        { mail: "abc#def@test.com", expected: false },
        { mail: "abc@test#com", expected: false }
    ];

    for (var i = 0; i < testList.length; i++) {
        var test = testList[i];
        var actual = isValidMailAddress(test.mail);

        if (actual === test.expected) {
            console.log("OK : " + test.mail + " => " + actual);
        } else {
            console.log("NG : " + test.mail + " => actual=" + actual + ", expected=" + test.expected);
        }
    }
}

testMailAddress();
