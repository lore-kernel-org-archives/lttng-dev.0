From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: ] [PATCH lttng-modules] Fix: Repair of broken
 arm-32 build Signed-off-by: Martin Leisener <martin@leisener.de>
Date: Fri, 29 May 2015 20:31:39 +0000 (UTC)
Message-ID: <218523230.110.1432931499735.JavaMail.zimbra__15352.4376488805$1432931559$gmane$org@efficios.com>
References: <55648B69.5060202@leisener.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YyQwc-0003kd-TC
 for lttng-dev@lists.lttng.org; Fri, 29 May 2015 16:31:57 -0400
In-Reply-To: <55648B69.5060202@leisener.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Martin Leisener <martin@leisener.de>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

merged with small cosmetic fixes to the changelog, thanks!

Mathieu

----- On May 26, 2015, at 11:04 AM, Martin Leisener martin@leisener.de wrote:

> Hi,
> 
> I found that the current master branch of lttng-modules doesn't seem to compile
> for arm-32 builds.
> 
> Utilizing the patch below it will build again for arm (and still an x86)
> (tested on Ubuntu 12.04 LTS x86 + imx6 solo)
> 
> It's my first patch I contribute so please be kind, if something is amiss or
> should have been provided differently...
> 
> 
> Regards Martin
> 
> ---
> .../arm-32-syscalls-3.4.25_integers_override.h     |    2 +-
> lttng-events.c                                     |    1 +
> 2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git
> a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers_override.h
> b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers_override.h
> index f0e031a..79efa54 100644
> ---
> a/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers_override.h
> +++
> b/instrumentation/syscalls/headers/arm-32-syscalls-3.4.25_integers_override.h
> @@ -23,7 +23,7 @@ SC_LTTNG_TRACEPOINT_EVENT(sync_file_range2,
> 		ctf_integer_hex(int, fd, fd)
> 		ctf_integer_hex(loff_t, offset, offset)
> 		ctf_integer_hex(loff_t, nbytes, nbytes)
> -		ctf_integer_hex(unsigned int, flags), flags)
> +		ctf_integer_hex(unsigned int, flags, flags)
> 	)
> )
> diff --git a/lttng-events.c b/lttng-events.c
> index 1ae894b..7eec04c 100644
> --- a/lttng-events.c
> +++ b/lttng-events.c
> @@ -38,6 +38,7 @@
> #include <linux/anon_inodes.h>
> #include "wrapper/file.h"
> #include <linux/jhash.h>
> +#include <linux/uaccess.h>
>  #include "wrapper/uuid.h"
> #include "wrapper/vmalloc.h"	/* for wrapper_vmalloc_sync_all() */
> --
> 1.7.9.5
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
