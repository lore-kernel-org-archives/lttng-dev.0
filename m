From: David Goulet <dgoulet@efficios.com>
Subject: Re: [LTTng-tools PATCH] Update URCU detection to
 correctly check for a 0.7 version
Date: Fri, 28 Jun 2013 11:21:30 -0400
Message-ID: <51CDA9FA.7030708__20474.7050338939$1372432933$gmane$org@efficios.com>
References: <1372367009-8377-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UsaUU-0005a2-PA
	for lttng-dev@lists.lttng.org; Fri, 28 Jun 2013 11:21:39 -0400
In-Reply-To: <1372367009-8377-1-git-send-email-yannick.brosseau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged!

Yannick Brosseau:
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  configure.ac |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 792679a..36c4ae1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -162,6 +162,10 @@ AC_CHECK_DECL([rcu_thread_online], [],
>  AC_CHECK_DECL([caa_likely], [],
>  	[AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
>  )
> +#Function added in urcu 0.7.0
> +AC_CHECK_DECL([cmm_smp_mb__before_uatomic_or], [],
> +        [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [[#include <urcu.h>]]
> +)
>  
>  AC_ARG_WITH(lttng-ust-prefix,
>    AS_HELP_STRING([--with-lttng-ust-prefix=PATH],
