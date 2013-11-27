From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH liburcu 2/5] Dont link pthread on Android
Date: Wed, 27 Nov 2013 16:10:37 +0000 (UTC)
Message-ID: <164876968.76709.1385568637093.JavaMail.zimbra__36440.9051057466$1385568737$gmane$org@efficios.com>
References: <1385567313-8138-1-git-send-email-charlesbriere.flatzo@gmail.com>
	<1385567313-8138-2-git-send-email-charlesbriere.flatzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VlhhF-0003pX-5e
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 11:10:42 -0500
In-Reply-To: <1385567313-8138-2-git-send-email-charlesbriere.flatzo@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Charles Briere <charlesbriere.flatzo@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Charles Briere" <charlesbriere.flatzo@gmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Charles Briere" <charlesbriere.flatzo@gmail.com>
> Sent: Wednesday, November 27, 2013 10:48:30 AM
> Subject: [PATCH liburcu 2/5] Dont link pthread on Android
> 
> On Android, pthread is already part of libc
> called Bionic and doesn't have an external
> library to link with.
> 
> Signed-off-by: Charles Briere <charlesbriere.flatzo@gmail.com>
> ---
>  Makefile.am                  | 5 ++++-
>  tests/benchmark/Makefile.am  | 4 +++-
>  tests/regression/Makefile.am | 4 +++-
>  tests/unit/Makefile.am       | 4 +++-
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index e09778f..baac8b9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -4,7 +4,10 @@ INCLUDES = -I$(top_builddir)/urcu
>  
>  #Add the -version-info directly here since we are only building
>  # library that use the version-info
> -AM_LDFLAGS=-lpthread -version-info $(URCU_LIBRARY_VERSION)
> +AM_LDFLAGS=-version-info $(URCU_LIBRARY_VERSION)
> +if !TARGET_IS_ANDROID
> +AM_LDFLAGS += -lpthread
> +endif
>  AM_CFLAGS=-Wall
>  
>  SUBDIRS = . doc tests
> diff --git a/tests/benchmark/Makefile.am b/tests/benchmark/Makefile.am
> index e071034..91ba1da 100644
> --- a/tests/benchmark/Makefile.am
> +++ b/tests/benchmark/Makefile.am
> @@ -1,4 +1,6 @@
> -AM_LDFLAGS=-lpthread
> +if !TARGET_IS_ANDROID
> +AM_LDFLAGS += -lpthread

change = for += is triggering those warnings

./bootstrap 
+ [ ! -e config ]
+ autoreconf -i
tests/benchmark/Makefile.am:2: AM_LDFLAGS must be set with `=' before using `+='
tests/regression/Makefile.am:2: AM_LDFLAGS must be set with `=' before using `+='
tests/unit/Makefile.am:2: AM_LDFLAGS must be set with `=' before using `+='
autoreconf: automake failed with exit status: 1

Will fix in the patch myself.

Thanks,

Mathieu

> +endif
>  AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
>  
>  noinst_PROGRAMS = test_urcu test_urcu_dynamic_link test_urcu_timing \
> diff --git a/tests/regression/Makefile.am b/tests/regression/Makefile.am
> index 2c0542f..2cefa33 100644
> --- a/tests/regression/Makefile.am
> +++ b/tests/regression/Makefile.am
> @@ -1,4 +1,6 @@
> -AM_LDFLAGS=-lpthread
> +if !TARGET_IS_ANDROID
> +AM_LDFLAGS += -lpthread
> +endif
>  AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
>  
>  noinst_PROGRAMS = test_urcu_fork \
> diff --git a/tests/unit/Makefile.am b/tests/unit/Makefile.am
> index 1fa8b71..85860e2 100644
> --- a/tests/unit/Makefile.am
> +++ b/tests/unit/Makefile.am
> @@ -1,4 +1,6 @@
> -AM_LDFLAGS=-lpthread
> +if !TARGET_IS_ANDROID
> +AM_LDFLAGS += -lpthread
> +endif
>  AM_CFLAGS=-I$(top_srcdir) -I$(top_builddir) -I$(top_srcdir)/tests/common -g
>  
>  noinst_PROGRAMS = test_uatomic \
> --
> 1.8.4.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
