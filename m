From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Use $enableval with
	AC_ARG_ENABLE
Date: Wed, 8 Jul 2015 18:42:34 +0000 (UTC)
Message-ID: <665537953.1085.1436380954314.JavaMail.zimbra__14910.8700723902$1436381054$gmane$org@efficios.com>
References: <1436379897-32219-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZCuIx-00072l-0H
 for lttng-dev@lists.lttng.org; Wed, 08 Jul 2015 14:42:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DA1073403F5
 for <lttng-dev@lists.lttng.org>; Wed,  8 Jul 2015 18:42:42 +0000 (UTC)
In-Reply-To: <1436379897-32219-1-git-send-email-mjeanson@efficios.com>
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

Merged into master and stable-2.6. The regression was introduced in
2.6, so not backported to 2.5.

Thanks,

Mathieu

----- On Jul 8, 2015, at 2:24 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> configure.ac | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 8bbf7b9..cb4bb21 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -255,7 +255,7 @@ fi
> # Check for JNI header files if requested
> AC_ARG_ENABLE([jni-interface],
> 	[AS_HELP_STRING([--enable-jni-interface],[build JNI interface between C and
> 	Java. Needs Java include files [default=no]])],
> -	[jni_interface=$withval],
> +	[jni_interface=$enableval],
> 	[jni_interface=no]
> )
> 
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
