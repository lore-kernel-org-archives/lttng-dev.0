From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: lttng-tools test suite problem
Date: Wed, 3 Apr 2013 14:28:53 -0400
Message-ID: <CAFXXi0nQ1QqF_OPY2wir8qcM+GG1+jkT0W5oi-eNW8t5jOmQAg__27772.0024613247$1365013825$gmane$org@mail.gmail.com>
References: <CAFXXi0mrOQdqQ-4j27_Eu4oCtfLcxhFF2EdYdy+tZsLZngDeRw@mail.gmail.com>
	<CAGDH53mtYuayRxgteSpZ5w+zkrfZo4rs6wwJBTHFamTSoKqtpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UNSR7-0002SF-GC
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 14:29:29 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so2101667ieb.29
	for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2013 11:29:24 -0700 (PDT)
In-Reply-To: <CAGDH53mtYuayRxgteSpZ5w+zkrfZo4rs6wwJBTHFamTSoKqtpA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 3 April 2013 12:49, Christian Babeux <christian.babeux@efficios.com> wrote:
> I would advocate for this option. Could you describe the issues you
> encountered using subdirs-objects?

Let's try to add

AUTOMAKE_OPTIONS = subdir-objects

at the top of tests/unit/Makefile.am. ./bootstrap and ./configure go
fine. When "making", here is the result: http://pastebin.com/QzcTuFpB.
Notice the complain "../../src/common/.deps/error.Po: No such file or
directory" ? This is what tests/unit looks like:

$ tree -a tests/unit
tests/unit
|-- .deps
|   |-- test_kernel_data.Po
|   |-- test_session.Po
|   |-- test_uri.Po
|   `-- test_ust_data.Po
|-- Makefile
|-- Makefile.am
|-- Makefile.in
|-- test_kernel_data.c
|-- test_session.c
|-- test_uri.c
|-- test_ust_data.c
`-- $(top_srcdir)
    `-- src
        |-- bin
        |   `-- lttng-sessiond
        |       `-- .deps
        |           |-- buffer-registry.Po
        |           |-- consumer.Po
        |           |-- fd-limit.Po
        |           |-- health.Po
        |           |-- session.Po
        |           |-- trace-kernel.Po
        |           |-- trace-ust.Po
        |           |-- ust-app.Po
        |           |-- ust-consumer.Po
        |           |-- ust-metadata.Po
        |           `-- ust-registry.Po
        `-- common
            `-- .deps
                |-- error.Po
                |-- uri.Po
                `-- utils.Po

8 directories, 25 files

Yep, there is a directory named $(top_srcdir). It comes from the path
of the files in Makefile.am that contains $(top_srcdir). And it
contains the files that were not found earlier. If I do a

$ cp -a tests/unit/\$\(top_srcdir\)/src .

it places the files at the right place. I can do make again and it
completes successfully.

I then tried to replace instances of $(top_srcdir) in
tests/unit/Makefile.am by "../..". The objects files will then be
placed in the same directory as the source file and everything looks
good. The problem I see though is that the resulting object files
overwrite the objects previously built when make passed in the source
folder. Maybe this can create problems if we want to compile tests
with different flags than the main libs and executables.

Finally, an idea just like that: instead of specifying the source
file, would it be possible to specify directly the object file (e.g.
$(top_srcdir)/src/bin/lttng/utils.o or ../../src/bin/lttng/utils.o) in
LDADD ? So the unit test Makefile would not recompile the unit under
test, but just link with the object that is already built ?

Simon
