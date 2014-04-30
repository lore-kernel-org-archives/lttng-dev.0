From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH] Clarify limitations of the --syscall flag
 with enable-event command
Date: Wed, 30 Apr 2014 12:55:04 -0400
Message-ID: <20140430165504.GC32499__22148.7107607119$1398877095$gmane$org@dalia>
References: <1397665585-31197-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0006584759=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WfXn3-0005D4-Ij
 for lttng-dev@lists.lttng.org; Wed, 30 Apr 2014 12:55:29 -0400
In-Reply-To: <1397665585-31197-1-git-send-email-christian.babeux@efficios.com>
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


--===============0006584759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 16 Apr (12:26:25), Christian Babeux wrote:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  doc/man/lttng.1 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 972f71c..9882083 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -541,7 +541,9 @@ Dynamic function entry/return probe. Addr and offset =
can be octal
>  .BR "\-\-syscall"
>  System call event. Enabling syscalls tracing (kernel tracer), you will
>  not be able to disable them with disable-event. This is a known
> -limitation. You can disable the entire channel to do the trick.
> +limitation. You can disable the entire channel to do the trick. Also note
> +that per-syscall selection is not supported yet. Use with "-a" to enable
> +all syscalls.
>  .TP
>  .BR "\-\-filter 'expression'"
>  Set a filter on a newly enabled event. Filter expression on event
> --=20
> 1.9.2
>=20

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTYSroXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02mDAIAK8ar+nnJ/mcoS7daqASccPS
eGU17UHGwkp35JbqNqqzCczQc/WudtcFKbmyBi1ogTNpWqy0h5nYO6NWQUQXFhXt
QkvPnrW2CsLiZBUiNGYnRq63llF87h3d7/pW9GssOZKyHXOl+ZlDpEP2Vuc5pYcb
wAfaa40YAZayi+4EvdYEUhsWDKbe6oTW5Ygw5cZolPwAoCV10baEvT3vA0Ky7H2l
+oDKCNw1GdzKQ8rCPUnrhU5o7OkJZ330Nc1kLupdfJ62boAhCsu4dbvI/KRzY9dx
foy6z3G5z82JkpZkgOzbUb1rWxD7yW1fo7YnVKWUrhIvLBmFxA5JjVVeTAaIswo=
=v05/
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--


--===============0006584759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0006584759==--
