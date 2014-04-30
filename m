From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH v4 lttng-tools] Backported to glibc 2.8
Date: Wed, 30 Apr 2014 12:54:44 -0400
Message-ID: <20140430165444.GB32499__29149.8010083616$1398876994$gmane$org@dalia>
References: <901205894.6381.1398319894929.JavaMail.zimbra@efficios.com>
 <1398327770-13813-1-git-send-email-jderehag@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0014985227=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WfXmm-0005Cp-8y
 for lttng-dev@lists.lttng.org; Wed, 30 Apr 2014 12:55:14 -0400
In-Reply-To: <1398327770-13813-1-git-send-email-jderehag@hotmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jesper Derehag <jderehag@hotmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0014985227==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Merged!

Thanks

On 24 Apr (10:22:50), Jesper Derehag wrote:
> This patch enables lttng-tools to run on top of glibc 2.8.
> Overall it fixes 2 things:
> 1. No support for epoll_create1(..) and EPOLL_CLOEXEC.
> 2. No support for htobe/betoh
>=20
> For 1, we revert back to epoll_create() and then sets CLOEXEC
> through fcntl instead.
> For 2, we define htobe/betoh as part of the compat/endian.h
> and make sure that any users of those functions actually
> include compat/endian.h instead of implicit include of
> system endian.h
>=20
> Signed-off-by: Jesper Derehag <jderehag@hotmail.com>
> Tested-by: Jesper Derehag <jderehag@hotmail.com>
> ---
>  src/bin/lttng-relayd/cmd-2-2.c               |  2 +
>  src/bin/lttng-relayd/cmd-2-4.c               |  2 +
>  src/bin/lttng-relayd/live.c                  |  1 +
>  src/bin/lttng-relayd/main.c                  |  1 +
>  src/bin/lttng-sessiond/jul-thread.c          |  2 +
>  src/bin/lttng-sessiond/jul.c                 |  2 +
>  src/common/compat/compat-epoll.c             |  2 +-
>  src/common/compat/endian.h                   | 94 ++++++++++++++++++++++=
+++++-
>  src/common/compat/poll.h                     | 31 +++++++++
>  src/common/consumer-timer.c                  |  1 +
>  src/common/consumer.c                        |  1 +
>  src/common/index/index.c                     |  1 +
>  src/common/kernel-consumer/kernel-consumer.c |  1 +
>  src/common/relayd/relayd.c                   |  1 +
>  src/common/ust-consumer/ust-consumer.c       |  1 +
>  tests/regression/tools/live/live_test.c      |  2 +
>  16 files changed, 143 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/bin/lttng-relayd/cmd-2-2.c b/src/bin/lttng-relayd/cmd-2-=
2.c
> index b7299a5..978a11e 100644
> --- a/src/bin/lttng-relayd/cmd-2-2.c
> +++ b/src/bin/lttng-relayd/cmd-2-2.c
> @@ -23,6 +23,8 @@
>  #include <common/common.h>
>  #include <common/sessiond-comm/relayd.h>
> =20
> +#include <common/compat/endian.h>
> +
>  #include "cmd-generic.h"
>  #include "cmd-2-1.h"
>  #include "utils.h"
> diff --git a/src/bin/lttng-relayd/cmd-2-4.c b/src/bin/lttng-relayd/cmd-2-=
4.c
> index 3196383..6d927a0 100644
> --- a/src/bin/lttng-relayd/cmd-2-4.c
> +++ b/src/bin/lttng-relayd/cmd-2-4.c
> @@ -23,6 +23,8 @@
>  #include <common/common.h>
>  #include <common/sessiond-comm/relayd.h>
> =20
> +#include <common/compat/endian.h>
> +
>  #include "cmd-generic.h"
>  #include "lttng-relayd.h"
> =20
> diff --git a/src/bin/lttng-relayd/live.c b/src/bin/lttng-relayd/live.c
> index c60f7e4..d8517d2 100644
> --- a/src/bin/lttng-relayd/live.c
> +++ b/src/bin/lttng-relayd/live.c
> @@ -43,6 +43,7 @@
>  #include <common/common.h>
>  #include <common/compat/poll.h>
>  #include <common/compat/socket.h>
> +#include <common/compat/endian.h>
>  #include <common/defaults.h>
>  #include <common/futex.h>
>  #include <common/index/index.h>
> diff --git a/src/bin/lttng-relayd/main.c b/src/bin/lttng-relayd/main.c
> index a93151a..93b08fc 100644
> --- a/src/bin/lttng-relayd/main.c
> +++ b/src/bin/lttng-relayd/main.c
> @@ -44,6 +44,7 @@
>  #include <common/common.h>
>  #include <common/compat/poll.h>
>  #include <common/compat/socket.h>
> +#include <common/compat/endian.h>
>  #include <common/defaults.h>
>  #include <common/daemonize.h>
>  #include <common/futex.h>
> diff --git a/src/bin/lttng-sessiond/jul-thread.c b/src/bin/lttng-sessiond=
/jul-thread.c
> index cc694df..9859a10 100644
> --- a/src/bin/lttng-sessiond/jul-thread.c
> +++ b/src/bin/lttng-sessiond/jul-thread.c
> @@ -23,6 +23,8 @@
>  #include <common/uri.h>
>  #include <common/utils.h>
> =20
> +#include <common/compat/endian.h>
> +
>  #include "fd-limit.h"
>  #include "jul-thread.h"
>  #include "lttng-sessiond.h"
> diff --git a/src/bin/lttng-sessiond/jul.c b/src/bin/lttng-sessiond/jul.c
> index 7bb0d75..da4cf67 100644
> --- a/src/bin/lttng-sessiond/jul.c
> +++ b/src/bin/lttng-sessiond/jul.c
> @@ -22,6 +22,8 @@
>  #include <common/common.h>
>  #include <common/sessiond-comm/jul.h>
> =20
> +#include <common/compat/endian.h>
> +
>  #include "jul.h"
>  #include "ust-app.h"
>  #include "utils.h"
> diff --git a/src/common/compat/compat-epoll.c b/src/common/compat/compat-=
epoll.c
> index ecd09a0..368fae1 100644
> --- a/src/common/compat/compat-epoll.c
> +++ b/src/common/compat/compat-epoll.c
> @@ -81,7 +81,7 @@ int compat_epoll_create(struct lttng_poll_event *events=
, int size, int flags)
>  		size =3D poll_max_size;
>  	}
> =20
> -	ret =3D epoll_create1(flags);
> +	ret =3D compat_glibc_epoll_create(size, flags);
>  	if (ret < 0) {
>  		/* At this point, every error is fatal */
>  		PERROR("epoll_create1");
> diff --git a/src/common/compat/endian.h b/src/common/compat/endian.h
> index 2850866..baea531 100644
> --- a/src/common/compat/endian.h
> +++ b/src/common/compat/endian.h
> @@ -15,11 +15,103 @@
>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
> =20
> -#ifdef _COMPAT_ENDIAN_H
> +#ifndef _COMPAT_ENDIAN_H
>  #define _COMPAT_ENDIAN_H
> =20
>  #ifdef __linux__
>  #include <endian.h>
> +
> +/*
> + * htobe/betoh are not defined for glibc <2.9, so add them
> + * explicitly if they are missing.
> + */
> +#ifdef __USE_BSD
> +/* Conversion interfaces. */
> +# include <byteswap.h>
> +
> +# if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
> +#  ifndef htobe16
> +#   define htobe16(x) __bswap_16(x)
> +#  endif
> +#  ifndef htole16
> +#   define htole16(x) (x)
> +#  endif
> +#  ifndef be16toh
> +#   define be16toh(x) __bswap_16(x)
> +#  endif
> +#  ifndef le16toh
> +#   define le16toh(x) (x)
> +#  endif
> +
> +#  ifndef htobe32
> +#   define htobe32(x) __bswap_32(x)
> +#  endif
> +#  ifndef htole32
> +#   define htole32(x) (x)
> +#  endif
> +#  ifndef be32toh
> +#   define be32toh(x) __bswap_32(x)
> +#  endif
> +#  ifndef le32toh
> +#   define le32toh(x) (x)
> +#  endif
> +
> +#  ifndef htobe64
> +#   define htobe64(x) __bswap_64(x)
> +#  endif
> +#  ifndef htole64
> +#   define htole64(x) (x)
> +#  endif
> +#  ifndef be64toh
> +#   define be64toh(x) __bswap_64(x)
> +#  endif
> +#  ifndef le64toh
> +#   define le64toh(x) (x)
> +#  endif
> +
> +# else /* __BYTE_ORDER =3D=3D __LITTLE_ENDIAN */
> +#  ifndef htobe16
> +#   define htobe16(x) (x)
> +#  endif
> +#  ifndef htole16
> +#   define htole16(x) __bswap_16(x)
> +#  endif
> +#  ifndef be16toh
> +#   define be16toh(x) (x)
> +#  endif
> +#  ifndef le16toh
> +#   define le16toh(x) __bswap_16(x)
> +#  endif
> +
> +#  ifndef htobe32
> +#   define htobe32(x) (x)
> +#  endif
> +#  ifndef htole32
> +#   define htole32(x) __bswap_32(x)
> +#  endif
> +#  ifndef be32toh
> +#   define be32toh(x) (x)
> +#  endif
> +#  ifndef le32toh
> +#   define le32toh(x) __bswap_32(x)
> +#  endif
> +
> +#  ifndef htobe64
> +#   define htobe64(x) (x)
> +#  endif
> +#  ifndef htole64
> +#   define htole64(x) __bswap_64(x)
> +#  endif
> +#  ifndef be64toh
> +#   define be64toh(x) (x)
> +#  endif
> +#  ifndef le64toh
> +#   define le64toh(x) __bswap_64(x)
> +#  endif
> +
> +# endif /* __BYTE_ORDER =3D=3D __LITTLE_ENDIAN */
> +#endif /* __USE_BSD */
> +
>  #elif defined(__FreeBSD__)
>  #include <machine/endian.h>
>  #else
> diff --git a/src/common/compat/poll.h b/src/common/compat/poll.h
> index b019b42..40a96d2 100644
> --- a/src/common/compat/poll.h
> +++ b/src/common/compat/poll.h
> @@ -52,6 +52,8 @@ static inline void __lttng_poll_free(void *events)
>  #ifdef HAVE_EPOLL
>  #include <sys/epoll.h>
>  #include <stdio.h>
> +#include <features.h>
> +#include <common/compat/fcntl.h>
> =20
>  /* See man epoll(7) for this define path */
>  #define COMPAT_EPOLL_PROC_PATH "/proc/sys/fs/epoll/max_user_watches"
> @@ -71,7 +73,15 @@ enum {
>  	LPOLLNVAL =3D EPOLLHUP,
>  	LPOLLRDHUP =3D EPOLLRDHUP,
>  	/* Close on exec feature of epoll */
> +#if __GLIBC_PREREQ(2, 9)
>  	LTTNG_CLOEXEC =3D EPOLL_CLOEXEC,
> +#else
> +	/* EPOLL_CLOEXEC was added in glibc 2.8 (usually used in conjunction
> +	 * with epoll_create1(..)), but since neither EPOLL_CLOEXEC exists nor
> +	 * epoll_create1(..), we set it to FD_CLOEXEC so that we can pass it
> +	 * directly to fcntl(..) instead */
> +	LTTNG_CLOEXEC =3D FD_CLOEXEC,
> +#endif
>  };
> =20
>  struct compat_epoll_event {
> @@ -115,6 +125,27 @@ extern int compat_epoll_create(struct lttng_poll_eve=
nt *events,
>  #define lttng_poll_create(events, size, flags) \
>  	compat_epoll_create(events, size, flags)
> =20
> +#if __GLIBC_PREREQ(2, 9)
> +static inline int compat_glibc_epoll_create(int size __attribute__((unus=
ed)),
> +		int flags)
> +{
> +	return epoll_create1(flags);
> +}
> +#else
> +static inline int compat_glibc_epoll_create(int size, int flags)
> +{
> +	/*
> +	 * epoll_create1 was added in glibc 2.9, but unfortunatly reverting to
> +	 * epoll_create(..) also means that we lose the possibility to
> +	 * directly set the EPOLL_CLOEXEC, so try and do it anyway but through
> +	 * fcntl(..).
> +	 */
> +	int efd =3D epoll_create(size);
> +	assert(fcntl(efd, F_SETFD, flags) !=3D -1);
> +	return efd;
> +}
> +#endif
> +
>  /*
>   * Wait on epoll set with the number of fd registered to the lttng_poll_=
event
>   * data structure (events).
> diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
> index dc6f2f7..c659bf6 100644
> --- a/src/common/consumer-timer.c
> +++ b/src/common/consumer-timer.c
> @@ -23,6 +23,7 @@
> =20
>  #include <bin/lttng-consumerd/health-consumerd.h>
>  #include <common/common.h>
> +#include <common/compat/endian.h>
>  #include <common/kernel-ctl/kernel-ctl.h>
>  #include <common/kernel-consumer/kernel-consumer.h>
>  #include <common/consumer-stream.h>
> diff --git a/src/common/consumer.c b/src/common/consumer.c
> index e80ac6b..cba4a60 100644
> --- a/src/common/consumer.c
> +++ b/src/common/consumer.c
> @@ -34,6 +34,7 @@
>  #include <common/common.h>
>  #include <common/utils.h>
>  #include <common/compat/poll.h>
> +#include <common/compat/endian.h>
>  #include <common/index/index.h>
>  #include <common/kernel-ctl/kernel-ctl.h>
>  #include <common/sessiond-comm/relayd.h>
> diff --git a/src/common/index/index.c b/src/common/index/index.c
> index abc0985..a462a63 100644
> --- a/src/common/index/index.c
> +++ b/src/common/index/index.c
> @@ -24,6 +24,7 @@
> =20
>  #include <common/common.h>
>  #include <common/defaults.h>
> +#include <common/compat/endian.h>
>  #include <common/utils.h>
> =20
>  #include "index.h"
> diff --git a/src/common/kernel-consumer/kernel-consumer.c b/src/common/ke=
rnel-consumer/kernel-consumer.c
> index d15329f..57dc2ba 100644
> --- a/src/common/kernel-consumer/kernel-consumer.c
> +++ b/src/common/kernel-consumer/kernel-consumer.c
> @@ -35,6 +35,7 @@
>  #include <common/sessiond-comm/sessiond-comm.h>
>  #include <common/sessiond-comm/relayd.h>
>  #include <common/compat/fcntl.h>
> +#include <common/compat/endian.h>
>  #include <common/pipe.h>
>  #include <common/relayd/relayd.h>
>  #include <common/utils.h>
> diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
> index 3de19c2..38ebdbd 100644
> --- a/src/common/relayd/relayd.c
> +++ b/src/common/relayd/relayd.c
> @@ -25,6 +25,7 @@
> =20
>  #include <common/common.h>
>  #include <common/defaults.h>
> +#include <common/compat/endian.h>
>  #include <common/sessiond-comm/relayd.h>
>  #include <common/index/ctf-index.h>
> =20
> diff --git a/src/common/ust-consumer/ust-consumer.c b/src/common/ust-cons=
umer/ust-consumer.c
> index 9f2e739..b8c1a3c 100644
> --- a/src/common/ust-consumer/ust-consumer.c
> +++ b/src/common/ust-consumer/ust-consumer.c
> @@ -37,6 +37,7 @@
>  #include <common/sessiond-comm/sessiond-comm.h>
>  #include <common/relayd/relayd.h>
>  #include <common/compat/fcntl.h>
> +#include <common/compat/endian.h>
>  #include <common/consumer-metadata-cache.h>
>  #include <common/consumer-stream.h>
>  #include <common/consumer-timer.h>
> diff --git a/tests/regression/tools/live/live_test.c b/tests/regression/t=
ools/live/live_test.c
> index aff8977..d2c9050 100644
> --- a/tests/regression/tools/live/live_test.c
> +++ b/tests/regression/tools/live/live_test.c
> @@ -43,6 +43,8 @@
>  #include <bin/lttng-relayd/lttng-viewer-abi.h>
>  #include <common/index/ctf-index.h>
> =20
> +#include <common/compat/endian.h>
> +
>  #define SESSION1 "test1"
>  #define RELAYD_URL "net://localhost"
>  #define LIVE_TIMER 2000000
> --=20
> 1.8.4.1
>=20

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTYSrUXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02HhoIAMviCpVZGrExcsM/t5Et9CiJ
2Bz5rX2MLGcIIGxLq29bHvQNsIcgKUKfqJrPXZttkLvW16OesLrNHpYinY07BnuY
RiW4DnKi5kjA6b5Lxl8sedHKfY1vnlBToD8JjJ3cEZpWbp5+5+uUPfGz5XcWZIhx
ATT6Ze9gbggonHcKYvGgHKr4j0/htr8uOqsNx/ykvF7B20zgi43WebrgVq9/Z1V0
fFx/nKuORzYOUjbknuzjCLNGnn6EpYawuZJQ0itXGh161sdghxF4zZqR/5HRIuv7
TEMxYUZhcQGGfybc+/9YVtdvNpgjVbCXw0RDxTlfJuag7hMnUpvEPNYdVc5t3+w=
=kBzG
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--


--===============0014985227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0014985227==--
