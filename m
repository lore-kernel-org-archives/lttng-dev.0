From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Copy-pasted PERROR
 messages may be misleading
Date: Wed, 14 May 2014 11:34:09 -0400
Message-ID: <20140514153409.GD17172__38835.2511836731$1400081718$gmane$org@thessa>
References: <1400081530-2950-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1808521781=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WkbCG-0002Bw-1F
 for lttng-dev@lists.lttng.org; Wed, 14 May 2014 11:34:25 -0400
In-Reply-To: <1400081530-2950-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============1808521781==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 14 May (11:32:10), J=E9r=E9mie Galarneau wrote:
> Some PERRORs in lttng-sessiond's pthread_create's error handling
> code indicate the wrong thread name which may be misleading
> during debugging.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/bin/lttng-sessiond/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 3a8a1b2..3fc2565 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -5190,7 +5190,7 @@ int main(int argc, char **argv)
>  	ret =3D pthread_create(&apps_notify_thread, NULL,
>  			ust_thread_manage_notify, (void *) NULL);
>  	if (ret !=3D 0) {
> -		PERROR("pthread_create apps");
> +		PERROR("pthread_create notify");
>  		goto exit_apps_notify;
>  	}
> =20
> @@ -5198,7 +5198,7 @@ int main(int argc, char **argv)
>  	ret =3D pthread_create(&jul_reg_thread, NULL,
>  			jul_thread_manage_registration, (void *) NULL);
>  	if (ret !=3D 0) {
> -		PERROR("pthread_create apps");
> +		PERROR("pthread_create JUL");
>  		goto exit_jul_reg;
>  	}
> =20
> --=20
> 1.9.2
>=20

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTc4zxXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02lfAIAIYVZqdAlTSNT7FNUUDlA2H9
rOtmz0NauYyvzmWFUrfO2y6q7qB/93qL+AFiotwnvJrwRKE4NnWOQ4LTVbyVfM+r
tA4UQzUiZLLVJ8oC+0F7frp6VUpXVy/RwZL3ONOo3J77RzEYTMZNDDpSwKO0IodM
qHfutZIWkzYGQ9Q98XBPpvYksqyqxG8mXoC9+EnUahs1BiReD2BtfczHApptKXCw
PQtfBtDKlp801lhk6F0bDaMdnriUGGCz1FWcCUgKw/WLWxj/Kc2YjMGSPPBQySiI
LL5OLx9coecjaZYwQG2RiR7oabElOb+e5s2/6HwHxCvs8PFSL5HFKzsXGl0p3PY=
=i6GF
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--


--===============1808521781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1808521781==--
