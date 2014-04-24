From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH v4 lttng-tools] Backported to glibc 2.8
Date: Thu, 24 Apr 2014 09:55:16 -0400
Message-ID: <20140424135516.GB8809__46227.7814433493$1398347846$gmane$org@thessa>
References: <901205894.6381.1398319894929.JavaMail.zimbra@efficios.com>
 <1398327770-13813-1-git-send-email-jderehag@hotmail.com>
 <272764226.6523.1398329899102.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1029888511=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([144.76.53.219])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <dgoulet@efficios.com>) id 1WdK7h-0006qz-S9
 for lttng-dev@lists.lttng.org; Thu, 24 Apr 2014 09:55:39 -0400
In-Reply-To: <272764226.6523.1398329899102.JavaMail.zimbra@efficios.com>
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


--===============1029888511==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24 Apr (08:58:19), Mathieu Desnoyers wrote:
> >  /* See man epoll(7) for this define path */
> >  #define COMPAT_EPOLL_PROC_PATH "/proc/sys/fs/epoll/max_user_watches"
> > @@ -71,7 +73,15 @@ enum {
> >  	LPOLLNVAL =3D EPOLLHUP,
> >  	LPOLLRDHUP =3D EPOLLRDHUP,
> >  	/* Close on exec feature of epoll */
> > +#if __GLIBC_PREREQ(2, 9)
> >  	LTTNG_CLOEXEC =3D EPOLL_CLOEXEC,
> > +#else
> > +	/* EPOLL_CLOEXEC was added in glibc 2.8 (usually used in conjunction
> > +	 * with epoll_create1(..)), but since neither EPOLL_CLOEXEC exists nor
> > +	 * epoll_create1(..), we set it to FD_CLOEXEC so that we can pass it
> > +	 * directly to fcntl(..) instead */
>=20
> David, can you edit this comment and add the missing newline
> when you merge this patch ?

Don't worry, I'll make it pretty.

I'll be merging this today.

Thanks!
David

>=20
> Other than that:
>=20
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>=20
> Thanks Jesper!
>=20
> Mathieu
>=20
> > +	LTTNG_CLOEXEC =3D FD_CLOEXEC,
> > +#endif
> >  };
> > =20
> >  struct compat_epoll_event {
> > @@ -115,6 +125,27 @@ extern int compat_epoll_create(struct lttng_poll_e=
vent
> > *events,
> >  #define lttng_poll_create(events, size, flags) \
> >  	compat_epoll_create(events, size, flags)
> > =20
> > +#if __GLIBC_PREREQ(2, 9)
> > +static inline int compat_glibc_epoll_create(int size
> > __attribute__((unused)),
> > +		int flags)
> > +{
> > +	return epoll_create1(flags);
> > +}
> > +#else
> > +static inline int compat_glibc_epoll_create(int size, int flags)
> > +{
> > +	/*
> > +	 * epoll_create1 was added in glibc 2.9, but unfortunatly reverting to
> > +	 * epoll_create(..) also means that we lose the possibility to
> > +	 * directly set the EPOLL_CLOEXEC, so try and do it anyway but through
> > +	 * fcntl(..).
> > +	 */
> > +	int efd =3D epoll_create(size);
> > +	assert(fcntl(efd, F_SETFD, flags) !=3D -1);
> > +	return efd;
> > +}
> > +#endif
> > +
> >  /*
> >   * Wait on epoll set with the number of fd registered to the
> >   lttng_poll_event
> >   * data structure (events).
> > diff --git a/src/common/consumer-timer.c b/src/common/consumer-timer.c
> > index dc6f2f7..c659bf6 100644
> > --- a/src/common/consumer-timer.c
> > +++ b/src/common/consumer-timer.c
> > @@ -23,6 +23,7 @@
> > =20
> >  #include <bin/lttng-consumerd/health-consumerd.h>
> >  #include <common/common.h>
> > +#include <common/compat/endian.h>
> >  #include <common/kernel-ctl/kernel-ctl.h>
> >  #include <common/kernel-consumer/kernel-consumer.h>
> >  #include <common/consumer-stream.h>
> > diff --git a/src/common/consumer.c b/src/common/consumer.c
> > index e80ac6b..cba4a60 100644
> > --- a/src/common/consumer.c
> > +++ b/src/common/consumer.c
> > @@ -34,6 +34,7 @@
> >  #include <common/common.h>
> >  #include <common/utils.h>
> >  #include <common/compat/poll.h>
> > +#include <common/compat/endian.h>
> >  #include <common/index/index.h>
> >  #include <common/kernel-ctl/kernel-ctl.h>
> >  #include <common/sessiond-comm/relayd.h>
> > diff --git a/src/common/index/index.c b/src/common/index/index.c
> > index abc0985..a462a63 100644
> > --- a/src/common/index/index.c
> > +++ b/src/common/index/index.c
> > @@ -24,6 +24,7 @@
> > =20
> >  #include <common/common.h>
> >  #include <common/defaults.h>
> > +#include <common/compat/endian.h>
> >  #include <common/utils.h>
> > =20
> >  #include "index.h"
> > diff --git a/src/common/kernel-consumer/kernel-consumer.c
> > b/src/common/kernel-consumer/kernel-consumer.c
> > index d15329f..57dc2ba 100644
> > --- a/src/common/kernel-consumer/kernel-consumer.c
> > +++ b/src/common/kernel-consumer/kernel-consumer.c
> > @@ -35,6 +35,7 @@
> >  #include <common/sessiond-comm/sessiond-comm.h>
> >  #include <common/sessiond-comm/relayd.h>
> >  #include <common/compat/fcntl.h>
> > +#include <common/compat/endian.h>
> >  #include <common/pipe.h>
> >  #include <common/relayd/relayd.h>
> >  #include <common/utils.h>
> > diff --git a/src/common/relayd/relayd.c b/src/common/relayd/relayd.c
> > index 3de19c2..38ebdbd 100644
> > --- a/src/common/relayd/relayd.c
> > +++ b/src/common/relayd/relayd.c
> > @@ -25,6 +25,7 @@
> > =20
> >  #include <common/common.h>
> >  #include <common/defaults.h>
> > +#include <common/compat/endian.h>
> >  #include <common/sessiond-comm/relayd.h>
> >  #include <common/index/ctf-index.h>
> > =20
> > diff --git a/src/common/ust-consumer/ust-consumer.c
> > b/src/common/ust-consumer/ust-consumer.c
> > index 9f2e739..b8c1a3c 100644
> > --- a/src/common/ust-consumer/ust-consumer.c
> > +++ b/src/common/ust-consumer/ust-consumer.c
> > @@ -37,6 +37,7 @@
> >  #include <common/sessiond-comm/sessiond-comm.h>
> >  #include <common/relayd/relayd.h>
> >  #include <common/compat/fcntl.h>
> > +#include <common/compat/endian.h>
> >  #include <common/consumer-metadata-cache.h>
> >  #include <common/consumer-stream.h>
> >  #include <common/consumer-timer.h>
> > diff --git a/tests/regression/tools/live/live_test.c
> > b/tests/regression/tools/live/live_test.c
> > index aff8977..d2c9050 100644
> > --- a/tests/regression/tools/live/live_test.c
> > +++ b/tests/regression/tools/live/live_test.c
> > @@ -43,6 +43,8 @@
> >  #include <bin/lttng-relayd/lttng-viewer-abi.h>
> >  #include <common/index/ctf-index.h>
> > =20
> > +#include <common/compat/endian.h>
> > +
> >  #define SESSION1 "test1"
> >  #define RELAYD_URL "net://localhost"
> >  #define LIVE_TIMER 2000000
> > --
> > 1.8.4.1
> >=20
> >=20
>=20
> --=20
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQF8BAEBAgBmBQJTWRfEXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCNzQ0MTdFRERGMjJBQzlGOUU5MEY0OTE0
MkU4NkEyQTExRjQ4RDM2AAoJEELoaioR9I02bv8IAJfJnKdrsPAhMdZTmyvhq4YQ
7oWIjX7i+ayRXd/2ycptM26VCySpDa2tpUvQoFND8RxbxnlxcrXU6UpCfg6YBea+
oTTANenFg+3SE/lYwT+ZVRsMV95ja5Ff5CdGHnAmC690ma3XX09KtfPZ6igf71gP
v2lWoSeA8gMViZzPPHZ7fMAVrv5gtHqe8HeKJ/rK8NTdtPQJ097B8cnegZanGX3c
/u8sFp4YWWjURHefUA7BBsBaHhu7GCnWmVqUw/9ZY+tVcNnnR3l5NUQJpNRI79OH
3n9VeaC8HepUgx7Z3LclXa5MZrXunXBFEe328B2wUExUhtVuh8iFFQWSt5d5GHQ=
=I2f9
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--


--===============1029888511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1029888511==--
