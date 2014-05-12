From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Add a -l/--load option to the
	session-daemon
Date: Mon, 12 May 2014 12:04:42 -0400
Message-ID: <20140512160442.GC7350__28.6806877285883$1399910758$gmane$org@thessa>
References: <1399564972-25216-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0338535954=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ns236805.ip-192-99-35.net ([192.99.35.19]
 helo=smtp.ini-tech.com) by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1Wjsii-0004yt-Te
 for lttng-dev@lists.lttng.org; Mon, 12 May 2014 12:04:57 -0400
In-Reply-To: <1399564972-25216-1-git-send-email-jeremie.galarneau@efficios.com>
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


--===============0338535954==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged with modifications discussed with the Author.

	commit 39120e55fda06380e866f5c1c87b2a094bcca4ab

David

On 08 May (12:02:52), J=E9r=E9mie Galarneau wrote:
> This option makes it possible to set a PATH from which session
> configurations are loaded by the session daemon on startup.
>=20
> Usage: lttng-sessiond -l PATH
>=20
> The session configuration file found at PATH, or all those present
> in it if it is a directory, will be loaded.
>=20
> All sessions found under the user's session configuration directory
> and under the system session configuration directory are now loaded
> by default.
>=20
> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> ---
>  src/bin/lttng-sessiond/Makefile.am           |  3 +-
>  src/bin/lttng-sessiond/load-session-thread.c | 57 ++++++++++++++++++++++=
++++++
>  src/bin/lttng-sessiond/load-session-thread.h | 25 ++++++++++++
>  src/bin/lttng-sessiond/main.c                | 47 ++++++++++++++++++++++-
>  4 files changed, 129 insertions(+), 3 deletions(-)
>  create mode 100644 src/bin/lttng-sessiond/load-session-thread.c
>  create mode 100644 src/bin/lttng-sessiond/load-session-thread.h
>=20
> diff --git a/src/bin/lttng-sessiond/Makefile.am b/src/bin/lttng-sessiond/=
Makefile.am
> index 71df926..5bd62e5 100644
> --- a/src/bin/lttng-sessiond/Makefile.am
> +++ b/src/bin/lttng-sessiond/Makefile.am
> @@ -28,7 +28,8 @@ lttng_sessiond_SOURCES =3D utils.c utils.h \
>                         testpoint.h ht-cleanup.c \
>                         snapshot.c snapshot.h \
>                         jul.c jul.h \
> -                       save.h save.c
> +                       save.h save.c \
> +                       load-session-thread.h load-session-thread.c
> =20
>  if HAVE_LIBLTTNG_UST_CTL
>  lttng_sessiond_SOURCES +=3D trace-ust.c ust-registry.c ust-app.c \
> diff --git a/src/bin/lttng-sessiond/load-session-thread.c b/src/bin/lttng=
-sessiond/load-session-thread.c
> new file mode 100644
> index 0000000..9afd6dc
> --- /dev/null
> +++ b/src/bin/lttng-sessiond/load-session-thread.c
> @@ -0,0 +1,57 @@
> +/*
> + * Copyright (C) 2014 - J=E9r=E9mie Galarneau <jeremie.galarneau@efficio=
s.com>
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
> +#define _GNU_SOURCE
> +#include "load-session-thread.h"
> +#include <common/error.h>
> +#include <common/config/config.h>
> +
> +extern sem_t message_thread_ready;
> +void lttng_sessiond_notify_ready(void);
> +
> +/*
> + * This thread loads session configurations once the session daemon is
> + * ready to process client messages.
> + */
> +void *thread_load_session(void *data)
> +{
> +	int ret;
> +	const char *path =3D data;
> +
> +	DBG("[load-session-thread] Load session");
> +
> +	ret =3D sem_wait(&message_thread_ready);
> +	if (ret) {
> +		PERROR("sem_wait message_thread_ready");
> +		goto end;
> +	}
> +
> +	ret =3D sem_destroy(&message_thread_ready);
> +	if (ret) {
> +		PERROR("sem_destroy message_thread_ready");
> +		goto end;
> +	}
> +
> +	ret =3D config_load_session(path, NULL, 0);
> +	if (ret) {
> +		ERR("Session load failed: %s", error_get_str(ret));
> +	}
> +
> +end:
> +	lttng_sessiond_notify_ready();
> +	return NULL;
> +}
> diff --git a/src/bin/lttng-sessiond/load-session-thread.h b/src/bin/lttng=
-sessiond/load-session-thread.h
> new file mode 100644
> index 0000000..70aaa31
> --- /dev/null
> +++ b/src/bin/lttng-sessiond/load-session-thread.h
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (C) 2014 - J=E9r=E9mie Galarneau <jeremie.galarneau@efficio=
s.com>
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
> +#ifndef LOAD_SESSION_THREAD_H
> +#define LOAD_SESSION_THREAD_H
> +
> +#include <semaphore.h>
> +
> +void *thread_load_session(void *session_name);
> +
> +#endif /* LOAD_SESSION_THREAD_H */
> diff --git a/src/bin/lttng-sessiond/main.c b/src/bin/lttng-sessiond/main.c
> index 052e32e..1b6f951 100644
> --- a/src/bin/lttng-sessiond/main.c
> +++ b/src/bin/lttng-sessiond/main.c
> @@ -69,6 +69,7 @@
>  #include "ust-thread.h"
>  #include "jul-thread.h"
>  #include "save.h"
> +#include "load-session-thread.h"
> =20
>  #define CONSUMERD_FILE	"lttng-consumerd"
> =20
> @@ -80,6 +81,7 @@ static int opt_sig_parent;
>  static int opt_verbose_consumer;
>  static int opt_daemon, opt_background;
>  static int opt_no_kernel;
> +static char *opt_load_session_path;
>  static pid_t ppid;          /* Parent PID for --sig-parent option */
>  static pid_t child_ppid;    /* Internal parent PID use with daemonize. */
>  static char *rundir;
> @@ -152,6 +154,7 @@ static const struct option long_options[] =3D {
>  	{ "pidfile", 1, 0, 'p' },
>  	{ "jul-tcp-port", 1, 0, 'J' },
>  	{ "config", 1, 0, 'f' },
> +	{ "load", 1, 0, 'l' },
>  	{ NULL, 0, 0, 0 }
>  };
> =20
> @@ -200,6 +203,7 @@ static pthread_t dispatch_thread;
>  static pthread_t health_thread;
>  static pthread_t ht_cleanup_thread;
>  static pthread_t jul_reg_thread;
> +LTTNG_HIDDEN sem_t message_thread_ready;
> =20
>  /*
>   * UST registration command queue. This queue is tied with a futex and u=
ses a N
> @@ -296,11 +300,11 @@ const char * const config_section_name =3D "session=
d";
>   * NR_LTTNG_SESSIOND_READY must match the number of calls to
>   * lttng_sessiond_notify_ready().
>   */
> -#define NR_LTTNG_SESSIOND_READY		2
> +#define NR_LTTNG_SESSIOND_READY		3
>  int lttng_sessiond_ready =3D NR_LTTNG_SESSIOND_READY;
> =20
>  /* Notify parents that we are ready for cmd and health check */
> -static
> +LTTNG_HIDDEN
>  void lttng_sessiond_notify_ready(void)
>  {
>  	if (uatomic_sub_return(&lttng_sessiond_ready, 1) =3D=3D 0) {
> @@ -647,6 +651,10 @@ static void cleanup(void)
>  		free(opt_pidfile);
>  	}
> =20
> +	if (opt_load_session_path) {
> +		free(opt_load_session_path);
> +	}
> +
>  	/* <fun> */
>  	DBG("%c[%d;%dm*** assert failed :-) *** =3D=3D> %c[%dm%c[%d;%dm"
>  			"Matthew, BEET driven development works!%c[%dm",
> @@ -3876,6 +3884,11 @@ static void *thread_manage_clients(void *data)
>  	}
> =20
>  	lttng_sessiond_notify_ready();
> +	ret =3D sem_post(&message_thread_ready);
> +	if (ret) {
> +		PERROR("sem_post message_thread_ready");
> +		goto error;
> +	}
> =20
>  	/* This testpoint is after we signal readiness to the parent. */
>  	if (testpoint(sessiond_thread_manage_clients)) {
> @@ -4110,6 +4123,7 @@ static void usage(void)
>  	fprintf(stderr, "      --no-kernel                    Disable kernel tr=
acer\n");
>  	fprintf(stderr, "      --jul-tcp-port                 JUL application r=
egistration TCP port\n");
>  	fprintf(stderr, "  -f  --config                       Load daemon confi=
guration file\n");
> +	fprintf(stderr, "  -l  --load PATH                    Load session conf=
iguration\n");
>  }
> =20
>  /*
> @@ -4229,6 +4243,13 @@ static int set_option(int opt, const char *arg, co=
nst char *optname)
>  		DBG3("JUL TCP port set to non default: %u", jul_tcp_port);
>  		break;
>  	}
> +	case 'l':
> +		opt_load_session_path =3D strdup(arg);
> +		if (!opt_load_session_path) {
> +			perror("strdup");
> +			ret =3D -ENOMEM;
> +		}
> +		break;
>  	default:
>  		/* Unknown option or other error.
>  		 * Error is printed by getopt, just return */
> @@ -4764,6 +4785,7 @@ int main(int argc, char **argv)
>  	int ret =3D 0;
>  	void *status;
>  	const char *home_path, *env_app_timeout;
> +	pthread_t load_session_thread;
> =20
>  	init_kernel_workarounds();
> =20
> @@ -5065,6 +5087,12 @@ int main(int argc, char **argv)
>  	/* This is to get the TCP timeout value. */
>  	lttcomm_inet_init();
> =20
> +	ret =3D sem_init(&message_thread_ready, 0, 0);
> +	if (ret) {
> +		PERROR("sem_init message_thread_ready");
> +		goto error;
> +	}
> +
>  	/*
>  	 * Initialize the health check subsystem. This call should set the
>  	 * appropriate time values.
> @@ -5148,7 +5176,22 @@ int main(int argc, char **argv)
>  			PERROR("pthread_create kernel");
>  			goto exit_kernel;
>  		}
> +	}
> +
> +	/* Create session loading thread. */
> +	ret =3D pthread_create(&load_session_thread, NULL,
> +			thread_load_session,
> +			(void *) opt_load_session_path);
> +	if (ret !=3D 0) {
> +		PERROR("pthread_create load_session_thread");
> +	}
> =20
> +	ret =3D pthread_detach(load_session_thread);
> +	if (ret !=3D 0) {
> +		PERROR("pthread_detach load_session_thread");
> +	}
> +
> +	if (is_root && !opt_no_kernel) {
>  		ret =3D pthread_join(kernel_thread, &status);
>  		if (ret !=3D 0) {
>  			PERROR("pthread_join");
> --=20
> 1.9.2
>=20

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTcPEaXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02alYH/3BvID7hqT9P5YQrU86+x+LH
bBFhVc5zzijYOqaAUZoHe3O6S6X5YFO/Zjl0qh2eBqNZ4eOvwr8J3soTabCQD/I7
4WWwQxyG80DnDNK1g4fO8eXkNNcuHGqZTWSjNrfoYEvV3zcl9C7I9a1QhHkdQh/t
nvre7f0B13V+kMytEvTdueyrA8zgRp6wUQGYoTmFO3yWN1Zb/evTnhdibdVKldln
vxS1+/QzmFFe731vWr+lvcnFMSFRR6WXHiK+7Ul+lTodQOtfzGv89VUk0yoik2YT
5t5HAQVw/atR5sICEUtDUjURV/8cAxm38FpGjvSgS91KawTw+6cw75aiNo1VHAk=
=JT6X
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--


--===============0338535954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0338535954==--
