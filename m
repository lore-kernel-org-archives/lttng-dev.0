From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: unresolvable dependencies
	to	liblttng-ust-tracepoint when cross-compiling.
Date: Thu, 2 Aug 2012 09:00:14 -0400
Message-ID: <20120802130014.GA29924__42171.8683596284$1343912441$gmane$org@Krystal>
References: <1343909189-1338-1-git-send-email-hhi08001@student.mdh.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Swv0i-000296-H4
	for lttng-dev@lists.lttng.org; Thu, 02 Aug 2012 09:00:16 -0400
Content-Disposition: inline
In-Reply-To: <1343909189-1338-1-git-send-email-hhi08001@student.mdh.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Henrik Hautakoski <hhi08001@student.mdh.se>
Cc: daniel.flemstrom@mdh.se, lttng-dev@lists.lttng.org, skn07007@student.mdh.se, alf.larsson@ericsson.com
List-Id: lttng-dev@lists.lttng.org

* Henrik Hautakoski (hhi08001@student.mdh.se) wrote:
> Original patch by Christian Babeux that did not apply cleanly on upstream.

I will wait for the proper fix from Christian, which is to fix the
libtool m4 file in the tree. Fix should be coming soon.

Thanks,

Mathieu

> 
> Co-author: Stefan Karlsson <skn07007@student.mdh.se>
> Signed-off-by: Henrik Hautakoski <hhi08001@student.mdh.se>
> ---
>  tests/fork/Makefile.am      |   12 ++++++++----
>  tests/hello.cxx/Makefile.am |    4 +++-
>  tests/hello/Makefile.am     |    4 +++-
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/fork/Makefile.am b/tests/fork/Makefile.am
> index 0a649c7..b5830d7 100644
> --- a/tests/fork/Makefile.am
> +++ b/tests/fork/Makefile.am
> @@ -2,11 +2,15 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
>  
>  noinst_PROGRAMS = fork fork2
>  fork_SOURCES = fork.c ust_tests_fork.h
> -fork_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la \
> -		$(top_builddir)/liblttng-ust-fork/liblttng-ust-fork.la
> +fork_LDADD = \
> +	$(top_builddir)/liblttng-ust/liblttng-ust.la \
> +	$(top_builddir)/liblttng-ust/liblttng-ust-tracepoint.la \
> +	$(top_builddir)/liblttng-ust-fork/liblttng-ust-fork.la
>  fork2_SOURCES = fork2.c
> -fork2_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la \
> -		$(top_builddir)/liblttng-ust-fork/liblttng-ust-fork.la
> +fork2_LDADD = \
> +	$(top_builddir)/liblttng-ust/liblttng-ust.la \
> +	$(top_builddir)/liblttng-ust/liblttng-ust-tracepoint.la \	
> +	$(top_builddir)/liblttng-ust-fork/liblttng-ust-fork.la
>  
>  if LTTNG_UST_BUILD_WITH_LIBDL
>  fork_LDADD += -ldl
> diff --git a/tests/hello.cxx/Makefile.am b/tests/hello.cxx/Makefile.am
> index f56f431..ea034df 100644
> --- a/tests/hello.cxx/Makefile.am
> +++ b/tests/hello.cxx/Makefile.am
> @@ -2,7 +2,9 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
>  
>  noinst_PROGRAMS = hello
>  hello_SOURCES = hello.cpp tp.c ust_tests_hello.h
> -hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +hello_LDADD = \
> +	$(top_builddir)/liblttng-ust/liblttng-ust.la \
> +	$(top_builddir)/liblttng-ust/liblttng-ust-tracepoint.la
>  
>  if LTTNG_UST_BUILD_WITH_LIBDL
>  hello_LDADD += -ldl
> diff --git a/tests/hello/Makefile.am b/tests/hello/Makefile.am
> index 0c4c311..c00ce8b 100644
> --- a/tests/hello/Makefile.am
> +++ b/tests/hello/Makefile.am
> @@ -2,7 +2,9 @@ AM_CPPFLAGS = -I$(top_srcdir)/include -Wsystem-headers
>  
>  noinst_PROGRAMS = hello
>  hello_SOURCES = hello.c tp.c ust_tests_hello.h
> -hello_LDADD = $(top_builddir)/liblttng-ust/liblttng-ust.la
> +hello_LDADD = \
> +	$(top_builddir)/liblttng-ust/liblttng-ust.la \
> +	$(top_builddir)/liblttng-ust/liblttng-ust-tracepoint.la
>  hello_CFLAGS = -Werror=old-style-definition
>  
>  if LTTNG_UST_BUILD_WITH_LIBDL
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
