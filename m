From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix: out of tree build for lib Java and JUL
Date: Tue, 27 May 2014 15:11:31 +0000 (UTC)
Message-ID: <222512820.23253.1401203491274.JavaMail.zimbra__39256.3548907221$1401203603$gmane$org@efficios.com>
References: <1401203022-31445-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WpJ2P-0001bS-EU
 for lttng-dev@lists.lttng.org; Tue, 27 May 2014 11:11:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 3287434021D
 for <lttng-dev@lists.lttng.org>; Tue, 27 May 2014 15:11:37 +0000 (UTC)
In-Reply-To: <1401203022-31445-1-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

----- Original Message -----
> From: "David Goulet" <dgoulet@efficios.com>
> To: lttng-dev@lists.lttng.org
> Cc: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "David Goulet" <dgoulet@efficios.com>
> Sent: Tuesday, May 27, 2014 11:03:42 AM
> Subject: [PATCH] Fix: out of tree build for lib Java and JUL
> 
> Reported-by: Daniel Olivier <daniel.olivier@ericsson.com>
> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  liblttng-ust-java/Makefile.am | 2 +-
>  liblttng-ust-jul/Makefile.am  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/liblttng-ust-java/Makefile.am b/liblttng-ust-java/Makefile.am
> index 64c654b..c66dd79 100644
> --- a/liblttng-ust-java/Makefile.am
> +++ b/liblttng-ust-java/Makefile.am
> @@ -3,7 +3,7 @@ LTTNG_JUST_DESTDIR = $(builddir)/org/lttng/ust
>  
>  if BUILD_JNI_INTERFACE
>  
> -AM_CPPFLAGS = -I$(top_srcdir)/include -I$(builddir)
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(builddir)
> -I$(top_builddir)/include
>  
>  BUILT_SOURCES = org_lttng_ust_LTTngUst.h
>  lib_LTLIBRARIES = liblttng-ust-java.la
> diff --git a/liblttng-ust-jul/Makefile.am b/liblttng-ust-jul/Makefile.am
> index bc13c76..eb0a5f6 100644
> --- a/liblttng-ust-jul/Makefile.am
> +++ b/liblttng-ust-jul/Makefile.am
> @@ -3,7 +3,7 @@ LTTNG_JUL_DESTDIR = $(builddir)/org/lttng/ust/jul
>  
>  if BUILD_JNI_INTERFACE
>  
> -AM_CPPFLAGS = -I$(top_srcdir)/include -I$(builddir)
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(builddir)
> -I$(top_builddir)/include
>  
>  BUILT_SOURCES = org_lttng_ust_jul_LTTngUst.h
>  lib_LTLIBRARIES = liblttng-ust-jul-jni.la
> --
> 2.0.0.rc2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
