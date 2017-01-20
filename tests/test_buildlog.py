from nose.tools import *

import os
import re


LOG_FILE = 'docs/build.log'


def test_exists():
    assert_true(os.path.exists(LOG_FILE), 'File not found: %s' % LOG_FILE)


def test_errors():
    for m in re.finditer('^(.+):(\d+): [A-Z]+: (.+)$', _get_log_contents(), re.MULTILINE):
        yield _check_error, m


def _check_error(m):
    fname, linenr, msg = m.groups()
    fname = os.path.split(fname)[1]
    assert_false(m, '%s:%d: %s' % (fname, int(linenr), msg))


def _get_log_contents():
    if os.path.exists(LOG_FILE):
        with open(LOG_FILE, 'r') as fp:
            return fp.read()
    return ''
