From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace PATCH 01/01] Move strerror_r to compat
	directory
Date: Mon, 8 Jul 2013 09:04:28 -0400
Message-ID: <20130708130428.GG21348__20170.4879561023$1373288702$gmane$org@Krystal>
References: <009B25148989C6458484484699278506E5382C4B@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwB7G-0004ko-B9
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 09:04:30 -0400
Content-Disposition: inline
In-Reply-To: <009B25148989C6458484484699278506E5382C4B@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> The usage of strerror_r is platform dependent.
> Add new function compat_strerror_r to include/babeltrace/compat/string.h,
> and hide the platform-dependent usage there.
> Use the aforementioned header file instead of standard string.h where
> necessary.

merged as:

commit 9a7f65a34e9358633109338f12bb52303c358d35
Author: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Date:   Mon Jul 8 09:02:02 2013 -0400

    Move strerror_r to compat directory
    
    The usage of strerror_r is platform dependent.
    Add new function compat_strerror_r to
    include/babeltrace/compat/string.h,
    and hide the platform-dependent usage there.
    Use the aforementioned header file instead of standard string.h where
    necessary.
    
    [ Updates by Mathieu Desnoyers: fix coding style, fix possible buffer
      overflow by using strncpy rather than strcpy. ]
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> ---
>  include/Makefile.am                      |  1 +
>  include/babeltrace/babeltrace-internal.h | 32 +++-----------------------------
>  include/babeltrace/compat/string.h       | 28 ++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 29 deletions(-)
>  create mode 100644 include/babeltrace/compat/string.h
> 
> diff --git a/include/Makefile.am b/include/Makefile.am
> index eee2ac1..f121d84 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -33,5 +33,6 @@ noinst_HEADERS = \
>  	babeltrace/trace-handle-internal.h \
>  	babeltrace/compat/uuid.h \
>  	babeltrace/compat/memstream.h \
> +	babeltrace/compat/string.h \
>  	babeltrace/endian.h \
>  	babeltrace/mmap-align.h
> diff --git a/include/babeltrace/babeltrace-internal.h b/include/babeltrace/babeltrace-internal.h
> index 9b9ffbd..1f379ee 100644
> --- a/include/babeltrace/babeltrace-internal.h
> +++ b/include/babeltrace/babeltrace-internal.h
> @@ -27,7 +27,7 @@
>  #include <stdio.h>
>  #include <glib.h>
>  #include <stdint.h>
> -#include <string.h>
> +#include <babeltrace/compat/string.h>
>  
>  #define PERROR_BUFLEN	200
>  
> @@ -81,46 +81,20 @@ extern int babeltrace_verbose, babeltrace_debug;
>  		perrorstr,						\
>  		## args)
>  
> -#if !defined(__linux__) || ((_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && !defined(_GNU_SOURCE))
> -
>  #define _bt_printf_perror(fp, fmt, args...)				\
>  	({								\
>  		char buf[PERROR_BUFLEN] = "Error in strerror_r()";	\
> -		strerror_r(errno, buf, sizeof(buf));			\
> +		compat_strerror_r(errno, buf, sizeof(buf));		\
>  		_bt_printfe(fp, "error", buf, fmt, ## args);		\
>  	})
>  
>  #define _bt_printfl_perror(fp, lineno, fmt, args...)			\
>  	({								\
>  		char buf[PERROR_BUFLEN] = "Error in strerror_r()";	\
> -		strerror_r(errno, buf, sizeof(buf));			\
> +		compat_strerror_r(errno, buf, sizeof(buf));		\
>  		_bt_printfle(fp, "error", lineno, buf, fmt, ## args);	\
>  	})
>  
> -#else
> -
> -/*
> - * Version using GNU strerror_r, for linux with appropriate defines.
> - */
> -
> -#define _bt_printf_perror(fp, fmt, args...)				\
> -	({								\
> -		char *buf;						\
> -		char tmp[PERROR_BUFLEN] = "Error in strerror_r()";	\
> -		buf = strerror_r(errno, tmp, sizeof(tmp));		\
> -		_bt_printfe(fp, "error", buf, fmt, ## args);		\
> -	})
> -
> -#define _bt_printfl_perror(fp, lineno, fmt, args...)			\
> -	({								\
> -		char *buf;						\
> -		char tmp[PERROR_BUFLEN] = "Error in strerror_r()";	\
> -		buf = strerror_r(errno, tmp, sizeof(tmp));		\
> -		_bt_printfle(fp, "error", lineno, buf, fmt, ## args);	\
> -	})
> -
> -#endif
> -
>  /* printf without lineno information */
>  #define printf_fatal(fmt, args...)					\
>  	_bt_printf(stderr, "fatal", fmt, ## args)
> diff --git a/include/babeltrace/compat/string.h b/include/babeltrace/compat/string.h
> new file mode 100644
> index 0000000..62cf1bf
> --- /dev/null
> +++ b/include/babeltrace/compat/string.h
> @@ -0,0 +1,28 @@
> +#ifndef _BABELTRACE_COMPAT_STRING_H
> +#define _BABELTRACE_COMPAT_STRING_H
> +
> +#include <string.h>
> +
> +#if !defined(__linux__) || ((_POSIX_C_SOURCE >= 200112L || _XOPEN_SOURCE >= 600) && !defined(_GNU_SOURCE))
> +
> +/* XSI-compliant strerror_r */
> +static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
> +{
> +	return strerror_r(errnum, buf, buflen);
> +}
> +
> +#else
> +
> +/* GNU-compliant strerror_r */
> +static inline int compat_strerror_r(int errnum, char *buf, size_t buflen)
> +{
> +	char * retbuf;
> +	retbuf = strerror_r(errnum, buf, buflen);
> +	if (retbuf != buf)
> +		strcpy(buf, retbuf);
> +	return 0;
> +}
> +
> +#endif
> +
> +#endif /* _BABELTRACE_COMPAT_STRING_H */
> -- 
> 1.8.1.msysgit.1
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
