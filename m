From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Cleanup inconsistent use of
 spaces and tabs in README
Date: Tue, 11 Feb 2014 16:17:07 -0500
Message-ID: <20140211211707.GA9564__20857.2527081289$1392153497$gmane$org@thessa>
References: <1391795331-866-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1800554531=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WDKhh-0005YU-4n
	for lttng-dev@lists.lttng.org; Tue, 11 Feb 2014 16:17:23 -0500
In-Reply-To: <1391795331-866-1-git-send-email-christian.babeux@efficios.com>
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


--===============1800554531==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 07 Feb (12:48:51), Christian Babeux wrote:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  README | 58 +++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>=20
> diff --git a/README b/README
> index 4d70318..b217759 100644
> --- a/README
> +++ b/README
> @@ -11,11 +11,11 @@ Latest development can be found at:
> =20
>  REQUIREMENTS:
> =20
> -	- Linux kernel >=3D 2.6.27
> -	  For epoll() support, at least this version is needed. However, poll()=
 is
> -	  also supported by running "./configure --disable-epoll". Using that, =
the
> -	  kernel version can probably be older but we can't provide any guarant=
ee.
> -	  Please let us know if you are able to go lower without any problems.
> +    - Linux kernel >=3D 2.6.27
> +      For epoll() support, at least this version is needed. However, pol=
l() is
> +      also supported by running "./configure --disable-epoll". Using tha=
t, the
> +      kernel version can probably be older but we can't provide any guar=
antee.
> +      Please let us know if you are able to go lower without any problem=
s.
> =20
>      - liburcu
>        Userspace RCU library, by Mathieu Desnoyers and Paul E. McKenney
> @@ -61,8 +61,8 @@ REQUIREMENTS:
> =20
>      - For kernel tracing: modprobe
> =20
> -	- bash
> -	  Needed for running "make check".
> +    - bash
> +      Needed for running "make check".
> =20
>  For developers using the git tree:
> =20
> @@ -128,8 +128,8 @@ PACKAGE CONTENTS:
>        The LTTng tracing control library.
> =20
>      - libsessiond-comm (internal)
> -	  The lttng-sessiond communication library. In order to talk with
> -	  lttng-sessiond, this library must be used.
> +      The lttng-sessiond communication library. In order to talk with
> +      lttng-sessiond, this library must be used.
> =20
>      - libkernel-ctl (internal)
>        Kernel tracer control and ioctl definitions.
> @@ -137,26 +137,26 @@ PACKAGE CONTENTS:
>      - libconsumer (internal)
>        Library for Kernel and (optionally) UST trace consumer.
> =20
> -	- libkernel-consumer (internal)
> -	  Library for Kernel consumer control
> +    - libkernel-consumer (internal)
> +      Library for Kernel consumer control
> =20
> -	- libust-consumer (internal)
> -	  Library for UST consumer control
> +    - libust-consumer (internal)
> +      Library for UST consumer control
> =20
> -	- libhashtable (internal)
> -	  Library wrapper over URCU hashtables.
> +    - libhashtable (internal)
> +      Library wrapper over URCU hashtables.
> =20
> -	- libcommon (internal)
> -	  Contains multiple useful function call used by the whole tree.
> +    - libcommon (internal)
> +      Contains multiple useful function call used by the whole tree.
> =20
> -	- libcompat (internal)
> -	  Compatibility library mostly for FreeBSD and Linux.
> -=09
> -	- librelayd (internal)
> -	  Library for all relayd interactions over the network.
> +    - libcompat (internal)
> +      Compatibility library mostly for FreeBSD and Linux.
> =20
> -	- lttng-relayd
> -	  The relay daemon used for network streaming
> +    - librelayd (internal)
> +      Library for all relayd interactions over the network.
> +
> +    - lttng-relayd
> +      The relay daemon used for network streaming
> =20
>      - lttng-consumerd
>        The consumer daemon which uses libconsumer.
> @@ -173,9 +173,9 @@ PACKAGE CONTENTS:
>      - tests
>        Various test programs.
> =20
> -	- doc
> -	  Various documentations and quickstart guide.
> +    - doc
> +      Various documentations and quickstart guide.
> =20
> -	- extras
> -	  Contains extra data such as bash completion file. Python bindings for
> -	  liblttng-ctl are also available there.
> +    - extras
> +      Contains extra data such as bash completion file. Python bindings =
for
> +      liblttng-ctl are also available there.
> --=20
> 1.8.5.2
>=20

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS+pNTXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02qWoH/0TstN5ov781LFO333gNny01
3KuSqTRZYpGzX1O+nMlIR0XqloE5R4Rk05gPTojB5EHpIHaWhtbFtBkYAFQ51weC
Nw2+Y6DhR3D8gBaNsthp7bpA8s2vHGi0t29IOtYHV0WKJ0TtEJbs3jircgtcLufS
z449YMFQ9MnSyhGArW5u0QTuEiKje4/yFXZBs97u1PecJLKkqARCQF8KkfNZxUQE
rpX1G+iYLuZKa3pxvxv+GweRxi4CZ1qpfbAFooRoQQiy9+v02PakICyzfOBq/+7D
O1C1Lh6npQGkC4qpu3Ka3/XD4XFXOHgLwbVBNYi4VmcuLjhrtyqaomK3LwQ2dmU=
=FVva
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


--===============1800554531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1800554531==--
