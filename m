From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix typo 'Attemp' -> 'Attempt'
Date: Fri, 18 Oct 2019 23:27:17 -0400
Message-ID: <20191019032717.GB4093__36299.3385688$1571455670$gmane$org@gmail.com>
References: <20191018211222.4196-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 46w7cn4LDfzq3Z
 for <lttng-dev@lists.lttng.org>; Fri, 18 Oct 2019 23:27:21 -0400 (EDT)
Received: by mail-qt1-f195.google.com with SMTP id n17so12122641qtr.4
 for <lttng-dev@lists.lttng.org>; Fri, 18 Oct 2019 20:27:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20191018211222.4196-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Merged in master and stable-2.11.

Thanks!
J=E9r=E9mie

On Fri, Oct 18, 2019 at 05:12:22PM -0400, Michael Jeanson wrote:
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>  src/common/trace-chunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/common/trace-chunk.c b/src/common/trace-chunk.c
> index afba60b38..20dbd0a5e 100644
> --- a/src/common/trace-chunk.c
> +++ b/src/common/trace-chunk.c
> @@ -1269,7 +1269,7 @@ lttng_trace_chunk_registry_publish_chunk(
>  				 *
>  				 * Re-attempt to publish.
>  				 */
> -				ERR("Attemp to publish a trace chunk to the chunk registry raced wit=
h a trace chunk deletion");
> +				ERR("Attempt to publish a trace chunk to the chunk registry raced wi=
th a trace chunk deletion");
>  				continue;
>  			}
>  		}
> -- =

> 2.17.1
> =
