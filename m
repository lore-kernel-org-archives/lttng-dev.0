From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] perf to ctf converter
Date: Tue, 22 Jul 2014 08:58:17 +0200
Message-ID: <53CE0B89.7030400@linutronix.de>
References: <20140603163640.GA16279@linutronix.de> <20140714141533.GD17761@krava.redhat.com> <20140721171151.GA12969@linutronix.de> <20140721183530.GA28673@krava.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140721183530.GA28673@krava.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, namhyung.kim@lge.com, tzanussi@gmail.com
List-Id: lttng-dev@lists.lttng.org

On 07/21/2014 08:35 PM, Jiri Olsa wrote:
> On Mon, Jul 21, 2014 at 07:11:51PM +0200, Sebastian Andrzej Siewior w=
rote:
>
> heya,
> I've  got following build error:
>=20
>   CC       util/data-bt.o
> util/data-bt.c: In function =E2=80=98add_event_tracepoint_value=E2=80=
=99:
> util/data-bt.c:293:3: error: implicit declaration of function =E2=80=98=
bt_ctf_event_class_get_field_by_name=E2=80=99 [-Werror=3Dimplicit-funct=
ion-declaration]
>    type =3D bt_ctf_event_class_get_field_by_name(
>    ^
> util/data-bt.c:293:3: error: nested extern declaration of =E2=80=98bt=
_ctf_event_class_get_field_by_name=E2=80=99 [-Werror=3Dnested-externs]
> util/data-bt.c:293:8: error: assignment makes pointer from integer wi=
thout a cast [-Werror]
>    type =3D bt_ctf_event_class_get_field_by_name(
>         ^
> cc1: all warnings being treated as errors
> make[1]: *** [util/data-bt.o] Error 1
> make: *** [all] Error 2
>=20
>=20
> but I might be missing some of the babeltrace changes, my branch:
>   5805251d8079 Fix: mmap trace read the stream_id from the first pack=
et

Hmm. This function should be there as of commit 2f100782231 in the
master branch. However since my first post and now the babeltrace
source got moved around a little and as a result you have some more
header files.
The function in question is defined in "babeltrace/ctf-ir/event.h" and
included by "babeltrace/ctf-writer/event.h".

> feel free to use/change my commits as you wish ;-)

Thank you.

>=20
> I think the best would be to merge your changes with mine
> into some meaningful patchset, before it goes to review

Yeah. I merged some of the fixups back and for the data-bt.c changes,
dunno. Either all my changes as a single patch or merge it back into
yours as it doesn't make sense to post each incremental change.

> I'll check your changes
>=20
> thanks,
> jirka
>=20
Sebastian
