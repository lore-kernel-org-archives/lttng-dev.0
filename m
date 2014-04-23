From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Added fallback for betoh/htobe
 if	they do not exist
Date: Wed, 23 Apr 2014 08:30:47 +0000 (UTC)
Message-ID: <235015716.5713.1398241847265.JavaMail.zimbra__27616.8584278368$1398242457$gmane$org@efficios.com>
References: <1397857709-30241-1-git-send-email-jderehag@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Wcsin-0004rh-8u
 for lttng-dev@lists.lttng.org; Wed, 23 Apr 2014 04:40:06 -0400
In-Reply-To: <1397857709-30241-1-git-send-email-jderehag@hotmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jesper Derehag <jderehag@hotmail.com>
Cc: lttng-dev@lists.lttng.org, Jesper Derehag <jesper.derehag@ericsson.com>
List-Id: lttng-dev@lists.lttng.org

Hi Jesper,

Some minor comments below,

----- Original Message -----
> From: "Jesper Derehag" <jderehag@hotmail.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Jesper Derehag" <jesper.derehag@ericsson.com>
> Sent: Friday, April 18, 2014 11:48:29 PM
> Subject: [lttng-dev] [PATCH babeltrace] Added fallback for betoh/htobe if	they do not exist
> 
> From: Jesper Derehag <jesper.derehag@ericsson.com>
> 
> For older systems endian.h may not contain the betoh/htobe macros.
> If they are missing, add them and make sure that any user of
> htobe/betoh uses include/babeltrace/endian.h and not system endian.h
> 
> Signed-off-by: Jesper Derehag <jderehag@hotmail.com>
> Tested-by: Jesper Derehag <jderehag@hotmail.com>
> ---
>  formats/lttng-live/lttng-live-comm.c |  1 +
>  include/babeltrace/endian.h          | 91
>  +++++++++++++++++++++++++++++++++++-
>  2 files changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/formats/lttng-live/lttng-live-comm.c
> b/formats/lttng-live/lttng-live-comm.c
> index 9feb718..3aad981 100644
> --- a/formats/lttng-live/lttng-live-comm.c
> +++ b/formats/lttng-live/lttng-live-comm.c
> @@ -50,6 +50,7 @@
>  #include <babeltrace/ctf/events-internal.h>
>  #include <formats/ctf/events-private.h>
>  
> +#include <babeltrace/endian.h>
>  #include <babeltrace/compat/memstream.h>
>  
>  #include "lttng-live.h"
> diff --git a/include/babeltrace/endian.h b/include/babeltrace/endian.h
> index f15a44f..e39e599 100644
> --- a/include/babeltrace/endian.h
> +++ b/include/babeltrace/endian.h
> @@ -47,7 +47,96 @@
>  #define BYTE_ORDER     __BYTE_ORDER
>  #else
>  #include <endian.h>
> -#endif
> +
> +/* htobe/betoh are not defined for glibc <2.9, so add them
> + * explicitly if they are missing */

our comment style is:

/*
 * This is a sentence. Another, and other, and other. And
 * it continues.
 */

(missing newlines, and dot at the end of the comment.)

You might want to run checkpatch.pl from lttng-tools extras/
to validate the coding style.

> +# ifdef __USE_BSD
> +/* Conversion interfaces.  */

This kind of comment is also OK. However, please remove the extra
space after the dot.

> +#  include <byteswap.h>
> +
> +#  if __BYTE_ORDER == __LITTLE_ENDIAN
> +#   ifndef htobe16
> +#    define htobe16(x) __bswap_16(x)
> +#   endif
> +#   ifndef htole16
> +#    define htole16(x) (x)
> +#   endif
> +#   ifndef be16toh
> +#    define be16toh(x) __bswap_16(x)
> +#   endif
> +#   ifndef le16toh
> +#    define le16toh(x) (x)
> +#   endif
> +
> +#   ifndef htobe32
> +#    define htobe32(x) __bswap_32(x)
> +#   endif
> +#   ifndef htole32
> +#    define htole32(x) (x)
> +#   endif
> +#   ifndef be32toh
> +#    define be32toh(x) __bswap_32(x)
> +#   endif
> +#   ifndef le32toh
> +#    define le32toh(x) (x)
> +#   endif
> +
> +#   ifndef htobe64
> +#    define htobe64(x) __bswap_64(x)
> +#   endif
> +#   ifndef htole64
> +#    define htole64(x) (x)
> +#   endif
> +#   ifndef be64toh
> +#    define be64toh(x) __bswap_64(x)
> +#   endif
> +#   ifndef le64toh
> +#    define le64toh(x) (x)
> +#   endif
> +
> +#  else /* __BYTE_ORDER == __LITTLE_ENDIAN */
> +#   ifndef htobe16
> +#    define htobe16(x) (x)
> +#   endif
> +#   ifndef htole16
> +#    define htole16(x) __bswap_16(x)
> +#   endif
> +#   ifndef be16toh
> +#    define be16toh(x) (x)
> +#   endif
> +#   ifndef le16toh
> +#    define le16toh(x) __bswap_16(x)
> +#   endif
> +
> +#   ifndef htobe32
> +#    define htobe32(x) (x)
> +#   endif
> +#   ifndef htole32
> +#    define htole32(x) __bswap_32(x)
> +#   endif
> +#   ifndef be32toh
> +#    define be32toh(x) (x)
> +#   endif
> +#   ifndef le32toh
> +#    define le32toh(x) __bswap_32(x)
> +#   endif
> +
> +#   ifndef htobe64
> +#    define htobe64(x) (x)
> +#   endif
> +#   ifndef htole64
> +#    define htole64(x) __bswap_64(x)
> +#   endif
> +#   ifndef be64toh
> +#    define be64toh(x) (x)
> +#   endif
> +#   ifndef le64toh
> +#    define le64toh(x) __bswap_64(x)
> +#   endif
> +
> +#  endif /* __BYTE_ORDER == __LITTLE_ENDIAN */
> +# endif /* __USE_BSD */
> +#endif /* else -- __FreeBSD__ */

The /* else -- __FreeBSD__ */ style of comment (with --) is
new to me, but I see it's prettier than trying to express the
ifdef/elif, etc. So I'm OK with this one.

Thanks,

Mathieu

>  
>  #ifndef FLOAT_WORD_ORDER
>  #ifdef __FLOAT_WORD_ORDER
> --
> 1.9.1
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
