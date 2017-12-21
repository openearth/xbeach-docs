from nose.tools import *

import os
import re
from bs4 import BeautifulSoup


BUILD_DIR = 'docs/_build/html'


def test_references():
    files = _gather_files()
    references = _gather_references(files)
    for fname in files:
        fname = os.path.relpath(fname, BUILD_DIR)
        yield _check_references, fname, references


def _check_references(fname, references):
    if not fname.startswith('partable_'):
        assert_in(fname, references, fname)

    
def _gather_references(files):
    references = ['index.html','index_pdf.html']
    for fname in files:
        with open(fname, 'r') as fp:
            soup = BeautifulSoup(fp, 'html.parser')
            for reference in soup.find_all('a'):
                href = reference.get('href')
                href = re.sub('#.*$', '', href) # remove anchors, better use urllib
                cls = reference.get('class')
                if href and href.endswith('.html'):
                    if cls and 'internal' in cls:
                        references.append(href)
    return set(references)


def _gather_files(fpath=BUILD_DIR):
    files = []
    for fname in os.listdir(fpath):
        fname = os.path.join(fpath, fname)
        if os.path.isdir(fname):
            files.extend(_gather_files(fname))
        elif fname.endswith('.html'):
            files.append(fname)
    return files
