From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-ust] Fix: man: you can't link a lib with
	a	static lib
Date: Thu, 11 Dec 2014 16:00:56 +0000 (UTC)
Message-ID: <1604578754.26232.1418313656174.JavaMail.zimbra__44691.5350076326$1418313703$gmane$org@efficios.com>
References: <1417038656-21690-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Xz6Al-00021j-IP
 for lttng-dev@lists.lttng.org; Thu, 11 Dec 2014 11:01:00 -0500
In-Reply-To: <1417038656-21690-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged into master down to stable-2.4, thanks!

Mathieu

----- Original Message -----
> From: "Philippe Proulx" <eeppeliteloop@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Wednesday, November 26, 2014 4:50:56 PM
> Subject: [lttng-dev] [lttng-ust] Fix: man: you can't link a lib with a	static lib
> 
> Fixes: #825
> 
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
>  doc/man/lttng-ust.3 | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
> index 0c8405f..3d52bc0 100644
> --- a/doc/man/lttng-ust.3
> +++ b/doc/man/lttng-ust.3
> @@ -299,17 +299,13 @@ There are 2 ways to compile the Tracepoint Provider
> with the
>  application: either statically or dynamically. Please follow
>  carefully:
>  
> -  1.1) Compile the Tracepoint provider with the application, either
> -       directly or through a static library (.a):
> -    - Into exactly one object of your application: define
> +  1) Compile the Tracepoint Provider with the application, either
> +     directly or through a static library (.a):
> +    - Into exactly one object of your application, define
>        "TRACEPOINT_DEFINE" and include the tracepoint provider.
>      - Use "\-I." for the compilation unit containing the tracepoint
> -      provider include (e.g. tp.c).
> -    - Link application with "\-ldl".
> -    - If building the provider directly into the application,
> -      link the application with "\-llttng-ust".
> -    - If building a static library for the provider, link the static
> -      library with "\-llttng-ust".
> +      provider include (e.g., tp.c).
> +    - Link the application with "\-llttng-ust" and "\-ldl".
>      - Include the tracepoint provider header into all C files using
>        the provider.
>      - Examples:
> --
> 2.1.3
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
