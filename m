From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Do not install
	health	tests helper libraries
Date: Mon, 5 Nov 2012 17:11:03 -0500
Message-ID: <20121105221103.GB13619__41192.3412154012$1352153502$gmane$org@Krystal>
References: <1352150413-16685-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TVUsq-0008Kv-VK
	for lttng-dev@lists.lttng.org; Mon, 05 Nov 2012 17:11:04 -0500
Content-Disposition: inline
In-Reply-To: <1352150413-16685-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> The libraries libhealthexit and libhealthstall should not be
> installed on the user system. They are only useful for the
> health check tests.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>  tests/tools/health/Makefile.am | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/tools/health/Makefile.am b/tests/tools/health/Makefile.am
> index 9fab582..d1d4919 100644
> --- a/tests/tools/health/Makefile.am
> +++ b/tests/tools/health/Makefile.am
> @@ -10,8 +10,6 @@ endif
>  
>  UTILS=
>  
> -lib_LTLIBRARIES=libhealthexit.la libhealthstall.la
> -
>  # Health thread exit ld_preloaded test lib
>  libhealthexit_la_SOURCES=health_exit.c
>  libhealthexit_la_LDFLAGS= -module
> @@ -21,6 +19,7 @@ libhealthstall_la_SOURCES=health_stall.c
>  libhealthstall_la_LDFLAGS= -module
>  
>  noinst_PROGRAMS = health_check
> +noinst_LTLIBRARIES = libhealthexit.la libhealthstall.la
>  
>  health_check_SOURCES = health_check.c $(UTILS)
>  health_check_LDADD = $(top_builddir)/src/lib/lttng-ctl/liblttng-ctl.la \
> -- 
> 1.8.0
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
