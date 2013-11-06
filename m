From: David Goulet <dgoulet@efficios.com>
Subject: Re: Fix: application SIGBUS when starting in parallel
	with sessiond
Date: Wed, 6 Nov 2013 10:50:59 -0500
Message-ID: <20131106155059.GA8133__46154.23146538$1383753130$gmane$org@thessa>
References: <1078635254.57937.1383740230847.JavaMail.zimbra@efficios.com>
	<347494784.57942.1383740327175.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2109935139=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Ve5Ns-0003sq-9k
	for lttng-dev@lists.lttng.org; Wed, 06 Nov 2013 10:51:14 -0500
In-Reply-To: <347494784.57942.1383740327175.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============2109935139==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06 Nov (12:18:47), Mathieu Desnoyers wrote:
> Should be applied to master, stable-2.3, stable-2.2.

Merged!

>=20
> Thanks,
>=20
> Mathieu
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

> commit be2bcc7e9a02e5bd78dc2615886af32ddd87032b
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Nov 6 07:06:51 2013 -0500
>=20
>     Fix: application SIGBUS when starting in parallel with sessiond
>    =20
>     There is a race between application startup and sessiond startup, whe=
re
>     there is an intermediate state where applications can SIGBUS if they =
see
>     a zero-sized shm, if the shm has been created, but not ftruncated yet.
>    =20
>     On the sessiond side, we need to ensure that the shared memory is
>     writeable by applications as long as its size is 0, which allow
>     applications to perform ftruncate and extend its size.
>    =20
>     On the UST side, another commit needs to ensure that UST can read the
>     shared memory file descriptor with a read() system call before they
>     try accessing it through a memory map (which triggers the SIGBUS if
>     the access goes beyond the file size)
>    =20
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>=20
> diff --git a/src/bin/lttng-sessiond/shm.c b/src/bin/lttng-sessiond/shm.c
> index b94f4eb..7bb52d4 100644
> --- a/src/bin/lttng-sessiond/shm.c
> +++ b/src/bin/lttng-sessiond/shm.c
> @@ -48,40 +48,17 @@ static int get_wait_shm(char *shm_path, size_t mmap_s=
ize, int global)
>  	/* Default permissions */
>  	mode =3D S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP;
> =20
> -	/* Change owner of the shm path */
> +	/*
> +	 * Change owner of the shm path.
> +	 */
>  	if (global) {
> -		ret =3D chown(shm_path, 0, 0);
> -		if (ret < 0) {
> -			if (errno !=3D ENOENT) {
> -				PERROR("chown wait shm");
> -				goto error;
> -			}
> -		}
> -
>  		/*
> -		 * If global session daemon, any application can register so the shm
> -		 * needs to be set in read-only mode for others.
> +		 * If global session daemon, any application can
> +		 * register. Make it initially writeable so applications
> +		 * registering concurrently can do ftruncate() by
> +		 * themselves.
>  		 */
> -		mode |=3D S_IROTH;
> -	} else {
> -		ret =3D chown(shm_path, getuid(), getgid());
> -		if (ret < 0) {
> -			if (errno !=3D ENOENT) {
> -				PERROR("chown wait shm");
> -				goto error;
> -			}
> -		}
> -	}
> -
> -	/*
> -	 * Set permissions to the shm even if we did not create the shm.
> -	 */
> -	ret =3D chmod(shm_path, mode);
> -	if (ret < 0) {
> -		if (errno !=3D ENOENT) {
> -			PERROR("chmod wait shm");
> -			goto error;
> -		}
> +		mode |=3D S_IROTH | S_IWOTH;
>  	}
> =20
>  	/*
> @@ -107,13 +84,32 @@ static int get_wait_shm(char *shm_path, size_t mmap_=
size, int global)
>  	}
> =20
>  #ifndef __FreeBSD__
> -	ret =3D fchmod(wait_shm_fd, mode);
> -	if (ret < 0) {
> -		PERROR("fchmod");
> -		exit(EXIT_FAILURE);
> +	if (global) {
> +		ret =3D fchown(wait_shm_fd, 0, 0);
> +		if (ret < 0) {
> +			PERROR("fchown");
> +			exit(EXIT_FAILURE);
> +		}
> +		/*
> +		 * If global session daemon, any application can
> +		 * register so the shm needs to be set in read-only mode
> +		 * for others.
> +		 */
> +		mode &=3D ~S_IWOTH;
> +		ret =3D fchmod(wait_shm_fd, mode);
> +		if (ret < 0) {
> +			PERROR("fchmod");
> +			exit(EXIT_FAILURE);
> +		}
> +	} else {
> +		ret =3D fchown(wait_shm_fd, getuid(), getgid());
> +		if (ret < 0) {
> +			PERROR("fchown");
> +			exit(EXIT_FAILURE);
> +		}
>  	}
>  #else
> -#warning "FreeBSD does not support setting file mode on shm FD. Remember=
 that for secure use, lttng-sessiond should be started before applications =
linked on lttng-ust."
> +#warning "FreeBSD does not support setting file mode on shm FD."
>  #endif
> =20
>  	DBG("Got the wait shm fd %d", wait_shm_fd);


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQF8BAEBAgBmBQJSemVjXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02a4QIAJhagWw+52Qy6Ar30JNZ0T5v
p3CNqGqh8TWsU+E0j1oBHjjLLiHnKrCXogbSXmAwPx1kJOovNuRf8XHmqlMT6nC0
+2WEKCSSjbkRtfGKpNRNLhqewEhwbctt2t8R0pn17aW6OvvCprWvZilbaIW+MLxV
Pljlb3eun/L8Q5FwaD8QMGhDh8qSbFtfTCl3yaDY1TggDKM+DrTv1sly7nyFr8W1
2HdO9cow9ibqTfE6KrQQLSPWV6F1cwgVh4bni7jrtwKNNrZMmNo5mazvdw0PQBEu
kUhzJdlp4boQ1c53lHFG/ByoOobX0xALwswtkqwlqBtQzcuzU2Z8hEprVDAN9Ms=
=NSeB
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--


--===============2109935139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2109935139==--
