From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: large liblttng-ust startup overhead (ust_lock)
Date: Wed, 6 Sep 2017 19:57:11 +0000 (UTC)
Message-ID: <1506174693.4712.1504727831374.JavaMail.zimbra__19927.9387169101$1504727849$gmane$org@efficios.com>
References: <2117884.c1kuPXoiOA@milian-kdab2> <3731578.YsMjlWojEO@milian-kdab2>
 <709369421.3343.1504635118648.JavaMail.zimbra@efficios.com>
 <3211887.IErR8xQyUx@agathebauer>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_4710_1700636021.1504727831369"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3xnZ9W3x7SzCfx
 for <lttng-dev@lists.lttng.org>; Wed,  6 Sep 2017 19:57:02 +0000 (UTC)
In-Reply-To: <3211887.IErR8xQyUx@agathebauer>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

------=_Part_4710_1700636021.1504727831369
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Sep 6, 2017, at 3:35 AM, Milian Wolff milian.wolff@kdab.com wrote:

> On Dienstag, 5. September 2017 20:11:58 CEST Mathieu Desnoyers wrote:
>> ----- On Sep 5, 2017, at 11:08 AM, Milian Wolff milian.wolff@kdab.com wr=
ote:
>> > On Tuesday, September 5, 2017 4:51:42 PM CEST Mathieu Desnoyers wrote:
>> >> ----- On Sep 5, 2017, at 10:34 AM, Milian Wolff milian.wolff@kdab.com
> wrote:
>> >> > Hey all,
>> >> >=20
>> >> > I have noticed a very large overhead when linking against liblttng-=
ust:
>> >> >=20
>> >> > ~~~~~
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ cat lttng-test.c
>> >> > int main()
>> >> > {
>> >> >=20
>> >> >  return 0;
>> >> >=20
>> >> > }
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ gcc -O2 -g -ldl lttng-test.c
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ perf stat -r 5 ./a.out
>> >> >=20
>> >> > Performance counter stats for './a.out' (5 runs):
>> >> >          0.209587      task-clock (msec)         #    0.596 CPUs
>> >> >          utilized
>> >> >=20
>> >> > ( +-  8.76% )
>> >> >=20
>> >> >                 0      context-switches          #    0.000 K/sec
>> >> >                 0      cpu-migrations            #    0.000 K/sec
>> >> >               =20
>> >> >                49      page-faults               #    0.235 M/sec
>> >> >=20
>> >> > ( +-  1.19% )
>> >> >=20
>> >> >           706,854      cycles                    #    3.373 GHz
>> >> >=20
>> >> > ( +-  8.82% )
>> >> >=20
>> >> >           773,603      instructions              #    1.09  insn pe=
r
>> >> >           cycle
>> >> >=20
>> >> > ( +-  0.75% )
>> >> >=20
>> >> >           147,128      branches                  #  701.987 M/sec
>> >> >=20
>> >> > ( +-  0.70% )
>> >> >=20
>> >> >             4,096      branch-misses             #    2.78% of all
>> >> >             branches
>> >> >=20
>> >> > ( +-  5.27% )
>> >> >=20
>> >> >       0.000351422 seconds time elapsed
>> >> >=20
>> >> > ( +- 11.85% )
>> >> >=20
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ gcc -O2 -g -ldl -llttng-ust lttng-test.c
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ perf stat -r 5 ./a.out
>> >> >=20
>> >> > Performance counter stats for './a.out' (5 runs):
>> >> >          2.063040      task-clock (msec)         #    0.009 CPUs
>> >> >          utilized
>> >> >=20
>> >> > ( +-  1.37% )
>> >> >=20
>> >> >                44      context-switches          #    0.021 M/sec
>> >> >=20
>> >> > ( +-  1.95% )
>> >> >=20
>> >> >                 2      cpu-migrations            #    0.776 K/sec
>> >> >=20
>> >> > ( +- 25.00% )
>> >> >=20
>> >> >               209      page-faults               #    0.101 M/sec
>> >> >=20
>> >> > ( +-  0.34% )
>> >> >=20
>> >> >         7,053,686      cycles                    #    3.419 GHz
>> >> >=20
>> >> > ( +-  2.03% )
>> >> >=20
>> >> >         6,893,783      instructions              #    0.98  insn pe=
r
>> >> >         cycle
>> >> >=20
>> >> > ( +-  0.25% )
>> >> >=20
>> >> >         1,342,492      branches                  #  650.735 M/sec
>> >> >=20
>> >> > ( +-  0.20% )
>> >> >=20
>> >> >            29,390      branch-misses             #    2.19% of all
>> >> >            branches
>> >> >=20
>> >> > ( +-  0.61% )
>> >> >=20
>> >> >       0.225597302 seconds time elapsed
>> >> >=20
>> >> > ( +-  6.68% )
>> >> > ~~~~~
>> >> >=20
>> >> > This is without any LTTng session configured. If I enable LTTng ker=
nel
>> >> > and
>> >> > userspace events, this becomes even worse:
>> >> >=20
>> >> > ~~~~~
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ cat $(which run_lttng_trace.sh)
>> >> > #!/bin/sh
>> >> >=20
>> >> > if [ -z "$(pidof lttng-sessiond)" ]; then
>> >> >=20
>> >> >    sudo lttng-sessiond --daemonize
>> >> >=20
>> >> > fi
>> >> >=20
>> >> > sudo lttng create -o ~/lttng-traces/$(date -Iseconds)
>> >> > sudo lttng enable-channel kernel -k --subbuf-size 16M --num-subbuf =
8
>> >> > sudo lttng enable-event -c kernel -k -a
>> >> > sudo lttng enable-channel ust -u --subbuf-size 16M --num-subbuf 8
>> >> > sudo lttng enable-event -c ust -u lttng_ust_tracef:*
>> >> > sudo lttng start
>> >> > $@
>> >> > sudo lttng stop
>> >> >=20
>> >> > sudo chmod a+rx -R ~/lttng-traces
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ run_lttng_trace.sh perf stat -r 5 ./a.out
>> >> > Session auto-20170905-162818 created.
>> >> > Traces will be written in
>> >> > /home/milian/lttng-traces/2017-09-05T16:28:18+02:00 Kernel channel
>> >> > kernel
>> >> > enabled for session auto-20170905-162818
>> >> > All Kernel events are enabled in channel kernel
>> >> > UST channel ust enabled for session auto-20170905-162818
>> >> > UST event lttng_ust_tracef:* created in channel ust
>> >> > Tracing started for session auto-20170905-162818
>> >> >=20
>> >> > Performance counter stats for './a.out' (5 runs):
>> >> >          4.937820      task-clock (msec)         #    0.005 CPUs
>> >> >          utilized
>> >> >=20
>> >> > ( +-  1.28% )
>> >> >=20
>> >> >               117      context-switches          #    0.024 M/sec
>> >> >=20
>> >> > ( +-  0.70% )
>> >> >=20
>> >> >                 3      cpu-migrations            #    0.608 K/sec
>> >> >=20
>> >> > ( +- 23.57% )
>> >> >=20
>> >> >               245      page-faults               #    0.050 M/sec
>> >> >=20
>> >> > ( +-  0.20% )
>> >> >=20
>> >> >        16,541,355      cycles                    #    3.350 GHz
>> >> >=20
>> >> > ( +-  0.94% )
>> >> >=20
>> >> >        20,611,637      instructions              #    1.25  insn pe=
r
>> >> >        cycle
>> >> >=20
>> >> > ( +-  0.23% )
>> >> >=20
>> >> >         3,580,525      branches                  #  725.123 M/sec
>> >> >=20
>> >> > ( +-  0.19% )
>> >> >=20
>> >> >            52,093      branch-misses             #    1.45% of all
>> >> >            branches
>> >> >=20
>> >> > ( +-  1.73% )
>> >> >=20
>> >> >       0.965545882 seconds time elapsed
>> >> >=20
>> >> > ( +- 16.96% )
>> >> >=20
>> >> > Waiting for data availability...
>> >> > Tracing stopped for session auto-20170905-162818
>> >> > ~~~~~
>> >> >=20
>> >> > I see this ~1s delay during startup in nearly all test applications
>> >> > where
>> >> > I
>> >> > wanted to use lttng-ust. In tracecompass, and according to perf sle=
ep
>> >> > time
>> >> > profiling, this seems to be mostly due to extensive sleeping on mut=
ex
>> >> > locks
>> >> > (from ust_lock in liblttng-ust). With perf trace, I also see membar=
rier
>> >> > taking a lot of time:
>> >> >=20
>> >> > ~~~~~
>> >> > # without a running lttng session:
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ perf trace --duration 1 ./a.out
>> >> >=20
>> >> >     6.492 (52.468 ms): a.out/23672 recvmsg(fd: 3<socket:[1178439]>,
> msg:
>> >> > 0x7fbe2fbb1070                  ) =3D 1
>> >> >=20
>> >> >     5.077 (54.271 ms): a.out/23671 futex(uaddr: 0x7fbe30d508a0, op:
>> >> > WAIT_BITSET|PRIV|CLKRT, utime: 0x7ffc474ff5a0, val3: 4294967295) =
=3D 0
>> >> >=20
>> >> >    59.598 (79.379 ms): a.out/23671 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   138.984 (39.945 ms): a.out/23671 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >    59.621 (119.324 ms): a.out/23672 futex(uaddr: 0x7fbe303e54c0, op=
:
>> >> >    WAIT|
>> >> >=20
>> >> > PRIV, val: 2                    ) =3D 0
>> >> >=20
>> >> >   179.045 (79.918 ms): a.out/23671 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   258.971 (39.997 ms): a.out/23671 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   299.052 (79.883 ms): a.out/23671 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   378.942 (59.988 ms): a.out/23671 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   439.022 (69.908 ms): a.out/23671 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   508.937 (80.027 ms): a.out/23671 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> > # with a running lttng session:
>> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
>> >> > =E2=94=94$ run_lttng_trace.sh perf trace --duration 1 ./a.out
>> >> >=20
>> >> >     6.666 (392.496 ms): a.out-ust/23790 recvmsg(fd:
>> >> >     3<socket:[1185362]>,
>> >=20
>> > msg:
>> >> > 0x7fcd81d8a0b0                  ) =3D 612
>> >> >=20
>> >> >   400.238 (68.452 ms): a.out-ust/23790 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   468.698 (39.983 ms): a.out-ust/23790 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   510.567 (98.113 ms): a.out-ust/23790 recvmsg(fd: 3<socket:[118536=
2]>,
>> >=20
>> > msg:
>> >> > 0x7fcd81d8a070                  ) =3D 1
>> >> >=20
>> >> >     6.467 (603.500 ms): a.out/23789 futex(uaddr: 0x7fcd82f298a0, op=
:
>> >> > WAIT_BITSET|PRIV|CLKRT, utime: 0x7fff4df6c970, val3: 4294967295) =
=3D 0
>> >> >=20
>> >> >   610.020 ( 6.307 ms): a.out/23789 futex(uaddr: 0x7fcd82f29960, op:
>> >> >   WAIT|
>> >> >=20
>> >> > PRIV, val: 2                    ) =3D 0
>> >> >=20
>> >> >   616.446 (62.265 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   678.721 (59.916 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   616.332 (122.335 ms): a.out-ust/23790 futex(uaddr: 0x7fcd82f29960=
,
> op:
>> >> > WAIT|PRIV, val: 2                    ) =3D 0
>> >> >=20
>> >> >   738.976 (49.658 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   788.642 (49.987 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   739.014 (99.644 ms): a.out-ust/23790 futex(uaddr: 0x7fcd825be4c0,=
 op:
>> >> >   WAIT|
>> >> >=20
>> >> > PRIV, val: 2                    ) =3D 0
>> >> >=20
>> >> >   838.651 (49.977 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   888.636 (69.983 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >   838.662 (119.978 ms): a.out-ust/23790 futex(uaddr: 0x7fcd825be4c0=
,
> op:
>> >> > WAIT|PRIV, val: 2                    ) =3D 0
>> >> >=20
>> >> >   958.739 (59.873 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >  1018.621 (80.058 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >  1098.782 (49.844 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >  1148.634 (59.998 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >  1208.731 (69.940 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >  1278.680 (79.947 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >  1358.727 (39.881 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >  1398.616 (39.980 ms): a.out/23789 membarrier(cmd: 1
>> >> >=20
>> >> > ) =3D 0
>> >> >=20
>> >> >     6.640 (1432.157 ms): a.out-ust/23791 futex(uaddr: 0x7fcd82f9000=
0
>> >> >=20
>> >> > ) =3D -1 (null) INTERNAL ERROR: strerror_r(512, 0x7ffdbc5467a0, 128=
)=3D22
>> >> > ~~~~~
>> >> >=20
>> >> > This makes lttng-ust pretty much unusable for any short-lived
>> >> > application.
>> >> > Is this a known limitation?
>> >>=20
>> >> This kind of delay is not completely unexpected, but a bit higher tha=
n I
>> >> would expect. I'm interested in figuring out if most of this delay
>> >> happens
>> >> to be caused by sys_membarrier, either directly, or indirectly (throu=
gh a
>> >> lock).
>> >=20
>> > See my other email which adds some harder numbers from a perf sleep
>> > record.
>> >=20
>> >> > I'm using lttng-ust on Arch from the AUR packages, i.e. LTTng 2.9.4=
.
>> >> > I've
>> >> > seen this problem also on Ubuntu 17.04 though I didn't do any of th=
e
>> >> > above measurements there. So far, I suspected the ust statedump to =
take
>> >> > too much time, but I disabled that one for the measurements above.
>> >> >=20
>> >> > Any help would be appreciated
>> >>=20
>> >> Can you reproduce with a Linux kernel that has CONFIG_MEMBARRIER=3Dn =
and
>> >> share the performance results ?
>> >=20
>> > I'd have to recompile the kernel, which is something I don't like to d=
o.
>> > Why is this required, or put differently - why would the kernel option
>> > influence the userspace LTTng library?
>>=20
>> liburcu 0.9.x and 0.10.x (a dependency of lttng-ust) uses the membarrier
>> system call to speed up tracing, at the expense of slower execution of
>> tracing state update.
>>=20
>> I'm currently proposing a new sys_membarrier command for PRIVATE_EXPEDIT=
ED
>> (single-process) use cases which should execute much faster than the
>> non-expedited SHARED command currently implemented.
>>=20
>> liburcu 0.9 and 0.10 detects that this system call is available, and use=
s
>> it when it can.
>=20
> May I ask whether you have such a configuration available? The test case =
I
> have submitted should be easy to reproduce for everyone. Compiling my own
> kernel version takes a huge amount of time which I'm quite frankly not wi=
lling
> to invest at this point.

We have reproduced the situation, and it's pointing towards our use of the
sys_membarrier system call. We'll try narrowing it down between its use by
lttng-ust (liburcu-bp.so) or by lttng-sessiond (liburcu.so).

You can try to patch liburcu so it won't try using sys_membarrier at all
(see attached patch)

>=20
> I simply wonder whether anyone else is actually using lttng-ust, or if th=
ey
> are, whether they are only doing that for long-lived applications where t=
his
> overhead is not noticeable?

It appears that this application startup slowdown mainly appears with
LTTng linked against liburcu 0.9 and 0.10 running with rather recent kernel=
s.
This would explain why you are the first one to report this across our user
base.

Thanks,

Mathieu


>=20
> Thanks
>=20
> --
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

------=_Part_4710_1700636021.1504727831369
Content-Type: text/x-patch; name=liburcu-no-sys-mb.patch
Content-Disposition: attachment; filename=liburcu-no-sys-mb.patch
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NyYy91cmN1LWJwLmMgYi9zcmMvdXJjdS1icC5jCmluZGV4IGMwZmFjODMu
LjJkOGJjY2EgMTAwNjQ0Ci0tLSBhL3NyYy91cmN1LWJwLmMKKysrIGIvc3JjL3VyY3UtYnAuYwpA
QCAtOTUsNyArOTUsNyBAQCBzdGF0aWMKIGludCByY3VfYnBfcmVmY291bnQ7CiAKIC8qIElmIHRo
ZSBoZWFkZXJzIGRvIG5vdCBzdXBwb3J0IG1lbWJhcnJpZXIgc3lzdGVtIGNhbGwsIGZhbGwgYmFj
ayBzbXBfbWIuICovCi0jaWZkZWYgX19OUl9tZW1iYXJyaWVyCisjaWYgMCAvL2RlZiBfX05SX21l
bWJhcnJpZXIKICMgZGVmaW5lIG1lbWJhcnJpZXIoLi4uKQkJc3lzY2FsbChfX05SX21lbWJhcnJp
ZXIsIF9fVkFfQVJHU19fKQogI2Vsc2UKICMgZGVmaW5lIG1lbWJhcnJpZXIoLi4uKQkJLUVOT1NZ
UwpkaWZmIC0tZ2l0IGEvc3JjL3VyY3UuYyBiL3NyYy91cmN1LmMKaW5kZXggYTgxYjEyOS4uMWFh
ZmJjMCAxMDA2NDQKLS0tIGEvc3JjL3VyY3UuYworKysgYi9zcmMvdXJjdS5jCkBAIC02NCw3ICs2
NCw3IEBACiAjZGVmaW5lIFJDVV9RU19BQ1RJVkVfQVRURU1QVFMgMTAwCiAKIC8qIElmIHRoZSBo
ZWFkZXJzIGRvIG5vdCBzdXBwb3J0IG1lbWJhcnJpZXIgc3lzdGVtIGNhbGwsIGZhbGwgYmFjayBv
biBSQ1VfTUIgKi8KLSNpZmRlZiBfX05SX21lbWJhcnJpZXIKKyNpZiAwIC8vZGVmIF9fTlJfbWVt
YmFycmllcgogIyBkZWZpbmUgbWVtYmFycmllciguLi4pCQlzeXNjYWxsKF9fTlJfbWVtYmFycmll
ciwgX19WQV9BUkdTX18pCiAjZWxzZQogIyBkZWZpbmUgbWVtYmFycmllciguLi4pCQktRU5PU1lT
Cg==
------=_Part_4710_1700636021.1504727831369
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

------=_Part_4710_1700636021.1504727831369--
