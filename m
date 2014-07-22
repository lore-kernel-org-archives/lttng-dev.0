From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] perf to ctf converter
Date: Tue, 22 Jul 2014 13:31:59 +0200
Message-ID: <53CE4BAF.2010906@linutronix.de>
References: <20140603163640.GA16279@linutronix.de> <20140714141533.GD17761@krava.redhat.com> <20140721171151.GA12969@linutronix.de> <20140721183530.GA28673@krava.redhat.com> <53CE0B89.7030400@linutronix.de> <20140722112535.GA29750@krava.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140722112535.GA29750@krava.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, namhyung.kim@lge.com, tzanussi@gmail.com
List-Id: lttng-dev@lists.lttng.org

On 07/22/2014 01:25 PM, Jiri Olsa wrote:

> I've got it running... make LIBBABELTRACE_DIR=3D/opt/libbabeltrace/ u=
gh ;-)
>=20
> [jolsa@krava perf]$ LD_LIBRARY_PATH=3D/opt/libbabeltrace/lib /opt/lib=
babeltrace/bin/babeltrace ./ctf-data/
>=20
> [04:41:11.445378840] (+?.?????????) sched:sched_switch: { }, { pid =3D=
 5782, comm =3D "ls", prev_comm =3D [ [0] =3D "ls", [1] =3D "s", [2] =3D=
 "", [3] =3D "f", [4] =3D "", [5] =3D "", [6] =3D "-x86_64-l", [7] =3D =
"x86_64-l", [8] =3D "86_64-l", [9] =3D "6_64-l", [10] =3D "_64-l", [11]=
 =3D "64-l", [12] =3D "4-l", [13] =3D "-l", [14] =3D "l", [15] =3D "" ]=
, prev_pid =3D 5782, prev_prio =3D 120, prev_state =3D 0x1, next_comm =3D=
 [ [0] =3D "kworker/0:0", [1] =3D "worker/0:0", [2] =3D "orker/0:0", [3=
] =3D "rker/0:0", [4] =3D "ker/0:0", [5] =3D "er/0:0", [6] =3D "r/0:0",=
 [7] =3D "/0:0", [8] =3D "0:0", [9] =3D ":0", [10] =3D "0", [11] =3D ""=
, [12] =3D "", [13] =3D "", [14] =3D "", [15] =3D "" ], next_pid =3D 23=
76, next_prio =3D 120 }
> [04:41:11.445390175] (+0.000011335) sched:sched_switch: { }, { pid =3D=
 5782, comm =3D "ls", prev_comm =3D [ [0] =3D "ls", [1] =3D "s", [2] =3D=
 "", [3] =3D "f", [4] =3D "", [5] =3D "", [6] =3D "-x86_64-l", [7] =3D =
"x86_64-l", [8] =3D "86_64-l", [9] =3D "6_64-l", [10] =3D "_64-l", [11]=
 =3D "64-l", [12] =3D "4-l", [13] =3D "-l", [14] =3D "l", [15] =3D "" ]=
, prev_pid =3D 5782, prev_prio =3D 120, prev_state =3D 0x1, next_comm =3D=
 [ [0] =3D "kworker/0:0", [1] =3D "worker/0:0", [2] =3D "orker/0:0", [3=
] =3D "rker/0:0", [4] =3D "ker/0:0", [5] =3D "er/0:0", [6] =3D "r/0:0",=
 [7] =3D "/0:0", [8] =3D "0:0", [9] =3D ":0", [10] =3D "0", [11] =3D ""=
, [12] =3D "", [13] =3D "", [14] =3D "", [15] =3D "" ], next_pid =3D 23=
76, next_prio =3D 120 }
>=20
> ...
>=20
> looks like we need some better string arg handling,
> but we'll get there soon or later

I'm looking at how python gets it nicer=E2=80=A6

> we'd like to have single/compact change commits.. so far I think=20
> we can go with following commits:
>=20
>   perf tools: VF=3D2 code
>   perf tools: Feature check for libbabeltrace
>   perf tools: Add new data command
>=20
> and merge your changes/fixies into:
>   perf tools: Add perf data to CTF convertion support
>=20
> if we could break the last one into more logical changes
> it'd be nicer.. but if not, let's got from here
>=20
> I'll prepare those 1st 3 patches.. and review your code while
> getting familiar with ctf again ;-)

Okay. I rebased and re-pushed perf_ctf_3. It is down to 3 + 2
patches. Can merge the last two patches into one.

> thanks,
> jirka

Sebastian
