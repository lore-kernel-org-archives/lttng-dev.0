From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH] Fix: Don't (re)define STAP_PROBEV
Date: Wed, 14 Oct 2015 13:29:56 -0400
Message-ID: <561E9114.1040705__15971.5686146685$1444843856$gmane$org@efficios.com>
References: <871tcx5s47.wl-sb@enotty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1ZmPsL-0006HM-LB
 for lttng-dev@lists.lttng.org; Wed, 14 Oct 2015 13:30:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 74C23340307
 for <lttng-dev@lists.lttng.org>; Wed, 14 Oct 2015 17:30:01 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5NHSTsMzoDBm for <lttng-dev@lists.lttng.org>;
 Wed, 14 Oct 2015 17:29:59 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id D188A34031D
 for <lttng-dev@lists.lttng.org>; Wed, 14 Oct 2015 17:29:59 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id l0Tjprwtu-aU for <lttng-dev@lists.lttng.org>;
 Wed, 14 Oct 2015 17:29:59 +0000 (UTC)
Received: from [172.16.0.141] (cable-192.222.213.99.electronicbox.net
 [192.222.213.99])
 by mail.efficios.com (Postfix) with ESMTPSA id 7313F340307
 for <lttng-dev@lists.lttng.org>; Wed, 14 Oct 2015 17:29:59 +0000 (UTC)
In-Reply-To: <871tcx5s47.wl-sb@enotty.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Stelios,

Thanks for the patch!

Look's like it's for lttng-tools. Since there is multiple projects on 
the ML make sure to add the project
name to the patch email suffix next time.

It will ease the work of jgalar :P

For more info you can have a look at the contributor's guide here [1].

[1] https://lttng.org/community/

Cheers!

On 2015-10-14 12:31 PM, Stelios Bounanos wrote:
> Define a new LTTNG_STAP_PROBEV macro to avoid clobbering STAP_PROBEV or
> emitting unwanted sdt probes when lttng-ust has been built without sdt
> support.
>
> Signed-off-by: Stelios Bounanos <sb@enotty.net>
> ---
>
> Notes:
>      Tested by building doc/examples/hello-static-lib both --with-sdt and
>      --without-sdt.
>      
>      Programs that included sys/sdt.h after (for example) lttng/tracef.h
>      would get static probes for lttng tracepoints even if lttng-ust was
>      built without sdt support.  I'm guessing that this was unintended.
>
>   include/lttng/tracef.h     | 2 +-
>   include/lttng/tracelog.h   | 2 +-
>   include/lttng/tracepoint.h | 5 +++--
>   3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
> index 7e8b59e..0c59c9a 100644
> --- a/include/lttng/tracef.h
> +++ b/include/lttng/tracef.h
> @@ -34,7 +34,7 @@ void _lttng_ust_tracef(const char *fmt, ...);
>   
>   #define tracef(fmt, ...)						\
>   	do {								\
> -		STAP_PROBEV(tracepoint_lttng_ust_tracef, event, ## __VA_ARGS__); \
> +		LTTNG_STAP_PROBEV(tracepoint_lttng_ust_tracef, event, ## __VA_ARGS__); \
>   		if (caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
>   			_lttng_ust_tracef(fmt, ## __VA_ARGS__);		\
>   	} while (0)
> diff --git a/include/lttng/tracelog.h b/include/lttng/tracelog.h
> index 5f14f70..4309d12 100644
> --- a/include/lttng/tracelog.h
> +++ b/include/lttng/tracelog.h
> @@ -53,7 +53,7 @@ TP_TRACELOG_CB_TEMPLATE(TRACE_DEBUG);
>   
>   #define tracelog(level, fmt, ...)					\
>   	do {								\
> -		STAP_PROBEV(tracepoint_lttng_ust_tracelog, level, ## __VA_ARGS__); \
> +		LTTNG_STAP_PROBEV(tracepoint_lttng_ust_tracelog, level, ## __VA_ARGS__); \
>   		if (caa_unlikely(__tracepoint_lttng_ust_tracelog___##level.state)) \
>   			_lttng_ust_tracelog_##level(__FILE__, __LINE__, __func__, \
>   				fmt, ## __VA_ARGS__); \
> diff --git a/include/lttng/tracepoint.h b/include/lttng/tracepoint.h
> index 4bc4fc9..e88db89 100644
> --- a/include/lttng/tracepoint.h
> +++ b/include/lttng/tracepoint.h
> @@ -37,8 +37,9 @@
>   #ifdef LTTNG_UST_HAVE_SDT_INTEGRATION
>   #define SDT_USE_VARIADIC
>   #include <sys/sdt.h>
> +#define LTTNG_STAP_PROBEV STAP_PROBEV
>   #else
> -#define STAP_PROBEV(...)
> +#define LTTNG_STAP_PROBEV(...)
>   #endif
>   
>   #ifdef __cplusplus
> @@ -53,7 +54,7 @@ extern "C" {
>   
>   #define tracepoint(provider, name, ...)					    \
>   	do {								    \
> -		STAP_PROBEV(provider, name, ## __VA_ARGS__);		    \
> +		LTTNG_STAP_PROBEV(provider, name, ## __VA_ARGS__);	    \
>   		if (tracepoint_enabled(provider, name)) 		    \
>   			do_tracepoint(provider, name, __VA_ARGS__);	    \
>   	} while (0)

-- 
Jonathan R. Julien
Efficios
