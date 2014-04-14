From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH] Fix: XML declaration must be at beginning
	of XSD file
Date: Mon, 14 Apr 2014 10:38:57 -0400
Message-ID: <20140414143857.GD9369__24467.9670468487$1397486418$gmane$org@thessa>
References: <1397164599-28503-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0657749875=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WZi2P-0001Wl-Jb
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 10:39:15 -0400
In-Reply-To: <1397164599-28503-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0657749875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

David

On 10 Apr (17:16:39), Christian Babeux wrote:
> Move down license information to fix the parser error :
> XML declaration allowed only at the start of the document
>=20
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  src/common/config/session.xsd | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/common/config/session.xsd b/src/common/config/session.xsd
> index 910f070..7c3e9d8 100644
> --- a/src/common/config/session.xsd
> +++ b/src/common/config/session.xsd
> @@ -1,3 +1,4 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8"?>
>  <!--
>  Copyright (c) 2014 - J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.c=
om>
> =20
> @@ -19,7 +20,6 @@ LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OT=
HERWISE, ARISING FROM,
>  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>  THE SOFTWARE.
>  -->
> -<?xml version=3D"1.0" encoding=3D"UTF-8"?>
>  <xs:schema xmlns:xs=3D"http://www.w3.org/2001/XMLSchema"
>  elementFormDefault=3D"qualified" version=3D"2.5">
> =20
> --=20
> 1.8.5.2
>=20

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTS/MBXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02+TQIALcaXbTpTbEBwo8FVTq2ru70
4h+VmNZTNAa6YyUGrhuXRqOM4NxKJAQtH6UADZPNJZTNie+5D2P+chyfR7zyRZXc
0LWxgJI6g9k3z7vTCI8o1VSKGtUDTQJ1zCj5vLESuSxZQohAMLRqpQmB4BPyGi+i
hcx8olQL1UMBv6uCu87im4XzvE6dRm96tTqEePmPhnwvMd1EZgmoJh2bOgVNKISX
u5DbHtswysS8NIVfwNuaC7cTYXySLNnx42TMp2r2YJaLrS9JMy6hSKgdhbCj23yb
2TTekVFJFQvavCfJ+J4dPoS+13fWGj6/9+xab33Q1ceKnlY1m/6QcTr+FVcIhhY=
=xvt/
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--


--===============0657749875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0657749875==--
