From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: mi: logically dead code,
 missing ret assignment
Date: Tue, 29 Jul 2014 10:09:23 -0400
Message-ID: <20140729140923.GA6805__1493.70864169232$1406643018$gmane$org@thessa>
References: <1406577028-7152-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1579970327=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XC85r-00044V-Io
 for lttng-dev@lists.lttng.org; Tue, 29 Jul 2014 10:09:33 -0400
In-Reply-To: <1406577028-7152-1-git-send-email-jonathan.r.julien@gmail.com>
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


--===============1579970327==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 28 Jul (15:50:28), Jonathan Rajotte Julien wrote:
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng/commands/list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
> index 210c2f4..956b62e 100644
> --- a/src/bin/lttng/commands/list.c
> +++ b/src/bin/lttng/commands/list.c
> @@ -748,7 +748,7 @@ static int mi_list_kernel_events(struct lttng_event *=
events, int count,
>  	}
> =20
>  	for (i =3D 0; i < count; i++) {
> -		mi_lttng_event(writer, &events[i], 0);
> +		ret =3D mi_lttng_event(writer, &events[i], 0);
>  		if (ret) {
>  			goto end;
>  		}
> --=20
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT16sTXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02RzgH/iXtWjFImlp0XP4s6C+r8w9b
KPhiU2z0/KlNNVZnBAVjm6WO7ntcKWe8Dtbk9LsjCb8KmhOQJ80gSlllh0/pkAyY
pg1yEqq3usPouEY9B+al7qrrQSQMfeZcBA/EeXlFDewictwfC8BMzWhcY2kJnvuV
L3Dx1if8L3j6MYqi3+EoNHmkfBj1Sm6hDEx5Clxxb3VftUGFUdhNpZd8cLXW4F+f
GbJsCOAPoajqyxDJs3ng/GUFAH/0ntZVNfmgALiTRsew2DSK66qnITOkNxMgQtdp
UoiZbMAa7fmF3rzIYaK3FOFWWJsS0KMkUKgTVEVFUMogTX6GvhF7grxFUrDszEQ=
=0H/u
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--


--===============1579970327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1579970327==--
