From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Docs: Add load and save
 sections to the lttng.1 man page
Date: Tue, 13 May 2014 13:10:19 -0400
Message-ID: <20140513171019.GF7414__48025.8104893894$1400001086$gmane$org@thessa>
References: <1399997650-17503-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2052673501=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WkGDm-0005Th-Do
 for lttng-dev@lists.lttng.org; Tue, 13 May 2014 13:10:33 -0400
In-Reply-To: <1399997650-17503-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============2052673501==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+ts6NCQ4mrNQIV8p"
Content-Disposition: inline


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged with minor modifications.

David

On 13 May (12:14:10), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  doc/man/lttng.1 | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 60 insertions(+)
>=20
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 9f95a8a..d49a5b2 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -736,6 +736,60 @@ List available domain(s)
>  .PP
> =20
>  .PP
> +\fBload\fP [OPTIONS] [NAME]
> +.RS
> +Load tracing session configuration
> +
> +If NAME is omitted, all session configurations found in both the user's =
session
> +configuration directory and the system session configuration directory w=
ill be
> +loaded.
> +
> +.B OPTIONS:
> +
> +.TP
> +.BR "\-h, \-\-help"
> +Show summary of possible options and commands.
> +.TP
> +.BR "\-a, \-\-all"
> +Load all session configurations (default).
> +.TP
> +.BR "\-i, \-\-input-path PATH"
> +Specify the input path for session configurations.
> +.TP
> +.BR "\-f, -\-force"
> +Overwrite current session configuration(s) if a session of the same name=
 already
> +exists.
> +.RE
> +.PP
> +
> +.PP
> +\fBsave\fP [OPTIONS] [SESSION]
> +.RS
> +Save tracing session configuration
> +
> +If SESSION is omitted, all session configurations will be saved to
> +individual \fB.lttng\fP files under the user's session configuration dir=
ectory.
> +The default session configuration file naming scheme is \fBSESSION.lttng=
\fP.
> +
> +.B OPTIONS:
> +
> +.TP
> +.BR "\-h, \-\-help"
> +Show summary of possible options and commands.
> +.TP
> +.BR "\-a, \-\-all"
> +Save all session configurations (default).
> +.TP
> +.BR "\-o, \-\-output-path PATH"
> +Specify the output path for session configurations (defaults to
> +~/.lttng/sessions/).
> +.TP
> +.BR "\-f, -\-force"
> +Overwrite session configuration files if names clash.
> +.RE
> +.PP
> +
> +.PP
>  \fBset-session\fP NAME [OPTIONS]
>  .RS
>  Set current session name
> @@ -980,6 +1034,12 @@ Allows one to specify the full session daemon binar=
y path to lttng command line
>  tool. You can also use \-\-sessiond-path option having the same effect.
>  .PP
> =20
> +.PP
> +.IP "LTTNG_SESSION_CONFIG_XSD_PATH"
> +Set the path in which the \fBsession.xsd\fP session configuration schema=
 may be
> +found.
> +.PP
> +
>  .SH "SEE ALSO"
>  .BR babeltrace(1),
>  .BR lttng-ust(3),
> --=20
> 1.9.2
>=20

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTclH7XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ic0H+wRAAz0JNqueGRPtMzeg99I7
K++YlbcFdTv9uUCayYyyZD118sLANsTrL1kOTwxIplyqEf7kQ496WFZO1l1GeFZL
V5oa0VWiC15m10cxk0hu4rX8slscPbVry3Avak0tmUqNRy+7dN2dNjBchZ0+gO2+
Qlne8B84UyV312HSY5YEV+SJXZjHy7uh+bX08BDF0rwLj3JlB+yVwgwu3HqRucUG
W0eb9dGJrI5TqXtLJuhW6SrDAafL5E1H17B0CQTID0fW5HixTDOjkqAS4DyFaKyI
79+u9O2eGgtTN6FfnsUHwrCFwS3jykt6AWCsYY9IQjs64ii32crj++4fIc4HH6o=
=EiMD
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--


--===============2052673501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2052673501==--
