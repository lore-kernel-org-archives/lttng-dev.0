From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix out-of-tree build
Date: Thu, 25 Sep 2014 11:33:49 -0400
Message-ID: <20140925153349.GA23466__48136.138302698$1411659286$gmane$org@thessa>
References: <1411176563-20209-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0917955772=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XXB3N-0006al-1Y
 for lttng-dev@lists.lttng.org; Thu, 25 Sep 2014 11:33:59 -0400
In-Reply-To: <1411176563-20209-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0917955772==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 19 Sep (21:29:23), Simon Marchi wrote:
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  tests/regression/tools/mi/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/regression/tools/mi/Makefile.am b/tests/regression/too=
ls/mi/Makefile.am
> index 4c77f56..c4081db 100644
> --- a/tests/regression/tools/mi/Makefile.am
> +++ b/tests/regression/tools/mi/Makefile.am
> @@ -1,4 +1,4 @@
> -AM_CPPFLAGS =3D -I$(srcdir)/include
> +AM_CPPFLAGS =3D -I$(top_srcdir)/include
> =20
>  noinst_PROGRAMS =3D validate_xml extract_xml
>  validate_xml_SOURCES =3D validate_xml.c
> --=20
> 2.1.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUJDXdXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02P+oIALb1VFoWICSSkdsUW8frqQv2
rn58Cr6F/MPiua9g8c5iml+XxJEoslCPBJ4aNrEkmFp13VqELLdkrwhf+7a38vMK
NpP/zuhq4GxLgMWBPkRnwGuLquW5/rw08Q5nSK9MCXmMXEDaASsPSZUk2BT3nNOl
th7aH15vdcJbsAjhjx3JYfieaY9ZLnAc+POL49ffJFKzCUmg1umGxH6horthlbGa
XQXh9LihN7zTKZCQ6fDe7maP6v77BjJ4/minpJDa/HnnTAo+BfM48dfVHVeXGi1k
CBR5QhB/5iGSayzUuQXTW6jfRw4A1JBK3eyACTr5JCoK2r2nR+PLg8uzjvBNmmk=
=xoEV
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--


--===============0917955772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0917955772==--
