From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Corrected python
	version	assumptions in lttng-gen-tp
Date: Tue, 25 Mar 2014 14:16:02 +0000 (UTC)
Message-ID: <654526496.119.1395756962956.JavaMail.zimbra__8273.55609876594$1395759064$gmane$org@efficios.com>
References: <1395671384-24750-1-git-send-email-jderehag@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WSS9E-0005s9-Sz
	for lttng-dev@lists.lttng.org; Tue, 25 Mar 2014 10:16:21 -0400
In-Reply-To: <1395671384-24750-1-git-send-email-jderehag@hotmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jderehag@hotmail.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: jderehag@hotmail.com
> To: lttng-dev@lists.lttng.org
> Cc: "Jesper Derehag" <jderehag@hotmail.com>
> Sent: Monday, March 24, 2014 10:29:44 AM
> Subject: [lttng-dev] [PATCH lttng-ust] Fix: Corrected python version	assumptions in lttng-gen-tp
> 
> From: Jesper Derehag <jderehag@hotmail.com>
> 
> This modification calls the interpreter through env instead of
> directly, which should be more portable for those distros which do not
> install
> python into /usr/bin/.
> 
> Also, since lttng-gen-tp is not python2 compatible, I changed it to strictly
> call python3 which is the recommended way.
> See PEP 394.
> http://legacy.python.org/dev/peps/pep-0394/

Hi Jesper,

I somehow thought that lttng-gen-tp was meant to work with
Python 2.7 and Python 3. But maybe I'm missing something.
Where have you seen the dependency of this script on python
3 in our docs ?

Thanks,

Mathieu


> ---
>  tools/lttng-gen-tp |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
> index c49e8a5..c7bf295 100755
> --- a/tools/lttng-gen-tp
> +++ b/tools/lttng-gen-tp
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python3
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
