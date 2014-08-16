From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: list command: revert merge
 error made when adding mi on pretty printing
Date: Sat, 16 Aug 2014 10:45:46 -0400
Message-ID: <20140816144546.GG7634__14531.688244506$1408200389$gmane$org@thessa>
References: <1407866140-6261-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0766248789=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XIfEu-0004eH-AF
 for lttng-dev@lists.lttng.org; Sat, 16 Aug 2014 10:45:53 -0400
In-Reply-To: <1407866140-6261-1-git-send-email-jonathan.r.julien@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0766248789==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
Content-Disposition: inline


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12 Aug (13:55:40), Jonathan Rajotte Julien wrote:
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng/commands/list.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
> index e3ff4f1..ccffdc7 100644
> --- a/src/bin/lttng/commands/list.c
> +++ b/src/bin/lttng/commands/list.c
> @@ -1271,14 +1271,10 @@ static int list_sessions(const char *session_name)
>  					break;
>  				}
>  			} else {
> -				MSG("  %d) %s (%s) [%s%s]", i + 1,
> -						sessions[i].name, sessions[i].path,
> +				MSG("  %d) %s (%s) [%s%s]", i + 1, sessions[i].name,
> +						sessions[i].path,
>  						active_string(sessions[i].enabled),
>  						snapshot_string(sessions[i].snapshot_mode));
> -				MSG("%sTrace path: %s", indent4, sessions[i].path);
> -				MSG("%sLive timer interval (usec): %u\n", indent4,
> -						sessions[i].live_timer_interval);
> -				break;

Not sure removing that is wanted here. The "trace path" and "live timer
interval" lines are in stable-2.5 thus removing them here, you need a
real good reason ;)

David

>  			}
>  		}
> =20
> --=20
> 2.0.4
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT726aXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I020vkIAJSTr/gXJ4Hym4778XxofUjG
mQPZBYa9DvRcYjvV9NaPgP89faKscBEY6Pv8zAiqQpYBs3xbEsDN8hW4Y8oF+APg
On+79VJzr55tvW1Krv9gpxOO+l/IHzVAXPu/nPOQ7bS0yw9bOO2bQw3mCNZAf/yA
lmtNrryC2v05VrxCHqAU1BSDCDbICBwmvB9KtEf51lCwTkoofptuLqxXwlfE54RS
TZYx6FQp+ftTk/g+KahQashGJ5/jmuiv+1guptaltBgtDZIPq7zTkHjvmGWLuOVq
9+xzBpAJ7f8fOPPszkYIVfVXtbfr2dM9lQiSgm5Jqlk3dkAGRoY3yFebsMAE1kY=
=uSxK
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--


--===============0766248789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0766248789==--
