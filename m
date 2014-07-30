From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: git version build system
 integration (v2)
Date: Wed, 30 Jul 2014 08:50:26 -0400
Message-ID: <20140730125026.GB6050__31480.3530731753$1406724709$gmane$org@thessa>
References: <1406673411-20721-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1781883583=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XCTKz-0003ce-S2
 for lttng-dev@lists.lttng.org; Wed, 30 Jul 2014 08:50:36 -0400
In-Reply-To: <1406673411-20721-1-git-send-email-mathieu.desnoyers@efficios.com>
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


--===============1781883583==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged

On 29 Jul (18:36:51), Mathieu Desnoyers wrote:
> Fix:
> - Don't overwrite version.h if the previous content matches.
> - While we are there, if we notice the previous content matches,
>   print a (cached) message to show that we do not overwrite the
>   content.
> - Introduce LTTNG_TOOLS_BUILD_GIT_SOURCE automake conditional rather
>   than compile-time define to disable the feature. It ensures we
>   do not invoke "git describe" when configure --disable-git-version
>   has been requested.
> - Use git describe rather than git describe --long --all. Based
>   on the last tag, and adds the first numbers of git revision.
>   Last tag is useful both to the developer and in a bug report,
>   whereas the branch name returned by --long --all is meaningless
>   in a bug report.
> - We want to ship version.h.tmpl in the tarball (make dist), not
>   version.h which is generated. Someone could very well do a
>   git init on the extracted tarball and want to have git tracking
>   support.
> - Fix the git prefix " - " that is incorrectly printed in some
>   situations, e.g. when GIT_SOURCE was active, but we are in
>   a non-git tree (or git is not available).
> - Fix incorrect handling of out of tree build. Invoke git describe from
>   top_srcdir.
>=20
> Changelog since v1:
> - Add missing comma for lttng usage output.
>=20
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  configure.ac                     |  8 +++---
>  include/Makefile.am              | 60 +++++++++++++++++++++-------------=
------
>  include/version.h.tmpl           | 14 +++-------
>  src/bin/lttng/commands/version.c |  3 +-
>  src/bin/lttng/lttng.c            |  8 ++++--
>  5 files changed, 47 insertions(+), 46 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index bd49df7..a8e04f5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -262,11 +262,11 @@ AC_CHECK_LIB([c], [open_memstream],
>  AC_ARG_ENABLE([git-version],
>                [AC_HELP_STRING([--disable-git-version],
>                                [Do not use the git version for the build]=
)],
> -              [disable_git_version=3Dyes], [disable_git_version=3Dno]
> +              [have_git_version=3D$enableval], [have_git_version=3Dyes]
>  )
> -if test "x${disable_git_version:-no}" =3D xno; then
> -    AC_DEFINE_UNQUOTED([GIT_SOURCE], 1, [Disable git version.])
> -fi
> +
> +AM_CONDITIONAL([LTTNG_TOOLS_BUILD_GIT_SOURCE],
> +	[test "x${have_git_version}" =3D "xyes"])
> =20
>  # For Python
>  # SWIG version needed or newer:
> diff --git a/include/Makefile.am b/include/Makefile.am
> index 767b05b..4b59e72 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -1,3 +1,9 @@
> +if LTTNG_TOOLS_BUILD_GIT_SOURCE
> +GIT_DESCRIBE_CMD =3D (cd $(top_srcdir); git describe)
> +else
> +GIT_DESCRIBE_CMD =3D /bin/true
> +endif
> +
>  ##
>  ## The version.h file must be verified and generated or updated if the
>  ## git commit id (called git version here) changed since the last build
> @@ -6,49 +12,44 @@
>  version.h:
>  	##
>  	## We first create variables for the current git version and
> -	## the locations of the version.h and version.h.tmpl files
> +	## the locations of the version.h and version.h.tmpl files.
>  	##
> -	@echo -n "Generating version.h ... "
> +	@echo -n "Generating version.h... "
>  	@(version_h_tmpl=3D"$(top_srcdir)/include/version.h.tmpl"; \
>  	if [ -f "$${version_h_tmpl}" ]; then \
>  		version_h=3D"$(top_builddir)/include/version.h"; \
>  		##
> -		## We check the git version format we will use depending on
> -		## whether or not we are in the master branch or on a tag
> +		## Check whether we are in a git repo.
>  		##
> -		git_branch=3D"$$(git describe --all 2>/dev/null)"; \
> -		if [ -z "$${git_branch}" ]; then \
> -			git_version=3D""; \
> +		git_describe=3D"$$($(GIT_DESCRIBE_CMD) 2>/dev/null)"; \
> +		if [ $$? -eq 0 ]; then \
> +			git_version=3D"$${git_describe}"; \
>  		else \
> -			git_describe=3D"$$(git describe)"; \
> -			if [ "$${git_branch}" =3D=3D "$${git_describe}" ]; then \
> -				git_version=3D"$${git_describe}"; \
> -			else \
> -				git_version=3D"$$(git describe --long --all)"; \
> -			fi; \
> +			git_version=3D""; \
>  		fi; \
>  		##
>  		## If the version.h file doesn't exist or is not up to date,
> -		## We replace it by the version.h.tmpl file
> +		## We replace it by the version.h.tmpl file.
>  		##
>  		if [ ! -e "$${version_h}" ] || \
>  			[ "$${version_h_tmpl}" -nt "$${version_h}" ]; then \
>  			cp "$${version_h_tmpl}" "$${version_h}"; \
>  		fi; \
> -		if [ -n "$${git_version}" ]; then \
> -			##
> -			## We remove the leading "v" for the version number
> -			##
> -			git_version=3D"$$(echo "$${git_version}" | sed -r "s/^v([0-9])/\1/")"=
; \
> -			##
> -			## If we have a git version, we verify that it isn't the same
> -			## as the one currently in the file (if there is one), as we
> -			## don't want to update the file if it is already up to date
> -			##
> -			if [ $$(grep -cE "^#define GIT_VERSION_SED \"?$${git_version}\"?$$" "=
$${version_h}") -eq 0 ]; then \
> -				sed -i "s'^#define GIT_VERSION_SED.*$$'#define GIT_VERSION \"$${git_=
version}\"'" "$${version_h}"; \
> -			fi; \
> +		echo -n "git version: \"$${git_version}\""; \
> +		##
> +		## We verify that git_version isn't the same as the one
> +		## currently in the file (if there is one), as we don't
> +		## want to update the file if it is already up to date.
> +		##
> +		version_match=3D'^#define GIT_VERSION.*'; \
> +		old_version=3D$$(grep "$${version_match}" "$${version_h}"); \
> +		new_version=3D"#define GIT_VERSION	\"$${git_version}\""; \
> +		if [ x"$${old_version}" !=3D x"$${new_version}" ]; then \
> +			sed -i "s'$${version_match}'$${new_version}'" "$${version_h}"; \
> +		else \
> +			echo -n " (cached)"; \
>  		fi; \
> +		echo -n "... "; \
>  	fi)
>  	@echo "ok"
> =20
> @@ -58,6 +59,9 @@ version.h:
>  ##
>  .PHONY: version.h
> =20
> +nodist_noinst_HEADERS =3D \
> +	version.h
> +
>  lttnginclude_HEADERS =3D \
>  	lttng/health.h \
>  	lttng/lttng.h \
> @@ -71,7 +75,7 @@ lttnginclude_HEADERS =3D \
>  	lttng/snapshot.h \
>  	lttng/save.h \
>  	lttng/load.h \
> -	version.h
> +	version.h.tmpl
> =20
>  noinst_HEADERS =3D \
>  	lttng/snapshot-internal.h \
> diff --git a/include/version.h.tmpl b/include/version.h.tmpl
> index e2ce531..d3f3302 100644
> --- a/include/version.h.tmpl
> +++ b/include/version.h.tmpl
> @@ -1,3 +1,6 @@
> +#ifndef VERSION_H
> +#define VERSION_H
> +
>  /*
>   * Copyright (C) 2013-2014 - Rapha=EBl Beamonte <raphael.beamonte@gmail.=
com>
>   *
> @@ -17,15 +20,6 @@
> =20
>  #include <config.h>
> =20
> -#ifndef VERSION_H
> -#define VERSION_H
> -
> -#ifdef GIT_SOURCE
> -#define GIT_VERSION_PREFIX " - "
> -#define GIT_VERSION_SED ""
> -#else
> -#define GIT_VERSION_PREFIX ""
> -#define GIT_VERSION ""
> -#endif
> +#define GIT_VERSION	""
> =20
>  #endif /* VERSION_H */
> diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands/ve=
rsion.c
> index 4e46d72..f4d8963 100644
> --- a/src/bin/lttng/commands/version.c
> +++ b/src/bin/lttng/commands/version.c
> @@ -164,7 +164,8 @@ int cmd_version(int argc, const char **argv)
>  	if (lttng_opt_mi) {
>  		ret =3D print_mi();
>  	} else {
> -		MSG("lttng version " VERSION " - " VERSION_NAME GIT_VERSION_PREFIX GIT=
_VERSION);
> +		MSG("lttng version " VERSION " - " VERSION_NAME "%s",
> +			GIT_VERSION[0] =3D=3D '\0' ? "" : " - " GIT_VERSION);
>  		MSG("\n" VERSION_DESCRIPTION "\n");
>  		MSG("Web site: http://lttng.org");
>  		MSG("\n%s", lttng_license);
> diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
> index 41232be..2df8b87 100644
> --- a/src/bin/lttng/lttng.c
> +++ b/src/bin/lttng/lttng.c
> @@ -90,7 +90,8 @@ static struct cmd_struct commands[] =3D  {
> =20
>  static void usage(FILE *ofp)
>  {
> -	fprintf(ofp, "LTTng Trace Control " VERSION " - " VERSION_NAME" - " GIT=
_VERSION "\n\n");
> +	fprintf(ofp, "LTTng Trace Control " VERSION " - " VERSION_NAME "%s\n\n",
> +		GIT_VERSION[0] =3D=3D '\0' ? "" : " - " GIT_VERSION);
>  	fprintf(ofp, "usage: lttng [OPTIONS] <COMMAND> [<ARGS>]\n");
>  	fprintf(ofp, "\n");
>  	fprintf(ofp, "Options:\n");
> @@ -134,8 +135,9 @@ static void usage(FILE *ofp)
> =20
>  static void version(FILE *ofp)
>  {
> -	fprintf(ofp, "%s (LTTng Trace Control) " VERSION" - " VERSION_NAME" - "=
 GIT_VERSION "\n",
> -			progname);
> +	fprintf(ofp, "%s (LTTng Trace Control) " VERSION" - " VERSION_NAME "%s\=
n",
> +			progname,
> +			GIT_VERSION[0] =3D=3D '\0' ? "" : " - " GIT_VERSION);
>  }
> =20
>  /*
> --=20
> 2.0.1
>=20

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJT2OoSXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I024RgIAJwcM9dw8VSb8pVaA/X7Q003
HVoIUYooD2INJaBZe6N6BFhypxa5sMNiQyt/WYKZTNxiPqFrtywMrZwBjP0ElVcf
S7yTHM47iRQ9QbrwI6kPm/ppa5cd35XVggIkjrbCg3Ab25YvhheIEBGz3ZrkFuOX
GAp+wuuYlxWSJQOWMrLbJYx3d+pG3tfReTUVNuii5AyLfcah8X6OtI4jra5oI7/h
HhsKbf16/I7mrg/HXMuhC2zYEtf+0n3eTfQu5trRK3sd8jdV0B8Zm69MXE1hW8Su
Z+BEZTXzVZv5Bhgu1w7Z/4EPzoD1HF/QWlFsj77mBx9V6DofuIK7bZGtDa+ElzQ=
=+LfA
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--


--===============1781883583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1781883583==--
