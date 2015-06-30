From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Default to no unaligned access on
 unsupported archs
Date: Tue, 30 Jun 2015 17:05:11 +0000 (UTC)
Message-ID: <1228904846.1385.1435683911053.JavaMail.zimbra__40352.8283736252$1435684010$gmane$org@efficios.com>
References: <1435679740-32074-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z9yyM-0007Qj-FM
 for lttng-dev@lists.lttng.org; Tue, 30 Jun 2015 13:05:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8C69C34048B
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2015 17:05:21 +0000 (UTC)
In-Reply-To: <1435679740-32074-1-git-send-email-mjeanson@efficios.com>
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

Merged with a small configure output layout modification.

Thanks!

Mathieu

----- On Jun 30, 2015, at 11:55 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> configure.ac | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 03483a7..5901dfb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -241,7 +241,10 @@ changequote([,])dnl
> 	aarch64) NO_UNALIGNED_ACCESS=1 ;;
> 	mips*) NO_UNALIGNED_ACCESS=1 ;;
> 	tile*) NO_UNALIGNED_ACCESS=1 ;;
> -	*) AC_MSG_ERROR([unable to detect alignment requirements (unsupported
> architecture ($host_cpu)?)]) ;;
> +	*)
> +		UNSUPPORTED_ARCH=1
> +		NO_UNALIGNED_ACCESS=1
> +		;;
> esac
> AC_MSG_RESULT([$host_cpu])
> 
> @@ -423,5 +426,10 @@ AS_ECHO_N("sdt.h integration:  ")
> AS_IF([test "x$with_sdt" = "xyes"], [AS_ECHO("Enabled")], [AS_ECHO("Disabled")])
> 
> AS_ECHO()
> +AS_ECHO_N("Architecture ($host_cpu) has efficient unaligned memory access: ")
> +AS_IF([test "x$NO_UNALIGNED_ACCESS" != "x1"], [AS_ECHO("yes")], [AS_IF([test
> "x$UNSUPPORTED_ARCH" != "x1"], [AS_ECHO("no")], [AS_ECHO("unknown")])])
> +AS_IF([test "x$UNSUPPORTED_ARCH" = "x1"], [AC_MSG_WARN([Your architecture
> ($host_cpu) is unsupported, using safe default of no unaligned access])])
> +AS_ECHO()
> +
> AS_ECHO("Type 'make' to compile.")
> 
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
