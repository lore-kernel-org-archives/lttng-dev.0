From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools]
	Fix:	LTTNG_ERR_NEED_ROOT_SESSIOND error message
Date: Wed, 7 Aug 2013 15:30:13 -0400
Message-ID: <20130807193013.GA7623__30132.1191400804$1375903869$gmane$org@Krystal>
References: <1375901885-23781-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V79R0-000307-LD
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 15:30:20 -0400
Content-Disposition: inline
In-Reply-To: <1375901885-23781-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> A root session daemon _and_ "tracing" group user membership are required
> to trace the kernel.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

David, I'll let you merge it.

Thanks,

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/common/error.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/src/common/error.c b/src/common/error.c
> index acfd6c6..42ed06f 100644
> --- a/src/common/error.c
> +++ b/src/common/error.c
> @@ -82,7 +82,7 @@ static const char *error_string_array[] =3D {
>  	[ ERROR_INDEX(LTTNG_ERR_UST_EVENT_NOT_FOUND)] =3D "UST event not found",
>  	[ ERROR_INDEX(LTTNG_ERR_UST_CONTEXT_EXIST)] =3D "UST context already ex=
ist",
>  	[ ERROR_INDEX(LTTNG_ERR_UST_CONTEXT_INVAL)] =3D "UST invalid context",
> -	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] =3D "Tracing the kernel r=
equires a root lttng-sessiond daemon or \"tracing\" group user membership",
> +	[ ERROR_INDEX(LTTNG_ERR_NEED_ROOT_SESSIOND) ] =3D "Tracing the kernel r=
equires a root lttng-sessiond daemon and \"tracing\" group user membership",
>  	[ ERROR_INDEX(LTTNG_ERR_TRACE_ALREADY_STARTED) ] =3D "Tracing already s=
tarted",
>  	[ ERROR_INDEX(LTTNG_ERR_TRACE_ALREADY_STOPPED) ] =3D "Tracing already s=
topped",
>  	[ ERROR_INDEX(LTTNG_ERR_KERN_EVENT_ENOSYS) ] =3D "Kernel event type not=
 supported",
> -- =

> 1.8.3.4
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
