From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: mi test: possible race
 between listing UST events and testapp start
Date: Wed, 29 Oct 2014 14:23:43 -0400
Message-ID: <20141029182343.GB8595__34113.5642528117$1414607098$gmane$org@thessa>
References: <1414372906-22433-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2057806225=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XjXuR-0005rC-Pz
 for lttng-dev@lists.lttng.org; Wed, 29 Oct 2014 14:23:58 -0400
In-Reply-To: <1414372906-22433-1-git-send-email-jonathan.r.julien@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============2057806225==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26 Oct (21:21:46), Jonathan Rajotte wrote:
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> ---
>  tests/regression/tools/mi/test_mi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tools/m=
i/test_mi
> index fa46b51..7acec18 100755
> --- a/tests/regression/tools/mi/test_mi
> +++ b/tests/regression/tools/mi/test_mi
> @@ -507,6 +507,11 @@ function test_list_ust_event ()
> =20
>  	#Begin testing
>  	$TESTAPP_BIN $NR_USEC_WAIT & 2>/dev/null
> +	pid=3D$!
> +
> +	#Wait for TESTAPP to run
> +	while ! kill -0 $pid 2> /dev/null; do :; done

So of what I understand here, this tests the existance of the PID but
wondering if it really fixes the race. Even if the PID indeed exists,
still it might not have registered to the session daemon.

I think one way to fix that is to have a "lttng list -u | grep $PID"
test and if the output is not empty, the application did registered.
Also, you can use the "create file" option of gen-ust-events. You can
pass a fourth argument to the app, once a tracepoint is hit, it will
create the file you gave with the full path. You can then loop on that.
There are some tests that already uses that, you can check it out.

Finally, that test should actually spawn the application with a long
life time and kill it at the end so we don't race between very long
commands and the application actually quiting gracefully.

Cheers!
David

> +
>  	list_lttng_with_opts "-u -f"
>  	$XML_VALIDATE $OUTPUT_DEST
>  	ok $? "Mi test: list ust event xsd validation"
> --=20
> 1.9.1
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBCABmBQJUUTCvXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02Qu0H/iZTsEshRbUIZ7qLuuTsfUIR
7T7o35fZgtU8+0QCGrNcZTtgjtL9iEAhCShqLVxYZ8IhV09xdZecs09SxvwVMbEb
g7KHJ1uMN01yZJvg9A9Ocf5RvOMYONwESOgUZVq4++Wp3f7C+mOhXPQIhSVd3zeB
BVspf8gkOXxC4gDS0uUzehfJXz6MP4n8Y4EfimokBzKGFLNwoUHjgWK7D9KUfCJC
vCtgiD0hmWm+Tu7IhzM8Bg9x21Xcnh0dzdzSr9d4ViWWfprnm+LwbHIAqKiC8O7Q
Oz6UQuBkci0WDLqVSiKdbGmYni9rNxh9qM+R+2IMqWm38v/jyGIXeXuLDJ8WNew=
=ohZd
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--


--===============2057806225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2057806225==--
