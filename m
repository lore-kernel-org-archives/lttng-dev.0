From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Load modules through kmod
Date: Wed, 3 Sep 2014 15:10:41 -0400
Message-ID: <20140903191041.GF1549__17315.4268450618$1409771506$gmane$org@dalia>
References: <1409063266-28706-1-git-send-email-umut.tezduyar@axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1977896235=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XPFxA-0008G5-BI
 for lttng-dev@lists.lttng.org; Wed, 03 Sep 2014 15:10:54 -0400
In-Reply-To: <1409063266-28706-1-git-send-email-umut.tezduyar@axis.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Umut Tezduyar Lindskog <umut.tezduyar@axis.com>
Cc: lttng-dev@lists.lttng.org, Umut Tezduyar Lindskog <umuttl@axis.com>
List-Id: lttng-dev@lists.lttng.org


--===============1977896235==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26 Aug (16:27:46), Umut Tezduyar Lindskog wrote:
> Instead of forking processes, load modules through libkmod.
>=20
> This adds a package dependency to kmod but can be disabled
> by --disable-kmod option in ./configure.

First, thanks for this patch, this is really good to have!

Adding a dependency on libkmod might needs a bit more discussion for
2.6 which I'm quite open to that but I don't want to make the decision
alone.

So could we for now simply use a "--enable-kmod" and by default disable
it? If we decide to depend on libkmod, should be quite easy to revert
back to --disable-kmod.

Thanks!
David

