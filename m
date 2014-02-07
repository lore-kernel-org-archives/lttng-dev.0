From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add extern C to the
 health-check header
Date: Fri, 7 Feb 2014 10:16:52 -0500
Message-ID: <20140207151652.GA7281__11251.0109473535$1391786284$gmane$org@thessa>
References: <1391714036-14376-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0165827816=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1WBnAr-0008D5-Ab
	for lttng-dev@lists.lttng.org; Fri, 07 Feb 2014 10:17:06 -0500
In-Reply-To: <1391714036-14376-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0165827816==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

Upstream and backported in stable-2.4

On 06 Feb (14:13:56), J=E9r=E9mie Galarneau wrote:
> This makes it possible to include health.h in a C++ program.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  include/lttng/health.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/include/lttng/health.h b/include/lttng/health.h
> index 9960928..9a7a7fc 100644
> --- a/include/lttng/health.h
> +++ b/include/lttng/health.h
> @@ -19,6 +19,10 @@
>   * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */
> =20
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
>  struct lttng_health;
>  struct lttng_health_thread;
> =20
> @@ -124,4 +128,8 @@ int lttng_health_thread_state(const struct lttng_heal=
th_thread *thread);
>   */
>  const char *lttng_health_thread_name(const struct lttng_health_thread *t=
hread);
> =20
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif /* LTTNG_HEALTH_H */
> --=20
> 1.8.5.2
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJS9PjkXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I0228oIAL7ORv4lBnjgY/M4uSZOZXMv
w5gxVdj3+ZYZ1ETlSdWzJEFC0llhnpuTyS+XeGM2BPtXtEi8EKaR3+JGeykrfDfM
rxc+nNPyIvnh5/gFFaSRMZTr11vGysnOKYzvXdBPbEJG3QSSdmumzbWkvPoP8rbg
G+JYOo1UPNe+u64MsOXEjdEKZO9plF1HI9Z6fX2zDPgZOYWXawwmZfQPucOiZr4U
1JxlTPndXJ3xj6xE98AGUX0rqhkLQ+ArPKX9PVP3hXSC36Mc/Ca0oyoX/WBnU+XK
akFVdtMi2Pq3ZOOAMEcSFhFK3O7BTba+NeWWYqaeVdT8g8Z0992df4jx65fAYFU=
=x0wJ
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--


--===============0165827816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0165827816==--
