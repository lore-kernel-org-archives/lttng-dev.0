From: Jon Bernard <jbernard@debian.org>
Subject: Re: babeltrace test failures on some architectures
Date: Thu, 12 Jun 2014 23:51:17 -0400
Message-ID: <20140613035117.GA8741__24450.7129224532$1402631549$gmane$org@helmut>
References: <20140604184126.GA26877@helmut>
 <CA+jJMxtn8XiLjT5NVURv5K8kECPPoPs1WF-0zTakJmRW=CO3mg@mail.gmail.com>
 <CAEzWAeLEvv8FbHfwq8=sMeDW49DjO_gKoZ99z1Ff9s+dR6GuJQ@mail.gmail.com>
 <20140609145201.GB25766@helmut>
 <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jbernard@debian.org>) id 1WvIWR-0006yU-NJ
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 23:51:29 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4E01720BEA
 for <lttng-dev@lists.lttng.org>; Thu, 12 Jun 2014 23:51:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CA+jJMxsuEtk3QdDz1_a0MOBq0To7wB4+QnOW3Rkp0uJZ1eM1gw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com> wrote:
> The build logs only seem to contain the "prove" output (invoked by run.sh=
).
> =

> Could you run tests/bin/test_trace_read and
> tests/lib/test_seek_empty_packet on armel and sparc? The output of
> both of these tests and the coredumps (if any) should give me
> something to work with.

Here are the sparc results:

    $ ./tests/bin/test_trace_read
    1..17
    ./tests/bin/test_trace_read: line 34: 31489 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 1 - Run babeltrace with trace env-warning
    #   Failed test 'Run babeltrace with trace env-warning'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31508 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 2 - Run babeltrace with trace lttng-modules-2.0-pre5
    #   Failed test 'Run babeltrace with trace lttng-modules-2.0-pre5'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31527 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 3 - Run babeltrace with trace sequence
    #   Failed test 'Run babeltrace with trace sequence'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31546 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 4 - Run babeltrace with trace smalltrace
    #   Failed test 'Run babeltrace with trace smalltrace'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31565 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 5 - Run babeltrace with trace succeed1
    #   Failed test 'Run babeltrace with trace succeed1'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31584 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 6 - Run babeltrace with trace succeed2
    #   Failed test 'Run babeltrace with trace succeed2'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31603 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 7 - Run babeltrace with trace succeed3
    #   Failed test 'Run babeltrace with trace succeed3'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31622 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 8 - Run babeltrace with trace succeed4
    #   Failed test 'Run babeltrace with trace succeed4'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31641 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 9 - Run babeltrace with trace test
    #   Failed test 'Run babeltrace with trace test'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31660 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 10 - Run babeltrace with trace warnings
    #   Failed test 'Run babeltrace with trace warnings'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 34: 31679 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    not ok 11 - Run babeltrace with trace wk-heartbeat-u
    #   Failed test 'Run babeltrace with trace wk-heartbeat-u'
    #   in ./tests/bin/test_trace_read:main() at line 37.
    ./tests/bin/test_trace_read: line 40: 31698 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    ok 12 - Run babeltrace with invalid trace fail1
    ./tests/bin/test_trace_read: line 40: 31713 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    ok 13 - Run babeltrace with invalid trace fail2
    ./tests/bin/test_trace_read: line 40: 31728 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    ok 14 - Run babeltrace with invalid trace integer-range
    ok 15 - Run babeltrace with invalid trace lttng-modules-2.0-pre1
    ok 16 - Run babeltrace with invalid trace packet-based-metadata
    ./tests/bin/test_trace_read: line 40: 31773 Bus error               $BA=
BELTRACE_BIN ${path} > /dev/null 2>&1
    ok 17 - Run babeltrace with invalid trace smalltrace
    # Looks like you failed 11 tests of 17.


    $ ./tests/lib/test_seek_empty_packet
    1..29
    Bus error

I'll gather the arm results tomorrow.

-- =

Jon
