From: David Goulet <dgoulet@efficios.com>
Subject: Re: [MI RFC 1/3] Mi: mi backend + mi for command version
Date: Mon, 14 Apr 2014 11:26:31 -0400
Message-ID: <20140414152631.GA32712__30669.5713349201$1397489277$gmane$org@thessa>
References: <20140406193032.GA24869@psrcode-MS-7693>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0671935944=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WZimS-0001up-DS
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 11:26:52 -0400
In-Reply-To: <20140406193032.GA24869@psrcode-MS-7693>
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


--===============0671935944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've fixed some minor things and prepared this one for a merge.

Once the full patch set is ready to be merged, I'll be pushing them all
at once.

Thanks!
David

On 06 Apr (15:30:32), Jonathan Rajotte wrote:
> Hi,
>=20
> These patches add machine interface functionality to command version and =
list.
> At the same time they procure a base architecture of the machine
> interface.
>=20
> The first patch cover the version command and add the base for the
> machine interface.(mostly the same as last week mi patch)
> p.s: David if you want to pull this one [1].
>=20
> The second patch provide full machine interface functionality to the list
> command. You will find attached a little script that demonstrate the mi
> functionality of list. The script need a root sessiond and need to be
> at the base of lttng-tool directory. Outputs will be generated in
> ./mi_test_output/ .
>=20
> The third patch provide an xsd to validate the mi output of list and
> version command.
>=20
> Voil=E0!
>=20
> Jonathan
>=20
> [1] https://github.com/PSRCode/lttng-tools-dev/commits/list_release
>     commit: add4aa1a79247749cb823ec68ab1067beda937d0
> --Patch--
>=20
> The machine interface option is now available for version.
> Other commands will shortly follow.
> Mi backend is expected to grow with addition of mi support
> to other commands.
>=20
> How to use:
> 	lttng --mi <mi_output_type> <command>
>=20
> This syntax will be the same for all commands.
> Currently *only xml is supported as machine interface output.*
>=20
> As for errors handling, if an error/warning occurs while using mi it will=
 be
