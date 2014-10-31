From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: syscall list ioctl
	number conflict
Date: Fri, 31 Oct 2014 16:22:32 -0400
Message-ID: <20141031202232.GF24977__39280.7966833518$1414786999$gmane$org@dalia>
References: <1413845433-24348-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0965594164=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XkIiW-0004Dh-0X
 for lttng-dev@lists.lttng.org; Fri, 31 Oct 2014 16:22:42 -0400
In-Reply-To: <1413845433-24348-1-git-send-email-mathieu.desnoyers@efficios.com>
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


--===============0965594164==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

merged in 2.6.0-rc2

David

On 20 Oct (18:50:32), Mathieu Desnoyers wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  src/common/kernel-ctl/kernel-ioctl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/common/kernel-ctl/kernel-ioctl.h b/src/common/kernel-ctl=
/kernel-ioctl.h
> index c88f970..475a066 100644
> --- a/src/common/kernel-ctl/kernel-ioctl.h
> +++ b/src/common/kernel-ctl/kernel-ioctl.h
> @@ -103,7 +103,7 @@
>  #define LTTNG_KERNEL_WAIT_QUIESCENT		_IO(0xF6, 0x48)
>  #define LTTNG_KERNEL_CALIBRATE			\
>  	_IOWR(0xF6, 0x49, struct lttng_kernel_calibrate)
> -#define LTTNG_KERNEL_SYSCALL_LIST		_IO(0xF6, 0x49)
> +#define LTTNG_KERNEL_SYSCALL_LIST		_IO(0xF6, 0x4A)
> =20
>  /* Session FD ioctl */
>  #define LTTNG_KERNEL_METADATA			\
> --=20
> 2.1.0
>=20

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUU++IXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02AEsH/0j9FYk9/or973L7cGD98pg0
tsTANMxaKGJJQBeEDz9ba8KoHtFEJbTvo5MlpxHZW8dPCEVBvafkHos8nPO09DqV
mZB+BnRxn5uiQNb63L/cT1U4DbEc/eEIKoDhcCQdIp/ndmbc1AwqVyU6d8IsVu4V
MszUxj/LUyGUUemz33yYdl534NIO7p9MaYFQk+pXNUFy0N71ADsf0RzlQL196D89
HdiGbM3xIwtZxYamWwbEVR8vdAy8KWeUvfqeT589iWmbH/+2s2tI5wp0e8vZWj1U
RlumJ/WSMSn2SnjgWbU0NbvePO1H8LJj7PdU4aZuNKcmzBuou9lD6tEmYVk0dPE=
=bL94
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--


--===============0965594164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0965594164==--
