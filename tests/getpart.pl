#!/usr/bin/env perl
#***************************************************************************
#                                  _   _ ____  _
#  Project                     ___| | | |  _ \| |
#                             / __| | | | |_) | |
#                            | (__| |_| |  _ <| |___
#                             \___|\___/|_| \_\_____|
#
# Copyright (C) 1998 - 2020, Daniel Stenberg, <daniel@haxx.se>, et al.
#
# This software is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at https://curl.haxx.se/docs/copyright.html.
#
# You may opt to use, copy, modify, merge, publish, distribute and/or sell
# copies of the Software, and permit persons to whom the Software is
# furnished to do so, under the terms of the COPYING file.
#
# This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
# KIND, either express or implied.
#
###########################################################################
#
# This is just small (test) utility to output a part from a test case.
# Can be used from shell scripts and for debugging the getpart parser and
# decoder functions.
#

use strict;
require "./getpart.pm"; # array functions


my $testno = $ARGV[0];
my $section = $ARGV[1];
my $part = $ARGV[2];

if(!$testno || !$section || !$part) {
    print "testpart <testno> <section> <part>\n";
    exit 0;
}

my $srcdir = $ENV{'srcdir'} || '.';
my $TESTDIR="$srcdir/data";

if(loadtest("${TESTDIR}/test${testno}")) {
    # bad case
    print "couldn't load it?\n";
    exit 1;
}

my @ec = getpart($section, $part);
if($ec[0]) {
    # output
    print @ec;
}