>=20
> The startup time has decreased by %36 on our embedded mips
> product. The measurement is done by cgroup cpu shares.
> ---
>  configure.ac                      |   34 ++++++++++++++++++++++++
>  src/bin/lttng-sessiond/modprobe.c |   53 +++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 87 insertions(+)
>=20
> diff --git a/configure.ac b/configure.ac
> index a8e04f5..b36a95d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -200,6 +200,32 @@ AC_CHECK_DECL([cmm_smp_mb__before_uatomic_or], [],
>          [AC_MSG_ERROR([liburcu $liburcu_version or newer is needed])], [=
[#include <urcu.h>]]
>  )
> =20
> +# Check kmod library
> +AC_ARG_WITH(kmod-prefix,
> +  AS_HELP_STRING([--with-kmod-prefix=3DPATH],
> +                 [Specify the installation prefix of the kmod library.
> +	          Headers must be in PATH/include; libraries in PATH/lib.]),
> +		  [
> +		    CPPFLAGS=3D"$CPPFLAGS -I${withval}/include"
> +		    LDFLAGS=3D"$LDFLAGS -L${withval}/lib64 -L${withval}/lib"
> +		  ])
> +
> +AC_ARG_ENABLE(kmod,
> +	AS_HELP_STRING([--disable-kmod],[build without kmod support]),
> +	kmod_support=3D$enableval, kmod_support=3Dyes)
> +
> +AS_IF([test "x$kmod_support" =3D "xyes"], [
> +	AC_CHECK_LIB([kmod], [kmod_module_probe_insert_module],
> +		[
> +			AC_DEFINE([HAVE_KMOD], [1], [has kmod support])
> +			LIBS=3D"$LIBS -lkmod"
> +			kmod_found=3Dyes
> +		],
> +		[AC_MSG_ERROR([Cannot find kmod >=3D 5. Use --with-kmod-prefix=3DPREFI=
X to specify its location, or specify --disable-kmod to build lttng-tools w=
ithout kmod support.])]
> +	)
> +])
> +AM_CONDITIONAL([HAVE_KMOD], [test "x$kmod_found" =3D xyes])
> +
>  AC_ARG_WITH(lttng-ust-prefix,
>    AS_HELP_STRING([--with-lttng-ust-prefix=3DPATH],
>                   [Specify the installation prefix of the lttng-ust libra=
ry.
> @@ -483,6 +509,14 @@ done
>  AS_ECHO_N("Target architecture: ")
>  AS_ECHO($target_arch)
> =20
> +# kmod enabled/disabled
> +AS_ECHO_N("kmod support: ")
> +AS_IF([test "x$kmod_support" =3D "xyes"],[
> +	AS_ECHO("Enabled")
> +],[
> +	AS_ECHO("Disabled")
> +])
> +
>  # LTTng-UST enabled/disabled
>  AS_ECHO_N("Lttng-UST support: ")
>  AS_IF([test "x$lttng_ust_support" =3D "xyes"],[
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/m=
odprobe.c
> index 3cc67f0..40a2ee0 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -164,6 +164,58 @@ void modprobe_remove_lttng_all(void)
>  	modprobe_remove_lttng_control();
>  }
> =20
> +#if HAVE_KMOD
> +#include <libkmod.h>
> +static void log_kmod(void *data, int priority, const char *file, int lin=
e,
> +		     const char *fn, const char *format, va_list args)
> +{
> +	char *str;
> +	if (vasprintf(&str, format, args) < 0)
> +		return;
> +	DBG("libkmod: %s", str);
> +	free(str);
> +}
> +static int modprobe_lttng(struct kern_modules_param *modules,
> +			  int entries, int required)
> +{
> +	int ret =3D 0, i;
> +	struct kmod_ctx *ctx;
> +
> +	ctx =3D kmod_new(NULL, NULL);
> +	if (!ctx) {
> +		PERROR("Unable to create kmod library context");
> +		ret =3D -ENOMEM;
> +		goto error;
> +	}
> +
> +	kmod_set_log_fn(ctx, log_kmod, NULL);
> +	kmod_load_resources(ctx);
> +
> +	for (i =3D 0; i < entries; i++) {
> +		struct kmod_module *mod =3D NULL;
> +
> +		ret =3D kmod_module_new_from_name(ctx, modules[i].name, &mod);
> +		if (ret < 0) {
> +			PERROR("Failed to create kmod module for %s", modules[i].name);
> +			goto error;
> +		}
> +
> +		ret =3D kmod_module_probe_insert_module(mod, KMOD_PROBE_IGNORE_LOADED,=
 NULL, NULL, NULL, NULL);
> +		if (required && ret < 0) {
> +			ERR("Unable to load module %s", modules[i].name);
> +		} else {
> +			DBG("Modprobe successfully %s", modules[i].name);
> +		}
> +
> +		kmod_module_unref(mod);
> +	}
> +
> +error:
> +	if (ctx)
> +		kmod_unref(ctx);
> +	return ret;
> +}
> +#else
>  static int modprobe_lttng(struct kern_modules_param *modules,
>  			  int entries, int required)
>  {
> @@ -194,6 +246,7 @@ static int modprobe_lttng(struct kern_modules_param *=
modules,
>  error:
>  	return ret;
>  }
> +#endif
> =20
>  /*
>   * Load control kernel module(s).
> --=20
> 1.7.10.4
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUB2exXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02CAIH/15iwFETa2xtVCFJOI11lI5b
b2i7Gz5fU3hG/lsk3rwnYbKX8YMKOuak7ODQl0gnB+TqOCr33bcFpvTIQlLisavi
NltX8t8TxzaudIiXWV2BF5rPAJF5cs8wTYf3mtz2LOlYJ+DEhZrOQkJhT3oeoqdg
S6MqzCflePURnuyDC8QPjYNDU6d88DVTAn7sPrQ3T4xPFgxema53hL602yA3WZ3a
9WhcuK8jbvj+/aW40G9eqdaxe7lbJUB336dWqkGBzrZZXMVo1Y/+IkLMHOa7lTPn
giBbHAI03ykzjZ0yGRO13UMetu9gy49pdCsfaTAKSxKojnpB/snnNKYP3+Qwsx8=
=RP/4
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--


--===============1977896235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1977896235==--
