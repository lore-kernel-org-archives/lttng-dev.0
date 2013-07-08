From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace PATCH 04/23] Add MinGW definitions to
	endian.h
Date: Mon, 8 Jul 2013 10:12:38 -0400
Message-ID: <20130708141238.GE22703__11534.2022422285$1373292788$gmane$org@Krystal>
References: <009B25148989C6458484484699278506E5382EF4@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwCBD-0005N7-9l
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 10:12:39 -0400
Content-Disposition: inline
In-Reply-To: <009B25148989C6458484484699278506E5382EF4@EU-MBX-01.mgc.mentorg.com>
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

merged as:

commit 1b168db0ed3a64fb3513d6cacff1d0d96a7ae35d
Author: JP Ikaheimonen <jp_ikaheimonen@mentor.com>
Date:   Mon Jul 8 10:03:27 2013 -0400

    Add MinGW definitions to endian.h
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


* Ikaheimonen, JP (jp_ikaheimonen@mentor.com) wrote:
> ---
>  include/babeltrace/endian.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/babeltrace/endian.h b/include/babeltrace/endian.h
> index 9eee0c1..f15a44f 100644
> --- a/include/babeltrace/endian.h
> +++ b/include/babeltrace/endian.h
> @@ -29,6 +29,22 @@
>  
>  #ifdef __FreeBSD__
>  #include <machine/endian.h>
> +#elif defined(__MINGW32__)
> +#ifndef __BIG_ENDIAN
> +#define __BIG_ENDIAN 4321
> +#endif
> +#ifndef __LITTLE_ENDIAN
> +#define __LITTLE_ENDIAN 1234
> +#endif
> +
> +#ifndef __BYTE_ORDER
> +#define __BYTE_ORDER __LITTLE_ENDIAN
> +#endif
> +
> +#define LITTLE_ENDIAN  __LITTLE_ENDIAN
> +#define BIG_ENDIAN     __BIG_ENDIAN
> +#define PDP_ENDIAN     __PDP_ENDIAN
> +#define BYTE_ORDER     __BYTE_ORDER
>  #else
>  #include <endian.h>
>  #endif
> -- 
> 1.8.1.msysgit.1
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
