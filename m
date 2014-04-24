From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 babeltrace] Added fallback for
 betoh/htobe if they do not exist
Date: Thu, 24 Apr 2014 06:14:42 +0000 (UTC)
Message-ID: <1265513289.6410.1398320082067.JavaMail.zimbra__26090.4927891263$1398320149$gmane$org@efficios.com>
References: <235015716.5713.1398241847265.JavaMail.zimbra@efficios.com>
 <1398267926-2541-1-git-send-email-jderehag@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WdCvn-0003u5-QW
 for lttng-dev@lists.lttng.org; Thu, 24 Apr 2014 02:14:52 -0400
In-Reply-To: <1398267926-2541-1-git-send-email-jderehag@hotmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jesper Derehag <jderehag@hotmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Merged. I added the missing space between "." and "*" in one
comment. I also changed the patch title to present tense "Add
fallback...".

Thanks!

Mathieu

----- Original Message -----
> From: "Jesper Derehag" <jderehag@hotmail.com>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org, "Jesper Derehag" <jderehag@hotmail.com>
> Sent: Wednesday, April 23, 2014 5:45:26 PM
> Subject: [PATCH v3 babeltrace] Added fallback for betoh/htobe if they do not exist
> 
> For older systems endian.h may not contain the betoh/htobe macros.
> If they are missing, add them and make sure that any user of
> htobe/betoh uses the compat/endian.h
> 
> Signed-off-by: Jesper Derehag <jderehag@hotmail.com>
> Tested-by: Jesper Derehag <jderehag@hotmail.com>
> ---
> Compared to v2 this fixes the coding style for comments.
> I just want to mention that I did run checkpatch for v2 and
> that it passed. But fixed according to Mr. Desnoyers
> comments anyway.
> 
>  formats/lttng-live/lttng-live-comm.c |  1 +
>  include/babeltrace/endian.h          | 93
>  +++++++++++++++++++++++++++++++++++-
>  2 files changed, 93 insertions(+), 1 deletion(-)
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
> index f15a44f..fcfe583 100644
> --- a/include/babeltrace/endian.h
> +++ b/include/babeltrace/endian.h
> @@ -47,7 +47,98 @@
>  #define BYTE_ORDER     __BYTE_ORDER
>  #else
>  #include <endian.h>
> -#endif
> +
> +/*
> + * htobe/betoh are not defined for glibc <2.9, so add them
> + * explicitly if they are missing.
> + */
> +# ifdef __USE_BSD
> +/* Conversion interfaces.*/
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
>  
>  #ifndef FLOAT_WORD_ORDER
>  #ifdef __FLOAT_WORD_ORDER
> --
> 1.8.4.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
