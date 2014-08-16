From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] fix: mi: xsd: wrong comment for
 context_type_type
Date: Sat, 16 Aug 2014 10:44:09 -0400
Message-ID: <20140816144409.GF7634__31153.7772337489$1408200319$gmane$org@thessa>
References: <1407963509-6920-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2072454317=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XIfDL-0004aL-5q
 for lttng-dev@lists.lttng.org; Sat, 16 Aug 2014 10:44:15 -0400
In-Reply-To: <1407963509-6920-1-git-send-email-jonathan.r.julien@gmail.com>
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


--===============2072454317==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 13 Aug (16:58:29), Jonathan Rajotte Julien wrote:
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/common/mi_lttng.xsd | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/common/mi_lttng.xsd b/src/common/mi_lttng.xsd
> index f63065c..d2cc5d4 100644
> --- a/src/common/mi_lttng.xsd
> +++ b/src/common/mi_lttng.xsd
> @@ -83,7 +83,7 @@ THE SOFTWARE.
>  		</xs:restriction>
>  	</xs:simpleType>
> =20
> -	<!-- Maps to the lttng_loglevel_type enum -->
> +	<!-- Maps to the lttng_event_context_type enum -->
>  	<xs:simpleType name=3D"context_type_type">
>  		<xs:restriction base=3D"xs:string">
>  			<xs:enumeration value=3D"PERF_COUNTER" />
> --=20
> 2.0.4
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT7245XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02H7oIAJCQQl8bgzMhxTKT+bUevT86
YbrOpbFUtGqFFsM3zb3gItMgWpDVYenh4U/2nbJ05UhfUpW3BtB2Dq65pPwrUd/l
JZGc5GpLYvBEvXQqhOBNIKRVNODM/IUu/WxW6rrH3nFVoVPemqmvq+6lCU3h77fd
yl0gIUZ7+cKWry5v1Tf5Rq/WIGy75FIcdxIFgRJwrJmuEf0Wj4igqmA26fxGePqh
tRYKkZBNr4mhhFaq6cPuzfXieK30O1FXVgfkPpYd1M9nLUJIitKuc7YCVKp0o9Bf
WwLXFizScWXjomoiC1OsFf5F2O+sKH0P+qhfORAHuERDcVMvZHBWYf8uOApsRJo=
=DFzy
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--


--===============2072454317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2072454317==--
