From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC] perf to ctf converter
Date: Tue, 22 Jul 2014 15:31:28 +0200
Message-ID: <53CE67B0.7020406@linutronix.de>
References: <20140603163640.GA16279@linutronix.de> <20140714141533.GD17761@krava.redhat.com> <20140721171151.GA12969@linutronix.de> <20140721183530.GA28673@krava.redhat.com> <53CE0B89.7030400@linutronix.de> <20140722112535.GA29750@krava.redhat.com> <53CE4BAF.2010906@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53CE4BAF.2010906@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, namhyung.kim@lge.com, tzanussi@gmail.com
List-Id: lttng-dev@lists.lttng.org

On 07/22/2014 01:31 PM, Sebastian Andrzej Siewior wrote:
>> [jolsa@krava perf]$ LD_LIBRARY_PATH=3D/opt/libbabeltrace/lib /opt/li=
bbabeltrace/bin/babeltrace ./ctf-data/
>>
>> [04:41:11.445378840] (+?.?????????) sched:sched_switch: { }, { pid =3D=
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
>> [04:41:11.445390175] (+0.000011335) sched:sched_switch: { }, { pid =3D=
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
>>
>> ...
>>
>> looks like we need some better string arg handling,
>> but we'll get there soon or later
>=20
> I'm looking at how python gets it nicer=E2=80=A6

Okay, fixed. The problem was that a string has the STRING and the
ARRAY bit set. So I used the length of the array and made an array of
strings. Not really what was expected :) I removed this nonsense. Now I
get:

[06:37:09.867844231] (+0.000005597) sched:sched_switch: { cpu_id =3D 0 =
},
{ common_pid =3D 14068, common_tid =3D 14068, common_comm =3D "ls", pre=
v_comm
=3D "ls", prev_pid =3D 14068, prev_prio =3D 120, prev_state =3D 2, next=
_comm =3D
"swapper/5", next_pid =3D 0, next_prio =3D 120 }

So the strings look good now. I also renamed "pid" to "common_pid" beca=
use

[06:37:09.885385418] (+0.017541187) sched:sched_wakeup: { cpu_id =3D 0 =
},
{ common_pid =3D 179, common_tid =3D 179, common_comm =3D ":179", comm =
=3D "ls",
pid =3D 14068, prio =3D 120, success =3D 1, target_cpu =3D 5 }

that thing brings its own pid & comm.

And while looking at the data types and dropped that & LONG since it is
not set for 64bit data types as I assumed. I do now consider ->size and
the result is

[06:37:09.867838634] (+0.000253941) sched:sched_stat_runtime: { cpu_id =
=3D
0 }, { common_pid =3D 14068, common_tid =3D 14068, common_comm =3D "ls"=
, comm
=3D "ls", pid =3D 14068, runtime =3D 2020750, vruntime =3D 76395575003 =
}

that means vruntime is 64bit as it should and decimal might be nice.
\o/

Sebastian
