From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/2] Fix: Parenthesize previous
 statement when adding conditions to a filter
Date: Wed, 3 Sep 2014 15:00:05 -0400
Message-ID: <20140903190005.GE1549__40075.8005016998$1409770872$gmane$org@dalia>
References: <1409244824-6680-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0410030210=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XPFmu-0008A5-O4
 for lttng-dev@lists.lttng.org; Wed, 03 Sep 2014 15:00:18 -0400
In-Reply-To: <1409244824-6680-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0410030210==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both patches merged!

On 28 Aug (12:53:43), J=E9r=E9mie Galarneau wrote:
> Not parenthesizing the clauses in a filter string causes JUL events to be
> traced even though they are not enabled when an enable-event command is
> issued with a filter and the --loglevel-only option.
>=20
> For instance,
>=20
> lttng enable-event -j "my_event" --loglevel-only JUL_CONFIG -f "int_logle=
vel > 0 || int_loglevel < 0"
>=20
> results in the following filter being applied:
>=20
> int_loglevel > 0 || int_loglevel < 0 && logger_name =3D=3D "my_event" && =
int_loglevel =3D=3D 700
>=20
> The resulting expression will always evaluate to true, regardless of the =
logger
> name.
>=20
> This fix parenthesizes each clause to ensure they are all independently
> evaluated and not unintuitively affected by operator precedence.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/lib/lttng-ctl/lttng-ctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 9686b7d..f83d053 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -705,7 +705,7 @@ static char *set_jul_filter(const char *filter, struc=
t lttng_event *ev)
>  	/* Don't add filter for the '*' event. */
>  	if (ev->name[0] !=3D '*') {
>  		if (filter) {
> -			err =3D asprintf(&jul_filter, "%s && logger_name =3D=3D \"%s\"", filt=
er,
> +			err =3D asprintf(&jul_filter, "(%s) && (logger_name =3D=3D \"%s\")", =
filter,
>  					ev->name);
>  		} else {
>  			err =3D asprintf(&jul_filter, "logger_name =3D=3D \"%s\"", ev->name);
> @@ -729,7 +729,7 @@ static char *set_jul_filter(const char *filter, struc=
t lttng_event *ev)
>  		if (filter || jul_filter) {
>  			char *new_filter;
> =20
> -			err =3D asprintf(&new_filter, "%s && int_loglevel %s %d",
> +			err =3D asprintf(&new_filter, "(%s) && (int_loglevel %s %d)",
>  					jul_filter ? jul_filter : filter, op,
>  					ev->loglevel);
>  			if (jul_filter) {
> --=20
> 2.1.0
>=20

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUB2U1XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02U7sH/0z/sVdcYwLZGM2bkdIPpBto
P2nPzysHvQBtK0vvJZdPLkoLZhnA24B8EQHQ99DUEew4bouiQl3z9jRIz1i+FbJ9
CpWpKTb7hYH80UwOnFWeIajHyZ8hjTmVhY3mMsqd656baadn24NDCYy+7qBxFTnT
TExYuRMrf2dQGfsTWT0Qk49BbfHn591aNj4YfiFbLmOsNYGaVEss+GOFim1AJ0B5
b9W8AROBC8if0Cnf7Y83pqdNgbNxR+2l+Emkf1VL+hOcTqCtkPBWzWrqyNM32Gx1
/xMqocoGbMAotsAEY0YZHW5nHrUgmkX+sY006LFMp9HhMZY6420V6YRrkey9+eA=
=U/5M
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--


--===============0410030210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0410030210==--
