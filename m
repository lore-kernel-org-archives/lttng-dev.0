From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: [MI-prototype] MI: mi-lttng into libcommon,
 global option lttng_mi_opt , command version
Date: Tue, 25 Mar 2014 14:49:09 -0400
Message-ID: <20140325184906.GA1538__47194.5684323602$1395773439$gmane$org@gmail.com>
References: <20140321172505.GA9511@gmail.com>
 <20140325144745.GB7702@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WSWPX-00083j-4k
	for lttng-dev@lists.lttng.org; Tue, 25 Mar 2014 14:49:26 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so1129362oag.13
	for <lttng-dev@lists.lttng.org>; Tue, 25 Mar 2014 11:49:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140325144745.GB7702@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Mar 25, 2014 at 10:47:45AM -0400, David Goulet wrote:
> On 21 Mar (13:25:12), Jonathan Rajotte wrote:
> > Hi guys,
> > This is our current machine interface backend.
> > You can test it by applying this patch to master.
> > =

> > Finally after discussion with Jeremie Galard and David Goulet, we chose=
d to
> > use a global option for the machine interface.
> > =

> > 	lttng --mi <output_type> <command>
> > =

> > The only output_type supported is xml.
> > =

> > Currently you can test it with the command version (nothing spectatular=
).
> > We will send patch for list before monday.
> > =

> > That's it.
> > =

> > Thx
> > =

> > Signed-off-by: Olivier Cotte <olivier.cotte@polymtl.ca>
> > Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> > ---
> >  include/lttng/lttng-error.h               |    6 +
> >  include/lttng/lttng.h                     |   20 +++
> >  src/bin/lttng-consumerd/lttng-consumerd.c |    2 +
> >  src/bin/lttng/commands/version.c          |   73 +++++++-
> >  src/bin/lttng/lttng.c                     |   32 +++-
> >  src/common/Makefile.am                    |    5 +-
> >  src/common/error.h                        |    6 +-
> >  src/common/mi-lttng.c                     |  273 +++++++++++++++++++++=
++++++++
> >  src/common/mi-lttng.h                     |  212 ++++++++++++++++++++++
> >  src/lib/lttng-ctl/lttng-ctl.c             |    1 +
> >  tests/unit/ini_config/ini_config.c        |    1 +
> >  tests/unit/test_kernel_data.c             |    1 +
> >  tests/unit/test_session.c                 |    1 +
> >  tests/unit/test_uri.c                     |    1 +
> >  tests/unit/test_ust_data.c                |    1 +
> >  tests/unit/test_utils_expand_path.c       |    1 +
> >  tests/unit/test_utils_parse_size_suffix.c |    1 +
> >  17 files changed, 629 insertions(+), 8 deletions(-)
> >  create mode 100644 src/common/mi-lttng.c
> >  create mode 100644 src/common/mi-lttng.h
> > =

> > diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
> > index 06baa04..18924dd 100644
> > --- a/include/lttng/lttng-error.h
> > +++ b/include/lttng/lttng-error.h
> > @@ -142,6 +142,12 @@ enum lttng_error_code {
> >  	LTTNG_ERR_NO_CONSUMER            =3D 109, /* No consumer exist for th=
e session */
> >  	LTTNG_ERR_EXCLUSION_INVAL        =3D 110, /* Invalid event exclusion =
data */
> >  	LTTNG_ERR_EXCLUSION_NOMEM        =3D 111, /* Lack of memory while pro=
cessing event exclusions */
> > +	/* 112 */
> > +	/* 113 */
> > +	/* 114 */
> > +	/* 115 */
> =

> Why adding 4 numbers here? You should actually use the empty values
> above before adding more. This is a long time legacy situation here when
> we refactored the error code but didn't want to break the API value thus
> there is empty slots...
Okai we weren't sure if we had to reserve space for futher error_code.
> =

> > +	LTTNG_ERR_MI_OUTPUT_TYPE         =3D 116, /* Invalid MI output format=
 */
> > +	LTTNG_ERR_MI_IO_FAIL             =3D 117, /* IO error while writing m=
achine interface output */
> >  =

> >  	/* MUST be last element */
> >  	LTTNG_ERR_NR,                           /* Last element */
> > diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
> > index f0be224..b0a1380 100644
> > --- a/include/lttng/lttng.h
> > +++ b/include/lttng/lttng.h
> > @@ -170,6 +170,11 @@ enum lttng_buffer_type {
> >  	LTTNG_BUFFER_GLOBAL,	/* Only supported by the Kernel. */
> >  };
> >  =

> > +/* Machine interface output type */
> > +enum lttng_mi_output_type {
> > +	LTTNG_MI_XML                          =3D 1 /* XML output */
> > +};
> > +
> >  /*
> >   * The structures should be initialized to zero before use.
> >   */
> > @@ -372,6 +377,21 @@ struct lttng_handle {
> >  };
> >  =

> >  /*
> > + * Version information for the machine interface.
> > + */
> > +#define LTTNG_VERSION_PADDING1		16
> > +struct lttng_version {
> > +	char version[NAME_MAX];
> =

> Just to clarify, this holds for instance "2.4.0-rc2" full string?
yes,  there is no rc field in config.h but a full string.
> =

> > +	int version_major;
> > +	int version_minor;
> > +	int version_patchlevel;
> =

> Should be uint32_t here.
> =

> > +	char version_name[NAME_MAX];
> > +	char package_url[NAME_MAX];
> > +
> > +	char padding[LTTNG_VERSION_PADDING1];
> > +};
> =

> So this should not be in lttng.h but rather in mi-lttng.h probably.
> lttng.h is the *public* ABI thus data structure being used for the
> public API used by lttng_* function calls.
> =

Okai, guess we don't quite understand yet how lttng is organized.

> Thus padding won't be necessary.
> =

> > +
> > +/*
> >   * Public LTTng control API
> >   *
> >   * For functions having an lttng domain type as parameter, if a bad va=
lue is
> > diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng-=
consumerd/lttng-consumerd.c
> > index e226ebc..0ce163e 100644
> > --- a/src/bin/lttng-consumerd/lttng-consumerd.c
> > +++ b/src/bin/lttng-consumerd/lttng-consumerd.c
> > @@ -65,6 +65,8 @@ static int sigintcount =3D 0;
> >  /* Argument variables */
> >  int lttng_opt_quiet;    /* not static in error.h */
> >  int lttng_opt_verbose;  /* not static in error.h */
> > +int lttng_opt_mi;       /* not static in error.h */
> > +
> >  static int opt_daemon;
> >  static const char *progname;
> >  static char command_sock_path[PATH_MAX]; /* Global command socket path=
 */
> > diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands/=
version.c
> > index 7f69de3..80a663e 100644
> > --- a/src/bin/lttng/commands/version.c
> > +++ b/src/bin/lttng/commands/version.c
> > @@ -25,6 +25,8 @@
> >  #include <unistd.h>
> >  #include <config.h>
> >  =

> > +#include <common/mi-lttng.h>
> > +
> >  #include "../command.h"
> >  =

> >  enum {
> > @@ -32,6 +34,8 @@ enum {
> >  	OPT_LIST_OPTIONS,
> >  };
> >  =

> > +static const char lttng_license[] =3D "lttng is free software and unde=
r the GPL license and part LGPL";
> > +
> >  static struct poptOption long_options[] =3D {
> >  	/* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
> >  	{"help",      'h', POPT_ARG_NONE, 0, OPT_HELP, 0, 0},
> > @@ -53,12 +57,27 @@ static void usage(FILE *ofp)
> >  }
> >  =

> >  /*
> > + *  create_version
> > + */
> > +static void create_version(struct lttng_version *version)
> > +{
> > +	strncpy(version->version, VERSION, NAME_MAX);
> > +	version->version_major =3D VERSION_MAJOR;
> > +	version->version_minor =3D VERSION_MINOR;
> > +	version->version_patchlevel =3D VERSION_PATCHLEVEL;
> > +	strncpy(version->version_name, VERSION_NAME, NAME_MAX);
> > +	strncpy(version->package_url, PACKAGE_URL, NAME_MAX);
> > +}
> > +
> > +/*
> >   *  cmd_version
> >   */
> >  int cmd_version(int argc, const char **argv)
> >  {
> >  	int opt, ret =3D CMD_SUCCESS;
> >  	static poptContext pc;
> > +	struct mi_writer *writer =3D NULL;
> > +	struct lttng_version version;
> >  =

> >  	pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >  	poptReadDefaultConfig(pc, 0);
> > @@ -78,12 +97,58 @@ int cmd_version(int argc, const char **argv)
> >  		}
> >  	}
> >  =

> > -	MSG("lttng version " VERSION " - " VERSION_NAME);
> > -	MSG("\n" VERSION_DESCRIPTION "\n");
> > -	MSG("Web site: http://lttng.org");
> > -	MSG("\nlttng is free software and under the GPL license and part LGPL=
");
> > +	if (lttng_opt_mi) {
> =

> I would go for a function to print the mi like maybe "print_mi()" since
> this *may* change depending on what output type we use. For now, only
> one but let's think ahead :) and this allow to handle the mi writer
> destruction in one specific call also, cleaner in the long run I think.
Okai, we got a patch comming for list ( need some cleanup, internal
code review and 2 features) but you might want to check the way we
incorporate the mi into the command and tell us what you think. Cause
with your comment I think we are heading the wrong way.
https://github.com/PSRCode/lttng-tools-dev/commit/23b3a771083dc9abbf80aa9a4=
6087b0ea9fd5959
> =

> > +		create_version(&version);
> > +
> > +		writer =3D mi_lttng_writer_create(fileno(stdout), lttng_opt_mi);
> > +
> > +		if (!writer) {
> > +			ret =3D -LTTNG_ERR_NOMEM;
> > +			goto end;
> > +		}
> > +
> > +		/* Open the command element */
> > +		ret =3D mi_lttng_writer_command_open(writer,
> > +				mi_lttng_element_command_version);
> > +		if (ret) {
> > +			goto end;
> > +		}
> > +
> > +		/* Beginning of output */
> > +		ret =3D mi_lttng_writer_open_element(writer,
> > +				mi_lttng_element_command_output);
> > +		if (ret) {
> > +			goto end;
> > +		}
> > +
> > +		ret =3D mi_lttng_version(writer, &version,
> > +				VERSION_DESCRIPTION,
> > +				lttng_license);
> > +		if (ret) {
> > +			goto end;
> > +		}
> > +
> > +		/* Close the output element */
> > +		ret =3D mi_lttng_writer_close_element(writer);
> > +		if (ret) {
> > +			goto end;
> > +		}
> > +
> > +		/* Close the command  */
> > +		ret =3D mi_lttng_writer_command_close(writer);
> > +
> > +	} else {
> > +		MSG("lttng version " VERSION " - " VERSION_NAME);
> > +		MSG("\n" VERSION_DESCRIPTION "\n");
> > +		MSG("Web site: http://lttng.org");
> > +		MSG("\n%s", lttng_license);
> > +	}
> >  =

> >  end:
> > +	if (writer && mi_lttng_writer_destroy(writer)) {
> > +		/* Preserve original error code */
> > +		ret =3D ret ? ret : LTTNG_ERR_MI_IO_FAIL;
> > +	}
> >  	poptFreeContext(pc);
> >  	return ret;
> >  }
> > diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
> > index bc7577d..ebfe6f2 100644
> > --- a/src/bin/lttng/lttng.c
> > +++ b/src/bin/lttng/lttng.c
> > @@ -55,6 +55,7 @@ static struct option long_options[] =3D {
> >  	{"group",            1, NULL, 'g'},
> >  	{"verbose",          0, NULL, 'v'},
> >  	{"quiet",            0, NULL, 'q'},
> > +	{"mi",               1, NULL, 'm'},
> >  	{"no-sessiond",      0, NULL, 'n'},
> >  	{"sessiond-path",    1, NULL, OPT_SESSION_PATH},
> >  	{"relayd-path",      1, NULL, OPT_RELAYD_PATH},
> > @@ -99,6 +100,8 @@ static void usage(FILE *ofp)
> >  	fprintf(ofp, "      --list-commands        Simple listing of lttng co=
mmands\n");
> >  	fprintf(ofp, "  -v, --verbose              Increase verbosity\n");
> >  	fprintf(ofp, "  -q, --quiet                Quiet mode\n");
> > +	fprintf(ofp, "  -m, --mi TYPE              Machine Interface mode.\n"=
);
> > +	fprintf(ofp, "                                 Type: xml\n");
> >  	fprintf(ofp, "  -g, --group NAME           Unix tracing group name. (=
default: tracing)\n");
> >  	fprintf(ofp, "  -n, --no-sessiond          Don't spawn a session daem=
on\n");
> >  	fprintf(ofp, "      --sessiond-path PATH   Session daemon full path\n=
");
> > @@ -136,6 +139,26 @@ static void version(FILE *ofp)
> >  }
> >  =

> >  /*
> > + * mi_output_type
> > + *
> > + * Find the MI output type enum from a string
> > + * This function is for the support of
> > + * new output language.
> > + */
> > +static int mi_output_type(const char *output_type)
> > +{
> > +	int ret =3D 0;
> > +	if (!strncmp("xml", output_type, 3)) {
> =

> Maybe we could also allow "XML" or a anything looking like that like
> "XmL". Isn't there a libc call that ignores the case ?

:P fail.

> =

> > +		ret =3D LTTNG_MI_XML;
> > +	} else {
> > +		/* Invalid output format */
> > +		ERR("MI output format not supported");
> > +		ret =3D -LTTNG_ERR_MI_OUTPUT_TYPE;
> > +	}
> > +	return ret;
> > +}
> > +
> > +/*
> >   *  list_options
> >   *
> >   *  List options line by line. This is mostly for bash auto completion=
 and to
> > @@ -426,7 +449,7 @@ static int parse_args(int argc, char **argv)
> >  		clean_exit(EXIT_FAILURE);
> >  	}
> >  =

> > -	while ((opt =3D getopt_long(argc, argv, "+Vhnvqg:", long_options, NUL=
L)) !=3D -1) {
> > +	while ((opt =3D getopt_long(argc, argv, "+Vhnvqg:m:", long_options, N=
ULL)) !=3D -1) {
> >  		switch (opt) {
> >  		case 'V':
> >  			version(stdout);
> > @@ -442,6 +465,13 @@ static int parse_args(int argc, char **argv)
> >  		case 'q':
> >  			lttng_opt_quiet =3D 1;
> >  			break;
> > +		case 'm':
> > +			lttng_opt_mi =3D mi_output_type(optarg);
> > +			if (lttng_opt_mi < 0) {
> > +				ret =3D lttng_opt_mi;
> > +				goto error;
> > +			}
> > +			break;
> >  		case 'g':
> >  			lttng_set_tracing_group(optarg);
> >  			break;
> > diff --git a/src/common/Makefile.am b/src/common/Makefile.am
> > index 1a764ae..dffab06 100644
> > --- a/src/common/Makefile.am
> > +++ b/src/common/Makefile.am
> > @@ -16,8 +16,11 @@ noinst_LTLIBRARIES =3D libcommon.la
> >  libcommon_la_SOURCES =3D error.h error.c utils.c utils.h runas.c runas=
.h \
> >                         common.h futex.c futex.h uri.c uri.h defaults.c=
 \
> >                         pipe.c pipe.h readwrite.c readwrite.h \
> > +                       mi-lttng.h mi-lttng.c \
> >                         daemonize.c daemonize.h
> > -libcommon_la_LIBADD =3D -luuid
> > +libcommon_la_LIBADD =3D \
> > +		-luuid \
> > +		$(top_builddir)/src/common/config/libconfig.la
> >  =

> >  # Consumer library
> >  noinst_LTLIBRARIES +=3D libconsumer.la
> > diff --git a/src/common/error.h b/src/common/error.h
> > index f8c0a1d..2e21463 100644
> > --- a/src/common/error.h
> > +++ b/src/common/error.h
> > @@ -36,6 +36,7 @@
> >  =

> >  extern int lttng_opt_quiet;
> >  extern int lttng_opt_verbose;
> > +extern int lttng_opt_mi;
> >  =

> >  /* Error type. */
> >  #define PRINT_ERR   0x1
> > @@ -51,9 +52,10 @@ extern int lttng_opt_verbose;
> >   */
> >  #define __lttng_print(type, fmt, args...)                           \
> >  	do {                                                            \
> > -		if (lttng_opt_quiet =3D=3D 0 && type =3D=3D PRINT_MSG) {            \
> > +		if (lttng_opt_quiet =3D=3D 0 && lttng_opt_mi =3D=3D 0 &&            \
> > +				type =3D=3D PRINT_MSG) {                                \
> >  			fprintf(stdout, fmt, ## args);                          \
> > -		} else if (lttng_opt_quiet =3D=3D 0 &&                          \
> > +		} else if (lttng_opt_quiet =3D=3D 0 && lttng_opt_mi =3D=3D 0 &&     \
> >  				(((type & PRINT_DBG) && lttng_opt_verbose =3D=3D 1) ||  \
> >  				((type & (PRINT_DBG | PRINT_DBG2)) &&               \
> >  					lttng_opt_verbose =3D=3D 2) ||                      \
> =

> Can you add a comment here just above this define explaining exactly why
> we suppress stdout output with the MI option.
> =

> > diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> > new file mode 100644
> > index 0000000..2f3ee68
> > --- /dev/null
> > +++ b/src/common/mi-lttng.c
> > @@ -0,0 +1,273 @@
> > +/*
> > + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.co=
m>
> > + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License, version 2 only, =
as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long with
> > + * this program; if not, write to the Free Software Foundation, Inc., =
51
> > + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#include <include/config.h>
> > +#include <common/config/config.h>
> > +#include "mi-lttng.h"
> > +
> > +/* Strings related to command */
> > +const char * const mi_lttng_element_command =3D "command";
> > +const char * const mi_lttng_element_command_version =3D "version";
> > +const char * const mi_lttng_element_command_list =3D "list";
> > +const char * const mi_lttng_element_command_name =3D "name";
> > +const char * const mi_lttng_element_command_output =3D "output";
> > +
> > +/* Strings related to command: version */
> > +const char * const mi_lttng_element_version_str =3D "string";
> > +const char * const mi_lttng_element_version_web =3D "url";
> > +const char * const mi_lttng_element_version_major =3D "major";
> > +const char * const mi_lttng_element_version_minor =3D "minor";
> > +const char * const mi_lttng_element_version_license =3D "license";
> > +const char * const mi_lttng_element_version_patch_level =3D "patchLeve=
l";
> > +const char * const mi_lttng_element_version_description =3D "descripti=
on";
> > +
> > +LTTNG_HIDDEN
> > +struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output_=
type)
> > +{
> > +	struct mi_writer *mi_writer;
> > +
> > +	mi_writer =3D zmalloc(sizeof(struct mi_writer));
> > +	if (!mi_writer) {
> > +		PERROR("zmalloc mi_writer_create");
> > +		goto end;
> > +	}
> > +	if (mi_output_type =3D=3D LTTNG_MI_XML) {
> > +		mi_writer->writer =3D config_writer_create(fd_output);
> > +		if (!mi_writer->writer) {
> > +			goto err_destroy;
> > +		}
> > +		mi_writer->type =3D LTTNG_MI_XML;
> > +	} else {
> > +		goto err_destroy;
> > +	}
> > +
> > +end:
> > +	return mi_writer;
> > +
> > +err_destroy:
> > +	free(mi_writer);
> > +	return NULL;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_destroy(struct mi_writer *writer)
> > +{
> > +	int ret =3D 0;
> =

> No default return values. In the long run of the bad and forsaken
> history of "maintaining code" this will just be your worst ennemy :P.
> =

> > +
> > +	if (!writer) {
> > +		ret =3D -EINVAL;
> > +		goto end;
> > +	}
> > +
> > +	ret =3D config_writer_destroy(writer->writer);
> > +	if (ret < 0) {
> > +		goto end;
> > +	}
> > +
> > +	free(writer);
> > +end:
> > +	return ret;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_command_open(struct mi_writer *writer, const char =
*command)
> > +{
> > +	int ret;
> > +	ret =3D mi_lttng_writer_open_element(writer, mi_lttng_element_command=
);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +	ret =3D mi_lttng_writer_write_element_string(writer,
> > +			mi_lttng_element_command_name, command);
> > +end:
> > +	return ret;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_command_close(struct mi_writer *writer)
> > +{
> > +	return mi_lttng_writer_close_element(writer);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_open_element(struct mi_writer *writer,
> > +		const char *element_name)
> > +{
> > +	return config_writer_open_element(writer->writer, element_name);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_close_element(struct mi_writer *writer)
> > +{
> > +	return config_writer_close_element(writer->writer);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *write=
r,
> > +		const char *element_name, uint64_t value)
> > +{
> > +	int ret;
> > +	ret =3D config_writer_write_element_unsigned_int(writer->writer,
> > +			element_name, value);
> =

> Maybe just "return config_writer_write_element_unsigned_int(...)" ?
> =

> > +	return ret;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_signed_int(struct mi_writer *writer,
> > +		const char *element_name, int64_t value)
> > +{
> > +	return config_writer_write_element_signed_int(writer->writer,
> > +			element_name, value);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_bool(struct mi_writer *writer,
> > +		const char *element_name, int value)
> > +{
> > +	return config_writer_write_element_bool(writer->writer,
> > +			element_name, value);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_string(struct mi_writer *writer,
> > +		const char *element_name, const char *value)
> > +{
> > +	return config_writer_write_element_string(writer->writer,
> > +			element_name, value);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_version(struct mi_writer *writer, struct lttng_version *v=
ersion,
> > +	char *lttng_description, char *lttng_license)
> > +{
> > +	int ret =3D 0;
> =

> Same as above, no default ret values.
> =

> > +
> > +	/* Version string (contain info like rc etc.) */
> > +	ret =3D mi_lttng_writer_write_element_string(writer,
> > +			mi_lttng_element_version_str, VERSION);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* Major version number */
> > +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +			mi_lttng_element_version_major, version->version_major);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* Minor version number */
> > +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +			mi_lttng_element_version_minor, version->version_minor);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* Patch number */
> > +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +			mi_lttng_element_version_patch_level, version->version_patchlevel);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* Name of the version */
> > +	ret =3D mi_lttng_writer_write_element_string(writer,
> > +			config_element_name, version->version_name);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* Description mostly related to beer... */
> > +	ret =3D mi_lttng_writer_write_element_string(writer,
> > +			mi_lttng_element_version_description, lttng_description);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* url */
> > +	ret =3D mi_lttng_writer_write_element_string(writer,
> > +			mi_lttng_element_version_web, version->package_url);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* License: free as in free beer...no...*speech* */
> > +	ret =3D mi_lttng_writer_write_element_string(writer,
> > +			mi_lttng_element_version_license, lttng_license);
> > +
> > +end:
> > +	return ret;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_session(struct mi_writer *writer,
> > +		struct lttng_session *session, int isOpen)
> > +{
> > +	int ret =3D 0;
> =

> Same as above, no default ret values.
> =

> > +
> > +	/* open sessions element */
> > +	ret =3D mi_lttng_writer_open_element(writer,
> > +			config_element_session);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* Name of the session */
> > +	ret =3D mi_lttng_writer_write_element_string(writer,
> > +			config_element_name, session->name);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* path */
> > +	ret =3D mi_lttng_writer_write_element_string(writer,
> > +			config_element_path, session->path);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* enabled ? */
> > +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +			config_element_enabled, session->enabled);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* snapshot mode */
> > +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +			config_element_snapshot_mode, session->snapshot_mode);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	/* live timer interval in usec */
> > +	ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +			config_element_live_timer_interval,
> > +			session->live_timer_interval);
> > +	if (ret) {
> > +		goto end;
> > +	}
> > +
> > +	if (!isOpen) {
> > +		/* Closing session element */
> > +		ret =3D mi_lttng_writer_close_element(writer);
> > +	}
> > +end:
> > +	return ret;
> > +
> > +}
> > diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
> > new file mode 100644
> > index 0000000..534c1db
> > --- /dev/null
> > +++ b/src/common/mi-lttng.h
> > @@ -0,0 +1,212 @@
> > +/*
> > + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.co=
m>
> > + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License, version 2 only, =
as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long with
> > + * this program; if not, write to the Free Software Foundation, Inc., =
51
> > + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#ifndef _MI_LTTNG_H
> > +#define _MI_LTTNG_H
> > +
> > +#include <common/error.h>
> > +#include <common/macros.h>
> > +#include <common/config/config.h>
> > +
> > +#include <lttng/lttng.h>
> > +
> > +#include <stdint.h>
> > +
> > +
> > +/* Instance of a machine interface writer. */
> > +struct mi_writer {
> > +	struct config_writer *writer;
> > +	enum lttng_mi_output_type type;
> > +};
> > +
> > +/* Strings related to command */
> > +const char * const mi_lttng_element_command;
> > +const char * const mi_lttng_element_command_version;
> > +const char * const mi_lttng_element_command_list;
> > +const char * const mi_lttng_element_command_name;
> > +const char * const mi_lttng_element_command_output;
> > +
> > +/* Strings related to command: version */
> > +const char * const mi_lttng_element_version_str;
> > +const char * const mi_lttng_element_version_web;
> > +const char * const mi_lttng_element_version_major;
> > +const char * const mi_lttng_element_version_minor;
> > +const char * const mi_lttng_element_version_license;
> > +const char * const mi_lttng_element_version_patch_level;
> > +const char * const mi_lttng_element_version_description;
> > +
> > +/*
> > + * Create an instance of a machine interface writer.
> > + *
> > + * fd_output File to which the XML content must be written. The file w=
ill be
> > + * closed once the mi_writer has been destroyed.
> > + *
> > + * Returns an instance of a machine interface writer on success, NULL =
on
> > + * error.
> > + */
> > +LTTNG_HIDDEN
> =

> Don't think you need the HIDDEN attribute here since they are assigned
> in the C file. Same for all of them below.
> =

> This is the end. Apart from those small changes, this looks great!
> Confident you next patch summit would be the last one which already
> means great job guys!

Let's hope so.
> =

> Ideally, if you can send me a patch with "git format-patch" or "git show
> <commit>" so it retains your commit message and signed-off. You can also
> send me a branch for me to pull in based on upstream/master.

I'm sure you don't want our messy comments. :P

Thx David.
> =

> Cheers!
> David
> =

> > +struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output_=
type);
> > +
> > +/*
> > + * Destroy an instance of a configuration writer.
> > + *
> > + * writer An instance of a configuration writer.
> > + *
> > + * Returns zero if the XML document could be closed cleanly. Negative =
values
> > + * indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_destroy(struct mi_writer *writer);
> > +
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_command_open(struct mi_writer *writer, const char =
*command);
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_command_close(struct mi_writer *writer);
> > +
> > +/*
> > + * Open an element tag.
> > + *
> > + * writer An instance of a configuration writer.
> > + *
> > + * element_name Element tag name.
> > + *
> > + * Returns zero if the XML document could be closed cleanly.
> > + * Negative values indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_open_element(struct mi_writer *writer,
> > +		const char *element_name);
> > +
> > +/*
> > + * Close the current element tag.
> > + *
> > + * writer An instance of a configuration writer.
> > + *
> > + * Returns zero if the XML document could be closed cleanly.
> > + * Negative values indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_close_element(struct mi_writer *writer);
> > +
> > +/*
> > + * Write an element of type unsigned int.
> > + *
> > + * writer An instance of a configuration writer.
> > + *
> > + * element_name Element name.
> > + *
> > + * value Unsigned int value of the element
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *write=
r,
> > +		const char *element_name, uint64_t value);
> > +
> > +/*
> > + * Write an element of type signed int.
> > + *
> > + * writer An instance of a configuration writer.
> > + *
> > + * element_name Element name.
> > + *
> > + * value Signed int value of the element
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_signed_int(struct mi_writer *writer,
> > +		const char *element_name, int64_t value);
> > +
> > +/*
> > + * Write an element of type boolean.
> > + *
> > + * writer An instance of a configuration writer.
> > + *
> > + * element_name Element name.
> > + *
> > + * value Boolean value of the element
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_bool(struct mi_writer *writer,
> > +		const char *element_name, int value);
> > +
> > +/*
> > + * Write an element of type string.
> > + *
> > + * writer An instance of a configuration writer.
> > + *
> > + * element_name Element name.
> > + *
> > + * value String value of the element
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_string(struct mi_writer *writer,
> > +		const char *element_name, const char *value);
> > +
> > +/*
> > + * Machine interface of struct version.
> > + *
> > + * writer An instance of a mi writer.
> > + *
> > + * version Version struct.
> > + *
> > + * lttng_description String value of the version description.
> > + *
> > + * lttng_license String value of the version license.
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_version(struct mi_writer *writer, struct lttng_version *v=
ersion,
> > +	char *lttng_description, char *lttng_license);
> > +
> > +/*
> > + * Machine interface of struct session.
> > + *
> > + * writer An instance of a mi writer
> > + *
> > + * session An instance of a session
> > + *
> > + * isOpen Define if we close the session element
> > + *        This should be use carefully and the client
> > + *        need to close the session element.
> > + *        Use case: nested addition information on a session
> > + *                  ex: domain,channel event.
> > + *        0-> False
> > + *        1-> True
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +LTTNG_HIDDEN
> > +int mi_lttng_session(struct mi_writer *writer,
> > +		struct lttng_session *session, int isOpen);
> > +
> > +#endif /* _MI_LTTNG_H */
> > diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ct=
l.c
> > index 8e2593d..1112484 100644
> > --- a/src/lib/lttng-ctl/lttng-ctl.c
> > +++ b/src/lib/lttng-ctl/lttng-ctl.c
> > @@ -74,6 +74,7 @@ static int connected;
> >   */
> >  int lttng_opt_quiet;
> >  int lttng_opt_verbose;
> > +int lttng_opt_mi;
> >  =

> >  /*
> >   * Copy string from src to dst and enforce null terminated byte.
> > diff --git a/tests/unit/ini_config/ini_config.c b/tests/unit/ini_config=
/ini_config.c
> > index 38fe5f4..29935ef 100644
> > --- a/tests/unit/ini_config/ini_config.c
> > +++ b/tests/unit/ini_config/ini_config.c
> > @@ -31,6 +31,7 @@ struct state {
> >  =

> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose =3D 0;
> > +int lttng_opt_mi;
> >  =

> >  int entry_handler(const struct config_entry *entry,
> >  		struct state *state)
> > diff --git a/tests/unit/test_kernel_data.c b/tests/unit/test_kernel_dat=
a.c
> > index e2182e9..2639be4 100644
> > --- a/tests/unit/test_kernel_data.c
> > +++ b/tests/unit/test_kernel_data.c
> > @@ -38,6 +38,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose;
> > +int lttng_opt_mi;
> >  =

> >  int ust_consumerd32_fd;
> >  int ust_consumerd64_fd;
> > diff --git a/tests/unit/test_session.c b/tests/unit/test_session.c
> > index a0e84e9..4f90c33 100644
> > --- a/tests/unit/test_session.c
> > +++ b/tests/unit/test_session.c
> > @@ -46,6 +46,7 @@ static struct ltt_session_list *session_list;
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose =3D 0;
> > +int lttng_opt_mi;
> >  =

> >  int ust_consumerd32_fd;
> >  int ust_consumerd64_fd;
> > diff --git a/tests/unit/test_uri.c b/tests/unit/test_uri.c
> > index 7cac95d..432e2b3 100644
> > --- a/tests/unit/test_uri.c
> > +++ b/tests/unit/test_uri.c
> > @@ -25,6 +25,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose =3D 3;
> > +int lttng_opt_mi;
> >  =

> >  /* Number of TAP tests in this file */
> >  #define NUM_TESTS 11
> > diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
> > index bc3154c..54b96d6 100644
> > --- a/tests/unit/test_ust_data.c
> > +++ b/tests/unit/test_ust_data.c
> > @@ -44,6 +44,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose;
> > +int lttng_opt_mi;
> >  =

> >  int ust_consumerd32_fd;
> >  int ust_consumerd64_fd;
> > diff --git a/tests/unit/test_utils_expand_path.c b/tests/unit/test_util=
s_expand_path.c
> > index fe709ac..f863b5d 100644
> > --- a/tests/unit/test_utils_expand_path.c
> > +++ b/tests/unit/test_utils_expand_path.c
> > @@ -31,6 +31,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose =3D 3;
> > +int lttng_opt_mi;
> >  =

> >  struct valid_test_input {
> >  	char *input;
> > diff --git a/tests/unit/test_utils_parse_size_suffix.c b/tests/unit/tes=
t_utils_parse_size_suffix.c
> > index 990aa1b..f81278d 100644
> > --- a/tests/unit/test_utils_parse_size_suffix.c
> > +++ b/tests/unit/test_utils_parse_size_suffix.c
> > @@ -26,6 +26,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose =3D 3;
> > +int lttng_opt_mi;
> >  =

> >  struct valid_test_input {
> >  	char *input;
> > -- =

> > 1.7.9.5
> > =

> > =

> > -- =

> > Jonathan Rajotte Julien
> > Charg=E9 de laboratoire INF1995
> > Membre MD6
> > Polytechnique Montr=E9al
> > =

> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

Jonathan Rajotte Julien
Charg=E9 de laboratoire INF1995
Membre MD6
Polytechnique Montr=E9al
