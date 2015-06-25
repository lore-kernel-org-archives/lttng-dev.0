From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: out of tree build of java
	agents
Date: Thu, 25 Jun 2015 23:19:49 +0000 (UTC)
Message-ID: <420624310.3691.1435274389914.JavaMail.zimbra__30105.678147129$1435274464$gmane$org@efficios.com>
References: <1435273854-19722-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z8GR9-0006Ow-1T
 for lttng-dev@lists.lttng.org; Thu, 25 Jun 2015 19:20:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 05233340407
 for <lttng-dev@lists.lttng.org>; Thu, 25 Jun 2015 23:19:58 +0000 (UTC)
In-Reply-To: <1435273854-19722-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged in master and stable-2.6, thanks!

Mathieu

----- On Jun 25, 2015, at 7:10 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> liblttng-ust-java-agent/jni/jul/Makefile.am   | 2 +-
> liblttng-ust-java-agent/jni/log4j/Makefile.am | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/liblttng-ust-java-agent/jni/jul/Makefile.am
> b/liblttng-ust-java-agent/jni/jul/Makefile.am
> index 6c9dc28..d0d6d78 100644
> --- a/liblttng-ust-java-agent/jni/jul/Makefile.am
> +++ b/liblttng-ust-java-agent/jni/jul/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> 
> lib_LTLIBRARIES = liblttng-ust-jul-jni.la
> liblttng_ust_jul_jni_la_SOURCES = lttng_ust_jul.c \
> diff --git a/liblttng-ust-java-agent/jni/log4j/Makefile.am
> b/liblttng-ust-java-agent/jni/log4j/Makefile.am
> index b734bf3..7acbccd 100644
> --- a/liblttng-ust-java-agent/jni/log4j/Makefile.am
> +++ b/liblttng-ust-java-agent/jni/log4j/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS = -I$(top_srcdir)/include
> +AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_builddir)/include
> lib_LTLIBRARIES = liblttng-ust-log4j-jni.la
> liblttng_ust_log4j_jni_la_SOURCES = lttng_ust_log4j.c \
> 				  lttng_ust_log4j.h
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
