From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Free new_chunk on error
Date: Fri, 20 Sep 2019 17:34:26 -0400
Message-ID: <20190920213426.GE20024__33435.8499547065$1569015286$gmane$org@gmail.com>
References: <20190920144730.163268-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by lists.lttng.org (Postfix) with ESMTPS id 46Zn6Z2tQ6zqw7
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 17:34:30 -0400 (EDT)
Received: by mail-qt1-f193.google.com with SMTP id m15so10378596qtq.2
 for <lttng-dev@lists.lttng.org>; Fri, 20 Sep 2019 14:34:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20190920144730.163268-1-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11.

On Fri, Sep 20, 2019 at 10:47:30AM -0400, Jonathan Rajotte wrote:
> Fixes coverity #1405775
> =

> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  src/common/trace-chunk.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/src/common/trace-chunk.c b/src/common/trace-chunk.c
> index 6770bd982..bad993bea 100644
> --- a/src/common/trace-chunk.c
> +++ b/src/common/trace-chunk.c
> @@ -367,6 +367,8 @@ end:
>  	return new_chunk;
>  error_unlock:
>  	pthread_mutex_unlock(&source_chunk->lock);
> +	lttng_trace_chunk_fini(new_chunk);
> +	free(new_chunk);

Changed this to lttng_trace_chunk_put(), which will drop the only
existing reference to `new_chunk` and perform the equivalent
operations to what you proposed here.

Thanks!
J=E9r=E9mie

>  	return NULL;
>  }
>  =

> -- =

> 2.17.1
> =
