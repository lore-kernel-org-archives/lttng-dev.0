From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: java class check when
 uudecode is not present
Date: Tue, 30 Jun 2015 21:09:12 +0000 (UTC)
Message-ID: <1332006543.1502.1435698552905.JavaMail.zimbra__40444.5977685556$1435698642$gmane$org@efficios.com>
References: <1435697994-7682-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZA2mS-0000AE-Dk
 for lttng-dev@lists.lttng.org; Tue, 30 Jun 2015 17:09:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8DD2534049E
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jun 2015 21:09:19 +0000 (UTC)
In-Reply-To: <1435697994-7682-1-git-send-email-mjeanson@efficios.com>
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

merged into stable-2.6 and master, thanks!

Mathieu

----- On Jun 30, 2015, at 4:59 PM, Michael Jeanson mjeanson@efficios.com wrote:

> On systems where 'uudecode' is present, the java class check will
> run a precompiled class file in the local directory. If the CLASSPATH
> variable doesn't contain "." the test will fail regardless of the
> presence of the tested for class on the classpath.
> 
> This fix makes the behavior of the test consistant whether 'uudecode'
> is present or not.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> config/ax_check_class.m4 | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/config/ax_check_class.m4 b/config/ax_check_class.m4
> index 098aa77..42b51d7 100644
> --- a/config/ax_check_class.m4
> +++ b/config/ax_check_class.m4
> @@ -118,7 +118,7 @@ EOF
>                         ac_cv_prog_uudecode_base64=no
>                 fi
>         rm -f Test.uue
> -        if AC_TRY_COMMAND($JAVA $JAVAFLAGS Test $1) >/dev/null 2>&1; then
> +        if AC_TRY_COMMAND($JAVA -classpath ".:$CLASSPATH" $JAVAFLAGS Test $1)
> >/dev/null 2>&1; then
>                 eval "ac_cv_class_$ac_var_name=yes"
>         else
>                 eval "ac_cv_class_$ac_var_name=no"
> --
> 1.9.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
