From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Add POPT_CFLAGS to
 lttng_CFLAGS
Date: Fri, 22 Feb 2019 14:28:33 -0500
Message-ID: <20190222192833.GC24251__1637.52988898835$1550863736$gmane$org@joraj-alpa>
References: <20190218170528.18823-1-ylamarre@efficios.com>
 <20190222191453.6533-1-ylamarre@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 445hGC3j46zh3J
 for <lttng-dev@lists.lttng.org>; Fri, 22 Feb 2019 14:28:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20190222191453.6533-1-ylamarre@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Hi,

Could you resend outside this thread and mark as v3?

Also remove the RFC flag from patch 2.

Thanks

On Fri, Feb 22, 2019 at 02:14:52PM -0500, Yannick Lamarre wrote:
> The generated makefile was ignoring POPT_CFLAGS when compiling
> lttng, but was adding POPT_LIBS to lttng_LDADD. With this commit,
> make now honors both settings for applications and tests.
> 
> Fixes: #1165
> 
> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
> ---
>  src/bin/lttng/Makefile.am                  | 2 ++
>  tests/regression/kernel/Makefile.am        | 2 +-
>  tests/regression/ust/multi-lib/Makefile.am | 8 ++++----
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/src/bin/lttng/Makefile.am b/src/bin/lttng/Makefile.am
> index b0e1247d..62ae0593 100644
> --- a/src/bin/lttng/Makefile.am
> +++ b/src/bin/lttng/Makefile.am
> @@ -28,6 +28,8 @@ lttng_SOURCES = command.h conf.c conf.h commands/start.c \
>  				commands/disable_rotation.c \
>  				utils.c utils.h lttng.c
>  
> +lttng_CFLAGS = $(AM_CFLAGS) $(POPT_CFLAGS)
> +
>  lttng_LDADD = $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
>  			$(top_builddir)/src/common/libcommon.la \
>  			$(top_builddir)/src/common/config/libconfig.la \
> diff --git a/tests/regression/kernel/Makefile.am b/tests/regression/kernel/Makefile.am
> index a787e4fa..3ab6d75b 100644
> --- a/tests/regression/kernel/Makefile.am
> +++ b/tests/regression/kernel/Makefile.am
> @@ -7,7 +7,7 @@ EXTRA_DIST = test_event_basic test_all_events test_syscall \
>  noinst_PROGRAMS = select_poll_epoll
>  select_poll_epoll_SOURCES = select_poll_epoll.c
>  select_poll_epoll_LDADD = $(POPT_LIBS)
> -select_poll_epoll_CFLAGS = -fno-stack-protector -D_FORTIFY_SOURCE=0 $(AM_CFLAGS)
> +select_poll_epoll_CFLAGS = $(POPT_CFLAGS) -fno-stack-protector -D_FORTIFY_SOURCE=0 $(AM_CFLAGS)
>  
>  all-local:
>  	@if [ x"$(srcdir)" != x"$(builddir)" ]; then \
> diff --git a/tests/regression/ust/multi-lib/Makefile.am b/tests/regression/ust/multi-lib/Makefile.am
> index 3fb4ae74..17ccf3e6 100644
> --- a/tests/regression/ust/multi-lib/Makefile.am
> +++ b/tests/regression/ust/multi-lib/Makefile.am
> @@ -3,13 +3,13 @@ EXTRA_DIST = test_multi_lib
>  noinst_PROGRAMS = exec-with-callsites exec-without-callsites
>  
>  exec_with_callsites_SOURCES = multi-lib-test.c callsites.c
> -exec_with_callsites_LDFLAGS = -ldl -lpopt
> -exec_with_callsites_CFLAGS = $(AM_CFLAGS) -DHAS_CALLSITES=1
> +exec_with_callsites_LDFLAGS = -ldl $(POPT_LIBS)
> +exec_with_callsites_CFLAGS = $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALLSITES=1
>  
>  exec_without_callsites_SOURCES = multi-lib-test.c
> -exec_without_callsites_LDFLAGS = -ldl -lpopt -llttng-ust
> +exec_without_callsites_LDFLAGS = -ldl $(POPT_LIBS) -llttng-ust
>  exec_without_callsites_LDADD = probes.o
> -exec_without_callsites_CFLAGS = $(AM_CFLAGS) -DHAS_CALLSITES=0
> +exec_without_callsites_CFLAGS = $(POPT_CFLAGS) $(AM_CFLAGS) -DHAS_CALLSITES=0
>  
>  PROBES_SRC=probes.c probes.h
>  PROBES_LDF=-shared -module -llttng-ust -avoid-version -rpath $(abs_builddir)/.libs/
> -- 
> 2.11.0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan Rajotte-Julien
EfficiOS
