From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix
	ctf_clock_declaration_visit	returning an error when reading a
	boolean
Date: Thu, 22 Aug 2013 12:49:13 -0400
Message-ID: <20130822164913.GA31785__12773.7573035576$1377190217$gmane$org@Krystal>
References: <1376359196-25062-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VCY4R-0000Vu-B3
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 12:49:21 -0400
Content-Disposition: inline
In-Reply-To: <1376359196-25062-1-git-send-email-jeremie.galarneau@efficios.com>
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
> The ret variable is used to read the "absolute" field's value and was not=
 reset
> to zero, thus returning an error whenever that value was TRUE.

merged in master and stable-1.0

Thanks!

Mathieu

> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  formats/ctf/metadata/ctf-visitor-generate-io-struct.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/form=
ats/ctf/metadata/ctf-visitor-generate-io-struct.c
> index 664d0af..c7de92e 100644
> --- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> +++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> @@ -2399,6 +2399,7 @@ int ctf_clock_declaration_visit(FILE *fd, int depth=
, struct ctf_node *node,
>  				goto error;
>  			}
>  			clock->absolute =3D ret;
> +			ret =3D 0;
>  		} else {
>  			fprintf(fd, "[warning] %s: attribute \"%s\" is unknown in clock decla=
ration.\n", __func__, left);
>  		}
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
