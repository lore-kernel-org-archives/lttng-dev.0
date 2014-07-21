From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf to ctf converter
Date: Mon, 21 Jul 2014 20:35:30 +0200
Message-ID: <20140721183530.GA28673@krava.redhat.com>
References: <20140603163640.GA16279@linutronix.de>
 <20140714141533.GD17761@krava.redhat.com>
 <20140721171151.GA12969@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140721171151.GA12969@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, namhyung.kim@lge.com, tzanussi@gmail.com
List-Id: lttng-dev@lists.lttng.org

On Mon, Jul 21, 2014 at 07:11:51PM +0200, Sebastian Andrzej Siewior wro=
te:

SNIP

> I have the following now:
>=20
> |$ ../perf data convert -i perf.data.backup --to-ctf ctf-out-backup &=
& babeltrace ctf-out-backup
> |[11:01:45.468071953] (+?.?????????) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0xE, args =3D [ [0] =3D=
 0x0, [1] =3D 0x7FFF18EB71F0, [2] =3D 0x7FFF18EB7170, [3] =3D 0x8, [4] =
=3D 0x0, [5] =3D 0x0 ] }
> |[11:01:45.468074246] (+0.000002293) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0xE, args =3D [ [0] =3D=
 0x2, [1] =3D 0x7FFF18EB7170, [2] =3D 0x0, [3] =3D 0x8, [4] =3D 0x0, [5=
] =3D 0x0 ] }
> |[11:01:45.468076200] (+0.000001954) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0x0, args =3D [ [0] =3D=
 0xE, [1] =3D 0x7FFF18EB3140, [2] =3D 0x4000, [3] =3D 0x0, [4] =3D 0x8C=
=469, [5] =3D 0x0 ] }
> |[11:01:45.468097941] (+0.000021741) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0x17, args =3D [ [0] =
=3D 0x18, [1] =3D 0x7F9E804FBBB0, [2] =3D 0x7F9E804FBB90, [3] =3D 0x0, =
[4] =3D 0x0, [5] =3D 0x0 ] }
> |[11:01:45.468100727] (+0.000002786) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0xE, args =3D [ [0] =3D=
 0x0, [1] =3D 0x7FFF18EB71F0, [2] =3D 0x7FFF18EB7170, [3] =3D 0x8, [4] =
=3D 0x0, [5] =3D 0x0 ] }
> |[11:01:45.468101797] (+0.000001070) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0xE, args =3D [ [0] =3D=
 0x2, [1] =3D 0x7FFF18EB7170, [2] =3D 0x0, [3] =3D 0x8, [4] =3D 0x0, [5=
] =3D 0x0 ] }
> |[11:01:45.468103615] (+0.000001818) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0x1, args =3D [ [0] =3D=
 0x3, [1] =3D 0x7F9E805472E0, [2] =3D 0x30, [3] =3D 0x0, [4] =3D 0x8CF9=
, [5] =3D 0x0 ] }
> |[11:01:45.468126271] (+0.000022656) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0x17, args =3D [ [0] =
=3D 0x18, [1] =3D 0x7F9E804FBBB0, [2] =3D 0x7F9E804FBB90, [3] =3D 0x0, =
[4] =3D 0x0, [5] =3D 0x0 ] }
> |[11:01:45.468140058] (+0.000013787) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 7121, comm =3D "perf_3.14", id =3D 0x10, args =3D [=
 [0] =3D 0x10, [1] =3D 0x2400, [2] =3D 0x0, [3] =3D 0x7FFFCCDED220, [4]=
 =3D 0x2505110, [5] =3D 0x7FB588E31780 ] }
> |[11:01:45.468141518] (+0.000001460) raw_syscalls:sys_enter: { cpu_id=
 =3D 0 }, { pid =3D 7121, comm =3D "perf_3.14", id =3D 0x10, args =3D [=
 [0] =3D 0x18, [1] =3D 0x2400, [2] =3D 0x0, [3] =3D 0x7FFFCCDED220, [4]=
 =3D 0x2505110, [5] =3D 0x7FB588E31780 ] }
> =E2=80=A6
> |[11:01:45.468208465] (+0.000000062) irq:softirq_raise: { cpu_id =3D =
0 }, { pid =3D 0, comm =3D "swapper", vec =3D 3 }
> |[11:01:45.468209788] (+0.000001323) irq:softirq_entry: { cpu_id =3D =
0 }, { pid =3D 0, comm =3D "swapper", vec =3D 3 }

heya,
I've  got following build error:

  CC       util/data-bt.o
util/data-bt.c: In function =E2=80=98add_event_tracepoint_value=E2=80=99=
:
util/data-bt.c:293:3: error: implicit declaration of function =E2=80=98=
bt_ctf_event_class_get_field_by_name=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
   type =3D bt_ctf_event_class_get_field_by_name(
   ^
util/data-bt.c:293:3: error: nested extern declaration of =E2=80=98bt_c=
tf_event_class_get_field_by_name=E2=80=99 [-Werror=3Dnested-externs]
util/data-bt.c:293:8: error: assignment makes pointer from integer with=
out a cast [-Werror]
   type =3D bt_ctf_event_class_get_field_by_name(
        ^
cc1: all warnings being treated as errors
make[1]: *** [util/data-bt.o] Error 1
make: *** [all] Error 2


but I might be missing some of the babeltrace changes, my branch:
  5805251d8079 Fix: mmap trace read the stream_id from the first packet

> =E2=80=A6
>=20
> In brief:
> - added support for PERF_TYPE_TRACEPOINT, broked everything else. Fix=
ing
>   this on todo :)
> - added support for multiple type of arguments (pid & comm is "generi=
c",
>   id, args, vec is based on tp_format which I don't fully understand =
but
>   it seems to work (the python script writes NR instead id or adds
>   "[action=3DNET_RX]" behind vec=3D3 and I haven't figured out what k=
ind of
>   magic that is)).
>=20
> I pushed my current state to:
>     http://git.breakpoint.cc/cgit/bigeasy/linux.git/log/?h=3Dperf_ctf=
_3
>     git://git.breakpoint.cc/bigeasy/linux.git perf_ctf_3
>=20
> It is based on TIP tree from last friday and I fixed up some of your
> cows :)
>=20
> Some of your patches lack a sign-off by line. If I am allowed to add =
them
> then I would post the complete thing for a public review. Otherwiese =
I am
> open to suggestions how we could proceed here.

feel free to use/change my commits as you wish ;-)

I think the best would be to merge your changes with mine
into some meaningful patchset, before it goes to review

I'll check your changes

thanks,
jirka
