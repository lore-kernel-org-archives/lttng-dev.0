From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: [MI RFC 1/3] Mi: mi backend + mi for command version
Date: Mon, 14 Apr 2014 11:32:35 -0400
Message-ID: <CAF4oYfF51hSeAhCFALyKoajhbLEaU_RD91DQY0Yqg1P114JkJw__4452.27795648879$1397489657$gmane$org@mail.gmail.com>
References: <20140406193032.GA24869@psrcode-MS-7693>
 <20140414152631.GA32712@thessa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0477889171=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1WZisD-0001yW-D5
 for lttng-dev@lists.lttng.org; Mon, 14 Apr 2014 11:32:53 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so6666602yha.14
 for <lttng-dev@lists.lttng.org>; Mon, 14 Apr 2014 08:32:35 -0700 (PDT)
In-Reply-To: <20140414152631.GA32712@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0477889171==
Content-Type: multipart/alternative; boundary=089e0160bea6896d7404f7026445

--089e0160bea6896d7404f7026445
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

We will also provide patches for snapshot + regression test.

Could you send me the minor modifications? I wouldn't like to make the same
mistakes twice.

Thanks


On Mon, Apr 14, 2014 at 11:26 AM, David Goulet <dgoulet@efficios.com> wrote=
:

> I've fixed some minor things and prepared this one for a merge.
>
> Once the full patch set is ready to be merged, I'll be pushing them all
> at once.
>
> Thanks!
> David
>
> On 06 Apr (15:30:32), Jonathan Rajotte wrote:
> > Hi,
> >
> > These patches add machine interface functionality to command version an=
d
> list.
> > At the same time they procure a base architecture of the machine
> > interface.
> >
> > The first patch cover the version command and add the base for the
> > machine interface.(mostly the same as last week mi patch)
> > p.s: David if you want to pull this one [1].
> >
> > The second patch provide full machine interface functionality to the li=
st
> > command. You will find attached a little script that demonstrate the mi
> > functionality of list. The script need a root sessiond and need to be
> > at the base of lttng-tool directory. Outputs will be generated in
> > ./mi_test_output/ .
> >
> > The third patch provide an xsd to validate the mi output of list and
> > version command.
> >
> > Voil=C3=A0!
> >
> > Jonathan
> >
> > [1] https://github.com/PSRCode/lttng-tools-dev/commits/list_release
> >     commit: add4aa1a79247749cb823ec68ab1067beda937d0
> > --Patch--
> >
> > The machine interface option is now available for version.
> > Other commands will shortly follow.
> > Mi backend is expected to grow with addition of mi support
> > to other commands.
> >
> > How to use:
> >       lttng --mi <mi_output_type> <command>
> >
> > This syntax will be the same for all commands.
> > Currently *only xml is supported as machine interface output.*
> >
> > As for errors handling, if an error/warning occurs while using mi it
> will be
> > reported on stderr as normal. The integrity of the mi output cannot be
> > guaranteed if an error/warning occurs.
> > The error output format is consistent and easy for a machine client to
> parse.
> > Thus no mi output format is required for error output.
> >
> > Example:
> >       lttng --mi xml version
> > Output:
> > <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> >   <command>
> >     <name>version</name>
> >     <output>
> >       <string>2.4.0-rc2</string>
> >       <major>2</major>
> >       <minor>4</minor>
> >       <patchLevel>0</patchLevel>
> >       <name>=C3=89poque Opaque</name>
> >       <description>The =C3=89poque Opaque is a black IPA from Trou du D=
iable
> >       brewery. The nose is eerily reminiscent of the coffee crisp candy
> from
> >       of our childhood. These strong mocha accents are present on the
> palate,
> >       which are quickly subdued by Japanese and Australian hops leading
> to a
> >       final state of satisfaction enjoyable for any fan of bitter
> >       beer.</description>
> >       <url>http://lttng.org</url>
> >       <license>lttng is free software and under the GPL license and par=
t
> >       LGPL</license>
> >   </output>
> > </command>
> >
> > Signed-off-by: Olivier Cotte <olivier.cotte@polymtl.ca>
> > Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
> > ---
> >  include/lttng/lttng-error.h               |   6 +-
> >  include/lttng/lttng.h                     |   5 +
> >  src/bin/lttng-consumerd/lttng-consumerd.c |   2 +
> >  src/bin/lttng/commands/add_context.c      |   7 +
> >  src/bin/lttng/commands/calibrate.c        |   7 +
> >  src/bin/lttng/commands/create.c           |   7 +
> >  src/bin/lttng/commands/destroy.c          |   7 +
> >  src/bin/lttng/commands/disable_channels.c |   7 +
> >  src/bin/lttng/commands/disable_events.c   |   7 +
> >  src/bin/lttng/commands/enable_channels.c  |   7 +
> >  src/bin/lttng/commands/enable_events.c    |   7 +
> >  src/bin/lttng/commands/list.c             |   7 +
> >  src/bin/lttng/commands/load.c             |   7 +
> >  src/bin/lttng/commands/save.c             |   7 +
> >  src/bin/lttng/commands/set_session.c      |   7 +
> >  src/bin/lttng/commands/snapshot.c         |   7 +
> >  src/bin/lttng/commands/start.c            |   7 +
> >  src/bin/lttng/commands/stop.c             |   7 +
> >  src/bin/lttng/commands/version.c          |  88 ++++++++-
> >  src/bin/lttng/commands/view.c             |   4 +
> >  src/bin/lttng/lttng.c                     |  32 +++-
> >  src/common/Makefile.am                    |   5 +-
> >  src/common/error.h                        |  11 +-
> >  src/common/mi-lttng.c                     | 284
> ++++++++++++++++++++++++++++++
> >  src/common/mi-lttng.h                     | 230 ++++++++++++++++++++++=
++
> >  src/lib/lttng-ctl/lttng-ctl.c             |   1 +
> >  tests/unit/ini_config/ini_config.c        |   1 +
> >  tests/unit/test_kernel_data.c             |   1 +
> >  tests/unit/test_session.c                 |   1 +
> >  tests/unit/test_uri.c                     |   1 +
> >  tests/unit/test_ust_data.c                |   1 +
> >  tests/unit/test_utils_expand_path.c       |   1 +
> >  tests/unit/test_utils_parse_size_suffix.c |   1 +
> >  33 files changed, 769 insertions(+), 11 deletions(-)
> >  create mode 100644 src/common/mi-lttng.c
> >  create mode 100644 src/common/mi-lttng.h
> >
> > diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h
> > index 06baa04..1594ba9 100644
> > --- a/include/lttng/lttng-error.h
> > +++ b/include/lttng/lttng-error.h
> > @@ -120,9 +120,9 @@ enum lttng_error_code {
> >       LTTNG_ERR_LOAD_INVALID_CONFIG    =3D 87,  /* Invalid session
> configuration */
> >       LTTNG_ERR_LOAD_IO_FAIL           =3D 88,  /* IO error while readi=
ng
> a session configuration */
> >       LTTNG_ERR_LOAD_SESSION_NOENT     =3D 89,  /* Session file not fou=
nd
> */
> > -     /* 90 */
> > -     /* 91 */
> > -     /* 92 */
> > +     LTTNG_ERR_MI_OUTPUT_TYPE         =3D 90, /* Invalid MI output for=
mat
> */
> > +     LTTNG_ERR_MI_IO_FAIL             =3D 91, /* IO error while writin=
g
> machine interface output */
> > +     LTTNG_ERR_MI_NOT_IMPLEMENTED     =3D 92, /* Mi feature not
> implemented */
> >       /* 93 */
> >       /* 94 */
> >       /* 95 */
> > diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
> > index f0be224..9449161 100644
> > --- a/include/lttng/lttng.h
> > +++ b/include/lttng/lttng.h
> > @@ -170,6 +170,11 @@ enum lttng_buffer_type {
> >       LTTNG_BUFFER_GLOBAL,    /* Only supported by the Kernel. */
> >  };
> >
> > +/* Machine interface output type */
> > +enum lttng_mi_output_type {
> > +     LTTNG_MI_XML                          =3D 1 /* XML output */
> > +};
> > +
> >  /*
> >   * The structures should be initialized to zero before use.
> >   */
> > diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c
> b/src/bin/lttng-consumerd/lttng-consumerd.c
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
> >  static char command_sock_path[PATH_MAX]; /* Global command socket path
> */
> > diff --git a/src/bin/lttng/commands/add_context.c
> b/src/bin/lttng/commands/add_context.c
> > index 6483c98..2eb0e90 100644
> > --- a/src/bin/lttng/commands/add_context.c
> > +++ b/src/bin/lttng/commands/add_context.c
> > @@ -446,6 +446,13 @@ int cmd_add_context(int argc, const char **argv)
> >               goto end;
> >       }
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > diff --git a/src/bin/lttng/commands/calibrate.c
> b/src/bin/lttng/commands/calibrate.c
> > index 092632c..7d4de29 100644
> > --- a/src/bin/lttng/commands/calibrate.c
> > +++ b/src/bin/lttng/commands/calibrate.c
> > @@ -133,6 +133,13 @@ static int calibrate_lttng(void)
> >               goto error;
> >       }
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto error;
> > +     }
> > +
> >       handle =3D lttng_create_handle(NULL, &dom);
> >       if (handle =3D=3D NULL) {
> >               ret =3D CMD_ERROR;
> > diff --git a/src/bin/lttng/commands/create.c
> b/src/bin/lttng/commands/create.c
> > index e02b141..c43ce59 100644
> > --- a/src/bin/lttng/commands/create.c
> > +++ b/src/bin/lttng/commands/create.c
> > @@ -515,6 +515,13 @@ int cmd_create(int argc, const char **argv)
> >               }
> >       }
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       if (opt_no_consumer) {
> >               MSG("The option --no-consumer is obsolete. Use --no-outpu=
t
> now.");
> >               ret =3D CMD_WARNING;
> > diff --git a/src/bin/lttng/commands/destroy.c
> b/src/bin/lttng/commands/destroy.c
> > index 3fb5fb2..26548b9 100644
> > --- a/src/bin/lttng/commands/destroy.c
> > +++ b/src/bin/lttng/commands/destroy.c
> > @@ -148,6 +148,13 @@ int cmd_destroy(int argc, const char **argv)
> >               goto end;
> >       }
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       /* Ignore session name in case all sessions are to be destroyed *=
/
> >       if (opt_destroy_all) {
> >               ret =3D destroy_all_sessions();
> > diff --git a/src/bin/lttng/commands/disable_channels.c
> b/src/bin/lttng/commands/disable_channels.c
> > index 1aa3916..da53d25 100644
> > --- a/src/bin/lttng/commands/disable_channels.c
> > +++ b/src/bin/lttng/commands/disable_channels.c
> > @@ -167,6 +167,13 @@ int cmd_disable_channels(int argc, const char
> **argv)
> >               }
> >       }
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       opt_channels =3D (char*) poptGetArg(pc);
> >       if (opt_channels =3D=3D NULL) {
> >               ERR("Missing channel name(s).\n");
> > diff --git a/src/bin/lttng/commands/disable_events.c
> b/src/bin/lttng/commands/disable_events.c
> > index e712343..fb96b80 100644
> > --- a/src/bin/lttng/commands/disable_events.c
> > +++ b/src/bin/lttng/commands/disable_events.c
> > @@ -212,6 +212,13 @@ int cmd_disable_events(int argc, const char **argv=
)
> >               }
> >       }
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       opt_event_list =3D (char*) poptGetArg(pc);
> >       if (opt_event_list =3D=3D NULL && opt_disable_all =3D=3D 0) {
> >               ERR("Missing event name(s).\n");
> > diff --git a/src/bin/lttng/commands/enable_channels.c
> b/src/bin/lttng/commands/enable_channels.c
> > index 55fbae6..8ea405e 100644
> > --- a/src/bin/lttng/commands/enable_channels.c
> > +++ b/src/bin/lttng/commands/enable_channels.c
> > @@ -327,6 +327,13 @@ int cmd_enable_channels(int argc, const char **arg=
v)
> >       pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/commands/enable_events.c
> b/src/bin/lttng/commands/enable_events.c
> > index bd2d997..8c7a73e 100644
> > --- a/src/bin/lttng/commands/enable_events.c
> > +++ b/src/bin/lttng/commands/enable_events.c
> > @@ -968,6 +968,13 @@ int cmd_enable_events(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       /* Default event type */
> >       opt_event_type =3D LTTNG_EVENT_ALL;
> >
> > diff --git a/src/bin/lttng/commands/list.c
> b/src/bin/lttng/commands/list.c
> > index f69b3ba..bbd674c 100644
> > --- a/src/bin/lttng/commands/list.c
> > +++ b/src/bin/lttng/commands/list.c
> > @@ -850,6 +850,13 @@ int cmd_list(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/commands/load.c
> b/src/bin/lttng/commands/load.c
> > index e732baa..2cfc698 100644
> > --- a/src/bin/lttng/commands/load.c
> > +++ b/src/bin/lttng/commands/load.c
> > @@ -77,6 +77,13 @@ int cmd_load(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, load_opts, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/commands/save.c
> b/src/bin/lttng/commands/save.c
> > index e8a4565..1aeb9f2 100644
> > --- a/src/bin/lttng/commands/save.c
> > +++ b/src/bin/lttng/commands/save.c
> > @@ -73,6 +73,13 @@ int cmd_save(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, save_opts, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/commands/set_session.c
> b/src/bin/lttng/commands/set_session.c
> > index 4238016..54320df 100644
> > --- a/src/bin/lttng/commands/set_session.c
> > +++ b/src/bin/lttng/commands/set_session.c
> > @@ -92,6 +92,13 @@ int cmd_set_session(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/commands/snapshot.c
> b/src/bin/lttng/commands/snapshot.c
> > index c704eee..21b5a05 100644
> > --- a/src/bin/lttng/commands/snapshot.c
> > +++ b/src/bin/lttng/commands/snapshot.c
> > @@ -446,6 +446,13 @@ int cmd_snapshot(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, snapshot_opts, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/commands/start.c
> b/src/bin/lttng/commands/start.c
> > index 82122cc..82b3f5f 100644
> > --- a/src/bin/lttng/commands/start.c
> > +++ b/src/bin/lttng/commands/start.c
> > @@ -118,6 +118,13 @@ int cmd_start(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/commands/stop.c
> b/src/bin/lttng/commands/stop.c
> > index 60a1dac..5de96d8 100644
> > --- a/src/bin/lttng/commands/stop.c
> > +++ b/src/bin/lttng/commands/stop.c
> > @@ -122,6 +122,13 @@ int cmd_stop(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     /* TODO: mi support */
> > +     if (lttng_opt_mi) {
> > +             ret =3D -LTTNG_ERR_MI_NOT_IMPLEMENTED;
> > +             ERR("mi option not supported");
> > +             goto end;
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/commands/version.c
> b/src/bin/lttng/commands/version.c
> > index 7f69de3..5c7ebbf 100644
> > --- a/src/bin/lttng/commands/version.c
> > +++ b/src/bin/lttng/commands/version.c
> > @@ -25,6 +25,8 @@
> >  #include <unistd.h>
> >  #include <config.h>
> >
> > +#include <common/mi-lttng.h>
> > +
> >  #include "../command.h"
> >
> >  enum {
> > @@ -32,6 +34,8 @@ enum {
> >       OPT_LIST_OPTIONS,
> >  };
> >
> > +static const char *lttng_license =3D "lttng is free software and under
> the GPL license and part LGPL";
> > +
> >  static struct poptOption long_options[] =3D {
> >       /* longName, shortName, argInfo, argPtr, value, descrip, argDesc =
*/
> >       {"help",      'h', POPT_ARG_NONE, 0, OPT_HELP, 0, 0},
> > @@ -53,6 +57,78 @@ static void usage(FILE *ofp)
> >  }
> >
> >  /*
> > + *  create_version
> > + */
> > +static void create_version(struct mi_lttng_version *version)
> > +{
> > +     strncpy(version->version, VERSION, NAME_MAX);
> > +     version->version_major =3D VERSION_MAJOR;
> > +     version->version_minor =3D VERSION_MINOR;
> > +     version->version_patchlevel =3D VERSION_PATCHLEVEL;
> > +     strncpy(version->version_name, VERSION_NAME, NAME_MAX);
> > +     strncpy(version->package_url, PACKAGE_URL, NAME_MAX);
> > +}
> > +
> > +/*
> > + *  print_mi
> > + */
> > +static int print_mi()
> > +{
> > +     int ret;
> > +     struct mi_writer *writer =3D NULL;
> > +     struct mi_lttng_version version;
> > +
> > +     create_version(&version);
> > +
> > +     writer =3D mi_lttng_writer_create(fileno(stdout), lttng_opt_mi);
> > +
> > +     if (!writer) {
> > +             ret =3D -LTTNG_ERR_NOMEM;
> > +             goto end;
> > +     }
> > +
> > +     /* Open the command element */
> > +     ret =3D mi_lttng_writer_command_open(writer,
> > +                     mi_lttng_element_command_version);
> > +     if (ret) {
> > +             goto error;
> > +     }
> > +
> > +     /* Beginning of output */
> > +     ret =3D mi_lttng_writer_open_element(writer,
> > +                     mi_lttng_element_command_output);
> > +     if (ret) {
> > +             goto error;
> > +     }
> > +
> > +     /* Print the machine interface of version */
> > +     ret =3D mi_lttng_version(writer, &version,
> > +                     VERSION_DESCRIPTION, lttng_license);
> > +     if (ret) {
> > +             goto error;
> > +     }
> > +
> > +     /* Close the output element */
> > +     ret =3D mi_lttng_writer_close_element(writer);
> > +     if (ret) {
> > +             goto error;
> > +     }
> > +
> > +     /* Close the command  */
> > +     ret =3D mi_lttng_writer_command_close(writer);
> > +
> > +error:
> > +     /* Cleanup */
> > +     if (writer && mi_lttng_writer_destroy(writer)) {
> > +             /* Preserve original error code */
> > +             ret =3D ret ? ret : LTTNG_ERR_MI_IO_FAIL;
> > +     }
> > +
> > +end:
> > +     return ret;
> > +}
> > +
> > +/*
> >   *  cmd_version
> >   */
> >  int cmd_version(int argc, const char **argv)
> > @@ -78,10 +154,14 @@ int cmd_version(int argc, const char **argv)
> >               }
> >       }
> >
> > -     MSG("lttng version " VERSION " - " VERSION_NAME);
> > -     MSG("\n" VERSION_DESCRIPTION "\n");
> > -     MSG("Web site: http://lttng.org");
> > -     MSG("\nlttng is free software and under the GPL license and part
> LGPL");
> > +     if (lttng_opt_mi) {
> > +             ret =3D print_mi();
> > +     } else {
> > +             MSG("lttng version " VERSION " - " VERSION_NAME);
> > +             MSG("\n" VERSION_DESCRIPTION "\n");
> > +             MSG("Web site: http://lttng.org");
> > +             MSG("\n%s", lttng_license);
> > +     }
> >
> >  end:
> >       poptFreeContext(pc);
> > diff --git a/src/bin/lttng/commands/view.c
> b/src/bin/lttng/commands/view.c
> > index adedf29..dcd4d66 100644
> > --- a/src/bin/lttng/commands/view.c
> > +++ b/src/bin/lttng/commands/view.c
> > @@ -445,6 +445,10 @@ int cmd_view(int argc, const char **argv)
> >       pc =3D poptGetContext(NULL, argc, argv, long_options, 0);
> >       poptReadDefaultConfig(pc, 0);
> >
> > +     if (lttng_opt_mi) {
> > +             WARN("mi does not apply to view command");
> > +     }
> > +
> >       while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {
> >               switch (opt) {
> >               case OPT_HELP:
> > diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c
> > index bc7577d..4510057 100644
> > --- a/src/bin/lttng/lttng.c
> > +++ b/src/bin/lttng/lttng.c
> > @@ -55,6 +55,7 @@ static struct option long_options[] =3D {
> >       {"group",            1, NULL, 'g'},
> >       {"verbose",          0, NULL, 'v'},
> >       {"quiet",            0, NULL, 'q'},
> > +     {"mi",               1, NULL, 'm'},
> >       {"no-sessiond",      0, NULL, 'n'},
> >       {"sessiond-path",    1, NULL, OPT_SESSION_PATH},
> >       {"relayd-path",      1, NULL, OPT_RELAYD_PATH},
> > @@ -99,6 +100,8 @@ static void usage(FILE *ofp)
> >       fprintf(ofp, "      --list-commands        Simple listing of lttn=
g
> commands\n");
> >       fprintf(ofp, "  -v, --verbose              Increase verbosity\n")=
;
> >       fprintf(ofp, "  -q, --quiet                Quiet mode\n");
> > +     fprintf(ofp, "  -m, --mi TYPE              Machine Interface
> mode.\n");
> > +     fprintf(ofp, "                                 Type: xml\n");
> >       fprintf(ofp, "  -g, --group NAME           Unix tracing group
> name. (default: tracing)\n");
> >       fprintf(ofp, "  -n, --no-sessiond          Don't spawn a session
> daemon\n");
> >       fprintf(ofp, "      --sessiond-path PATH   Session daemon full
> path\n");
> > @@ -136,6 +139,26 @@ static void version(FILE *ofp)
> >  }
> >
> >  /*
> > + * mi_output_type
> > + *
> > + * Find the MI output type enum from a string
> > + * This function is for the support of
> > + * new output language.
> > + */
> > +static int mi_output_type(const char *output_type)
> > +{
> > +     int ret =3D 0;
> > +     if (!strncasecmp("xml", output_type, 3)) {
> > +             ret =3D LTTNG_MI_XML;
> > +     } else {
> > +             /* Invalid output format */
> > +             ERR("MI output format not supported");
> > +             ret =3D -LTTNG_ERR_MI_OUTPUT_TYPE;
> > +     }
> > +     return ret;
> > +}
> > +
> > +/*
> >   *  list_options
> >   *
> >   *  List options line by line. This is mostly for bash auto completion
> and to
> > @@ -426,7 +449,7 @@ static int parse_args(int argc, char **argv)
> >               clean_exit(EXIT_FAILURE);
> >       }
> >
> > -     while ((opt =3D getopt_long(argc, argv, "+Vhnvqg:", long_options,
> NULL)) !=3D -1) {
> > +     while ((opt =3D getopt_long(argc, argv, "+Vhnvqg:m:", long_option=
s,
> NULL)) !=3D -1) {
> >               switch (opt) {
> >               case 'V':
> >                       version(stdout);
> > @@ -442,6 +465,13 @@ static int parse_args(int argc, char **argv)
> >               case 'q':
> >                       lttng_opt_quiet =3D 1;
> >                       break;
> > +             case 'm':
> > +                     lttng_opt_mi =3D mi_output_type(optarg);
> > +                     if (lttng_opt_mi < 0) {
> > +                             ret =3D lttng_opt_mi;
> > +                             goto error;
> > +                     }
> > +                     break;
> >               case 'g':
> >                       lttng_set_tracing_group(optarg);
> >                       break;
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
> > +             -luuid \
> > +             $(top_builddir)/src/common/config/libconfig.la
> >
> >  # Consumer library
> >  noinst_LTLIBRARIES +=3D libconsumer.la
> > diff --git a/src/common/error.h b/src/common/error.h
> > index f8c0a1d..4e096b3 100644
> > --- a/src/common/error.h
> > +++ b/src/common/error.h
> > @@ -36,6 +36,7 @@
> >
> >  extern int lttng_opt_quiet;
> >  extern int lttng_opt_verbose;
> > +extern int lttng_opt_mi;
> >
> >  /* Error type. */
> >  #define PRINT_ERR   0x1
> > @@ -48,12 +49,18 @@ extern int lttng_opt_verbose;
> >
> >  /*
> >   * Macro for printing message depending on command line option and
> verbosity.
> > + *
> > + * Machine interface:
> > + * We use lttng_opt_mi to suppress all normal msg to stdout. We don't
> > + * want any nested msg to show up when printing mi to stdout(if it's
> the case).
> > + * All warnings and errors should be printed to stderr as normal.
> >   */
> >  #define __lttng_print(type, fmt, args...)                           \
> >       do {                                                            \
> > -             if (lttng_opt_quiet =3D=3D 0 && type =3D=3D PRINT_MSG) {
>  \
> > +             if (lttng_opt_quiet =3D=3D 0 && lttng_opt_mi =3D=3D 0 &&
>  \
> > +                             type =3D=3D PRINT_MSG) {
>          \
> >                       fprintf(stdout, fmt, ## args);
>      \
> > -             } else if (lttng_opt_quiet =3D=3D 0 &&
>  \
> > +             } else if (lttng_opt_quiet =3D=3D 0 && lttng_opt_mi =3D=
=3D 0 &&
>   \
> >                               (((type & PRINT_DBG) && lttng_opt_verbose
> =3D=3D 1) ||  \
> >                               ((type & (PRINT_DBG | PRINT_DBG2)) &&
>           \
> >                                       lttng_opt_verbose =3D=3D 2) ||
>              \
> > diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c
> > new file mode 100644
> > index 0000000..bbec2c5
> > --- /dev/null
> > +++ b/src/common/mi-lttng.c
> > @@ -0,0 +1,284 @@
> > +/*
> > + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.co=
m
> >
> > + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> it
> > + * under the terms of the GNU General Public License, version 2 only, =
as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
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
> > +const char * const mi_lttng_element_version =3D "version";
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
> > +struct mi_writer *mi_lttng_writer_create(int fd_output, int
> mi_output_type)
> > +{
> > +     struct mi_writer *mi_writer;
> > +
> > +     mi_writer =3D zmalloc(sizeof(struct mi_writer));
> > +     if (!mi_writer) {
> > +             PERROR("zmalloc mi_writer_create");
> > +             goto end;
> > +     }
> > +     if (mi_output_type =3D=3D LTTNG_MI_XML) {
> > +             mi_writer->writer =3D config_writer_create(fd_output);
> > +             if (!mi_writer->writer) {
> > +                     goto err_destroy;
> > +             }
> > +             mi_writer->type =3D LTTNG_MI_XML;
> > +     } else {
> > +             goto err_destroy;
> > +     }
> > +
> > +end:
> > +     return mi_writer;
> > +
> > +err_destroy:
> > +     free(mi_writer);
> > +     return NULL;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_destroy(struct mi_writer *writer)
> > +{
> > +     int ret;
> > +
> > +     if (!writer) {
> > +             ret =3D -EINVAL;
> > +             goto end;
> > +     }
> > +
> > +     ret =3D config_writer_destroy(writer->writer);
> > +     if (ret < 0) {
> > +             goto end;
> > +     }
> > +
> > +     free(writer);
> > +end:
> > +     return ret;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_command_open(struct mi_writer *writer, const char
> *command)
> > +{
> > +     int ret;
> > +     ret =3D mi_lttng_writer_open_element(writer,
> mi_lttng_element_command);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +     ret =3D mi_lttng_writer_write_element_string(writer,
> > +                     mi_lttng_element_command_name, command);
> > +end:
> > +     return ret;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_command_close(struct mi_writer *writer)
> > +{
> > +     return mi_lttng_writer_close_element(writer);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_open_element(struct mi_writer *writer,
> > +             const char *element_name)
> > +{
> > +     return config_writer_open_element(writer->writer, element_name);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_close_element(struct mi_writer *writer)
> > +{
> > +     return config_writer_close_element(writer->writer);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *write=
r,
> > +             const char *element_name, uint64_t value)
> > +{
> > +     return config_writer_write_element_unsigned_int(writer->writer,
> > +                     element_name, value);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_signed_int(struct mi_writer *writer,
> > +             const char *element_name, int64_t value)
> > +{
> > +     return config_writer_write_element_signed_int(writer->writer,
> > +                     element_name, value);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_bool(struct mi_writer *writer,
> > +             const char *element_name, int value)
> > +{
> > +     return config_writer_write_element_bool(writer->writer,
> > +                     element_name, value);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_writer_write_element_string(struct mi_writer *writer,
> > +             const char *element_name, const char *value)
> > +{
> > +     return config_writer_write_element_string(writer->writer,
> > +                     element_name, value);
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_version(struct mi_writer *writer, struct mi_lttng_version
> *version,
> > +     const char *lttng_description, const char *lttng_license)
> > +{
> > +     int ret;
> > +
> > +     /* Open version */
> > +     ret =3D mi_lttng_writer_open_element(writer,
> mi_lttng_element_version);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* Version string (contain info like rc etc.) */
> > +     ret =3D mi_lttng_writer_write_element_string(writer,
> > +                     mi_lttng_element_version_str, VERSION);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* Major version number */
> > +     ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +                     mi_lttng_element_version_major,
> version->version_major);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* Minor version number */
> > +     ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +                     mi_lttng_element_version_minor,
> version->version_minor);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* Patch number */
> > +     ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +                     mi_lttng_element_version_patch_level,
> version->version_patchlevel);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* Name of the version */
> > +     ret =3D mi_lttng_writer_write_element_string(writer,
> > +                     config_element_name, version->version_name);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* Description mostly related to beer... */
> > +     ret =3D mi_lttng_writer_write_element_string(writer,
> > +                     mi_lttng_element_version_description,
> lttng_description);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* url */
> > +     ret =3D mi_lttng_writer_write_element_string(writer,
> > +                     mi_lttng_element_version_web,
> version->package_url);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* License: free as in free beer...no...*speech* */
> > +     ret =3D mi_lttng_writer_write_element_string(writer,
> > +                     mi_lttng_element_version_license, lttng_license);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* Close version element */
> > +     ret =3D mi_lttng_writer_close_element(writer);
> > +
> > +end:
> > +     return ret;
> > +}
> > +
> > +LTTNG_HIDDEN
> > +int mi_lttng_session(struct mi_writer *writer,
> > +             struct lttng_session *session, int is_open)
> > +{
> > +     int ret;
> > +
> > +     /* open sessions element */
> > +     ret =3D mi_lttng_writer_open_element(writer,
> > +                     config_element_session);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* Name of the session */
> > +     ret =3D mi_lttng_writer_write_element_string(writer,
> > +                     config_element_name, session->name);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* path */
> > +     ret =3D mi_lttng_writer_write_element_string(writer,
> > +                     config_element_path, session->path);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* enabled ? */
> > +     ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +                     config_element_enabled, session->enabled);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* snapshot mode */
> > +     ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +                     config_element_snapshot_mode,
> session->snapshot_mode);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     /* live timer interval in usec */
> > +     ret =3D mi_lttng_writer_write_element_unsigned_int(writer,
> > +                     config_element_live_timer_interval,
> > +                     session->live_timer_interval);
> > +     if (ret) {
> > +             goto end;
> > +     }
> > +
> > +     if (!is_open) {
> > +             /* Closing session element */
> > +             ret =3D mi_lttng_writer_close_element(writer);
> > +     }
> > +end:
> > +     return ret;
> > +
> > +}
> > diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h
> > new file mode 100644
> > index 0000000..69ec0f5
> > --- /dev/null
> > +++ b/src/common/mi-lttng.h
> > @@ -0,0 +1,230 @@
> > +/*
> > + * Copyright (C) 2014   - Jonathan Rajotte <jonathan.r.julien@gmail.co=
m
> >
> > + *                      - Olivier Cotte <olivier.cotte@polymtl.ca>
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> it
> > + * under the terms of the GNU General Public License, version 2 only, =
as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
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
> > +     struct config_writer *writer;
> > +     enum lttng_mi_output_type type;
> > +};
> > +
> > +/*
> > + * Version information for the machine interface.
> > + */
> > +struct mi_lttng_version {
> > +     char version[NAME_MAX]; /* Version number of package */
> > +     uint32_t version_major; /* LTTng-Tools major version number */
> > +     uint32_t version_minor; /* LTTng-Tools minor version number */
> > +     uint32_t version_patchlevel; /* LTTng-Tools patchlevel version
> number */
> > +     char version_name[NAME_MAX];
> > +     char package_url[NAME_MAX]; /* Define to the home page for this
> package. */
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
> > +const char * const mi_lttng_element_version;
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
> > + * fd_output File to which the XML content must be written. The file
> will be
> > + * closed once the mi_writer has been destroyed.
> > + *
> > + * Returns an instance of a machine interface writer on success, NULL =
on
> > + * error.
> > + */
> > +struct mi_writer *mi_lttng_writer_create(int fd_output, int
> mi_output_type);
> > +
> > +/*
> > + * Destroy an instance of a machine interface writer.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * Returns zero if the XML document could be closed cleanly. Negative
> values
> > + * indicate an error.
> > + */
> > +int mi_lttng_writer_destroy(struct mi_writer *writer);
> > +
> > +/*
> > + * Open a command tag and add it's name node.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * command The command name.
> > + *
> > + * Returns zero if the XML document could be closed cleanly.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_writer_command_open(struct mi_writer *writer, const char
> *command);
> > +
> > +/*
> > + * Close a command tag.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * Returns zero if the XML document could be closed cleanly.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_writer_command_close(struct mi_writer *writer);
> > +
> > +/*
> > + * Open an element tag.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * element_name Element tag name.
> > + *
> > + * Returns zero if the XML document could be closed cleanly.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_writer_open_element(struct mi_writer *writer,
> > +             const char *element_name);
> > +
> > +/*
> > + * Close the current element tag.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * Returns zero if the XML document could be closed cleanly.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_writer_close_element(struct mi_writer *writer);
> > +
> > +/*
> > + * Write an element of type unsigned int.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * element_name Element name.
> > + *
> > + * value Unsigned int value of the element
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *write=
r,
> > +             const char *element_name, uint64_t value);
> > +
> > +/*
> > + * Write an element of type signed int.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * element_name Element name.
> > + *
> > + * value Signed int value of the element
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_writer_write_element_signed_int(struct mi_writer *writer,
> > +             const char *element_name, int64_t value);
> > +
> > +/*
> > + * Write an element of type boolean.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * element_name Element name.
> > + *
> > + * value Boolean value of the element
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_writer_write_element_bool(struct mi_writer *writer,
> > +             const char *element_name, int value);
> > +
> > +/*
> > + * Write an element of type string.
> > + *
> > + * writer An instance of a machine interface writer.
> > + *
> > + * element_name Element name.
> > + *
> > + * value String value of the element
> > + *
> > + * Returns zero if the element's value could be written.
> > + * Negative values indicate an error.
> > + */
> > +int mi_lttng_writer_write_element_string(struct mi_writer *writer,
> > +             const char *element_name, const char *value);
> > +
> > +/*
> > + * Machine interface of struct version.
> > + *
> > + * writer An instance of a machine interface writer.
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
> > +int mi_lttng_version(struct mi_writer *writer, struct mi_lttng_version
> *version,
> > +             const char *lttng_description, const char *lttng_license)=
;
> > +
> > +/*
> > + * Machine interface of struct session.
> > + *
> > + * writer An instance of a machine interface writer
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
> > +int mi_lttng_session(struct mi_writer *writer,
> > +             struct lttng_session *session, int isOpen);
> > +
> > +#endif /* _MI_LTTNG_H */
> > diff --git a/src/lib/lttng-ctl/lttng-ctl.c
> b/src/lib/lttng-ctl/lttng-ctl.c
> > index 100e587..7dd9828 100644
> > --- a/src/lib/lttng-ctl/lttng-ctl.c
> > +++ b/src/lib/lttng-ctl/lttng-ctl.c
> > @@ -74,6 +74,7 @@ static int connected;
> >   */
> >  int lttng_opt_quiet;
> >  int lttng_opt_verbose;
> > +int lttng_opt_mi;
> >
> >  /*
> >   * Copy string from src to dst and enforce null terminated byte.
> > diff --git a/tests/unit/ini_config/ini_config.c
> b/tests/unit/ini_config/ini_config.c
> > index 38fe5f4..29935ef 100644
> > --- a/tests/unit/ini_config/ini_config.c
> > +++ b/tests/unit/ini_config/ini_config.c
> > @@ -31,6 +31,7 @@ struct state {
> >
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose =3D 0;
> > +int lttng_opt_mi;
> >
> >  int entry_handler(const struct config_entry *entry,
> >               struct state *state)
> > diff --git a/tests/unit/test_kernel_data.c
> b/tests/unit/test_kernel_data.c
> > index e2182e9..2639be4 100644
> > --- a/tests/unit/test_kernel_data.c
> > +++ b/tests/unit/test_kernel_data.c
> > @@ -38,6 +38,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose;
> > +int lttng_opt_mi;
> >
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
> >
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
> >
> >  /* Number of TAP tests in this file */
> >  #define NUM_TESTS 11
> > diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
> > index 150d5da..dd00089 100644
> > --- a/tests/unit/test_ust_data.c
> > +++ b/tests/unit/test_ust_data.c
> > @@ -44,6 +44,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose;
> > +int lttng_opt_mi;
> >
> >  int ust_consumerd32_fd;
> >  int ust_consumerd64_fd;
> > diff --git a/tests/unit/test_utils_expand_path.c
> b/tests/unit/test_utils_expand_path.c
> > index fe709ac..f863b5d 100644
> > --- a/tests/unit/test_utils_expand_path.c
> > +++ b/tests/unit/test_utils_expand_path.c
> > @@ -31,6 +31,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose =3D 3;
> > +int lttng_opt_mi;
> >
> >  struct valid_test_input {
> >       char *input;
> > diff --git a/tests/unit/test_utils_parse_size_suffix.c
> b/tests/unit/test_utils_parse_size_suffix.c
> > index 990aa1b..f81278d 100644
> > --- a/tests/unit/test_utils_parse_size_suffix.c
> > +++ b/tests/unit/test_utils_parse_size_suffix.c
> > @@ -26,6 +26,7 @@
> >  /* For error.h */
> >  int lttng_opt_quiet =3D 1;
> >  int lttng_opt_verbose =3D 3;
> > +int lttng_opt_mi;
> >
> >  struct valid_test_input {
> >       char *input;
> > --
> > 1.8.3.2
> >
>
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
Jonathan Rajotte Julien
Charg=C3=A9 de laboratoire, INF1995
Polytechnique Montr=C3=A9al

--089e0160bea6896d7404f7026445
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We will also provide patches for snapshot + regression tes=
t.<div><br></div><div>Could you send me the minor modifications? I wouldn&#=
39;t like to make the same mistakes twice.</div><div><br></div><div>Thanks =
=C2=A0</div>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Mon,=
 Apr 14, 2014 at 11:26 AM, David Goulet <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:dgoulet@efficios.com" target=3D"_blank">dgoulet@efficios.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I&#39;ve fixed some minor things and prepare=
d this one for a merge.<br>
<br>
Once the full patch set is ready to be merged, I&#39;ll be pushing them all=
<br>
at once.<br>
<br>
Thanks!<br>
David<br>
<div><div class=3D"h5"><br>
On 06 Apr (15:30:32), Jonathan Rajotte wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; These patches add machine interface functionality to command version a=
nd list.<br>
&gt; At the same time they procure a base architecture of the machine<br>
&gt; interface.<br>
&gt;<br>
&gt; The first patch cover the version command and add the base for the<br>
&gt; machine interface.(mostly the same as last week mi patch)<br>
&gt; p.s: David if you want to pull this one [1].<br>
&gt;<br>
&gt; The second patch provide full machine interface functionality to the l=
ist<br>
&gt; command. You will find attached a little script that demonstrate the m=
i<br>
&gt; functionality of list. The script need a root sessiond and need to be<=
br>
&gt; at the base of lttng-tool directory. Outputs will be generated in<br>
&gt; ./mi_test_output/ .<br>
&gt;<br>
&gt; The third patch provide an xsd to validate the mi output of list and<b=
r>
&gt; version command.<br>
&gt;<br>
&gt; Voil=C3=A0!<br>
&gt;<br>
&gt; Jonathan<br>
&gt;<br>
&gt; [1] <a href=3D"https://github.com/PSRCode/lttng-tools-dev/commits/list=
_release" target=3D"_blank">https://github.com/PSRCode/lttng-tools-dev/comm=
its/list_release</a><br>
&gt; =C2=A0 =C2=A0 commit: add4aa1a79247749cb823ec68ab1067beda937d0<br>
&gt; --Patch--<br>
&gt;<br>
&gt; The machine interface option is now available for version.<br>
&gt; Other commands will shortly follow.<br>
&gt; Mi backend is expected to grow with addition of mi support<br>
&gt; to other commands.<br>
&gt;<br>
&gt; How to use:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 lttng --mi &lt;mi_output_type&gt; &lt;command&gt;=
<br>
&gt;<br>
&gt; This syntax will be the same for all commands.<br>
&gt; Currently *only xml is supported as machine interface output.*<br>
&gt;<br>
&gt; As for errors handling, if an error/warning occurs while using mi it w=
ill be<br>
&gt; reported on stderr as normal. The integrity of the mi output cannot be=
<br>
&gt; guaranteed if an error/warning occurs.<br>
&gt; The error output format is consistent and easy for a machine client to=
 parse.<br>
&gt; Thus no mi output format is required for error output.<br>
&gt;<br>
&gt; Example:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 lttng --mi xml version<br>
&gt; Output:<br>
&gt; &lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;UTF-8&quot;?&gt;<b=
r>
&gt; =C2=A0 &lt;command&gt;<br>
&gt; =C2=A0 =C2=A0 &lt;name&gt;version&lt;/name&gt;<br>
&gt; =C2=A0 =C2=A0 &lt;output&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 &lt;string&gt;2.4.0-rc2&lt;/string&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 &lt;major&gt;2&lt;/major&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 &lt;minor&gt;4&lt;/minor&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 &lt;patchLevel&gt;0&lt;/patchLevel&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 &lt;name&gt;=C3=89poque Opaque&lt;/name&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 &lt;description&gt;The =C3=89poque Opaque is a bl=
ack IPA from Trou du Diable<br>
&gt; =C2=A0 =C2=A0 =C2=A0 brewery. The nose is eerily reminiscent of the co=
ffee crisp candy from<br>
&gt; =C2=A0 =C2=A0 =C2=A0 of our childhood. These strong mocha accents are =
present on the palate,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 which are quickly subdued by Japanese and Austral=
ian hops leading to a<br>
&gt; =C2=A0 =C2=A0 =C2=A0 final state of satisfaction enjoyable for any fan=
 of bitter<br>
&gt; =C2=A0 =C2=A0 =C2=A0 beer.&lt;/description&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 &lt;url&gt;<a href=3D"http://lttng.org" target=3D=
"_blank">http://lttng.org</a>&lt;/url&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 &lt;license&gt;lttng is free software and under t=
he GPL license and part<br>
&gt; =C2=A0 =C2=A0 =C2=A0 LGPL&lt;/license&gt;<br>
&gt; =C2=A0 &lt;/output&gt;<br>
&gt; &lt;/command&gt;<br>
&gt;<br>
&gt; Signed-off-by: Olivier Cotte &lt;<a href=3D"mailto:olivier.cotte@polym=
tl.ca">olivier.cotte@polymtl.ca</a>&gt;<br>
&gt; Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.r.julie=
n@gmail.com">jonathan.r.julien@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0include/lttng/lttng-error.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 6 +-<br>
&gt; =C2=A0include/lttng/lttng.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 5 +<br>
&gt; =C2=A0src/bin/lttng-consumerd/lttng-consumerd.c | =C2=A0 2 +<br>
&gt; =C2=A0src/bin/lttng/commands/add_context.c =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/calibrate.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/create.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/destroy.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/disable_channels.c | =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/disable_events.c =C2=A0 | =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/enable_channels.c =C2=A0| =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/enable_events.c =C2=A0 =C2=A0| =C2=A0 7 +=
<br>
&gt; =C2=A0src/bin/lttng/commands/list.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/load.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/save.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/set_session.c =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/snapshot.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/start.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/stop.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 7 +<br>
&gt; =C2=A0src/bin/lttng/commands/version.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A088 ++++++++-<br>
&gt; =C2=A0src/bin/lttng/commands/view.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 4 +<br>
&gt; =C2=A0src/bin/lttng/lttng.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A032 +++-<br>
&gt; =C2=A0src/common/Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 5 +-<br>
&gt; =C2=A0src/common/error.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A011 +-<br>
&gt; =C2=A0src/common/mi-lttng.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 284 ++++++++++++++++++++++++++++++<br>
&gt; =C2=A0src/common/mi-lttng.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 230 ++++++++++++++++++++++++<br>
&gt; =C2=A0src/lib/lttng-ctl/lttng-ctl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 1 +<br>
&gt; =C2=A0tests/unit/ini_config/ini_config.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 1 +<br>
&gt; =C2=A0tests/unit/test_kernel_data.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 1 +<br>
&gt; =C2=A0tests/unit/test_session.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 1 +<br>
&gt; =C2=A0tests/unit/test_uri.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 1 +<br>
&gt; =C2=A0tests/unit/test_ust_data.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 1 +<br>
&gt; =C2=A0tests/unit/test_utils_expand_path.c =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 1 +<br>
&gt; =C2=A0tests/unit/test_utils_parse_size_suffix.c | =C2=A0 1 +<br>
&gt; =C2=A033 files changed, 769 insertions(+), 11 deletions(-)<br>
&gt; =C2=A0create mode 100644 src/common/mi-lttng.c<br>
&gt; =C2=A0create mode 100644 src/common/mi-lttng.h<br>
&gt;<br>
&gt; diff --git a/include/lttng/lttng-error.h b/include/lttng/lttng-error.h=
<br>
&gt; index 06baa04..1594ba9 100644<br>
&gt; --- a/include/lttng/lttng-error.h<br>
&gt; +++ b/include/lttng/lttng-error.h<br>
&gt; @@ -120,9 +120,9 @@ enum lttng_error_code {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 LTTNG_ERR_LOAD_INVALID_CONFIG =C2=A0 =C2=A0=3D 87=
, =C2=A0/* Invalid session configuration */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 LTTNG_ERR_LOAD_IO_FAIL =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 88, =C2=A0/* IO error while reading a session configuration =
*/<br>
&gt; =C2=A0 =C2=A0 =C2=A0 LTTNG_ERR_LOAD_SESSION_NOENT =C2=A0 =C2=A0 =3D 89=
, =C2=A0/* Session file not found */<br>
&gt; - =C2=A0 =C2=A0 /* 90 */<br>
&gt; - =C2=A0 =C2=A0 /* 91 */<br>
&gt; - =C2=A0 =C2=A0 /* 92 */<br>
&gt; + =C2=A0 =C2=A0 LTTNG_ERR_MI_OUTPUT_TYPE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D 90, /* Invalid MI output format */<br>
&gt; + =C2=A0 =C2=A0 LTTNG_ERR_MI_IO_FAIL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D 91, /* IO error while writing machine interface output */<br=
>
&gt; + =C2=A0 =C2=A0 LTTNG_ERR_MI_NOT_IMPLEMENTED =C2=A0 =C2=A0 =3D 92, /* =
Mi feature not implemented */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 /* 93 */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 /* 94 */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 /* 95 */<br>
&gt; diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h<br>
&gt; index f0be224..9449161 100644<br>
&gt; --- a/include/lttng/lttng.h<br>
&gt; +++ b/include/lttng/lttng.h<br>
&gt; @@ -170,6 +170,11 @@ enum lttng_buffer_type {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 LTTNG_BUFFER_GLOBAL, =C2=A0 =C2=A0/* Only support=
ed by the Kernel. */<br>
&gt; =C2=A0};<br>
&gt;<br>
&gt; +/* Machine interface output type */<br>
&gt; +enum lttng_mi_output_type {<br>
&gt; + =C2=A0 =C2=A0 LTTNG_MI_XML =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 1 /* XML output */<br>
&gt; +};<br>
&gt; +<br>
&gt; =C2=A0/*<br>
&gt; =C2=A0 * The structures should be initialized to zero before use.<br>
&gt; =C2=A0 */<br>
&gt; diff --git a/src/bin/lttng-consumerd/lttng-consumerd.c b/src/bin/lttng=
-consumerd/lttng-consumerd.c<br>
&gt; index e226ebc..0ce163e 100644<br>
&gt; --- a/src/bin/lttng-consumerd/lttng-consumerd.c<br>
&gt; +++ b/src/bin/lttng-consumerd/lttng-consumerd.c<br>
&gt; @@ -65,6 +65,8 @@ static int sigintcount =3D 0;<br>
&gt; =C2=A0/* Argument variables */<br>
&gt; =C2=A0int lttng_opt_quiet; =C2=A0 =C2=A0/* not static in error.h */<br=
>
&gt; =C2=A0int lttng_opt_verbose; =C2=A0/* not static in error.h */<br>
&gt; +int lttng_opt_mi; =C2=A0 =C2=A0 =C2=A0 /* not static in error.h */<br=
>
&gt; +<br>
&gt; =C2=A0static int opt_daemon;<br>
&gt; =C2=A0static const char *progname;<br>
&gt; =C2=A0static char command_sock_path[PATH_MAX]; /* Global command socke=
t path */<br>
&gt; diff --git a/src/bin/lttng/commands/add_context.c b/src/bin/lttng/comm=
ands/add_context.c<br>
&gt; index 6483c98..2eb0e90 100644<br>
&gt; --- a/src/bin/lttng/commands/add_context.c<br>
&gt; +++ b/src/bin/lttng/commands/add_context.c<br>
&gt; @@ -446,6 +446,13 @@ int cmd_add_context(int argc, const char **argv)<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, long_opti=
ons, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; diff --git a/src/bin/lttng/commands/calibrate.c b/src/bin/lttng/comman=
ds/calibrate.c<br>
&gt; index 092632c..7d4de29 100644<br>
&gt; --- a/src/bin/lttng/commands/calibrate.c<br>
&gt; +++ b/src/bin/lttng/commands/calibrate.c<br>
&gt; @@ -133,6 +133,13 @@ static int calibrate_lttng(void)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 handle =3D lttng_create_handle(NULL, &amp;dom);<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 if (handle =3D=3D NULL) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D CMD_ERROR;<br=
>
&gt; diff --git a/src/bin/lttng/commands/create.c b/src/bin/lttng/commands/=
create.c<br>
&gt; index e02b141..c43ce59 100644<br>
&gt; --- a/src/bin/lttng/commands/create.c<br>
&gt; +++ b/src/bin/lttng/commands/create.c<br>
&gt; @@ -515,6 +515,13 @@ int cmd_create(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 if (opt_no_consumer) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG(&quot;The option =
--no-consumer is obsolete. Use --no-output now.&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D CMD_WARNING;<=
br>
&gt; diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands=
/destroy.c<br>
&gt; index 3fb5fb2..26548b9 100644<br>
&gt; --- a/src/bin/lttng/commands/destroy.c<br>
&gt; +++ b/src/bin/lttng/commands/destroy.c<br>
&gt; @@ -148,6 +148,13 @@ int cmd_destroy(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 /* Ignore session name in case all sessions are t=
o be destroyed */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 if (opt_destroy_all) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D destroy_all_s=
essions();<br>
&gt; diff --git a/src/bin/lttng/commands/disable_channels.c b/src/bin/lttng=
/commands/disable_channels.c<br>
&gt; index 1aa3916..da53d25 100644<br>
&gt; --- a/src/bin/lttng/commands/disable_channels.c<br>
&gt; +++ b/src/bin/lttng/commands/disable_channels.c<br>
&gt; @@ -167,6 +167,13 @@ int cmd_disable_channels(int argc, const char **a=
rgv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 opt_channels =3D (char*) poptGetArg(pc);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 if (opt_channels =3D=3D NULL) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;Missing cha=
nnel name(s).\n&quot;);<br>
&gt; diff --git a/src/bin/lttng/commands/disable_events.c b/src/bin/lttng/c=
ommands/disable_events.c<br>
&gt; index e712343..fb96b80 100644<br>
&gt; --- a/src/bin/lttng/commands/disable_events.c<br>
&gt; +++ b/src/bin/lttng/commands/disable_events.c<br>
&gt; @@ -212,6 +212,13 @@ int cmd_disable_events(int argc, const char **arg=
v)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 opt_event_list =3D (char*) poptGetArg(pc);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 if (opt_event_list =3D=3D NULL &amp;&amp; opt_dis=
able_all =3D=3D 0) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;Missing eve=
nt name(s).\n&quot;);<br>
&gt; diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/=
commands/enable_channels.c<br>
&gt; index 55fbae6..8ea405e 100644<br>
&gt; --- a/src/bin/lttng/commands/enable_channels.c<br>
&gt; +++ b/src/bin/lttng/commands/enable_channels.c<br>
&gt; @@ -327,6 +327,13 @@ int cmd_enable_channels(int argc, const char **ar=
gv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, long_opti=
ons, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/commands/enable_events.c b/src/bin/lttng/co=
mmands/enable_events.c<br>
&gt; index bd2d997..8c7a73e 100644<br>
&gt; --- a/src/bin/lttng/commands/enable_events.c<br>
&gt; +++ b/src/bin/lttng/commands/enable_events.c<br>
&gt; @@ -968,6 +968,13 @@ int cmd_enable_events(int argc, const char **argv=
)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, long_opti=
ons, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 /* Default event type */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 opt_event_type =3D LTTNG_EVENT_ALL;<br>
&gt;<br>
&gt; diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/li=
st.c<br>
&gt; index f69b3ba..bbd674c 100644<br>
&gt; --- a/src/bin/lttng/commands/list.c<br>
&gt; +++ b/src/bin/lttng/commands/list.c<br>
&gt; @@ -850,6 +850,13 @@ int cmd_list(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, long_opti=
ons, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/commands/load.c b/src/bin/lttng/commands/lo=
ad.c<br>
&gt; index e732baa..2cfc698 100644<br>
&gt; --- a/src/bin/lttng/commands/load.c<br>
&gt; +++ b/src/bin/lttng/commands/load.c<br>
&gt; @@ -77,6 +77,13 @@ int cmd_load(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, load_opts=
, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/commands/save.c b/src/bin/lttng/commands/sa=
ve.c<br>
&gt; index e8a4565..1aeb9f2 100644<br>
&gt; --- a/src/bin/lttng/commands/save.c<br>
&gt; +++ b/src/bin/lttng/commands/save.c<br>
&gt; @@ -73,6 +73,13 @@ int cmd_save(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, save_opts=
, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/commands/set_session.c b/src/bin/lttng/comm=
ands/set_session.c<br>
&gt; index 4238016..54320df 100644<br>
&gt; --- a/src/bin/lttng/commands/set_session.c<br>
&gt; +++ b/src/bin/lttng/commands/set_session.c<br>
&gt; @@ -92,6 +92,13 @@ int cmd_set_session(int argc, const char **argv)<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, long_opti=
ons, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/commands/snapshot.c b/src/bin/lttng/command=
s/snapshot.c<br>
&gt; index c704eee..21b5a05 100644<br>
&gt; --- a/src/bin/lttng/commands/snapshot.c<br>
&gt; +++ b/src/bin/lttng/commands/snapshot.c<br>
&gt; @@ -446,6 +446,13 @@ int cmd_snapshot(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, snapshot_=
opts, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/commands/start.c b/src/bin/lttng/commands/s=
tart.c<br>
&gt; index 82122cc..82b3f5f 100644<br>
&gt; --- a/src/bin/lttng/commands/start.c<br>
&gt; +++ b/src/bin/lttng/commands/start.c<br>
&gt; @@ -118,6 +118,13 @@ int cmd_start(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, long_opti=
ons, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/commands/stop.c b/src/bin/lttng/commands/st=
op.c<br>
&gt; index 60a1dac..5de96d8 100644<br>
&gt; --- a/src/bin/lttng/commands/stop.c<br>
&gt; +++ b/src/bin/lttng/commands/stop.c<br>
&gt; @@ -122,6 +122,13 @@ int cmd_stop(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, long_opti=
ons, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 /* TODO: mi support */<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_NOT_=
IMPLEMENTED;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;mi option not su=
pported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/commands/version.c b/src/bin/lttng/commands=
/version.c<br>
&gt; index 7f69de3..5c7ebbf 100644<br>
&gt; --- a/src/bin/lttng/commands/version.c<br>
&gt; +++ b/src/bin/lttng/commands/version.c<br>
&gt; @@ -25,6 +25,8 @@<br>
&gt; =C2=A0#include &lt;unistd.h&gt;<br>
&gt; =C2=A0#include &lt;config.h&gt;<br>
&gt;<br>
&gt; +#include &lt;common/mi-lttng.h&gt;<br>
&gt; +<br>
&gt; =C2=A0#include &quot;../command.h&quot;<br>
&gt;<br>
&gt; =C2=A0enum {<br>
&gt; @@ -32,6 +34,8 @@ enum {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 OPT_LIST_OPTIONS,<br>
&gt; =C2=A0};<br>
&gt;<br>
&gt; +static const char *lttng_license =3D &quot;lttng is free software and=
 under the GPL license and part LGPL&quot;;<br>
&gt; +<br>
&gt; =C2=A0static struct poptOption long_options[] =3D {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 /* longName, shortName, argInfo, argPtr, value, d=
escrip, argDesc */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 {&quot;help&quot;, =C2=A0 =C2=A0 =C2=A0&#39;h&#39=
;, POPT_ARG_NONE, 0, OPT_HELP, 0, 0},<br>
&gt; @@ -53,6 +57,78 @@ static void usage(FILE *ofp)<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/*<br>
&gt; + * =C2=A0create_version<br>
&gt; + */<br>
&gt; +static void create_version(struct mi_lttng_version *version)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 strncpy(version-&gt;version, VERSION, NAME_MAX);<br>
&gt; + =C2=A0 =C2=A0 version-&gt;version_major =3D VERSION_MAJOR;<br>
&gt; + =C2=A0 =C2=A0 version-&gt;version_minor =3D VERSION_MINOR;<br>
&gt; + =C2=A0 =C2=A0 version-&gt;version_patchlevel =3D VERSION_PATCHLEVEL;=
<br>
&gt; + =C2=A0 =C2=A0 strncpy(version-&gt;version_name, VERSION_NAME, NAME_M=
AX);<br>
&gt; + =C2=A0 =C2=A0 strncpy(version-&gt;package_url, PACKAGE_URL, NAME_MAX=
);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * =C2=A0print_mi<br>
&gt; + */<br>
&gt; +static int print_mi()<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 int ret;<br>
&gt; + =C2=A0 =C2=A0 struct mi_writer *writer =3D NULL;<br>
&gt; + =C2=A0 =C2=A0 struct mi_lttng_version version;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 create_version(&amp;version);<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 writer =3D mi_lttng_writer_create(fileno(stdout), lttn=
g_opt_mi);<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 if (!writer) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_NOMEM;<=
br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Open the command element */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_command_open(writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_command_version);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Beginning of output */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_open_element(writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_command_output);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Print the machine interface of version */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_version(writer, &amp;version,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 VERSION_DESCRIPTION, lttng_license);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Close the output element */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_close_element(writer);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Close the command =C2=A0*/<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_command_close(writer);<br>
&gt; +<br>
&gt; +error:<br>
&gt; + =C2=A0 =C2=A0 /* Cleanup */<br>
&gt; + =C2=A0 =C2=A0 if (writer &amp;&amp; mi_lttng_writer_destroy(writer))=
 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Preserve original error=
 code */<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ret ? ret : LTTNG_=
ERR_MI_IO_FAIL;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +end:<br>
&gt; + =C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; =C2=A0 * =C2=A0cmd_version<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0int cmd_version(int argc, const char **argv)<br>
&gt; @@ -78,10 +154,14 @@ int cmd_version(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 MSG(&quot;lttng version &quot; VERSION &quot; - &quot;=
 VERSION_NAME);<br>
&gt; - =C2=A0 =C2=A0 MSG(&quot;\n&quot; VERSION_DESCRIPTION &quot;\n&quot;)=
;<br>
&gt; - =C2=A0 =C2=A0 MSG(&quot;Web site: <a href=3D"http://lttng.org" targe=
t=3D"_blank">http://lttng.org</a>&quot;);<br>
&gt; - =C2=A0 =C2=A0 MSG(&quot;\nlttng is free software and under the GPL l=
icense and part LGPL&quot;);<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D print_mi();<br>
&gt; + =C2=A0 =C2=A0 } else {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG(&quot;lttng version &q=
uot; VERSION &quot; - &quot; VERSION_NAME);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG(&quot;\n&quot; VERSION=
_DESCRIPTION &quot;\n&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG(&quot;Web site: <a hre=
f=3D"http://lttng.org" target=3D"_blank">http://lttng.org</a>&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG(&quot;\n%s&quot;, lttn=
g_license);<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; =C2=A0end:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptFreeContext(pc);<br>
&gt; diff --git a/src/bin/lttng/commands/view.c b/src/bin/lttng/commands/vi=
ew.c<br>
&gt; index adedf29..dcd4d66 100644<br>
&gt; --- a/src/bin/lttng/commands/view.c<br>
&gt; +++ b/src/bin/lttng/commands/view.c<br>
&gt; @@ -445,6 +445,10 @@ int cmd_view(int argc, const char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 pc =3D poptGetContext(NULL, argc, argv, long_opti=
ons, 0);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 poptReadDefaultConfig(pc, 0);<br>
&gt;<br>
&gt; + =C2=A0 =C2=A0 if (lttng_opt_mi) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN(&quot;mi does not app=
ly to view command&quot;);<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 while ((opt =3D poptGetNextOpt(pc)) !=3D -1) {<br=
>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPT_HELP:<br>
&gt; diff --git a/src/bin/lttng/lttng.c b/src/bin/lttng/lttng.c<br>
&gt; index bc7577d..4510057 100644<br>
&gt; --- a/src/bin/lttng/lttng.c<br>
&gt; +++ b/src/bin/lttng/lttng.c<br>
&gt; @@ -55,6 +55,7 @@ static struct option long_options[] =3D {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 {&quot;group&quot;, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01, NULL, &#39;g&#39;},<br>
&gt; =C2=A0 =C2=A0 =C2=A0 {&quot;verbose&quot;, =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00, NULL, &#39;v&#39;},<br>
&gt; =C2=A0 =C2=A0 =C2=A0 {&quot;quiet&quot;, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00, NULL, &#39;q&#39;},<br>
&gt; + =C2=A0 =C2=A0 {&quot;mi&quot;, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1, NULL, &#39;m&#39;},<br>
&gt; =C2=A0 =C2=A0 =C2=A0 {&quot;no-sessiond&quot;, =C2=A0 =C2=A0 =C2=A00, =
NULL, &#39;n&#39;},<br>
&gt; =C2=A0 =C2=A0 =C2=A0 {&quot;sessiond-path&quot;, =C2=A0 =C2=A01, NULL,=
 OPT_SESSION_PATH},<br>
&gt; =C2=A0 =C2=A0 =C2=A0 {&quot;relayd-path&quot;, =C2=A0 =C2=A0 =C2=A01, =
NULL, OPT_RELAYD_PATH},<br>
&gt; @@ -99,6 +100,8 @@ static void usage(FILE *ofp)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 fprintf(ofp, &quot; =C2=A0 =C2=A0 =C2=A0--list-co=
mmands =C2=A0 =C2=A0 =C2=A0 =C2=A0Simple listing of lttng commands\n&quot;)=
;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 fprintf(ofp, &quot; =C2=A0-v, --verbose =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Increase verbosity\n&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 fprintf(ofp, &quot; =C2=A0-q, --quiet =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Quiet mode\n&quot;);<br>
&gt; + =C2=A0 =C2=A0 fprintf(ofp, &quot; =C2=A0-m, --mi TYPE =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Machine Interface mode.\n&quot;);<br>
&gt; + =C2=A0 =C2=A0 fprintf(ofp, &quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Type: xml\n&quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 fprintf(ofp, &quot; =C2=A0-g, --group NAME =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Unix tracing group name. (default: tracing)\n&=
quot;);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 fprintf(ofp, &quot; =C2=A0-n, --no-sessiond =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Don&#39;t spawn a session daemon\n&quot;);<b=
r>
&gt; =C2=A0 =C2=A0 =C2=A0 fprintf(ofp, &quot; =C2=A0 =C2=A0 =C2=A0--session=
d-path PATH =C2=A0 Session daemon full path\n&quot;);<br>
&gt; @@ -136,6 +139,26 @@ static void version(FILE *ofp)<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0/*<br>
&gt; + * mi_output_type<br>
&gt; + *<br>
&gt; + * Find the MI output type enum from a string<br>
&gt; + * This function is for the support of<br>
&gt; + * new output language.<br>
&gt; + */<br>
&gt; +static int mi_output_type(const char *output_type)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 int ret =3D 0;<br>
&gt; + =C2=A0 =C2=A0 if (!strncasecmp(&quot;xml&quot;, output_type, 3)) {<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D LTTNG_MI_XML;<br>
&gt; + =C2=A0 =C2=A0 } else {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Invalid output format *=
/<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERR(&quot;MI output format=
 not supported&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -LTTNG_ERR_MI_OUTP=
UT_TYPE;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; + =C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; =C2=A0 * =C2=A0list_options<br>
&gt; =C2=A0 *<br>
&gt; =C2=A0 * =C2=A0List options line by line. This is mostly for bash auto=
 completion and to<br>
&gt; @@ -426,7 +449,7 @@ static int parse_args(int argc, char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clean_exit(EXIT_FAILU=
RE);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 while ((opt =3D getopt_long(argc, argv, &quot;+Vhnvqg:=
&quot;, long_options, NULL)) !=3D -1) {<br>
&gt; + =C2=A0 =C2=A0 while ((opt =3D getopt_long(argc, argv, &quot;+Vhnvqg:=
m:&quot;, long_options, NULL)) !=3D -1) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (opt) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;V&#39;:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 version(stdout);<br>
&gt; @@ -442,6 +465,13 @@ static int parse_args(int argc, char **argv)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;q&#39;:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 lttng_opt_quiet =3D 1;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;m&#39;:<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 lttng_opt_mi =3D mi_output_type(optarg);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (lttng_opt_mi &lt; 0) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D lttng_opt_mi;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;g&#39;:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 lttng_set_tracing_group(optarg);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;<br>
&gt; diff --git a/src/common/Makefile.am b/src/common/Makefile.am<br>
&gt; index 1a764ae..dffab06 100644<br>
&gt; --- a/src/common/Makefile.am<br>
&gt; +++ b/src/common/Makefile.am<br>
&gt; @@ -16,8 +16,11 @@ noinst_LTLIBRARIES =3D <a href=3D"http://libcommon.=
la" target=3D"_blank">libcommon.la</a><br>
&gt; =C2=A0libcommon_la_SOURCES =3D error.h error.c utils.c utils.h runas.c=
 runas.h \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 common.h futex.c futex.h uri.c uri.h defaults.c \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 pipe.c pipe.h readwrite.c readwrite.h \<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mi-lttng.h mi-lttng.c \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 daemonize.c daemonize.h<br>
&gt; -libcommon_la_LIBADD =3D -luuid<br>
&gt; +libcommon_la_LIBADD =3D \<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -luuid \<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(top_builddir)/src/common=
/config/<a href=3D"http://libconfig.la" target=3D"_blank">libconfig.la</a><=
br>
&gt;<br>
&gt; =C2=A0# Consumer library<br>
&gt; =C2=A0noinst_LTLIBRARIES +=3D <a href=3D"http://libconsumer.la" target=
=3D"_blank">libconsumer.la</a><br>
&gt; diff --git a/src/common/error.h b/src/common/error.h<br>
&gt; index f8c0a1d..4e096b3 100644<br>
&gt; --- a/src/common/error.h<br>
&gt; +++ b/src/common/error.h<br>
&gt; @@ -36,6 +36,7 @@<br>
&gt;<br>
&gt; =C2=A0extern int lttng_opt_quiet;<br>
&gt; =C2=A0extern int lttng_opt_verbose;<br>
&gt; +extern int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0/* Error type. */<br>
&gt; =C2=A0#define PRINT_ERR =C2=A0 0x1<br>
&gt; @@ -48,12 +49,18 @@ extern int lttng_opt_verbose;<br>
&gt;<br>
&gt; =C2=A0/*<br>
&gt; =C2=A0 * Macro for printing message depending on command line option a=
nd verbosity.<br>
&gt; + *<br>
&gt; + * Machine interface:<br>
&gt; + * We use lttng_opt_mi to suppress all normal msg to stdout. We don&#=
39;t<br>
&gt; + * want any nested msg to show up when printing mi to stdout(if it&#3=
9;s the case).<br>
&gt; + * All warnings and errors should be printed to stderr as normal.<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0#define __lttng_print(type, fmt, args...) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 do { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lttng_opt_quiet =3D=3D=
 0 &amp;&amp; type =3D=3D PRINT_MSG) { =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (lttng_opt_quiet =3D=3D=
 0 &amp;&amp; lttng_opt_mi =3D=3D 0 &amp;&amp; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type =3D=3D PRINT_MSG) { =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fprintf(stdout, fmt, ## args); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (lttng_opt_quiet=
 =3D=3D 0 &amp;&amp; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (lttng_opt_quiet=
 =3D=3D 0 &amp;&amp; lttng_opt_mi =3D=3D 0 &amp;&amp; =C2=A0 =C2=A0 \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((type &amp; PRINT_DBG) &amp;&amp; lttn=
g_opt_verbose =3D=3D 1) || =C2=A0\<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((type &amp; (PRINT_DBG | PRINT_DBG2)) &=
amp;&amp; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lttng_opt_ve=
rbose =3D=3D 2) || =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\<br>
&gt; diff --git a/src/common/mi-lttng.c b/src/common/mi-lttng.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..bbec2c5<br>
&gt; --- /dev/null<br>
&gt; +++ b/src/common/mi-lttng.c<br>
&gt; @@ -0,0 +1,284 @@<br>
&gt; +/*<br>
&gt; + * Copyright (C) 2014 =C2=A0 - Jonathan Rajotte &lt;<a href=3D"mailto=
:jonathan.r.julien@gmail.com">jonathan.r.julien@gmail.com</a>&gt;<br>
&gt; + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0- Olivier Cotte &lt;<a href=3D"mailto:olivier.cotte@polymtl.ca">o=
livier.cotte@polymtl.ca</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy it<br>
&gt; + * under the terms of the GNU General Public License, version 2 only,=
 as<br>
&gt; + * published by the Free Software Foundation.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful, bu=
t WITHOUT<br>
&gt; + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licen=
se for<br>
&gt; + * more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License =
along with<br>
&gt; + * this program; if not, write to the Free Software Foundation, Inc.,=
 51<br>
&gt; + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;include/config.h&gt;<br>
&gt; +#include &lt;common/config/config.h&gt;<br>
&gt; +#include &quot;mi-lttng.h&quot;<br>
&gt; +<br>
&gt; +/* Strings related to command */<br>
&gt; +const char * const mi_lttng_element_command =3D &quot;command&quot;;<=
br>
&gt; +const char * const mi_lttng_element_command_version =3D &quot;version=
&quot;;<br>
&gt; +const char * const mi_lttng_element_command_list =3D &quot;list&quot;=
;<br>
&gt; +const char * const mi_lttng_element_command_name =3D &quot;name&quot;=
;<br>
&gt; +const char * const mi_lttng_element_command_output =3D &quot;output&q=
uot;;<br>
&gt; +<br>
&gt; +/* Strings related to command: version */<br>
&gt; +const char * const mi_lttng_element_version =3D &quot;version&quot;;<=
br>
&gt; +const char * const mi_lttng_element_version_str =3D &quot;string&quot=
;;<br>
&gt; +const char * const mi_lttng_element_version_web =3D &quot;url&quot;;<=
br>
&gt; +const char * const mi_lttng_element_version_major =3D &quot;major&quo=
t;;<br>
&gt; +const char * const mi_lttng_element_version_minor =3D &quot;minor&quo=
t;;<br>
&gt; +const char * const mi_lttng_element_version_license =3D &quot;license=
&quot;;<br>
&gt; +const char * const mi_lttng_element_version_patch_level =3D &quot;pat=
chLevel&quot;;<br>
&gt; +const char * const mi_lttng_element_version_description =3D &quot;des=
cription&quot;;<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output=
_type)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 struct mi_writer *mi_writer;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 mi_writer =3D zmalloc(sizeof(struct mi_writer));<br>
&gt; + =C2=A0 =C2=A0 if (!mi_writer) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PERROR(&quot;zmalloc mi_wr=
iter_create&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; + =C2=A0 =C2=A0 if (mi_output_type =3D=3D LTTNG_MI_XML) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mi_writer-&gt;writer =3D c=
onfig_writer_create(fd_output);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mi_writer-&gt;writer)=
 {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto err_destroy;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mi_writer-&gt;type =3D LTT=
NG_MI_XML;<br>
&gt; + =C2=A0 =C2=A0 } else {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_destroy;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +end:<br>
&gt; + =C2=A0 =C2=A0 return mi_writer;<br>
&gt; +<br>
&gt; +err_destroy:<br>
&gt; + =C2=A0 =C2=A0 free(mi_writer);<br>
&gt; + =C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_destroy(struct mi_writer *writer)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 if (!writer) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EINVAL;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 ret =3D config_writer_destroy(writer-&gt;writer);<br>
&gt; + =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 free(writer);<br>
&gt; +end:<br>
&gt; + =C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_command_open(struct mi_writer *writer, const char=
 *command)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 int ret;<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_open_element(writer, mi_lttng_=
element_command);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_string(writer,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_command_name, command);<br>
&gt; +end:<br>
&gt; + =C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_command_close(struct mi_writer *writer)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 return mi_lttng_writer_close_element(writer);<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_open_element(struct mi_writer *writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name)<=
br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 return config_writer_open_element(writer-&gt;writer, e=
lement_name);<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_close_element(struct mi_writer *writer)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 return config_writer_close_element(writer-&gt;writer);=
<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *writ=
er,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name, =
uint64_t value)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 return config_writer_write_element_unsigned_int(writer=
-&gt;writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 element_name, value);<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_write_element_signed_int(struct mi_writer *writer=
,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name, =
int64_t value)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 return config_writer_write_element_signed_int(writer-&=
gt;writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 element_name, value);<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_write_element_bool(struct mi_writer *writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name, =
int value)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 return config_writer_write_element_bool(writer-&gt;wri=
ter,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 element_name, value);<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_writer_write_element_string(struct mi_writer *writer,<br=
>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name, =
const char *value)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 return config_writer_write_element_string(writer-&gt;w=
riter,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 element_name, value);<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_version(struct mi_writer *writer, struct mi_lttng_versio=
n *version,<br>
&gt; + =C2=A0 =C2=A0 const char *lttng_description, const char *lttng_licen=
se)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Open version */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_open_element(writer, mi_lttng_=
element_version);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Version string (contain info like rc etc.) */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_string(writer,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_version_str, VERSION);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Major version number */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_unsigned_int(wri=
ter,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_version_major, version-&gt;version_major);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Minor version number */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_unsigned_int(wri=
ter,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_version_minor, version-&gt;version_minor);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Patch number */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_unsigned_int(wri=
ter,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_version_patch_level, version-&gt;version_patchlevel);<=
br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Name of the version */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_string(writer,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 config_element_name, version-&gt;version_name);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Description mostly related to beer... */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_string(writer,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_version_description, lttng_description);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* url */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_string(writer,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_version_web, version-&gt;package_url);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* License: free as in free beer...no...*speech* */<br=
>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_string(writer,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mi_lttng_element_version_license, lttng_license);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Close version element */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_close_element(writer);<br>
&gt; +<br>
&gt; +end:<br>
&gt; + =C2=A0 =C2=A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +LTTNG_HIDDEN<br>
&gt; +int mi_lttng_session(struct mi_writer *writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lttng_session *sess=
ion, int is_open)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* open sessions element */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_open_element(writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 config_element_session);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* Name of the session */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_string(writer,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 config_element_name, session-&gt;name);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* path */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_string(writer,<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 config_element_path, session-&gt;path);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* enabled ? */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_unsigned_int(wri=
ter,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 config_element_enabled, session-&gt;enabled);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* snapshot mode */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_unsigned_int(wri=
ter,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 config_element_snapshot_mode, session-&gt;snapshot_mode);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 /* live timer interval in usec */<br>
&gt; + =C2=A0 =C2=A0 ret =3D mi_lttng_writer_write_element_unsigned_int(wri=
ter,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 config_element_live_timer_interval,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 session-&gt;live_timer_interval);<br>
&gt; + =C2=A0 =C2=A0 if (ret) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 if (!is_open) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Closing session element=
 */<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mi_lttng_writer_cl=
ose_element(writer);<br>
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +end:<br>
&gt; + =C2=A0 =C2=A0 return ret;<br>
&gt; +<br>
&gt; +}<br>
&gt; diff --git a/src/common/mi-lttng.h b/src/common/mi-lttng.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..69ec0f5<br>
&gt; --- /dev/null<br>
&gt; +++ b/src/common/mi-lttng.h<br>
&gt; @@ -0,0 +1,230 @@<br>
&gt; +/*<br>
&gt; + * Copyright (C) 2014 =C2=A0 - Jonathan Rajotte &lt;<a href=3D"mailto=
:jonathan.r.julien@gmail.com">jonathan.r.julien@gmail.com</a>&gt;<br>
&gt; + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0- Olivier Cotte &lt;<a href=3D"mailto:olivier.cotte@polymtl.ca">o=
livier.cotte@polymtl.ca</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy it<br>
&gt; + * under the terms of the GNU General Public License, version 2 only,=
 as<br>
&gt; + * published by the Free Software Foundation.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful, bu=
t WITHOUT<br>
&gt; + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=
 or<br>
&gt; + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licen=
se for<br>
&gt; + * more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License =
along with<br>
&gt; + * this program; if not, write to the Free Software Foundation, Inc.,=
 51<br>
&gt; + * Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef _MI_LTTNG_H<br>
&gt; +#define _MI_LTTNG_H<br>
&gt; +<br>
&gt; +#include &lt;common/error.h&gt;<br>
&gt; +#include &lt;common/macros.h&gt;<br>
&gt; +#include &lt;common/config/config.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;lttng/lttng.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;stdint.h&gt;<br>
&gt; +<br>
&gt; +<br>
&gt; +/* Instance of a machine interface writer. */<br>
&gt; +struct mi_writer {<br>
&gt; + =C2=A0 =C2=A0 struct config_writer *writer;<br>
&gt; + =C2=A0 =C2=A0 enum lttng_mi_output_type type;<br>
&gt; +};<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Version information for the machine interface.<br>
&gt; + */<br>
&gt; +struct mi_lttng_version {<br>
&gt; + =C2=A0 =C2=A0 char version[NAME_MAX]; /* Version number of package *=
/<br>
&gt; + =C2=A0 =C2=A0 uint32_t version_major; /* LTTng-Tools major version n=
umber */<br>
&gt; + =C2=A0 =C2=A0 uint32_t version_minor; /* LTTng-Tools minor version n=
umber */<br>
&gt; + =C2=A0 =C2=A0 uint32_t version_patchlevel; /* LTTng-Tools patchlevel=
 version number */<br>
&gt; + =C2=A0 =C2=A0 char version_name[NAME_MAX];<br>
&gt; + =C2=A0 =C2=A0 char package_url[NAME_MAX]; /* Define to the home page=
 for this package. */<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* Strings related to command */<br>
&gt; +const char * const mi_lttng_element_command;<br>
&gt; +const char * const mi_lttng_element_command_version;<br>
&gt; +const char * const mi_lttng_element_command_list;<br>
&gt; +const char * const mi_lttng_element_command_name;<br>
&gt; +const char * const mi_lttng_element_command_output;<br>
&gt; +<br>
&gt; +/* Strings related to command: version */<br>
&gt; +const char * const mi_lttng_element_version;<br>
&gt; +const char * const mi_lttng_element_version_str;<br>
&gt; +const char * const mi_lttng_element_version_web;<br>
&gt; +const char * const mi_lttng_element_version_major;<br>
&gt; +const char * const mi_lttng_element_version_minor;<br>
&gt; +const char * const mi_lttng_element_version_license;<br>
&gt; +const char * const mi_lttng_element_version_patch_level;<br>
&gt; +const char * const mi_lttng_element_version_description;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Create an instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * fd_output File to which the XML content must be written. The file =
will be<br>
&gt; + * closed once the mi_writer has been destroyed.<br>
&gt; + *<br>
&gt; + * Returns an instance of a machine interface writer on success, NULL=
 on<br>
&gt; + * error.<br>
&gt; + */<br>
&gt; +struct mi_writer *mi_lttng_writer_create(int fd_output, int mi_output=
_type);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Destroy an instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * Returns zero if the XML document could be closed cleanly. Negative=
 values<br>
&gt; + * indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_destroy(struct mi_writer *writer);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Open a command tag and add it&#39;s name node.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * command The command name.<br>
&gt; + *<br>
&gt; + * Returns zero if the XML document could be closed cleanly.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_command_open(struct mi_writer *writer, const char=
 *command);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Close a command tag.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * Returns zero if the XML document could be closed cleanly.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_command_close(struct mi_writer *writer);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Open an element tag.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * element_name Element tag name.<br>
&gt; + *<br>
&gt; + * Returns zero if the XML document could be closed cleanly.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_open_element(struct mi_writer *writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name);=
<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Close the current element tag.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * Returns zero if the XML document could be closed cleanly.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_close_element(struct mi_writer *writer);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Write an element of type unsigned int.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * element_name Element name.<br>
&gt; + *<br>
&gt; + * value Unsigned int value of the element<br>
&gt; + *<br>
&gt; + * Returns zero if the element&#39;s value could be written.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_write_element_unsigned_int(struct mi_writer *writ=
er,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name, =
uint64_t value);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Write an element of type signed int.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * element_name Element name.<br>
&gt; + *<br>
&gt; + * value Signed int value of the element<br>
&gt; + *<br>
&gt; + * Returns zero if the element&#39;s value could be written.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_write_element_signed_int(struct mi_writer *writer=
,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name, =
int64_t value);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Write an element of type boolean.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * element_name Element name.<br>
&gt; + *<br>
&gt; + * value Boolean value of the element<br>
&gt; + *<br>
&gt; + * Returns zero if the element&#39;s value could be written.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_write_element_bool(struct mi_writer *writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name, =
int value);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Write an element of type string.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * element_name Element name.<br>
&gt; + *<br>
&gt; + * value String value of the element<br>
&gt; + *<br>
&gt; + * Returns zero if the element&#39;s value could be written.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_writer_write_element_string(struct mi_writer *writer,<br=
>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *element_name, =
const char *value);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Machine interface of struct version.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer.<br>
&gt; + *<br>
&gt; + * version Version struct.<br>
&gt; + *<br>
&gt; + * lttng_description String value of the version description.<br>
&gt; + *<br>
&gt; + * lttng_license String value of the version license.<br>
&gt; + *<br>
&gt; + * Returns zero if the element&#39;s value could be written.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_version(struct mi_writer *writer, struct mi_lttng_versio=
n *version,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *lttng_descript=
ion, const char *lttng_license);<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Machine interface of struct session.<br>
&gt; + *<br>
&gt; + * writer An instance of a machine interface writer<br>
&gt; + *<br>
&gt; + * session An instance of a session<br>
&gt; + *<br>
&gt; + * isOpen Define if we close the session element<br>
&gt; + * =C2=A0 =C2=A0 =C2=A0 =C2=A0This should be use carefully and the cl=
ient<br>
&gt; + * =C2=A0 =C2=A0 =C2=A0 =C2=A0need to close the session element.<br>
&gt; + * =C2=A0 =C2=A0 =C2=A0 =C2=A0Use case: nested addition information o=
n a session<br>
&gt; + * =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ex: =
domain,channel event.<br>
&gt; + * =C2=A0 =C2=A0 =C2=A0 =C2=A00-&gt; False<br>
&gt; + * =C2=A0 =C2=A0 =C2=A0 =C2=A01-&gt; True<br>
&gt; + *<br>
&gt; + * Returns zero if the element&#39;s value could be written.<br>
&gt; + * Negative values indicate an error.<br>
&gt; + */<br>
&gt; +int mi_lttng_session(struct mi_writer *writer,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lttng_session *sess=
ion, int isOpen);<br>
&gt; +<br>
&gt; +#endif /* _MI_LTTNG_H */<br>
&gt; diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-c=
tl.c<br>
&gt; index 100e587..7dd9828 100644<br>
&gt; --- a/src/lib/lttng-ctl/lttng-ctl.c<br>
&gt; +++ b/src/lib/lttng-ctl/lttng-ctl.c<br>
&gt; @@ -74,6 +74,7 @@ static int connected;<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0int lttng_opt_quiet;<br>
&gt; =C2=A0int lttng_opt_verbose;<br>
&gt; +int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0/*<br>
&gt; =C2=A0 * Copy string from src to dst and enforce null terminated byte.=
<br>
&gt; diff --git a/tests/unit/ini_config/ini_config.c b/tests/unit/ini_confi=
g/ini_config.c<br>
&gt; index 38fe5f4..29935ef 100644<br>
&gt; --- a/tests/unit/ini_config/ini_config.c<br>
&gt; +++ b/tests/unit/ini_config/ini_config.c<br>
&gt; @@ -31,6 +31,7 @@ struct state {<br>
&gt;<br>
&gt; =C2=A0int lttng_opt_quiet =3D 1;<br>
&gt; =C2=A0int lttng_opt_verbose =3D 0;<br>
&gt; +int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0int entry_handler(const struct config_entry *entry,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct state *state)<=
br>
&gt; diff --git a/tests/unit/test_kernel_data.c b/tests/unit/test_kernel_da=
ta.c<br>
&gt; index e2182e9..2639be4 100644<br>
&gt; --- a/tests/unit/test_kernel_data.c<br>
&gt; +++ b/tests/unit/test_kernel_data.c<br>
&gt; @@ -38,6 +38,7 @@<br>
&gt; =C2=A0/* For error.h */<br>
&gt; =C2=A0int lttng_opt_quiet =3D 1;<br>
&gt; =C2=A0int lttng_opt_verbose;<br>
&gt; +int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0int ust_consumerd32_fd;<br>
&gt; =C2=A0int ust_consumerd64_fd;<br>
&gt; diff --git a/tests/unit/test_session.c b/tests/unit/test_session.c<br>
&gt; index a0e84e9..4f90c33 100644<br>
&gt; --- a/tests/unit/test_session.c<br>
&gt; +++ b/tests/unit/test_session.c<br>
&gt; @@ -46,6 +46,7 @@ static struct ltt_session_list *session_list;<br>
&gt; =C2=A0/* For error.h */<br>
&gt; =C2=A0int lttng_opt_quiet =3D 1;<br>
&gt; =C2=A0int lttng_opt_verbose =3D 0;<br>
&gt; +int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0int ust_consumerd32_fd;<br>
&gt; =C2=A0int ust_consumerd64_fd;<br>
&gt; diff --git a/tests/unit/test_uri.c b/tests/unit/test_uri.c<br>
&gt; index 7cac95d..432e2b3 100644<br>
&gt; --- a/tests/unit/test_uri.c<br>
&gt; +++ b/tests/unit/test_uri.c<br>
&gt; @@ -25,6 +25,7 @@<br>
&gt; =C2=A0/* For error.h */<br>
&gt; =C2=A0int lttng_opt_quiet =3D 1;<br>
&gt; =C2=A0int lttng_opt_verbose =3D 3;<br>
&gt; +int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0/* Number of TAP tests in this file */<br>
&gt; =C2=A0#define NUM_TESTS 11<br>
&gt; diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c<b=
r>
&gt; index 150d5da..dd00089 100644<br>
&gt; --- a/tests/unit/test_ust_data.c<br>
&gt; +++ b/tests/unit/test_ust_data.c<br>
&gt; @@ -44,6 +44,7 @@<br>
&gt; =C2=A0/* For error.h */<br>
&gt; =C2=A0int lttng_opt_quiet =3D 1;<br>
&gt; =C2=A0int lttng_opt_verbose;<br>
&gt; +int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0int ust_consumerd32_fd;<br>
&gt; =C2=A0int ust_consumerd64_fd;<br>
&gt; diff --git a/tests/unit/test_utils_expand_path.c b/tests/unit/test_uti=
ls_expand_path.c<br>
&gt; index fe709ac..f863b5d 100644<br>
&gt; --- a/tests/unit/test_utils_expand_path.c<br>
&gt; +++ b/tests/unit/test_utils_expand_path.c<br>
&gt; @@ -31,6 +31,7 @@<br>
&gt; =C2=A0/* For error.h */<br>
&gt; =C2=A0int lttng_opt_quiet =3D 1;<br>
&gt; =C2=A0int lttng_opt_verbose =3D 3;<br>
&gt; +int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0struct valid_test_input {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 char *input;<br>
&gt; diff --git a/tests/unit/test_utils_parse_size_suffix.c b/tests/unit/te=
st_utils_parse_size_suffix.c<br>
&gt; index 990aa1b..f81278d 100644<br>
&gt; --- a/tests/unit/test_utils_parse_size_suffix.c<br>
&gt; +++ b/tests/unit/test_utils_parse_size_suffix.c<br>
&gt; @@ -26,6 +26,7 @@<br>
&gt; =C2=A0/* For error.h */<br>
&gt; =C2=A0int lttng_opt_quiet =3D 1;<br>
&gt; =C2=A0int lttng_opt_verbose =3D 3;<br>
&gt; +int lttng_opt_mi;<br>
&gt;<br>
&gt; =C2=A0struct valid_test_input {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 char *input;<br>
&gt; --<br>
&gt; 1.8.3.2<br>
&gt;<br>
<br>
<br>
</div></div>&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
</a><br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Jonathan Rajotte Julien<div>Charg=C3=A9 de laboratoire, INF1995<br><di=
v>Polytechnique Montr=C3=A9al</div></div></div>
</div>

--089e0160bea6896d7404f7026445--


--===============0477889171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0477889171==--
