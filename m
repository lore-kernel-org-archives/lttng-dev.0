From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf to ctf converter
Date: Tue, 22 Jul 2014 13:25:35 +0200
Message-ID: <20140722112535.GA29750@krava.redhat.com>
References: <20140603163640.GA16279@linutronix.de>
 <20140714141533.GD17761@krava.redhat.com>
 <20140721171151.GA12969@linutronix.de>
 <20140721183530.GA28673@krava.redhat.com>
 <53CE0B89.7030400@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53CE0B89.7030400@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, namhyung.kim@lge.com, tzanussi@gmail.com
List-Id: lttng-dev@lists.lttng.org

On Tue, Jul 22, 2014 at 08:58:17AM +0200, Sebastian Andrzej Siewior wro=
te:
> On 07/21/2014 08:35 PM, Jiri Olsa wrote:
> > On Mon, Jul 21, 2014 at 07:11:51PM +0200, Sebastian Andrzej Siewior=
 wrote:
> >
> > heya,
> > I've  got following build error:
> >=20
> >   CC       util/data-bt.o
> > util/data-bt.c: In function =E2=80=98add_event_tracepoint_value=E2=80=
=99:
> > util/data-bt.c:293:3: error: implicit declaration of function =E2=80=
=98bt_ctf_event_class_get_field_by_name=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
> >    type =3D bt_ctf_event_class_get_field_by_name(
> >    ^
> > util/data-bt.c:293:3: error: nested extern declaration of =E2=80=98=
bt_ctf_event_class_get_field_by_name=E2=80=99 [-Werror=3Dnested-externs=
]
> > util/data-bt.c:293:8: error: assignment makes pointer from integer =
without a cast [-Werror]
> >    type =3D bt_ctf_event_class_get_field_by_name(
> >         ^
> > cc1: all warnings being treated as errors
> > make[1]: *** [util/data-bt.o] Error 1
> > make: *** [all] Error 2
> >=20
> >=20
> > but I might be missing some of the babeltrace changes, my branch:
> >   5805251d8079 Fix: mmap trace read the stream_id from the first pa=
cket
>=20
> Hmm. This function should be there as of commit 2f100782231 in the
> master branch. However since my first post and now the babeltrace
> source got moved around a little and as a result you have some more
> header files.
> The function in question is defined in "babeltrace/ctf-ir/event.h" an=
d
> included by "babeltrace/ctf-writer/event.h".

I've got it running... make LIBBABELTRACE_DIR=3D/opt/libbabeltrace/ ugh=
 ;-)

[jolsa@krava perf]$ LD_LIBRARY_PATH=3D/opt/libbabeltrace/lib /opt/libba=
beltrace/bin/babeltrace ./ctf-data/

[04:41:11.445378840] (+?.?????????) sched:sched_switch: { }, { pid =3D =
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
[04:41:11.445390175] (+0.000011335) sched:sched_switch: { }, { pid =3D =
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

=2E..

looks like we need some better string arg handling,
but we'll get there soon or later

>=20
> > feel free to use/change my commits as you wish ;-)
>=20
> Thank you.
>=20
> >=20
> > I think the best would be to merge your changes with mine
> > into some meaningful patchset, before it goes to review
>=20
> Yeah. I merged some of the fixups back and for the data-bt.c changes,
> dunno. Either all my changes as a single patch or merge it back into
> yours as it doesn't make sense to post each incremental change.

we'd like to have single/compact change commits.. so far I think=20
we can go with following commits:

  perf tools: VF=3D2 code
  perf tools: Feature check for libbabeltrace
  perf tools: Add new data command

and merge your changes/fixies into:
  perf tools: Add perf data to CTF convertion support

if we could break the last one into more logical changes
it'd be nicer.. but if not, let's got from here

I'll prepare those 1st 3 patches.. and review your code while
getting familiar with ctf again ;-)

thanks,
jirka
