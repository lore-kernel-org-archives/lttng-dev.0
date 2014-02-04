From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH] Use uint32_t for
 lttng_viewer_stream.metadata_flag
Date: Tue, 4 Feb 2014 14:39:30 -0500
Message-ID: <20140204193930.GK13440__21424.8018725359$1391542837$gmane$org@thessa>
References: <1390002463-21184-1-git-send-email-marc-andre.laperle@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1241577183=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WAlqN-0001B7-GF
	for lttng-dev@lists.lttng.org; Tue, 04 Feb 2014 14:39:45 -0500
In-Reply-To: <1390002463-21184-1-git-send-email-marc-andre.laperle@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Marc-Andre Laperle <marc-andre.laperle@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1241577183==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Content-Disposition: inline


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI, there is a lot of development on the relayd right now so I'll be
merging this patch with everything else thus consider it merged but not
yet upstream.

Once upstream in the master branch, it will be ported to 2.4 stable.

Big thanks!
David

On 17 Jan (18:47:43), Marc-Andre Laperle wrote:
> This struct is meant to be sent over the network so members should be
> of exact-width.
>=20
> Signed-off-by: Marc-Andre Laperle <marc-andre.laperle@ericsson.com>
> ---
>  src/bin/lttng-relayd/lttng-viewer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/bin/lttng-relayd/lttng-viewer.h b/src/bin/lttng-relayd/l=
ttng-viewer.h
> index 1977a43..6330270 100644
> --- a/src/bin/lttng-relayd/lttng-viewer.h
> +++ b/src/bin/lttng-relayd/lttng-viewer.h
> @@ -100,7 +100,7 @@ struct lttng_viewer_session {
>  struct lttng_viewer_stream {
>  	uint64_t id;
>  	uint64_t ctf_trace_id;
> -	int metadata_flag;
> +	uint32_t metadata_flag;
>  	char path_name[LTTNG_VIEWER_PATH_MAX];
>  	char channel_name[LTTNG_VIEWER_NAME_MAX];
>  } __attribute__((__packed__));
> --=20
> 1.8.3.2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS8UHyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I028vgH/3bY09dGCIfvKoagalKea1Ec
Hry0t70uNGy/3r5WVfMGTo7R3Xmmfn1igsPTLFI3Fk7fOHRqCHUvaVlcQ3eZs0/s
+EXG/32SbM/2SO/BcAGquvU+iHHn+GOw3H//yLW9qOsVD9ATfNTkEmA+oZc7MlY6
F/ytqYqT9IsCX5qLisR/Z/XPneBRsMCMHz6KgkFU1CP3RzLwBhig04b7WB3x7l9E
+5MQWxL5aA+RXCtt3KVxTAKwOXQO4iCHUQWcYNJaT4tfOs8AY4M3c69u6jpy+7Ca
UzAzYerbKa3EMkS6MuNky7B1azOtAfcFrw4E1z3F3bUqHw8fqdBNV04vhkL/c7Y=
=b3tW
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--


--===============1241577183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1241577183==--
