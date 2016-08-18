From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/6] hypertrace: Lightweight guest-to-QEMU
 trace channel
Date: Thu, 18 Aug 2016 10:47:20 +0100
Message-ID: <20160818094720.GA4850@stefanha-x1.localdomain>
References: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <147041636348.2523.2954972609232949598.stgit@fimbulvetr.bsc.es>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, Luiz Capitulino <lcapitulino@redhat.com>, lttng-dev@lists.lttng.org, Masami Hiramatsu <mhiramat@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: lttng-dev@lists.lttng.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2016 at 06:59:23PM +0200, Llu=EDs Vilanova wrote:
> The hypertrace channel allows guest code to emit events in QEMU (the host=
) using
> its tracing infrastructure (see "docs/trace.txt"). This works in both 'sy=
stem'
> and 'user' modes. That is, hypertrace is to tracing, what hypercalls are =
to
> system calls.
>=20
> You can use this to emit an event on both guest and QEMU (host) traces to=
 easily
> synchronize or correlate them. You could also modify you guest's tracing =
system
> to emit all events through the hypertrace channel, providing a unified an=
d fully
> synchronized trace log. Another use case is timing the performance of gue=
st code
> when optimizing TCG (QEMU traces have a timestamp).
>=20
> See first commit for a full description.
>=20
> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> ---

CCing Steven Rostedt, Masami Hiramatsu, Luiz Capitulino, and LTTng folks
who have all looked into host/guest tracing solutions.

Here is a mailing list archive link to this email thread:
https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg01081.html

>=20
> Llu=EDs Vilanova (6):
>       hypertrace: Add documentation
>       hypertrace: Add tracing event "guest_hypertrace"
>       hypertrace: [*-user] Add QEMU-side proxy to "guest_hypertrace" event
>       hypertrace: [softmmu] Add QEMU-side proxy to "guest_hypertrace" eve=
nt
>       hypertrace: Add guest-side user-level library
>       hypertrace: Add guest-side Linux module
>=20
>=20
>  Makefile                                           |    8 -
>  Makefile.objs                                      |    6=20
>  bsd-user/main.c                                    |   16 +
>  bsd-user/mmap.c                                    |    2=20
>  bsd-user/syscall.c                                 |    4=20
>  configure                                          |   42 +++
>  docs/hypertrace.txt                                |  141 ++++++++++
>  docs/tracing.txt                                   |    3=20
>  hypertrace/Makefile.objs                           |   20 +
>  hypertrace/guest/linux-module/Kbuild.in            |    5=20
>  hypertrace/guest/linux-module/Makefile             |   24 ++
>  .../include/linux/qemu-hypertrace-internal.h       |   46 +++
>  .../linux-module/include/linux/qemu-hypertrace.h   |   71 +++++
>  hypertrace/guest/linux-module/qemu-hypertrace.c    |  133 +++++++++
>  hypertrace/guest/user/Makefile                     |   28 ++
>  hypertrace/guest/user/common.c                     |  221 +++++++++++++++
>  hypertrace/guest/user/qemu-hypertrace.h            |   77 +++++
>  hypertrace/softmmu.c                               |  243 ++++++++++++++=
+++
>  hypertrace/user.c                                  |  292 ++++++++++++++=
++++++
>  hypertrace/user.h                                  |   52 ++++
>  include/hw/pci/pci.h                               |    2=20
>  linux-user/main.c                                  |   19 +
>  linux-user/mmap.c                                  |    2=20
>  linux-user/syscall.c                               |    3=20
>  trace/Makefile.objs                                |    2=20
>  25 files changed, 1460 insertions(+), 2 deletions(-)
>  create mode 100644 docs/hypertrace.txt
>  create mode 100644 hypertrace/Makefile.objs
>  create mode 100644 hypertrace/guest/linux-module/Kbuild.in
>  create mode 100644 hypertrace/guest/linux-module/Makefile
>  create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace-internal.h
>  create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace.h
>  create mode 100644 hypertrace/guest/linux-module/qemu-hypertrace.c
>  create mode 100644 hypertrace/guest/user/Makefile
>  create mode 100644 hypertrace/guest/user/common.c
>  create mode 100644 hypertrace/guest/user/qemu-hypertrace.h
>  create mode 100644 hypertrace/softmmu.c
>  create mode 100644 hypertrace/user.c
>  create mode 100644 hypertrace/user.h
>=20
>=20
> To: qemu-devel@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>=20

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXtYQoAAoJEJykq7OBq3PIemYH/j8uwZcQRkcsSt8WA+w+DKQa
0n6YCaoIPOl2sha8WTnV6v1NCcAtf+zmQJ+lVXaSUhqOdJGvoIIVKICUPRlsEn4B
xp6XGNM2l9BfaEtVOmUnuA4NiKZI2LWEf+3eeztu3FbWxuY2S4PF9xgyE5RDiMma
PF9HqpX9ody7jjFXLP3om+CDBorWpNmhUtDnXitA+22Ap4K1Fmyq15p99JJcRGxg
cvUyhfhkhU0UaJ1r/AF30vy9YZtcHZOX4syhyGtHch2WUHsY1QLft9WSrrRPMA6Y
2dVRNk8qgDetXkKM9SJmTvHhDa4OC50iouuvv9UZGcZtL+7N0wq6/9+mB2pyU2g=
=u9S6
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
