From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-ust] Fix: python invocation through
 env
Date: Wed, 2 Apr 2014 16:34:56 +0000 (UTC)
Message-ID: <1245840009.4951.1396456496843.JavaMail.zimbra__11331.3498594382$1396519268$gmane$org@efficios.com>
References: <1396845262.585.1395775224524.JavaMail.zimbra@efficios.com>
 <1395907026-934-1-git-send-email-jderehag@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WVO81-0001E8-Da
 for lttng-dev@lists.lttng.org; Wed, 02 Apr 2014 12:35:11 -0400
In-Reply-To: <1395907026-934-1-git-send-email-jderehag@hotmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jderehag@hotmail.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

For the next patches, please add a 

Signed-off-by: Name Lastname <email>

line at the end of the patch description to follow the
LTTng project's use of developer's certificate of origin.

Please let me know if I can add your signed-off-by as:

Signed-off-by: Jesper Derehag <jderehag@hotmail.com>

to this patch so I can merge it.

If you wonder what it means, see:

http://elinux.org/Developer_Certificate_Of_Origin

Thanks!

Mathieu

----- Original Message -----
> From: jderehag@hotmail.com
> To: lttng-dev@lists.lttng.org
> Sent: Thursday, March 27, 2014 3:57:06 AM
> Subject: [lttng-dev] [PATCH v2 lttng-ust] Fix: python invocation through env
> 
> From: Jesper Derehag <jderehag@hotmail.com>
> 
> This modification calls the interpreter through env instead of
> directly, which should be more portable for those distros which do not
> install
> python into /usr/bin/.
> ---
>  tools/lttng-gen-tp |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
> index c49e8a5..a3a01f2 100755
> --- a/tools/lttng-gen-tp
> +++ b/tools/lttng-gen-tp
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python
>  #
>  # Copyright (c)  2012 Yannick Brosseau <yannick.brosseau@gmail.com>
>  #
> --
> 1.7.9.5
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
