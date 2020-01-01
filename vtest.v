module vtest

import term

const (
    // TODO should be OS-independent
    NEWLINE_SEPARATOR = "\n"
    ASSERT_FAIL_MSG = term.red("Assertion failure:") + NEWLINE_SEPARATOR
)

// Checks wheter two integers are equal
pub fn assert_eq_int(left int, right int) bool {
    if left != right {
        eprintln(assert_eq_fail_msg(left.str(), right.str()))
        return false
    }
    return true
}

// Checks wheter two integers are not equal
pub fn assert_ne_int(left int, right int) bool {
    if left == right {
        eprintln(assert_eq_fail_msg(left.str(), right.str()))
        return false
    }
    return true
}

// Checks wheter two strings are equal
pub fn assert_eq_str(left string, right string) bool {
    if left != right {
        eprintln(assert_eq_fail_msg(left, right))
        return false
    }
    return true
}

// Checks wheter two strings are not equal
pub fn assert_ne_str(left string, right string) bool {
    if left == right {
        eprintln(assert_eq_fail_msg(left, right))
        return false
    }
    return true
}

// Checks whether provided value is set to false
pub fn assert_false(val bool) bool {
    return assert_bool(false, val)
}

// Checks whether provided value is set to true
pub fn assert_true(val bool) bool {
    return assert_bool(true, val)
}

// Builds a colored diff between two strings
fn build_diff(left_input string, right_input string) string {
    left := unescape_newline(left_input)
    right := unescape_newline(right_input)

    mut min_length := 0
    if left.len <= right.len {
        min_length = left.len
    } else {
        min_length = right.len
    }

    mut left_diff := ""
    mut right_diff := ""
    mut i := 0

    for i < min_length {
        if left[i] == right[i] {
            left_diff += left[i].str()
            right_diff += right[i].str()
            i++
            continue
        }

        mut left_current_diff := ""
        mut right_current_diff := ""

        for i < min_length && left[i] != right[i] {
            left_current_diff += left[i].str()
            right_current_diff += right[i].str()
            i++
        }

        left_diff += term.green(left_current_diff)
        right_diff += term.red(right_current_diff)
    }

    if left.len > right.len {
        left_diff += term.green(left.substr(right.len, left.len))
    } else if right.len > left.len {
        right_diff += term.red(right.substr(left.len, right.len))
    }
    
    mut diff_msg := "Left:  `$left_diff`" + NEWLINE_SEPARATOR
    diff_msg += "Right: `$right_diff`" + NEWLINE_SEPARATOR

    return diff_msg
}

fn assertion_failure_msg() string {
    return ASSERT_FAIL_MSG
}

fn assert_eq_fail_msg(left string, right string) string {
    mut message := assertion_failure_msg()

    message += build_diff(left, right)
    
    return message
}

fn assert_bool_fail_msg(expected bool, got bool) string {
    mut message := assertion_failure_msg()

    message += "Expected " + term.green(expected.str()) + ", got " + term.red(got.str()) + NEWLINE_SEPARATOR

    return message
}

fn assert_bool(expected bool, got bool) bool {
    if expected != got {
        eprintln(assert_bool_fail_msg(expected, got))
        return false
    }
    return true
}

// Replaces \n in string with \\n
fn unescape_newline(input string) string {
    return input.split('\n').join('\\n')
}
