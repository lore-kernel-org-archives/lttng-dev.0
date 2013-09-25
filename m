From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix typo in lttng snapshot
 add-output example of lttng(1)
Date: Wed, 25 Sep 2013 10:20:46 -0400
Message-ID: <5242F13E.4070202__41862.1020312004$1380118918$gmane$org@efficios.com>
References: <1380117966-30710-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2091439722=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VOpxY-0000O9-1J
	for lttng-dev@lists.lttng.org; Wed, 25 Sep 2013 10:21:01 -0400
In-Reply-To: <1380117966-30710-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============2091439722==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig5773C36E36E1A1B2FBBDAEEB"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5773C36E36E1A1B2FBBDAEEB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Merged!

Christian Babeux:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  doc/man/lttng.1 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 57c89f0..659a27c 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -742,7 +742,7 @@ size will override the current output values. For i=
nstance, you can record a
>  snapshot with a custom maximum size or with a different name.
> =20
>  .nf
> -$ lttng add-output -n mysnapshot file:///data/snapshot
> +$ lttng snapshot add-output -n mysnapshot file:///data/snapshot
>  [...]
>  $ lttng snapshot record -n new_name_snapshot
>  .fi


--------------enig5773C36E36E1A1B2FBBDAEEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQF8BAEBCgBmBQJSQvE+XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02g0QH/A94xx1Kr+QTN32mFbocbR9Q
OS8Uo/ylFGlpELmQ2S9sr5vD3U3pOxGBlGA+ACjqUpOwuD26awx90E/yrx34z2c6
OqJMdZmW4oyYCTrp0XATCBLr2c7oLcTlckro4mLku7TSezlm2mhEE5sUkMt2u2g4
E9B3gmA6MBrnp83/a57NYzWtbVUz6UZyqtV/p3l44YD0FOxgOdiLsHBj2YqPW/bK
5BXWGknH9O1y6zPFVDwPEZeWxFNx2Tg0GbTXuehEeBIiQIx3L7KFmFrMu0cIc/y+
CTxzAdRWVgh0F4KmZhhp0ttwM0maz3MIxTvJ9+fAS0gkg3HBDkNs6qvRI1AaTuc=
=S9ME
-----END PGP SIGNATURE-----

--------------enig5773C36E36E1A1B2FBBDAEEB--


--===============2091439722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2091439722==--