> reported on stderr as normal. The integrity of the mi output cannot be
> guaranteed if an error/warning occurs.
> The error output format is consistent and easy for a machine client to pa=
rse.
> Thus no mi output format is required for error output.
>=20
> Example:
> 	lttng --mi xml version
> Output:
> <?xml version=3D"1.0" encoding=3D"UTF-8"?>
>   <command>
>     <name>version</name>
>     <output>
>       <string>2.4.0-rc2</string>
>       <major>2</major>
>       <minor>4</minor>
>       <patchLevel>0</patchLevel>
>       <name>=C9poque Opaque</name>
>       <description>The =C9poque Opaque is a black IPA from Trou du Diable
>       brewery. The nose is eerily reminiscent of the coffee crisp candy f=
rom
>       of our childhood. These strong mocha accents are present on the pal=
ate,
>       which are quickly subdued by Japanese and Australian hops leading t=
o a
>       final state of satisfaction enjoyable for any fan of bitter
>       beer.</description>
>       <url>http://lttng.org</url>
>       <license>lttng is free software and under the GPL license and part
>       LGPL</license>
>   </output>
> </command>
>=20
> Signed-off-by: Olivier Cotte <olivier.cotte@polymtl.ca>
> Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> ---
>  include/lttng/lttng-error.h               |   6 +-
>  include/lttng/lttng.h                     |   5 +
>  src/bin/lttng-consumerd/lttng-consumerd.c |   2 +
>  src/bin/lttng/commands/add_context.c      |   7 +
>  src/bin/lttng/commands/calibrate.c        |   7 +
>  src/bin/lttng/commands/create.c           |   7 +
>  src/bin/lttng/commands/destroy.c          |   7 +
>  src/bin/lttng/commands/disable_channels.c |   7 +
>  src/bin/lttng/commands/disable_events.c   |   7 +
>  src/bin/lttng/commands/enable_channels.c  |   7 +
>  src/bin/lttng/commands/enable_events.c    |   7 +
>  src/bin/lttng/commands/list.c             |   7 +
>  src/bin/lttng/commands/load.c             |   7 +
>  src/bin/lttng/commands/save.c             |   7 +
>  src/bin/lttng/commands/set_session.c      |   7 +
>  src/bin/lttng/commands/snapshot.c         |   7 +
>  src/bin/lttng/commands/start.c            |   7 +
>  src/bin/lttng/commands/stop.c             |   7 +
>  src/bin/lttng/commands/version.c          |  88 ++++++++-
>  src/bin/lttng/commands/view.c             |   4 +
>  src/bin/lttng/lttng.c                     |  32 +++-
>  src/common/Makefile.am                    |   5 +-
>  src/common/error.h                        |  11 +-
>  src/common/mi-lttng.c                     | 284 ++++++++++++++++++++++++=
++++++
>  src/common/mi-lttng.h                     | 230 ++++++++++++++++++++++++
>  src/lib/lttng-ctl/lttng-ctl.c             |   1 +
>  tests/unit/ini_config/ini_config.c        |   1 +
>  tests/unit/test_kernel_data.c             |   1 +
>  tests/unit/test_session.c                 |   1 +
>  tests/unit/test_uri.c                     |   1 +
>  tests/unit/test_ust_data.c                |   1 +
>  tests/unit/test_utils_expand_path.c       |   1 +
>  tests/unit/test_utils_parse_size_suffix.c |   1 +
>  33 files changed, 769 insertions(+), 11 deletions(-)
>  create mode 100644 src/common/mi-lttng.c
>  create mode 100644 src/common/mi-lttng.h
>=20
> diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
> index 06baa04..1594ba9 100644
> --- a/include/lttng/lttng-error.h
> +++ b/include/lttng/lttng-error.h
> @@ -120,9 +120,9 @@ enum lttng_error_code {
>  	LTTNG_ERR_LOAD_INVALID_CONFIG    =3D 87,  /* Invalid session configurat=
ion */
>  	LTTNG_ERR_LOAD_IO_FAIL           =3D 88,  /* IO error while reading a s=
ession configuration */
>  	LTTNG_ERR_LOAD_SESSION_NOENT     =3D 89,  /* Session file not found */
> -	/* 90 */
> -	/* 91 */
> -	/* 92 */
> +	LTTNG_ERR_MI_OUTPUT_TYPE         =3D 90, /* Invalid MI output format */
> +	LTTNG_ERR_MI_IO_FAIL             =3D 91, /* IO error while writing mach=
ine interface output */
> +	LTTNG_ERR_MI_NOT_IMPLEMENTED     =3D 92, /* Mi feature not implemented =
*/
>  	/* 93 */
>  	/* 94 */
>  	/* 95 */
> diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
> index f0be224..9449161 100644
> --- a/include/lttng/lttng.h
> +++ b/include/lttng/lttng.h
> @@ -170,6 +170,11 @@ enum lttng_buffer_type {
>  	LTTNG_BUFFER_GLOBAL,	/* Only supported by the Kernel. */
>  };
> =20
> +/* Machine interface output type */
> +enum lttng_mi_output_type {
> +	LTTNG_MI_XML                          =3D 1 /* XML output */
> +};
> +
>  /*
>   * The structures should be initialized to zero before use.
>   */
> diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-co=
nsumerd/lttng-consumerd.c
> index e226ebc..0ce163e 100644
> --- a/src/bin/lttng-consumerd/lttng-consumerd.c
> +++ b/src/bin/lttng-consumerd/lttng-consumerd.c
> @@ -65,6 +65,8 @@ static int sigintcount =3D 0;
>  /* Argument variables */
>  int lttng_opt_quiet;    /* not static in error.h */
>  int lttng_opt_verbose;  /* not static in error.h */
> +int lttng_opt_mi;       /* not static in error.h */
> +
>  static int opt_daemon;
>  static const char *progname;
>  static char command_sock_path[PATH_MAX]; /* Global command socket path */
> diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/command=
s/add_context.c
> index 6483c98..2eb0e90 100644
> --- a/src/bin/lttng/commands/add_context.c
> +++ b/src/bin/lttng/commands/add_context.c
> @@ -446,6 +446,13 @@ int cmd_add_context(int argc, const char **argv)
>  		goto end;
>  	}
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> diff --git a/src/bin/lttng/commands/calibrate.c b/src/bin/lttng/commands/=
calibrate.c
> index 092632c..7d4de29 100644
> --- a/src/bin/lttng/commands/calibrate.c
> +++ b/src/bin/lttng/commands/calibrate.c
> @@ -133,6 +133,13 @@ static int calibrate_lttng(void)
>  		goto error;
>  	}
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto error;
> +	}
> +
>  	handle =3D lttng_create_handle(NULL, &dom);
>  	if (handle =3D=3D NULL) {
>  		ret =3D CMD_ERROR;
> diff --git a/src/bin/lttng/commands/create.c b/src/bin/lttng/commands/cre=
ate.c
> index e02b141..c43ce59 100644
> --- a/src/bin/lttng/commands/create.c
> +++ b/src/bin/lttng/commands/create.c
> @@ -515,6 +515,13 @@ int cmd_create(int argc, const char **argv)
>  		}
>  	}
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	if (opt_no_consumer) {
>  		MSG("The option --no-consumer is obsolete. Use --no-output now.");
>  		ret =3D CMD_WARNING;
> diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/de=
stroy.c
> index 3fb5fb2..26548b9 100644
> --- a/src/bin/lttng/commands/destroy.c
> +++ b/src/bin/lttng/commands/destroy.c
> @@ -148,6 +148,13 @@ int cmd_destroy(int argc, const char **argv)
>  		goto end;
>  	}
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	/* Ignore session name in case all sessions are to be destroyed */
>  	if (opt_destroy_all) {
>  		ret =3D destroy_all_sessions();
> diff --git a/src/bin/lttng/commands/disable_channels.c b/src/bin/lttng/co=
mmands/disable_channels.c
> index 1aa3916..da53d25 100644
> --- a/src/bin/lttng/commands/disable_channels.c
> +++ b/src/bin/lttng/commands/disable_channels.c
> @@ -167,6 +167,13 @@ int cmd_disable_channels(int argc, const char **argv)
>  		}
>  	}
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	opt_channels =3D (char*) poptGetArg(pc);
>  	if (opt_channels =3D=3D NULL) {
>  		ERR("Missing channel name(s).\n");
> diff --git a/src/bin/lttng/commands/disable_events.c b/src/bin/lttng/comm=
ands/disable_events.c
> index e712343..fb96b80 100644
> --- a/src/bin/lttng/commands/disable_events.c
> +++ b/src/bin/lttng/commands/disable_events.c
> @@ -212,6 +212,13 @@ int cmd_disable_events(int argc, const char **argv)
>  		}
>  	}
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	opt_event_list =3D (char*) poptGetArg(pc);
>  	if (opt_event_list =3D=3D NULL && opt_disable_all =3D=3D 0) {
>  		ERR("Missing event name(s).\n");
> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/com=
mands/enable_channels.c
> index 55fbae6..8ea405e 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -327,6 +327,13 @@ int cmd_enable_channels(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/comma=
nds/enable_events.c
> index bd2d997..8c7a73e 100644
> --- a/src/bin/lttng/commands/enable_events.c
> +++ b/src/bin/lttng/commands/enable_events.c
> @@ -968,6 +968,13 @@ int cmd_enable_events(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	/* Default event type */
>  	opt_event_type =3D LTTNG_EVENT_ALL;
> =20
> diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
> index f69b3ba..bbd674c 100644
> --- a/src/bin/lttng/commands/list.c
> +++ b/src/bin/lttng/commands/list.c
> @@ -850,6 +850,13 @@ int cmd_list(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/commands/load.c b/src/bin/lttng/commands/load.c
> index e732baa..2cfc698 100644
> --- a/src/bin/lttng/commands/load.c
> +++ b/src/bin/lttng/commands/load.c
> @@ -77,6 +77,13 @@ int cmd_load(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, load_opts, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/commands/save.c b/src/bin/lttng/commands/save.c
> index e8a4565..1aeb9f2 100644
> --- a/src/bin/lttng/commands/save.c
> +++ b/src/bin/lttng/commands/save.c
> @@ -73,6 +73,13 @@ int cmd_save(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, save_opts, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/commands/set_session.c b/src/bin/lttng/command=
s/set_session.c
> index 4238016..54320df 100644
> --- a/src/bin/lttng/commands/set_session.c
> +++ b/src/bin/lttng/commands/set_session.c
> @@ -92,6 +92,13 @@ int cmd_set_session(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/commands/s=
napshot.c
> index c704eee..21b5a05 100644
> --- a/src/bin/lttng/commands/snapshot.c
> +++ b/src/bin/lttng/commands/snapshot.c
> @@ -446,6 +446,13 @@ int cmd_snapshot(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, snapshot_opts, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/commands/start.c b/src/bin/lttng/commands/star=
t.c
> index 82122cc..82b3f5f 100644
> --- a/src/bin/lttng/commands/start.c
> +++ b/src/bin/lttng/commands/start.c
> @@ -118,6 +118,13 @@ int cmd_start(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/commands/stop.c b/src/bin/lttng/commands/stop.c
> index 60a1dac..5de96d8 100644
> --- a/src/bin/lttng/commands/stop.c
> +++ b/src/bin/lttng/commands/stop.c
> @@ -122,6 +122,13 @@ int cmd_stop(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	/* TODO: mi support */
> +	if (lttng_opt_mi) {
> +		ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> +		ERR("mi option not supported");
> +		goto end;
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands/ve=
rsion.c
> index 7f69de3..5c7ebbf 100644
> --- a/src/bin/lttng/commands/version.c
> +++ b/src/bin/lttng/commands/version.c
> @@ -25,6 +25,8 @@
>  #include <unistd.h>
>  #include <config.h>
> =20
> +#include <common/mi-lttng.h>
> +
>  #include "../command.h"
> =20
>  enum {
> @@ -32,6 +34,8 @@ enum {
>  	OPT_LIST_OPTIONS,
>  };
> =20
> +static const char *lttng_license =3D "lttng is free software and under t=
he GPL license and part LGPL";
> +
>  static struct poptOption long_options[] =3D {
>  	/* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
>  	{"help",      'h', POPT_ARG_NONE, 0, OPT_HELP, 0, 0},
> @@ -53,6 +57,78 @@ static void usage(FILE *ofp)
>  }
> =20
>  /*
> + *  create_version
> + */
> +static void create_version(struct mi_lttng_version *version)
> +{
> +	strncpy(version->version, VERSION, NAME_MAX);
> +	version->version_major =3D VERSION_MAJOR;
> +	version->version_minor =3D VERSION_MINOR;
> +	version->version_patchlevel =3D VERSION_PATCHLEVEL;
> +	strncpy(version->version_name, VERSION_NAME, NAME_MAX);
> +	strncpy(version->package_url, PACKAGE_URL, NAME_MAX);
> +}
> +
> +/*
> + *  print_mi
> + */
> +static int print_mi()
> +{
> +	int ret;
> +	struct mi_writer *writer =3D NULL;
> +	struct mi_lttng_version version;
> +
> +	create_version(&version);
> +
> +	writer =3D mi_lttng_writer_create(fileno(stdout), lttng_opt_mi);
> +
> +	if (!writer) {
> +		ret =3D -LTTNG_ERR_NOMEM;
> +		goto end;
> +	}
> +
> +	/* Open the command element */
> +	ret =3D mi_lttng_writer_command_open(writer,
> +			mi_lttng_element_command_version);
> +	if (ret) {
> +		goto error;
> +	}
> +
> +	/* Beginning of output */
> +	ret =3D mi_lttng_writer_open_element(writer,
> +			mi_lttng_element_command_output);
> +	if (ret) {
> +		goto error;
> +	}
> +
> +	/* Print the machine interface of version */
> +	ret =3D mi_lttng_version(writer, &version,
> +			VERSION_DESCRIPTION, lttng_license);
> +	if (ret) {
> +		goto error;
> +	}
> +
> +	/* Close the output element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +	if (ret) {
> +		goto error;
> +	}
> +
> +	/* Close the command  */
> +	ret =3D mi_lttng_writer_command_close(writer);
> +
> +error:
> +	/* Cleanup */
> +	if (writer && mi_lttng_writer_destroy(writer)) {
> +		/* Preserve original error code */
> +		ret =3D ret ? ret : LTTNG_ERR_MI_IO_FAIL;
> +	}
> +
> +end:
> +	return ret;
> +}
> +
> +/*
>   *  cmd_version
>   */
>  int cmd_version(int argc, const char **argv)
> @@ -78,10 +154,14 @@ int cmd_version(int argc, const char **argv)
>  		}
>  	}
> =20
> -	MSG("lttng version " VERSION " - " VERSION_NAME);
> -	MSG("\n" VERSION_DESCRIPTION "\n");
> -	MSG("Web site: http://lttng.org");
> -	MSG("\nlttng is free software and under the GPL license and part LGPL");
> +	if (lttng_opt_mi) {
> +		ret =3D print_mi();
> +	} else {
> +		MSG("lttng version " VERSION " - " VERSION_NAME);
> +		MSG("\n" VERSION_DESCRIPTION "\n");
> +		MSG("Web site: http://lttng.org");
> +		MSG("\n%s", lttng_license);
> +	}
> =20
>  end:
>  	poptFreeContext(pc);
> diff --git a/src/bin/lttng/commands/view.c b/src/bin/lttng/commands/view.c
> index adedf29..dcd4d66 100644
> --- a/src/bin/lttng/commands/view.c
> +++ b/src/bin/lttng/commands/view.c
> @@ -445,6 +445,10 @@ int cmd_view(int argc, const char **argv)
>  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
>  	poptReadDefaultConfig(pc, 0);
> =20
> +	if (lttng_opt_mi) {
> +		WARN("mi does not apply to view command");
> +	}
> +
>  	while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
>  		switch (opt) {
>  		case OPT_HELP:
> diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
> index bc7577d..4510057 100644
> --- a/src/bin/lttng/lttng.c
> +++ b/src/bin/lttng/lttng.c
> @@ -55,6 +55,7 @@ static struct option long_options[] =3D {
>  	{"group",            1, NULL, 'g'},
>  	{"verbose",          0, NULL, 'v'},
>  	{"quiet",            0, NULL, 'q'},
> +	{"mi",               1, NULL, 'm'},
>  	{"no-sessiond",      0, NULL, 'n'},
>  	{"sessiond-path",    1, NULL, OPT_SESSION_PATH},
>  	{"relayd-path",      1, NULL, OPT_RELAYD_PATH},
> @@ -99,6 +100,8 @@ static void usage(FILE *ofp)
>  	fprintf(ofp, "      --list-commands        Simple listing of lttng comm=
ands\n");
>  	fprintf(ofp, "  -v, --verbose              Increase verbosity\n");
>  	fprintf(ofp, "  -q, --quiet                Quiet mode\n");
> +	fprintf(ofp, "  -m, --mi TYPE              Machine Interface mode.\n");
> +	fprintf(ofp, "                                 Type: xml\n");
>  	fprintf(ofp, "  -g, --group NAME           Unix tracing group name. (de=
fault: tracing)\n");
>  	fprintf(ofp, "  -n, --no-sessiond          Don't spawn a session daemon=
\n");
>  	fprintf(ofp, "      --sessiond-path PATH   Session daemon full path\n");
> @@ -136,6 +139,26 @@ static void version(FILE *ofp)
>  }
> =20
>  /*
> + * mi_output_type
> + *
> + * Find the MI output type enum from a string
> + * This function is for the support of
> + * new output language.
> + */
> +static int mi_output_type(const char *output_type)
> +{
> +	int ret =3D 0;
> +	if (!strncasecmp("xml", output_type, 3)) {
> +		ret =3D LTTNG_MI_XML;
> +	} else {
> +		/* Invalid output format */
> +		ERR("MI output format not supported");
> +		ret =3D -LTTNG_ERR_MI_OUTPUT_TYPE;
> +	}
> +	return ret;
> +}
> +
> +/*
>   *  list_options
>   *
>   *  List options line by line. This is mostly for bash auto completion a=
nd to
> @@ -426,7 +449,7 @@ static int parse_args(int argc, char **argv)
>  		clean_exit(EXIT_FAILURE);
>  	}
> =20
> -	while ((opt =3D getopt_long(argc, argv, "+Vhnvqg:", long_options, NULL)=
) !=3D -1) {
> +	while ((opt =3D getopt_long(argc, argv, "+Vhnvqg:m:", long_options, NUL=
L)) !=3D -1) {
>  		switch (opt) {
>  		case 'V':
>  			version(stdout);
> @@ -442,6 +465,13 @@ static int parse_args(int argc, char **argv)
>  		case 'q':
>  			lttng_opt_quiet =3D 1;
>  			break;
> +		case 'm':
> +			lttng_opt_mi =3D mi_output_type(optarg);
> +			if (lttng_opt_mi < 0) {
> +				ret =3D lttng_opt_mi;
> +				goto error;
> +			}
> +			break;
>  		case 'g':
>  			lttng_set_tracing_group(optarg);
>  			break;
> diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> index 1a764ae..dffab06 100644
> --- a/src/common/Makefile.am
> +++ b/src/common/Makefile.am
> @@ -16,8 +16,11 @@ noinst_LTLIBRARIES =3D libcommon.la
>  libcommon_la_SOURCES =3D error.h error.c utils.c utils.h runas.c runas.h=
 \
>                         common.h futex.c futex.h uri.c uri.h defaults.c \
>                         pipe.c pipe.h readwrite.c readwrite.h \
> +                       mi-lttng.h mi-lttng.c \
>                         daemonize.c daemonize.h
> -libcommon_la_LIBADD =3D -luuid
> +libcommon_la_LIBADD =3D \
> +		-luuid \
> +		$(top_builddir)/src/common/config/libconfig.la
> =20
>  # Consumer library
>  noinst_LTLIBRARIES +=3D libconsumer.la
> diff --git a/src/common/error.h b/src/common/error.h
> index f8c0a1d..4e096b3 100644
> --- a/src/common/error.h
> +++ b/src/common/error.h
> @@ -36,6 +36,7 @@
> =20
>  extern int lttng_opt_quiet;
>  extern int lttng_opt_verbose;
> +extern int lttng_opt_mi;
> =20
>  /* Error type. */
>  #define PRINT_ERR   0x1
> @@ -48,12 +49,18 @@ extern int lttng_opt_verbose;
> =20
>  /*
>   * Macro for printing message depending on command line option and verbo=
sity.
> + *
> + * Machine interface:
> + * We use lttng_opt_mi to suppress all normal msg to stdout. We don't
> + * want any nested msg to show up when printing mi to stdout(if it's the=
 case).
> + * All warnings and errors should be printed to stderr as normal.
>   */
>  #define __lttng_print(type, fmt, args...)                           \
>  	do {                                                            \
> -		if (lttng_opt_quiet =3D=3D 0 && type =3D=3D PRINT_MSG) {            \
> +		if (lttng_opt_quiet =3D=3D 0 && lttng_opt_mi =3D=3D 0 &&            \
> +				type =3D=3D PRINT_MSG) {                                \
>  			fprintf(stdout, fmt, ## args);                          \
> -		} else if (lttng_opt_quiet =3D=3D 0 &&                          \
> +		} else if (lttng_opt_quiet =3D=3D 0 && lttng_opt_mi =3D=3D 0 &&     \
>  				(((type & PRINT_DBG) && lttng_opt_verbose =3D=3D 1) ||  \
>  				((type & (PRINT_DBG | PRINT_DBG2)) &&               \
>  					lttng_opt_verbose =3D=3D 2) ||                      \
> diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> new file mode 100644
> index 0000000..bbec2c5
> --- /dev/null
> +++ b/src/common/mi-lttng.c
> @@ -0,0 +1,284 @@
> +/*
> + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.com>
> + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License, version 2 only, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License =
for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program; if not, write to the Free Software Foundation, Inc., 51
> + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <include/config.h>
> +#include <common/config/config.h>
> +#include "mi-lttng.h"
> +
> +/* Strings related to command */
> +const char * const mi_lttng_element_command =3D "command";
> +const char * const mi_lttng_element_command_version =3D "version";
> +const char * const mi_lttng_element_command_list =3D "list";
> +const char * const mi_lttng_element_command_name =3D "name";
> +const char * const mi_lttng_element_command_output =3D "output";
> +
> +/* Strings related to command: version */
> +const char * const mi_lttng_element_version =3D "version";
> +const char * const mi_lttng_element_version_str =3D "string";
> +const char * const mi_lttng_element_version_web =3D "url";
> +const char * const mi_lttng_element_version_major =3D "major";
> +const char * const mi_lttng_element_version_minor =3D "minor";
> +const char * const mi_lttng_element_version_license =3D "license";
> +const char * const mi_lttng_element_version_patch_level =3D "patchLevel";
> +const char * const mi_lttng_element_version_description =3D "description=
";
> +
> +LTTNG_HIDDEN
> +struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output_ty=
pe)
> +{
> +	struct mi_writer *mi_writer;
> +
> +	mi_writer =3D zmalloc(sizeof(struct mi_writer));
> +	if (!mi_writer) {
> +		PERROR("zmalloc mi_writer_create");
> +		goto end;
> +	}
> +	if (mi_output_type =3D=3D LTTNG_MI_XML) {
> +		mi_writer->writer =3D config_writer_create(fd_output);
> +		if (!mi_writer->writer) {
> +			goto err_destroy;
> +		}
> +		mi_writer->type =3D LTTNG_MI_XML;
> +	} else {
> +		goto err_destroy;
> +	}
> +
> +end:
> +	return mi_writer;
> +
> +err_destroy:
> +	free(mi_writer);
> +	return NULL;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_destroy(struct mi_writer *writer)
> +{
> +	int ret;
> +
> +	if (!writer) {
> +		ret =3D -EINVAL;
> +		goto end;
> +	}
> +
> +	ret =3D config_writer_destroy(writer->writer);
> +	if (ret < 0) {
> +		goto end;
> +	}
> +
> +	free(writer);
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_command_open(struct mi_writer *writer, const char *c=
ommand)
> +{
> +	int ret;
> +	ret =3D mi_lttng_writer_open_element(writer, mi_lttng_element_command);
> +	if (ret) {
> +		goto end;
> +	}
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_command_name, command);
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_command_close(struct mi_writer *writer)
> +{
> +	return mi_lttng_writer_close_element(writer);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_open_element(struct mi_writer *writer,
> +		const char *element_name)
> +{
> +	return config_writer_open_element(writer->writer, element_name);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_close_element(struct mi_writer *writer)
> +{
> +	return config_writer_close_element(writer->writer);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *writer,
> +		const char *element_name, uint64_t value)
> +{
> +	return config_writer_write_element_unsigned_int(writer->writer,
> +			element_name, value);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_write_element_signed_int(struct mi_writer *writer,
> +		const char *element_name, int64_t value)
> +{
> +	return config_writer_write_element_signed_int(writer->writer,
> +			element_name, value);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_write_element_bool(struct mi_writer *writer,
> +		const char *element_name, int value)
> +{
> +	return config_writer_write_element_bool(writer->writer,
> +			element_name, value);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_writer_write_element_string(struct mi_writer *writer,
> +		const char *element_name, const char *value)
> +{
> +	return config_writer_write_element_string(writer->writer,
> +			element_name, value);
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_version(struct mi_writer *writer, struct mi_lttng_version *=
version,
> +	const char *lttng_description, const char *lttng_license)
> +{
> +	int ret;
> +
> +	/* Open version */
> +	ret =3D mi_lttng_writer_open_element(writer, mi_lttng_element_version);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Version string (contain info like rc etc.) */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_version_str, VERSION);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Major version number */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			mi_lttng_element_version_major, version->version_major);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Minor version number */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			mi_lttng_element_version_minor, version->version_minor);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Patch number */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			mi_lttng_element_version_patch_level, version->version_patchlevel);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Name of the version */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_name, version->version_name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Description mostly related to beer... */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_version_description, lttng_description);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* url */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_version_web, version->package_url);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* License: free as in free beer...no...*speech* */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			mi_lttng_element_version_license, lttng_license);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Close version element */
> +	ret =3D mi_lttng_writer_close_element(writer);
> +
> +end:
> +	return ret;
> +}
> +
> +LTTNG_HIDDEN
> +int mi_lttng_session(struct mi_writer *writer,
> +		struct lttng_session *session, int is_open)
> +{
> +	int ret;
> +
> +	/* open sessions element */
> +	ret =3D mi_lttng_writer_open_element(writer,
> +			config_element_session);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* Name of the session */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_name, session->name);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* path */
> +	ret =3D mi_lttng_writer_write_element_string(writer,
> +			config_element_path, session->path);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* enabled ? */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			config_element_enabled, session->enabled);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* snapshot mode */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			config_element_snapshot_mode, session->snapshot_mode);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	/* live timer interval in usec */
> +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> +			config_element_live_timer_interval,
> +			session->live_timer_interval);
> +	if (ret) {
> +		goto end;
> +	}
> +
> +	if (!is_open) {
> +		/* Closing session element */
> +		ret =3D mi_lttng_writer_close_element(writer);
> +	}
> +end:
> +	return ret;
> +
> +}
> diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
> new file mode 100644
> index 0000000..69ec0f5
> --- /dev/null
> +++ b/src/common/mi-lttng.h
> @@ -0,0 +1,230 @@
> +/*
> + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.com>
> + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License, version 2 only, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but W=
ITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License =
for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program; if not, write to the Free Software Foundation, Inc., 51
> + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef _MI_LTTNG_H
> +#define _MI_LTTNG_H
> +
> +#include <common/error.h>
> +#include <common/macros.h>
> +#include <common/config/config.h>
> +
> +#include <lttng/lttng.h>
> +
> +#include <stdint.h>
> +
> +
> +/* Instance of a machine interface writer. */
> +struct mi_writer {
> +	struct config_writer *writer;
> +	enum lttng_mi_output_type type;
> +};
> +
> +/*
> + * Version information for the machine interface.
> + */
> +struct mi_lttng_version {
> +	char version[NAME_MAX]; /* Version number of package */
> +	uint32_t version_major; /* LTTng-Tools major version number */
> +	uint32_t version_minor; /* LTTng-Tools minor version number */
> +	uint32_t version_patchlevel; /* LTTng-Tools patchlevel version number */
> +	char version_name[NAME_MAX];
> +	char package_url[NAME_MAX]; /* Define to the home page for this package=
=2E */
> +};
> +
> +/* Strings related to command */
> +const char * const mi_lttng_element_command;
> +const char * const mi_lttng_element_command_version;
> +const char * const mi_lttng_element_command_list;
> +const char * const mi_lttng_element_command_name;
> +const char * const mi_lttng_element_command_output;
> +
> +/* Strings related to command: version */
> +const char * const mi_lttng_element_version;
> +const char * const mi_lttng_element_version_str;
> +const char * const mi_lttng_element_version_web;
> +const char * const mi_lttng_element_version_major;
> +const char * const mi_lttng_element_version_minor;
> +const char * const mi_lttng_element_version_license;
> +const char * const mi_lttng_element_version_patch_level;
> +const char * const mi_lttng_element_version_description;
> +
> +/*
> + * Create an instance of a machine interface writer.
> + *
> + * fd_output File to which the XML content must be written. The file wil=
l be
> + * closed once the mi_writer has been destroyed.
> + *
> + * Returns an instance of a machine interface writer on success, NULL on
> + * error.
> + */
> +struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output_ty=
pe);
> +
> +/*
> + * Destroy an instance of a machine interface writer.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * Returns zero if the XML document could be closed cleanly. Negative va=
lues
> + * indicate an error.
> + */
> +int mi_lttng_writer_destroy(struct mi_writer *writer);
> +
> +/*
> + * Open a command tag and add it's name node.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * command The command name.
> + *
> + * Returns zero if the XML document could be closed cleanly.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_writer_command_open(struct mi_writer *writer, const char *c=
ommand);
> +
> +/*
> + * Close a command tag.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * Returns zero if the XML document could be closed cleanly.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_writer_command_close(struct mi_writer *writer);
> +
> +/*
> + * Open an element tag.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * element_name Element tag name.
> + *
> + * Returns zero if the XML document could be closed cleanly.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_writer_open_element(struct mi_writer *writer,
> +		const char *element_name);
> +
> +/*
> + * Close the current element tag.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * Returns zero if the XML document could be closed cleanly.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_writer_close_element(struct mi_writer *writer);
> +
> +/*
> + * Write an element of type unsigned int.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * element_name Element name.
> + *
> + * value Unsigned int value of the element
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *writer,
> +		const char *element_name, uint64_t value);
> +
> +/*
> + * Write an element of type signed int.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * element_name Element name.
> + *
> + * value Signed int value of the element
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_writer_write_element_signed_int(struct mi_writer *writer,
> +		const char *element_name, int64_t value);
> +
> +/*
> + * Write an element of type boolean.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * element_name Element name.
> + *
> + * value Boolean value of the element
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_writer_write_element_bool(struct mi_writer *writer,
> +		const char *element_name, int value);
> +
> +/*
> + * Write an element of type string.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * element_name Element name.
> + *
> + * value String value of the element
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_writer_write_element_string(struct mi_writer *writer,
> +		const char *element_name, const char *value);
> +
> +/*
> + * Machine interface of struct version.
> + *
> + * writer An instance of a machine interface writer.
> + *
> + * version Version struct.
> + *
> + * lttng_description String value of the version description.
> + *
> + * lttng_license String value of the version license.
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_version(struct mi_writer *writer, struct mi_lttng_version *=
version,
> +		const char *lttng_description, const char *lttng_license);
> +
> +/*
> + * Machine interface of struct session.
> + *
> + * writer An instance of a machine interface writer
> + *
> + * session An instance of a session
> + *
> + * isOpen Define if we close the session element
> + *        This should be use carefully and the client
> + *        need to close the session element.
> + *        Use case: nested addition information on a session
> + *                  ex: domain,channel event.
> + *        0-> False
> + *        1-> True
> + *
> + * Returns zero if the element's value could be written.
> + * Negative values indicate an error.
> + */
> +int mi_lttng_session(struct mi_writer *writer,
> +		struct lttng_session *session, int isOpen);
> +
> +#endif /* _MI_LTTNG_H */
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 100e587..7dd9828 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -74,6 +74,7 @@ static int connected;
>   */
>  int lttng_opt_quiet;
>  int lttng_opt_verbose;
> +int lttng_opt_mi;
> =20
>  /*
>   * Copy string from src to dst and enforce null terminated byte.
> diff --git a/tests/unit/ini_config/ini_config.c b/tests/unit/ini_config/i=
ni_config.c
> index 38fe5f4..29935ef 100644
> --- a/tests/unit/ini_config/ini_config.c
> +++ b/tests/unit/ini_config/ini_config.c
> @@ -31,6 +31,7 @@ struct state {
> =20
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 0;
> +int lttng_opt_mi;
> =20
>  int entry_handler(const struct config_entry *entry,
>  		struct state *state)
> diff --git a/tests/unit/test_kernel_data.c b/tests/unit/test_kernel_data.c
> index e2182e9..2639be4 100644
> --- a/tests/unit/test_kernel_data.c
> +++ b/tests/unit/test_kernel_data.c
> @@ -38,6 +38,7 @@
>  /* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose;
> +int lttng_opt_mi;
> =20
>  int ust_consumerd32_fd;
>  int ust_consumerd64_fd;
> diff --git a/tests/unit/test_session.c b/tests/unit/test_session.c
> index a0e84e9..4f90c33 100644
> --- a/tests/unit/test_session.c
> +++ b/tests/unit/test_session.c
> @@ -46,6 +46,7 @@ static struct ltt_session_list *session_list;
>  /* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 0;
> +int lttng_opt_mi;
> =20
>  int ust_consumerd32_fd;
>  int ust_consumerd64_fd;
> diff --git a/tests/unit/test_uri.c b/tests/unit/test_uri.c
> index 7cac95d..432e2b3 100644
> --- a/tests/unit/test_uri.c
> +++ b/tests/unit/test_uri.c
> @@ -25,6 +25,7 @@
>  /* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 3;
> +int lttng_opt_mi;
> =20
>  /* Number of TAP tests in this file */
>  #define NUM_TESTS 11
> diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
> index 150d5da..dd00089 100644
> --- a/tests/unit/test_ust_data.c
> +++ b/tests/unit/test_ust_data.c
> @@ -44,6 +44,7 @@
>  /* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose;
> +int lttng_opt_mi;
> =20
>  int ust_consumerd32_fd;
>  int ust_consumerd64_fd;
> diff --git a/tests/unit/test_utils_expand_path.c b/tests/unit/test_utils_=
expand_path.c
> index fe709ac..f863b5d 100644
> --- a/tests/unit/test_utils_expand_path.c
> +++ b/tests/unit/test_utils_expand_path.c
> @@ -31,6 +31,7 @@
>  /* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 3;
> +int lttng_opt_mi;
> =20
>  struct valid_test_input {
>  	char *input;
> diff --git a/tests/unit/test_utils_parse_size_suffix.c b/tests/unit/test_=
utils_parse_size_suffix.c
> index 990aa1b..f81278d 100644
> --- a/tests/unit/test_utils_parse_size_suffix.c
> +++ b/tests/unit/test_utils_parse_size_suffix.c
> @@ -26,6 +26,7 @@
>  /* For error.h */
>  int lttng_opt_quiet =3D 1;
>  int lttng_opt_verbose =3D 3;
> +int lttng_opt_mi;
> =20
>  struct valid_test_input {
>  	char *input;
> --=20
> 1.8.3.2
>=20


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTS/4nXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02qGYH/1e6+L9gWEnFPf92oGx30N/i
7feGaGCJ6ke5DWwPEkeYVZ5mMyZLrfuMCMoCY9qSiFwSH67JC843HdlZqP6o8mWb
Y41p5HRYO4uGFMz+8DKay0a/yU7nt+ZEB2izufT79vq8f8OjeBHEmar2IJ9Cq0hD
FSOee2Xv4GbirbWusJ9eY2DjKpjFXTD0Yj7JSpK7hobkncpGfISP47KbuMuV3EiQ
zVUgmN+1CgNETkv088zBKR/rZo0GCrCesjmj30cln/cv+DVF8FG/gfQJsyBxwpAJ
G7XiqVLmIjfAowpcH1WJkFUBcchFm9J7kEg0WICS/jTCKoOyVGQWDEIN/dfEyZE=
=UX/S
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--




--===============0671935944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0671935944==--
