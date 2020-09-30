import vtest
import term

fn test_asserts() {
    assert !vtest.assert_eq_int(1, 2)
    assert vtest.assert_eq_int(1, 1)

    assert !vtest.assert_eq_str("abc", "cde")
    assert vtest.assert_eq_str("abc", "abc")

    assert !vtest.assert_true(false)
    assert vtest.assert_true(true)

    assert !vtest.assert_false(true)
    assert vtest.assert_false(false)
}

fn test_unescape_newline() {
    value := "1000\n2000"

    assert vtest.assert_eq_str(vtest.unescape_newline(value), "1000\\n2000")
}

fn test_build() {
    left := "1000\n1000"
    right := "1320\n1000"

    mut expected_msg := ""
    expected_msg += "Left:  `1" + term.green("00") + "0\\n1000`" + vtest.newline_separator
    expected_msg += "Right: `1" + term.red("32") + "0\\n1000`" + vtest.newline_separator

    assert vtest.assert_eq_str(expected_msg, vtest.build_diff(left, right))
}
