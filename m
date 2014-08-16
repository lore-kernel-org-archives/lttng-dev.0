From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tool] Mi & save/load: add option to
 indent or not on config writer creation
Date: Sat, 16 Aug 2014 10:43:44 -0400
Message-ID: <20140816144344.GE7634__39271.1197761402$1408200275$gmane$org@thessa>
References: <1407334428-7601-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0435913407=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XIfCv-0004YU-Vw
 for lttng-dev@lists.lttng.org; Sat, 16 Aug 2014 10:43:50 -0400
In-Reply-To: <1407334428-7601-1-git-send-email-jonathan.r.julien@gmail.com>
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


--===============0435913407==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 06 Aug (10:13:48), Jonathan Rajotte Julien wrote:
> The presence of tabulation and newline in mi is irrelevant and
> can impact client performance. The parsing & processing of a lot of data =
=66rom mi
> with many /t and /n impact performance. This aim to fix the problem at the
> source. Style is useless for machine.
>=20
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  src/bin/lttng-sessiond/save.c | 2 +-
>  src/common/config/config.c    | 8 ++++----
>  src/common/config/config.h    | 5 ++++-
>  src/common/mi-lttng.c         | 2 +-
>  4 files changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/src/bin/lttng-sessiond/save.c b/src/bin/lttng-sessiond/save.c
> index 90b3a3b..28844e3 100644
> --- a/src/bin/lttng-sessiond/save.c
> +++ b/src/bin/lttng-sessiond/save.c
> @@ -1514,7 +1514,7 @@ int save_session(struct ltt_session *session,
>  	}
>  	file_opened =3D 1;
> =20
> -	writer =3D config_writer_create(fd);
> +	writer =3D config_writer_create(fd, 1);
>  	if (!writer) {
>  		ret =3D LTTNG_ERR_NOMEM;
>  		goto end;
> diff --git a/src/common/config/config.c b/src/common/config/config.c
> index bfb2576..1dccd26 100644
> --- a/src/common/config/config.c
> +++ b/src/common/config/config.c
> @@ -353,7 +353,7 @@ end:
>  }
> =20
>  LTTNG_HIDDEN
> -struct config_writer *config_writer_create(int fd_output)
> +struct config_writer *config_writer_create(int fd_output, int indent)
>  {
>  	int ret;
>  	struct config_writer *writer;
> @@ -379,12 +379,12 @@ struct config_writer *config_writer_create(int fd_o=
utput)
> =20
>  	ret =3D xmlTextWriterSetIndentString(writer->writer,
>  		BAD_CAST config_xml_indent_string);
> -	if (ret)  {
> +	if (ret) {
>  		goto error_destroy;
>  	}
> =20
> -	ret =3D xmlTextWriterSetIndent(writer->writer, 1);
> -	if (ret)  {
> +	ret =3D xmlTextWriterSetIndent(writer->writer, indent);
> +	if (ret) {
>  		goto error_destroy;
>  	}
> =20
> diff --git a/src/common/config/config.h b/src/common/config/config.h
> index 9a5671a..2fed612 100644
> --- a/src/common/config/config.h
> +++ b/src/common/config/config.h
> @@ -81,11 +81,14 @@ int config_parse_value(const char *value);
>   * fd_output File to which the XML content must be written. The file wil=
l be
>   * closed once the config_writer has been destroyed.
>   *
> + * indent If other than 0 the XML will be pretty printed
> + * with indentation and newline.
> + *
>   * Returns an instance of a configuration writer on success, NULL on
>   * error.
>   */
>  LTTNG_HIDDEN
> -struct config_writer *config_writer_create(int fd_output);
> +struct config_writer *config_writer_create(int fd_output, int indent);
> =20
>  /*
>   * Destroy an instance of a configuration writer.
> diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> index a636c71..31fa610 100644
> --- a/src/common/mi-lttng.c
> +++ b/src/common/mi-lttng.c
> @@ -352,7 +352,7 @@ struct mi_writer *mi_lttng_writer_create(int fd_outpu=
t, int mi_output_type)
>  		goto end;
>  	}
>  	if (mi_output_type =3D=3D LTTNG_MI_XML) {
> -		mi_writer->writer =3D config_writer_create(fd_output);
> +		mi_writer->writer =3D config_writer_create(fd_output, 0);
>  		if (!mi_writer->writer) {
>  			goto err_destroy;
>  		}
> --=20
> 2.0.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT724gXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02vt0IALbgBRsRWQmyWyb3n0rrfbHh
apozn5cWb9SrCRDgeQpCDinfKH0K4CpYPLRYF7KJueGiqFLf3scTZTMGRnHwhKfW
w2mh+iHQiggCbKL1e3DdCEiIXeg9HU/3DLqn+xsruQdI+NAeFKgATwDFFDue3Pp0
JibH+vT1L47WrkM59VH3P+2lkqaYvxjdV3WMah7pSeTKyVXiQmQC7aW+YBY57SUv
Yd/sfVg//ghmEVR/Cr4AGVCb6ASd78nb1aG6mdu6xZKR0fjB8VW+lKv6vBdC46sU
1PP3qtK0g9OZeR0RBH8tI59dcuC6JCIFbBSXBYmTPSKTbHkezyJuo5yamzhvNTI=
=BSBb
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--


--===============0435913407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0435913407==--
