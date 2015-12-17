From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Support for Xeon-Phi with newer MPSS
Date: Thu, 17 Dec 2015 12:56:11 +0000 (UTC)
Message-ID: <993448979.259018.1450356971102.JavaMail.zimbra__5475.8793827661$1450357050$gmane$org@efficios.com>
References: <1450296167-9584-1-git-send-email-didier.nadeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1a9Y6R-0001sq-VB
 for lttng-dev@lists.lttng.org; Thu, 17 Dec 2015 07:56:19 -0500
In-Reply-To: <1450296167-9584-1-git-send-email-didier.nadeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Didier Nadeau <didier.nadeau@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged into urcu master and stable-0.9, thanks!

Mathieu

----- On Dec 16, 2015, at 3:02 PM, Didier Nadeau didier.nadeau@gmail.com wrote:

> The Xeon-Phi is now considered as a new architecture instead of a
> vendor in MPSS version 3.4.4. This change is backward compatible with
> previous MPSS versions.
> 
> Signed-off-by: Didier Nadeau <didier.nadeau@gmail.com>
> ---
> configure.ac | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index e7e300b..39a7777 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -103,6 +103,7 @@ AC_CHECK_HEADERS([ \
> 
> # Find arch type
> AS_CASE([$host_cpu],
> +	[k1om], [ARCHTYPE="x86"],
> 	[i386], [ARCHTYPE="x86" && SUBARCHTYPE="x86compat"],
> 	[i486], [ARCHTYPE="x86"],
> 	[i586], [ARCHTYPE="x86"],
> @@ -189,7 +190,7 @@ AS_IF([test "x$ARCHTYPE" = "xx86"],[
> 	#
> 	#k1om is the name for the Intel MIC family (Xeon Phi). It is an x86_64
> 	#variant but lacks fence instructions.
> -	AS_IF([test "x$host_cpu" != "xi386" -a "x$host_cpu" != "xi486" -a "x$host_cpu"
> != "xi586" -a "x$host_cpu" != "xi686" -a "x$host_vendor" != "xk1om"],[
> +	AS_IF([test "x$host_cpu" != "xi386" -a "x$host_cpu" != "xi486" -a "x$host_cpu"
> != "xi586" -a "x$host_cpu" != "xi686" -a "x$host_vendor" != "xk1om" -a
> "x$host_cpu" != "xk1om"],[
> 		AC_MSG_RESULT([yes])
> 		AC_DEFINE([CONFIG_RCU_HAVE_FENCE], [1])
> 	],[
> --
> 1.9.1
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
