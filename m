From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] perf to ctf converter
Date: Mon, 21 Jul 2014 19:11:51 +0200
Message-ID: <20140721171151.GA12969@linutronix.de>
References: <20140603163640.GA16279@linutronix.de>
 <20140714141533.GD17761@krava.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140714141533.GD17761@krava.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, namhyung.kim@lge.com, tzanussi@gmail.com
List-Id: lttng-dev@lists.lttng.org

* Jiri Olsa | 2014-07-14 16:15:33 [+0200]:

>I made similar effort in C:
>
>---
>I made some *VERY* early perf convert example, mostly to try the ctf-w=
riter
>interface.. you can check in here:
>  https://git.kernel.org/cgit/linux/kernel/git/jolsa/perf.git/log/?h=3D=
perf/ctf_2
>
>It's able to convert single event (HW type) perf.data file into CTF da=
ta,
>by adding just one integer field "period" and single stream, like:
>
>  [jolsa@krava perf]$ LD_LIBRARY_PATH=3D/opt/libbabeltrace/lib/ ./perf=
 data convert --to-ctf=3D./ctf-data
>  ...
>  [jolsa@krava babeltrace]$ /opt/libbabeltrace/bin/babeltrace /home/jo=
lsa/kernel.org/linux-perf/tools/perf/ctf-data
>  [08:14:45.814456098] (+?.?????????) cycles: { }, { period =3D 1 }
>  [08:14:45.814459237] (+0.000003139) cycles: { }, { period =3D 1 }
>  [08:14:45.814460684] (+0.000001447) cycles: { }, { period =3D 9 }
>  [08:14:45.814462073] (+0.000001389) cycles: { }, { period =3D 182 }
>  [08:14:45.814463491] (+0.000001418) cycles: { }, { period =3D 4263 }
>  [08:14:45.814465874] (+0.000002383) cycles: { }, { period =3D 97878 =
}
>  [08:14:45.814506385] (+0.000040511) cycles: { }, { period =3D 136596=
5 }
>  [08:14:45.815056528] (+0.000550143) cycles: { }, { period =3D 225001=
2 }
>---
>
>the goals for me is to have a convert tool, like in above example
>perf data command and support in perf record/report to directl
>write/read ctf data

I have the following now:

|$ ../perf data convert -i perf.data.backup --to-ctf ctf-out-backup && =
babeltrace ctf-out-backup
|[11:01:45.468071953] (+?.?????????) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0xE, args =3D [ [0] =3D 0=
x0, [1] =3D 0x7FFF18EB71F0, [2] =3D 0x7FFF18EB7170, [3] =3D 0x8, [4] =3D=
 0x0, [5] =3D 0x0 ] }
|[11:01:45.468074246] (+0.000002293) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0xE, args =3D [ [0] =3D 0=
x2, [1] =3D 0x7FFF18EB7170, [2] =3D 0x0, [3] =3D 0x8, [4] =3D 0x0, [5] =
=3D 0x0 ] }
|[11:01:45.468076200] (+0.000001954) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0x0, args =3D [ [0] =3D 0=
xE, [1] =3D 0x7FFF18EB3140, [2] =3D 0x4000, [3] =3D 0x0, [4] =3D 0x8CF9=
, [5] =3D 0x0 ] }
|[11:01:45.468097941] (+0.000021741) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0x17, args =3D [ [0] =3D =
0x18, [1] =3D 0x7F9E804FBBB0, [2] =3D 0x7F9E804FBB90, [3] =3D 0x0, [4] =
=3D 0x0, [5] =3D 0x0 ] }
|[11:01:45.468100727] (+0.000002786) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0xE, args =3D [ [0] =3D 0=
x0, [1] =3D 0x7FFF18EB71F0, [2] =3D 0x7FFF18EB7170, [3] =3D 0x8, [4] =3D=
 0x0, [5] =3D 0x0 ] }
|[11:01:45.468101797] (+0.000001070) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0xE, args =3D [ [0] =3D 0=
x2, [1] =3D 0x7FFF18EB7170, [2] =3D 0x0, [3] =3D 0x8, [4] =3D 0x0, [5] =
=3D 0x0 ] }
|[11:01:45.468103615] (+0.000001818) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0x1, args =3D [ [0] =3D 0=
x3, [1] =3D 0x7F9E805472E0, [2] =3D 0x30, [3] =3D 0x0, [4] =3D 0x8CF9, =
[5] =3D 0x0 ] }
|[11:01:45.468126271] (+0.000022656) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 2906, comm =3D "sshd", id =3D 0x17, args =3D [ [0] =3D =
0x18, [1] =3D 0x7F9E804FBBB0, [2] =3D 0x7F9E804FBB90, [3] =3D 0x0, [4] =
=3D 0x0, [5] =3D 0x0 ] }
|[11:01:45.468140058] (+0.000013787) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 7121, comm =3D "perf_3.14", id =3D 0x10, args =3D [ [0]=
 =3D 0x10, [1] =3D 0x2400, [2] =3D 0x0, [3] =3D 0x7FFFCCDED220, [4] =3D=
 0x2505110, [5] =3D 0x7FB588E31780 ] }
|[11:01:45.468141518] (+0.000001460) raw_syscalls:sys_enter: { cpu_id =3D=
 0 }, { pid =3D 7121, comm =3D "perf_3.14", id =3D 0x10, args =3D [ [0]=
 =3D 0x18, [1] =3D 0x2400, [2] =3D 0x0, [3] =3D 0x7FFFCCDED220, [4] =3D=
 0x2505110, [5] =3D 0x7FB588E31780 ] }
=E2=80=A6
|[11:01:45.468208465] (+0.000000062) irq:softirq_raise: { cpu_id =3D 0 =
}, { pid =3D 0, comm =3D "swapper", vec =3D 3 }
|[11:01:45.468209788] (+0.000001323) irq:softirq_entry: { cpu_id =3D 0 =
}, { pid =3D 0, comm =3D "swapper", vec =3D 3 }
=E2=80=A6

In brief:
- added support for PERF_TYPE_TRACEPOINT, broked everything else. Fixin=
g
  this on todo :)
- added support for multiple type of arguments (pid & comm is "generic"=
,
  id, args, vec is based on tp_format which I don't fully understand bu=
t
  it seems to work (the python script writes NR instead id or adds
  "[action=3DNET_RX]" behind vec=3D3 and I haven't figured out what kin=
d of
  magic that is)).

I pushed my current state to:
    http://git.breakpoint.cc/cgit/bigeasy/linux.git/log/?h=3Dperf_ctf_3
    git://git.breakpoint.cc/bigeasy/linux.git perf_ctf_3

It is based on TIP tree from last friday and I fixed up some of your
cows :)

Some of your patches lack a sign-off by line. If I am allowed to add th=
em
then I would post the complete thing for a public review. Otherwiese I =
am
open to suggestions how we could proceed here.

>thanks,
>jirka

Sebastian
