module vtest

import term

fn test_asserts() {
	assert !assert_eq_int(1, 2)
	assert assert_eq_int(1, 1)
	assert !assert_eq_str('abc', 'cde')
	assert assert_eq_str('abc', 'abc')
	assert !assert_true(false)
	assert assert_true(true)
	assert !assert_false(true)
	assert assert_false(false)
}

fn test_unescape_newline() {
	value := '1000\n2000'
	assert assert_eq_str(unescape_newline(value), '1000\\n2000')
}

fn test_build() {
	left := '1000\n1000'
	right := '1320\n1000'
	mut expected_msg := ''
	expected_msg += 'Left:  `1' + term.green('00') + '0\\n1000`' + newline_separator
	expected_msg += 'Right: `1' + term.red('32') + '0\\n1000`' + newline_separator
	assert assert_eq_str(expected_msg, build_diff(left, right))
}
