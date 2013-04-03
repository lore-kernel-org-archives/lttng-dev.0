From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: lttng-tools test suite problem
Date: Wed, 3 Apr 2013 03:16:02 -0400
Message-ID: <CAFXXi0mrOQdqQ-4j27_Eu4oCtfLcxhFF2EdYdy+tZsLZngDeRw__8371.80035091496$1364973451$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UNHvy-0005HS-87
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 03:16:38 -0400
Received: by mail-ia0-f178.google.com with SMTP id r13so974040iar.23
	for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2013 00:16:32 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hello LTTng protagonists,

Here is a more detailled description of the problem I have with the
lttng-tools test suite.

Suppose I want to write a unit test for the list_cmd_options function
that is found in src/bin/lttng/utils.c. Based on existing tests, I
would create the file tests/unit/test_list_cmd_options.c and add the
following lines to tests/unit/Makefile.am:

test_list_cmd_options_SOURCES = test_list_cmd_options.c \
    $(top_srcdir)/src/bin/lttng/utils.c
test_list_cmd_options_LDADD = $(LIBTAP)

However, when I execute ./bootstrap, I get the following error:

+ [ ! -e config ]
+ autoreconf -i
tests/unit/Makefile.am: object `utils.$(OBJEXT)' created by \
    `$(top_srcdir)/src/bin/lttng/utils.c' and \
    `$(top_srcdir)/src/common/utils.c'
autoreconf: automake failed with exit status: 1

IIUC, it is caused by the fact that other tests use the similarly
named $(top_srcdir)/src/common/utils.c. Object files for the unit
tests are all created in the same directory, regardless of where they
come from. It results that two files with the same name will clash.

I kind of see two solutions for this:

A- Create a folder for each unit test. This is cumbersome, because it
will require creating a Makefile in each directory, which requires to
modify configure.ac. If it's hard to add a test, there will be less
tests, which is baaaaad. Also, a single test that needs stuff from two
files that have the same name will face the same problem as right now.
B- Use of option subdir-objects [1] [2]. Looks like a good solution,
but it won't work for me, it gives weird behaviours...

Thanks for looking into this. Testing ftw !

Simon

[1] http://www.gnu.org/software/automake/manual/html_node/Program-and-Library-Variables.html
[2] http://stackoverflow.com/questions/917948/automake-and-files-with-the-same-name
