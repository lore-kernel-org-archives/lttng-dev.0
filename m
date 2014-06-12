From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add dependency to libcommon for
 python binding
Date: Thu, 12 Jun 2014 14:02:09 -0400
Message-ID: <20140612180209.GC8011__6357.32973828471$1402596208$gmane$org@thessa>
References: <1401964788-24312-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2035633470=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wv9KK-0001ku-0y
 for lttng-dev@lists.lttng.org; Thu, 12 Jun 2014 14:02:18 -0400
In-Reply-To: <1401964788-24312-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============2035633470==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 05 Jun (12:39:48), Paul Woegerer wrote:
> Using the python binding library currently results in in the following er=
ror message:
>=20
> ImportError: No module named '_lttng'
>=20
> During handling of the above exception, another exception occurred:
>=20
> Traceback (most recent call last):
>   File "./test_daemon.py", line 31, in <module>
>     from test_utils import *
>   File "/home/pwoegere/MGC/lttng2_stack_latest/lttng-tools/tests/utils/te=
st_utils.py", line 33, in <module>
>     from lttng import *
>   File "/home/pwoegere/MGC/lttng2_stack_latest/lttng-tools/extras/binding=
s/swig/python/lttng.py", line 34, in <module>
>     _lttng =3D swig_import_helper()
>   File "/home/pwoegere/MGC/lttng2_stack_latest/lttng-tools/extras/binding=
s/swig/python/lttng.py", line 26, in swig_import_helper
>     import _lttng
> ImportError: /home/pwoegere/MGC/lttng2_stack_latest/lttng-tools/extras/bi=
ndings/swig/python/.libs/_lttng.so: undefined symbol: log_add_time
>=20
> This patch adds the missing dependency to libcommon that contains the def=
inition of log_add_time.
>=20
> Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
> ---
>  extras/bindings/swig/python/Makefile.am | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/extras/bindings/swig/python/Makefile.am b/extras/bindings/sw=
ig/python/Makefile.am
> index caf1934..ec35930 100644
> --- a/extras/bindings/swig/python/Makefile.am
> +++ b/extras/bindings/swig/python/Makefile.am
> @@ -13,7 +13,8 @@ MAINTAINERCLEANFILES =3D lttng_wrap.c lttng.py
>  nodist__lttng_la_SOURCES =3D lttng_wrap.c
>  _lttng_la_LDFLAGS =3D -module
>  _lttng_la_LIBADD =3D 	$(top_srcdir)/src/lib/lttng-ctl/liblttng-ctl.la 		\
> -			$(top_srcdir)/src/common/sessiond-comm/libsessiond-comm.la
> +			$(top_srcdir)/src/common/sessiond-comm/libsessiond-comm.la		\
> +			$(top_srcdir)/src/common/libcommon.la
> =20
>  lttng_wrap.c: lttng.i
>  	$(SWIG) -python -I. -I$(top_srcdir)/src/common/sessiond-comm lttng.i
> --=20
> 1.9.3
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTmeshXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02ceQIAKj8QUk2T34xqTSPSsI7VoN7
NTnHBCUswVnoXHdMXWbZWU6s5i8uzUsDH/hqnYWEmOyl4ZhTQpXW1LTqIyGst8J+
D15Yaey4CBTAmqnYTB4k0Oe+Lb2oiIA11vHilkfIEX2cUKCKba5h9lPEsZyUiZys
OzkSKWizd05DtFFhjljCmvRzDBo+8VPw2ZCMBvNk1BdLCJ7+jdScNsTyVaS6aAFb
LHfHhWMEVl9T0TftWlD0Qm6Ccp6Cd5Uff5a3oxeakiwKe21VG4+WwS2EgO/SvpWt
QYV0IhK62ALiKx/5ujSZQlBXaq2fHlBq+vVyMjIPaxrBmwKn9h5z/eAl0ItWnOY=
=Nhzs
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--


--===============2035633470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2035633470==--
