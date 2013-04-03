From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: lttng-tools test suite problem
Date: Wed, 3 Apr 2013 12:49:42 -0400
Message-ID: <CAGDH53mtYuayRxgteSpZ5w+zkrfZo4rs6wwJBTHFamTSoKqtpA__35062.1391473853$1365007844$gmane$org@mail.gmail.com>
References: <CAFXXi0mrOQdqQ-4j27_Eu4oCtfLcxhFF2EdYdy+tZsLZngDeRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UNQse-0001fK-EQ
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 12:49:48 -0400
Received: by mail-vb0-f43.google.com with SMTP id q12so603621vbe.2
	for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2013 09:49:42 -0700 (PDT)
In-Reply-To: <CAFXXi0mrOQdqQ-4j27_Eu4oCtfLcxhFF2EdYdy+tZsLZngDeRw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Simon,

> A- Create a folder for each unit test. This is cumbersome, because it
> will require creating a Makefile in each directory, which requires to
> modify configure.ac. If it's hard to add a test, there will be less
> tests, which is baaaaad. Also, a single test that needs stuff from two
> files that have the same name will face the same problem as right now.

Agreed.

> B- Use of option subdir-objects [1] [2]. Looks like a good solution,
> but it won't work for me, it gives weird behaviours...

I would advocate for this option. Could you describe the issues you
encountered using subdirs-objects?

Thanks,

Christian

On Wed, Apr 3, 2013 at 3:16 AM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
>
> Hello LTTng protagonists,
>
> Here is a more detailled description of the problem I have with the
> lttng-tools test suite.
>
> Suppose I want to write a unit test for the list_cmd_options function
> that is found in src/bin/lttng/utils.c. Based on existing tests, I
> would create the file tests/unit/test_list_cmd_options.c and add the
> following lines to tests/unit/Makefile.am:
>
> test_list_cmd_options_SOURCES = test_list_cmd_options.c \
>     $(top_srcdir)/src/bin/lttng/utils.c
> test_list_cmd_options_LDADD = $(LIBTAP)
>
> However, when I execute ./bootstrap, I get the following error:
>
> + [ ! -e config ]
> + autoreconf -i
> tests/unit/Makefile.am: object `utils.$(OBJEXT)' created by \
>     `$(top_srcdir)/src/bin/lttng/utils.c' and \
>     `$(top_srcdir)/src/common/utils.c'
> autoreconf: automake failed with exit status: 1
>
> IIUC, it is caused by the fact that other tests use the similarly
> named $(top_srcdir)/src/common/utils.c. Object files for the unit
> tests are all created in the same directory, regardless of where they
> come from. It results that two files with the same name will clash.
>
> I kind of see two solutions for this:
>
> A- Create a folder for each unit test. This is cumbersome, because it
> will require creating a Makefile in each directory, which requires to
> modify configure.ac. If it's hard to add a test, there will be less
> tests, which is baaaaad. Also, a single test that needs stuff from two
> files that have the same name will face the same problem as right now.
> B- Use of option subdir-objects [1] [2]. Looks like a good solution,
> but it won't work for me, it gives weird behaviours...
>
> Thanks for looking into this. Testing ftw !
>
> Simon
>
> [1] http://www.gnu.org/software/automake/manual/html_node/Program-and-Library-Variables.html
> [2] http://stackoverflow.com/questions/917948/automake-and-files-with-the-same-name
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
