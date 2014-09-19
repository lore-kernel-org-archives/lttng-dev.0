From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] sessiond: add
 --extra-kmod-probes option
Date: Fri, 19 Sep 2014 12:13:57 -0400
Message-ID: <20140919161357.GA21729__26141.0464918756$1411143315$gmane$org@dalia>
References: <1410572238-5924-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1748112897=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from albert.ini-tech.com ([192.99.35.19] helo=smtp.ini-tech.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1XV0ov-0001Q1-Gw
 for lttng-dev@lists.lttng.org; Fri, 19 Sep 2014 12:14:11 -0400
In-Reply-To: <1410572238-5924-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============1748112897==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

Small fixes of the syntax in the commit.

David

On 12 Sep (21:37:18), Philippe Proulx wrote:
> This patch adds the --extra-kmod-probes option to
> lttng-sessiond. The LTTNG_EXTRA_KMOD_PROBES environment
> variable may also be used.
>=20
> The option specifies a list of extra probe kernel modules
> to be loaded (and unloaded) by lttng-sessiond. The list
> is appended to either the default list or to the
> user-supplied --kmod-probes list.
>=20
> This option is especially useful for kernel developers who
> need the default LTTng kernel probes plus additional probes
> in order to instrument their custom kernel or module. This
> becomes easy with --extra-kmod-probes:
>=20
>     lttng-sessiond --extra-kmod-probes=3Dcustom_subsys,other
>=20
> would load all known and available LTTng kernel probes plus
> lttng_probe_custom_subsys and lttng_probe_other.
>=20
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
>  doc/man/lttng-sessiond.8          |   8 ++
>  src/bin/lttng-sessiond/main.c     |  10 ++
>  src/bin/lttng-sessiond/modprobe.c | 202 +++++++++++++++++++++++++++++---=
------
>  src/bin/lttng-sessiond/modprobe.h |   1 +
>  src/common/defaults.h             |   3 +
>  src/common/utils.c                |  12 ++-
>  src/common/utils.h                |   1 +
>  7 files changed, 192 insertions(+), 45 deletions(-)
>=20
> diff --git a/doc/man/lttng-sessiond.8 b/doc/man/lttng-sessiond.8
> index 212b743..9cd148e 100644
> --- a/doc/man/lttng-sessiond.8
> +++ b/doc/man/lttng-sessiond.8
> @@ -86,6 +86,12 @@ Specify the kernel modules containing LTTng probes to =
load by the session daemon
>  Only the component name of the probe needs to be specified, e.g. to load=
 the
>  lttng-probe-irq and lttng-probe-sched use: --kmod-probes=3D"irq, sched".
>  .TP
> +.BR "    --extra-kmod-probes=3Dprobe1, probe2, ..."
> +Specify extra kernel modules containing LTTng probes to be loaded by the=
 session
> +daemon. The list follows the format of the \fB--kmod-probes\fP option.
> +This list is appended to the list provided by \fB--kmod-probes\fP or, if
> +\fB--kmod-probes\fP is missing, to the default list of probes.
> +.TP
>  .BR "-c, --client-sock=3DPATH"
>  Specify path for the client unix socket
>  .TP
> @@ -175,6 +181,8 @@ the timeout of the operating system (this is the defa=
ult).
>  Specify the path that contains the XML session configuration schema (xsd=
).
>  .IP "LTTNG_KMOD_PROBES"
>  Specify the kernel modules probes that should be loaded by the session d=
aemon.
> +.IP "LTTNG_EXTRA_KMOD_PROBES"
> +Specify extra kernel modules probes that should be loaded by the session=
 daemon.
>  .SH "SEE ALSO"
> =20
>  .PP
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index c7fc178..2a97c37 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -157,6 +157,7 @@ static const struct option long_options[] =3D {
>  	{ "config", 1, 0, 'f' },
>  	{ "load", 1, 0, 'l' },
>  	{ "kmod-probes", 1, 0, 'P' },
> +	{ "extra-kmod-probes", 1, 0, 'e' },
>  	{ NULL, 0, 0, 0 }
>  };
> =20
> @@ -4214,6 +4215,7 @@ static void usage(void)
>  	fprintf(stderr, "  -f  --config                       Load daemon confi=
guration file\n");
>  	fprintf(stderr, "  -l  --load PATH                    Load session conf=
iguration\n");
>  	fprintf(stderr, "      --kmod-probes                  Specify kernel mo=
dule probes to load\n");
> +	fprintf(stderr, "      --extra-kmod-probes            Specify extra ker=
nel module probes to load\n");
>  }
> =20
>  /*
> @@ -4400,6 +4402,14 @@ static int set_option(int opt, const char *arg, co=
nst char *optname)
>  			ret =3D -ENOMEM;
>  		}
>  		break;
> +	case 'e':
> +		free(kmod_extra_probes_list);
> +		kmod_extra_probes_list =3D strdup(arg);
> +		if (!kmod_extra_probes_list) {
> +			perror("strdup");
> +			ret =3D -ENOMEM;
> +		}
> +		break;
>  	case 'f':
>  		/* This is handled in set_options() thus silent break. */
>  		break;
> diff --git a/src/bin/lttng-sessiond/modprobe.c b/src/bin/lttng-sessiond/m=
odprobe.c
> index adad7bf..2a0b66a 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -95,6 +95,7 @@ struct kern_modules_param kern_modules_probes_default[]=
 =3D {
>  /* dynamic probe modules list */
>  static struct kern_modules_param *probes;
>  static int nr_probes;
> +static int probes_capacity;
> =20
>  void modprobe_remove_lttng(const struct kern_modules_param *modules,
>  			   int entries, int required)
> @@ -122,8 +123,6 @@ void modprobe_remove_lttng(const struct kern_modules_=
param *modules,
>  			DBG("Modprobe removal successful %s",
>  					modules[i].name);
>  		}
> -		if (probes)
> -			free(probes[i].name);
>  	}
>  }
> =20
> @@ -145,14 +144,18 @@ void modprobe_remove_lttng_control(void)
>   */
>  void modprobe_remove_lttng_data(void)
>  {
> +	int i;
> +
>  	if (probes) {
>  		modprobe_remove_lttng(probes, nr_probes, LTTNG_MOD_OPTIONAL);
> +
> +		for (i =3D 0; i < nr_probes; ++i) {
> +			free(probes[i].name);
> +		}
> +
>  		free(probes);
>  		probes =3D NULL;
> -	} else
> -		modprobe_remove_lttng(kern_modules_probes_default,
> -				      ARRAY_SIZE(kern_modules_probes_default),
> -				      LTTNG_MOD_OPTIONAL);
> +	}
>  }
> =20
>  /*
> @@ -280,72 +283,183 @@ int modprobe_lttng_control(void)
>  	return ret;
>  }
> =20
> -/*
> - * Load data kernel module(s).
> +/**
> + * Grow global list of probes (double capacity or set it to 1 if
> + * currently 0 and copy existing data).
>   */
> -int modprobe_lttng_data(void)
> +static int grow_probes(void)
>  {
> -	int i, ret;
> -	int entries =3D ARRAY_SIZE(kern_modules_probes_default);
> -	char *list, *next;
> +	int i;
> =20
> -	/*
> -	 * First take command line option, if not available take environment
> -	 * variable.
> -	 */
> -	if (kmod_probes_list) {
> -		list =3D kmod_probes_list;
> -	} else {
> -		list =3D utils_get_kmod_probes_list();
> -	}
> -	/* The default is to load ALL probes */
> -	if (!list) {
> -		return modprobe_lttng(kern_modules_probes_default, entries,
> -				LTTNG_MOD_OPTIONAL);
> +	/* Initialize capacity to 1 if 0. */
> +	if (probes_capacity =3D=3D 0) {
> +		probes =3D zmalloc(sizeof(*probes));
> +
> +		if (!probes) {
> +			PERROR("malloc probe list");
> +			return -ENOMEM;
> +		}
> +
> +		probes_capacity =3D 1;
> +
> +		return 0;
>  	}
> =20
> -	/*
> -	 * A probe list is available, so use it.
> -	 * The number of probes is limited by the number of probes in the
> -	 * default list.
> -	 */
> -	probes =3D zmalloc(sizeof(struct kern_modules_param *) * entries);
> -	if (!probes) {
> +	/* Double size. */
> +	probes_capacity *=3D 2;
> +
> +	struct kern_modules_param *tmp_probes =3D
> +		zmalloc(sizeof(*tmp_probes) * probes_capacity);
> +
> +	if (!tmp_probes) {
>  		PERROR("malloc probe list");
>  		return -ENOMEM;
>  	}
> =20
> -	for (i =3D 0; i < entries; i++) {
> -		size_t name_len;
> +	for (i =3D 0; i < nr_probes; ++i) {
> +		/* Move name pointer. */
> +		tmp_probes[i].name =3D probes[i].name;
> +	}
> +
> +	/* Replace probes with larger copy. */
> +	free(probes);
> +	probes =3D tmp_probes;
> =20
> -		next =3D strtok(list, ",");
> +	return 0;
> +}
> +
> +/*
> + * Appends a comma-separated list of probes to the global list
> + * of probes.
> + */
> +static int append_list_to_probes(const char* list)
> +{
> +	char *next;
> +	int ret;
> +	int at =3D nr_probes;
> +
> +	char* tmp_list =3D strdup(list);
> +
> +	if (!tmp_list) {
> +		PERROR("strdup temp list");
> +		return -ENOMEM;
> +	}
> +
> +	for (;;) {
> +		next =3D strtok(tmp_list, ",");
>  		if (!next) {
> -			goto out;
> +			break;
>  		}
> -		list =3D NULL;
> +		tmp_list =3D NULL;
> =20
>  		/* filter leading spaces */
>  		while (*next =3D=3D ' ') {
>  			next++;
>  		}
> =20
> +		if (probes_capacity <=3D nr_probes) {
> +			ret =3D grow_probes();
> +
> +			if (ret) {
> +				return ret;
> +			}
> +		}
> +
>  		/* Length 13 is "lttng-probe-" + \0 */
> -		name_len =3D strlen(next) + 13;
> +		size_t name_len =3D strlen(next) + 13;
> +
> +		struct kern_modules_param *cur =3D &probes[at];
> =20
> -		probes[i].name =3D zmalloc(name_len);
> -		if (!probes[i].name) {
> +		cur->name =3D zmalloc(name_len);
> +		if (!cur->name) {
>  			PERROR("malloc probe list");
>  			return -ENOMEM;
>  		}
> =20
> -		ret =3D snprintf(probes[i].name, name_len, "lttng-probe-%s", next);
> +		ret =3D snprintf(cur->name, name_len, "lttng-probe-%s", next);
> +
>  		if (ret < 0) {
>  			PERROR("snprintf modprobe name");
> -			goto out;
> +			return -ENOMEM;
> +		}
> +
> +		at++;
> +		nr_probes++;
> +	}
> +
> +	free(tmp_list);
> +
> +	return 0;
> +}
> +
> +/*
> + * Load data kernel module(s).
> + */
> +int modprobe_lttng_data(void)
> +{
> +	int ret, i;
> +	char *list;
> +
> +	/*
> +	 * Base probes: either from command line option, environment
> +	 * variable or default list.
> +	 */
> +	if (kmod_probes_list) {
> +		list =3D kmod_probes_list;
> +	} else {
> +		list =3D utils_get_kmod_probes_list();
> +	}
> +
> +	if (list) {
> +		/* User-specified probes. */
> +		ret =3D append_list_to_probes(list);
> +
> +		if (ret) {
> +			return ret;
> +		}
> +	} else {
> +		/* Default probes. */
> +		int def_len =3D ARRAY_SIZE(kern_modules_probes_default);
> +		probes =3D zmalloc(sizeof(*probes) * def_len);
> +
> +		if (!probes) {
> +			PERROR("malloc probe list");
> +			return -ENOMEM;
> +		}
> +
> +		nr_probes =3D probes_capacity =3D def_len;
> +
> +		for (i =3D 0; i < def_len; ++i) {
> +			char* name =3D strdup(kern_modules_probes_default[i].name);
> +
> +			if (!name) {
> +				PERROR("strdup probe item");
> +				return -ENOMEM;
> +			}
> +
> +			probes[i].name =3D name;
>  		}
>  	}
> =20
> -out:
> -	nr_probes =3D i;
> +	/*
> +	 * Extra modules? Append them to current probes list.
> +	 */
> +	if (kmod_extra_probes_list) {
> +		list =3D kmod_extra_probes_list;
> +	} else {
> +		list =3D utils_get_extra_kmod_probes_list();
> +	}
> +
> +	if (list) {
> +		ret =3D append_list_to_probes(list);
> +
> +		if (ret) {
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * Load probes modules now.
> +	 */
>  	return modprobe_lttng(probes, nr_probes, LTTNG_MOD_OPTIONAL);
>  }
> diff --git a/src/bin/lttng-sessiond/modprobe.h b/src/bin/lttng-sessiond/m=
odprobe.h
> index 42e1912..cc44160 100644
> --- a/src/bin/lttng-sessiond/modprobe.h
> +++ b/src/bin/lttng-sessiond/modprobe.h
> @@ -25,5 +25,6 @@ int modprobe_lttng_control(void);
>  int modprobe_lttng_data(void);
> =20
>  char *kmod_probes_list;
> +char *kmod_extra_probes_list;
> =20
>  #endif /* _MODPROBE_H */
> diff --git a/src/common/defaults.h b/src/common/defaults.h
> index 88f7fe8..25d7b32 100644
> --- a/src/common/defaults.h
> +++ b/src/common/defaults.h
> @@ -94,6 +94,9 @@
>  /* Default probes list */
>  #define DEFAULT_LTTNG_KMOD_PROBES		"LTTNG_KMOD_PROBES"
> =20
> +/* Default extra probes list */
> +#define DEFAULT_LTTNG_EXTRA_KMOD_PROBES		"LTTNG_EXTRA_KMOD_PROBES"
> +
>  /* Default unix socket path */
>  #define DEFAULT_GLOBAL_CLIENT_UNIX_SOCK         DEFAULT_LTTNG_RUNDIR "/c=
lient-lttng-sessiond"
>  #define DEFAULT_HOME_CLIENT_UNIX_SOCK           DEFAULT_LTTNG_HOME_RUNDI=
R "/client-lttng-sessiond"
> diff --git a/src/common/utils.c b/src/common/utils.c
> index ff6d1c2..1d07cb3 100644
> --- a/src/common/utils.c
> +++ b/src/common/utils.c
> @@ -927,7 +927,7 @@ end:
> =20
>  /*
>   * Obtain the value of LTTNG_KMOD_PROBES environment variable, if exists.
> - * Otherwise returns an empty string.
> + * Otherwise returns NULL.
>   */
>  LTTNG_HIDDEN
>  char *utils_get_kmod_probes_list(void)
> @@ -936,6 +936,16 @@ char *utils_get_kmod_probes_list(void)
>  }
> =20
>  /*
> + * Obtain the value of LTTNG_EXTRA_KMOD_PROBES environment variable, if
> + * exists. Otherwise returns NULL.
> + */
> +LTTNG_HIDDEN
> +char *utils_get_extra_kmod_probes_list(void)
> +{
> +	return getenv(DEFAULT_LTTNG_EXTRA_KMOD_PROBES);
> +}
> +
> +/*
>   * With the given format, fill dst with the time of len maximum siz.
>   *
>   * Return amount of bytes set in the buffer or else 0 on error.
> diff --git a/src/common/utils.h b/src/common/utils.h
> index bdc0e14..537fe0f 100644
> --- a/src/common/utils.h
> +++ b/src/common/utils.h
> @@ -48,6 +48,7 @@ int utils_get_count_order_u32(uint32_t x);
>  char *utils_get_home_dir(void);
>  char *utils_get_user_home_dir(uid_t uid);
>  char *utils_get_kmod_probes_list(void);
> +char *utils_get_extra_kmod_probes_list(void);
>  size_t utils_get_current_time_str(const char *format, char *dst, size_t =
len);
>  gid_t utils_get_group_id(const char *name);
>  char *utils_generate_optstring(const struct option *long_options,
> --=20
> 2.1.0
>=20
>=20
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJUHFZFXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02QQAIAMWLgtJS4MbZDEO3PV+mbYCN
UItd3WAWsw6cSsiLvQoaawE56y7xMF7cLoyRah9HsQJkc0cEdC6bjt9VrO9ZnHyY
tLpg9a2yKgZ6529R86ooLxwOr2No19BWL7iRjaj/UZyTeYH53T8w4N8vCeBcC12k
dnVkJrMaa9OaPSVJc6mzKryV4KpCiWBff3cLboACU5QGzYb9oh7u37CFOrzAweYC
tP6IjCe7rfgNFE0KLmUHmjFebY5XDvMJLZsVYcyCeoDfit8CvikrS8CcUEW5ukaw
Hw/hXPZqBOx48W5gjsqNzdB7vJ5iElK6k5hrZ5doYoCosUTap31Q55phgAGMieU=
=z7BE
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


--===============1748112897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1748112897==--
