From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] mi: add machine interface
 description to man page
Date: Tue, 29 Jul 2014 12:26:02 -0400
Message-ID: <20140729162602.GC6805__17924.3285245777$1406651239$gmane$org@thessa>
References: <1406643952-30673-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0432542987=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XCAE6-0004vv-9J
 for lttng-dev@lists.lttng.org; Tue, 29 Jul 2014 12:26:15 -0400
In-Reply-To: <1406643952-30673-1-git-send-email-jonathan.r.julien@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0432542987==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged. I corrected a couple of things but most of it is there.

Thanks!
David

On 29 Jul (10:25:52), Jonathan Rajotte Julien wrote:
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  doc/man/lttng.1 | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 12ca33d..de13b76 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -77,6 +77,26 @@ Simple listing of lttng options.
>  .TP
>  .BR "\-\-list\-commands"
>  Simple listing of lttng commands.
> +.TP
> +.BR "\-m, \-\-mi TYPE
> +Machine interface
> +
> +TYPE supported: XML
> +
> +Machine interface (MI) mode convert the traditional pretty printing to a=
 more
> +machine friendly output syntax. Mi mode provide a format change-resistan=
t way to
> +access information generated via lttng-cli.
> +
> +When using MI mode, the generated document is outputted on STDOUT.
> +Errors and warning are outputted as normal on STDERR and in normal forma=
t.
> +
> +If any errors occurs during the execution of a command, the return value
> +of the command will be different than zero as normal. In this event, ltt=
ng does
> +no guarantees the syntax and data validity of the generated document.
> +
> +For XML output type, lttng provide an xml schema definitioni (XSD) file =
for validation. It
> +can be found under: lttng-tools/src/common/mi_lttng.xsd.
> +
>  .SH "COMMANDS"
> =20
>  .PP
> --=20
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT18saXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02oyIH/1eZsEBmCiT4R7YQE7tx88hL
eIsHotejmzp2TsVFAx1wYAeJkN14wjGQqsVCGtVz653uU2wnnpzzyMwk/i14w7Jb
u5WIsKPWPmLs/es8mzth8Gjy48Ylzf6wAUtEs422Y86A+GOCMWLGtTLNLW9D7EjQ
6Bb/Fp28uhEPyxS9/zycHNB5/qMtloqr+vAY+fIyg+uPhhjrW48+jy2CVV+u62/G
J04zArTWKuykpKl2hm4Cj5WDFRDj9ACxI2rGWJIf3Qp6atlAvGO8suonuNx4BPz2
Kyi63u7MFUdZ4tUXh+QwGQ5mrQPyvVwSwAaIrJIFcWH0BDXshloy8OXc+2JAAJ0=
=2Pty
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--


--===============0432542987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0432542987==--
