From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Build: only check if python exist
	in path
Date: Tue, 11 Aug 2015 16:14:00 +0000 (UTC)
Message-ID: <678189230.18432.1439309640661.JavaMail.zimbra__12189.3822368749$1439309747$gmane$org@efficios.com>
References: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZPCBp-00081B-Rz
 for lttng-dev@lists.lttng.org; Tue, 11 Aug 2015 12:14:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 239D734031F
 for <lttng-dev@lists.lttng.org>; Tue, 11 Aug 2015 16:14:08 +0000 (UTC)
In-Reply-To: <1439232334-31308-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

series of 5 patches merged into master and stable-2.7. Thanks!

Mathieu

----- On Aug 10, 2015, at 2:45 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> configure.ac | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 0e9886b..d2b6bcb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -363,7 +363,7 @@ AC_ARG_WITH([lttng-system-rundir],
> AC_DEFINE_UNQUOTED([LTTNG_SYSTEM_RUNDIR], ["$lttng_system_rundir"],
> 	[LTTng system runtime directory])
> 
> -AM_PATH_PYTHON([2.7],BUILD_GEN_TP_EXAMPLES=1,[:])
> +AC_CHECK_PROG([BUILD_GEN_TP_EXAMPLES],[python],["yes"])
> AM_CONDITIONAL([BUILD_GEN_TP_EXAMPLES], [test $BUILD_GEN_TP_EXAMPLES], [Build
> examples requiring lttng-gen-tp])
> 
> AC_CONFIG_FILES([
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
