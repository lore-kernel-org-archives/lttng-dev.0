From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Remove useless
	variable	assignment
Date: Tue, 28 May 2013 13:29:36 -0400
Message-ID: <20130528172936.GB20859__36807.0805947811$1369762213$gmane$org@Krystal>
References: <1369712328-17921-1-git-send-email-jeremie.galarneau@efficios.com>
	<1369712328-17921-4-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UhNiL-000368-6b
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 13:29:37 -0400
Content-Disposition: inline
In-Reply-To: <1369712328-17921-4-git-send-email-jeremie.galarneau@efficios.com>
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
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>

merged, thanks!

Mathieu

> ---
>  formats/ctf/metadata/ctf-visitor-generate-io-struct.c | 1 -
>  1 file changed, 1 deletion(-)
> =

> diff --git a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c b/form=
ats/ctf/metadata/ctf-visitor-generate-io-struct.c
> index 626eb6b..664d0af 100644
> --- a/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> +++ b/formats/ctf/metadata/ctf-visitor-generate-io-struct.c
> @@ -875,7 +875,6 @@ struct bt_declaration *ctf_declaration_struct_visit(F=
ILE *fd,
>  			ret =3D get_unary_unsigned(min_align, &min_align_value);
>  			if (ret) {
>  				fprintf(fd, "[error] %s: unexpected unary expression for structure \=
"align\" attribute\n", __func__);
> -				ret =3D -EINVAL;
>  				goto error;
>  			}
>  		}
> -- =

> 1.8.2.3
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
