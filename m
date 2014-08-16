From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Man page typos
Date: Sat, 16 Aug 2014 10:43:30 -0400
Message-ID: <20140816144330.GD7634__4285.72645546428$1408200261$gmane$org@thessa>
References: <1408047442-18033-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0909480316=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XIfCk-0004Y3-IE
 for lttng-dev@lists.lttng.org; Sat, 16 Aug 2014 10:43:39 -0400
In-Reply-To: <1408047442-18033-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0909480316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged.

Backported to stable-2.5 also

On 14 Aug (16:17:22), J=E9r=E9mie Galarneau wrote:
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  doc/man/lttng-sessiond.8 | 8 ++++----
>  doc/man/lttng.1          | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/doc/man/lttng-sessiond.8 b/doc/man/lttng-sessiond.8
> index 6fdc483..212b743 100644
> --- a/doc/man/lttng-sessiond.8
> +++ b/doc/man/lttng-sessiond.8
> @@ -134,7 +134,7 @@ wide one in \fB/etc/lttng/sessions/auto/\fP. Note tha=
t the directory containing
>  the session's configuration and lttng-sessiond MUST have the same UID fo=
r them
>  to be automatically loaded.
> =20
> -Specifiying a path with \-l, \-\-load PATH overrides the default directo=
ry and
> +Specifying a path with \-l, \-\-load PATH overrides the default director=
y and
>  UID check. The lttng-sessiond will simply check if it's accessible and t=
ry to
>  load every session file in it.
>  .PP
> @@ -153,10 +153,10 @@ override this variable.
>  Specify the 64-bit consumer binary path. \fB--consumerd64-path\fP
>  override this variable.
>  .IP "LTTNG_CONSUMERD32_LIBDIR"
> -Specifiy the 64-bit library path containing libconsumer.so.
> +Specify the 64-bit library path containing libconsumer.so.
>  \fB--consumerd32-libdir\fP override this variable.
>  .IP "LTTNG_CONSUMERD64_LIBDIR"
> -Specifiy the 32-bit library path containing libconsumer.so.
> +Specify the 32-bit library path containing libconsumer.so.
>  \fB--consumerd64-libdir\fP override this variable.
>  .IP "LTTNG_DEBUG_NOCLONE"
>  Debug-mode disabling use of clone/fork. Insecure, but required to allow
> @@ -187,7 +187,7 @@ babeltrace(1), lttng-ust(3), lttng(1)
>  For unprivileged user running lttng-sessiond, the maximum number of file
>  descriptors per process is usually 1024. This limits the number of trace=
able
>  applications since for each instrumented application there is two file
> -descriptors per-CPU and one more socktet for bidirectional communication.
> +descriptors per-CPU and one more socket for bidirectional communication.
> =20
>  For the root user, the limit is bumped to 65535. Future version will dea=
l with
>  this limitation.
> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 80861e9..2dda28a 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -281,7 +281,7 @@ URL, if one is specified, as the default snapshot out=
put.  Every channel will be
>  in overwrite mode and with mmap output (splice not supported).
>  .TP
>  .BR "\-\-live [USEC]"
> -Set the session exclusively in live mode. The paremeter is the delay in =
micro
> +Set the session exclusively in live mode. The parameter is the delay in =
micro
>  seconds before the data is flushed and streamed. The live mode allows yo=
u to
>  stream the trace and view it while it's being recorded by any tracer. Fo=
r that,
>  you need a lttng-relayd and this session requires a network URL (\-U or
> @@ -905,7 +905,7 @@ Apply to session name.
>  Name of the snapshot's output.
>  .TP
>  .BR "\-m, \-\-max-size SIZE"
> -Maximum size in bytes of the snapshot. The maxium size does not include =
the
> +Maximum size in bytes of the snapshot. The maximum size does not include=
 the
>  metadata file. Human readable format is accepted: {+k,+M,+G}. For instan=
ce,
>  \-\-max-size 5M
> =20
> @@ -1090,7 +1090,7 @@ found.
>  .PP
>  If you encounter any issues or usability problem, please report it on our
>  mailing list <lttng-dev@lists.lttng.org> to help improve this project or
> -at https://bugs.lttng.org which is a bugtracker.
> +at https://bugs.lttng.org which is a bug tracker.
>  .PP
> =20
>  .SH "CREDITS"
> --=20
> 2.0.4
>=20

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT724SXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I026TQH/jLg+RSOFbQ/l6eVbOJq5gQF
dvFPIcGmsNKCDr89Xl1RCyvWgjdAEz8cJbausKhk9BhZ4ZN5adXjQNg/HjjkZIvY
EMoSkGAAReK46qXFsWeD7M+t8WP8jKyqQ7Kv74ycxev2sWefqSAwDp+zQmIfJkHp
WJZbzi/iFDpgXO9lKBaPw0TIlJw+k0+RHJr40eGm1aU3I3HfKn2cBb/KiDyCTYVr
zg8qrI+A1nGGxGPP5OlIVrmQobO9PGxIfhsSjChYNCS7J4Ih22a+BQBo8edq6L4S
wdeEJa+zn3QOGWIayh+2UJrZfkJh1of7e3hltj3DTOiJK2VZHLDVDKoc02MTsD8=
=fnQ3
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--


--===============0909480316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0909480316==--
