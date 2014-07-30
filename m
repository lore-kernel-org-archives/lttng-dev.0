From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: out of tree build by
 adding missing ini.c include
Date: Wed, 30 Jul 2014 08:50:17 -0400
Message-ID: <20140730125017.GA6050__39233.2930969589$1406724683$gmane$org@thessa>
References: <1406671828-27743-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1998914793=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XCTKu-0003cd-Oc
 for lttng-dev@lists.lttng.org; Wed, 30 Jul 2014 08:50:29 -0400
In-Reply-To: <1406671828-27743-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1998914793==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 29 Jul (18:10:27), Mathieu Desnoyers wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/config/ini.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/src/common/config/ini.c b/src/common/config/ini.c
> index 4369a32..7b2a4b6 100644
> --- a/src/common/config/ini.c
> +++ b/src/common/config/ini.c
> @@ -31,9 +31,11 @@
>   * http://code.google.com/p/inih/
>   */
> =20
> +#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <ctype.h>
>  #include <string.h>
> +#include <common/common.h>
> =20
>  #include "ini.h"
> =20
> --=20
> 2.0.1
>=20

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT2OoJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02UB4H/3QNiI35K7Dn17LVy0t3XXUx
f5uucxBY89RS6up6zzWo6S3M8mfBYNgb0wHKjfc+maZichr19nwPDJaGbmmvPJUz
Rz7+iS36dC6J6BsxfmmyEScTPv+Tg7TqcV4BzB0lwOAj/K/5AKw8egP+MeUZh20J
YKqRn9bM1OMXakFyct/qo5HxKKGufkb49s8NVC6+JW2lce5tCjoN8lD99vbJnjcr
OvtSqou2L6RaVNjsH3hhUt0zK86drjntY+DA8Re3qzAq+F2129Fw9VnQirHI03Np
hnxPu1zS5HC3BWwTYVAit7GP2IU8NQIb7Pz6tk8abArfZ2mfmx2kS3mSu7BluEY=
=5Lhh
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--


--===============1998914793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1998914793==--
