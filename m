From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Insert V4L2 instrumentation
 module on session start
Date: Thu, 10 Apr 2014 15:32:16 -0400
Message-ID: <20140410193216.GA28773__7761.16527054018$1397158418$gmane$org@dalia>
References: <5335D717.6080808@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0772215757=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WYKi4-0003PG-1e
 for lttng-dev@lists.lttng.org; Thu, 10 Apr 2014 15:32:33 -0400
In-Reply-To: <5335D717.6080808@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wade Farnsworth <wade_farnsworth@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0772215757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

On 28 Mar (13:09:59), Wade Farnsworth wrote:
> Requires V4L2 instrumentation patch for lttng-modules.
>=20
> Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
> ---
>  src/bin/lttng-sessiond/modprobe.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/m=
odprobe.c
> index 92563b0..4ef4d4c 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -78,6 +78,7 @@ const struct kern_modules_param kern_modules_list[] =3D=
 {
>  	{ "lttng-probe-timer", 0 },
>  	{ "lttng-probe-udp", 0 },
>  	{ "lttng-probe-vmscan", 0 },
> +	{ "lttng-probe-v4l2", 0 },
>  	{ "lttng-probe-workqueue", 0 },
>  	{ "lttng-probe-writeback", 0 },
>  };
> --=20
> 1.9.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTRvHAXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I029pwIAIsFPHHN5Z3NNpDcEMJVQlGx
ygRk6fGPtH222KBT2w2t0IQ2rBdfGUCu9absDjxYZgHTKOUBX4srtn+eZ9vQELWF
upds42elKjIpry96JBW/tO/ZLiJn0f/ciLUR4BwBJV8/CPlgUDl4cniRi4FnzLBL
H5K2K/6n6+9T4Vk1bqEd7rOoyxfSE93CZJQIBM+RoE/sIqJbLwlTKpfcNvnGbxOh
Eq39MuXGgZn77g51nEz3xQyUgk9DiarMOKulIXps75ae+FxXIwHABMK/xAU4Dc5m
/VtK8nk8EhxlqgaLA0n6e5pcX4kaYyNUffe3o1TaagKzANI0XOTlbsnnGQr4K/s=
=YTC+
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--


--===============0772215757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0772215757==--
