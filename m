From: Simon Marchi <simark@simark.ca>
Subject: Re: [PATCH] Introduce vtracef
Date: Fri, 31 Jan 2020 18:03:16 -0500
Message-ID: <569392e8-be60-26e1-a2d4-72112e6acbac@simark.ca>
References: <20200131215501.19536-1-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 488XxB1gdsz24PJ
 for <lttng-dev@lists.lttng.org>; Fri, 31 Jan 2020 18:09:49 -0500 (EST)
In-Reply-To: <20200131215501.19536-1-maxime.roussinbelanger@gmail.com>
Content-Language: tl
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>, lttng-dev@lists.lttng.org
Cc: champagne.guillaume.c@gmail.com
List-Id: lttng-dev@lists.lttng.org

Hi Maxime,

Tip for next time: this mailing is used for many projects, so it helps
to include the project name in the patch prefix.  You can do so by using

  --subject-prefix="PATCH lttng-ust"

on you git-send-email command line.

On 2020-01-31 4:55 p.m., Maxime Roussin-Belanger wrote:
> vtracef accepts a va_list argument to simplify tracing
> functions which use a va_list
> 
> Here's an example from wpa_supplicant that I wanted to
> trace:
> 
> void wpa_debug(int level, const char* fmt, ...) {
> 
>     va_list ap;
>     va_start(ap, fmt);
> 
>     ...
>     // The call I want to easily trace with vtracef
>     vprintf(fmt, ap);
> 
>     ...
>     va_end(ap);
> }
> 
> wpa_debug is used a fair amount and it would be annoying to
> replace all the wpa_debug calls with tracef.
> 
> With vtracef, it simplifies the find and replace effort by
> only changing it at one place.

The shortcoming, as you mentiond on IRC, is that it doesn't support SDT integration.  The tracef
macro call has a `STAP_PROBEV` call, but it doesn't seem possible to use that here.  The number
of arguments in a va_list is known at runtime (in fact it's not really known by the va_list itself),
whereas STAP_PROBEV wants to know the number of arguments at compile time.

I think it would still be useful to have vtracef, for the use case explained above, but have it
documented that it is not integrated with the stap probes (unless somebody has a magic idea that
would make it work).  But that will be for the maintainer to decide.

Note that if the feature is accepted, it will require at least a man page update. An update in
doc/examples/demo-tracef/demo-tracef.c would also be nice, to have an example of how it can be used.

Simon

> 
> Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
> ---
>  include/lttng/tracef.h | 10 ++++++++++
>  liblttng-ust/tracef.c  | 18 +++++++++++-------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/lttng/tracef.h b/include/lttng/tracef.h
> index 0c59c9ae..e3a7587d 100644
> --- a/include/lttng/tracef.h
> +++ b/include/lttng/tracef.h
> @@ -32,13 +32,23 @@ extern "C" {
>  extern
>  void _lttng_ust_tracef(const char *fmt, ...);
>  
> +extern
> +void _lttng_ust_vtracef(const char *fmt, va_list ap);
> +
>  #define tracef(fmt, ...)						\
>  	do {								\
>  		LTTNG_STAP_PROBEV(tracepoint_lttng_ust_tracef, event, ## __VA_ARGS__); \
>  		if (caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
>  			_lttng_ust_tracef(fmt, ## __VA_ARGS__);		\
>  	} while (0)
>  
> +#ifndef LTTNG_UST_HAVE_SDT_INTEGRATION
> +#define vtracef(fmt, ap)						\
> +	do {								\
> +		if (caa_unlikely(__tracepoint_lttng_ust_tracef___event.state)) \
> +			_lttng_ust_vtracef(fmt, ap);		\
> +	} while (0)
> +#endif

If we end up with what I suggested above (vtracef documented not to integrate an
stap probe), this #ifndef would go away,

>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/liblttng-ust/tracef.c b/liblttng-ust/tracef.c
> index ea98e43e..2a809eed 100644
> --- a/liblttng-ust/tracef.c
> +++ b/liblttng-ust/tracef.c
> @@ -29,20 +29,24 @@
>  #define TRACEPOINT_DEFINE
>  #include "lttng-ust-tracef-provider.h"
>  
> -void _lttng_ust_tracef(const char *fmt, ...)
> +void _lttng_ust_vtracef(const char *fmt, va_list ap)
>  {
> -	va_list ap;
>  	char *msg;
> -	int len;
> -
> -	va_start(ap, fmt);
> -	len = vasprintf(&msg, fmt, ap);
> +	const int len = vasprintf(&msg, fmt, ap);
>  	/* len does not include the final \0 */
>  	if (len < 0)
> -		goto end;
> +		return;

We try to have a single exit point in each function, to facilitate
resource management in the case of errors, so please keep the goto
end pattern:

  ...

  if (len < 0)
    goto end;

  ...

end:
  return
}

>  	__tracepoint_cb_lttng_ust_tracef___event(msg, len,
>  		LTTNG_UST_CALLER_IP());
>  	free(msg);
> +}
> +
> +void _lttng_ust_tracef(const char *fmt, ...)
> +{
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +	_lttng_ust_vtracef(fmt, ap);
>  end:

You can remove the end label here.

Simon
