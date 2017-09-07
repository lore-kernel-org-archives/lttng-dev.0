From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: large liblttng-ust startup overhead (ust_lock)
Date: Thu, 07 Sep 2017 09:50:12 +0200
Message-ID: <2249054.rOntnxvaLr__16742.7413900898$1504770662$gmane$org@milian-kdab2>
References: <2117884.c1kuPXoiOA@milian-kdab2> <3211887.IErR8xQyUx@agathebauer>
 <1506174693.4712.1504727831374.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6735125071035004926=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 3xnt0k2tQrzCVv
 for <lttng-dev@lists.lttng.org>; Thu,  7 Sep 2017 07:50:29 +0000 (UTC)
In-Reply-To: <1506174693.4712.1504727831374.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6735125071035004926==
Content-Type: multipart/signed; boundary="nextPart3032029.J450EsyL5D"; micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart3032029.J450EsyL5D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, September 6, 2017 9:57:11 PM CEST Mathieu Desnoyers wrote:
> ----- On Sep 6, 2017, at 3:35 AM, Milian Wolff milian.wolff@kdab.com wrot=
e:
> > On Dienstag, 5. September 2017 20:11:58 CEST Mathieu Desnoyers wrote:
> >> ----- On Sep 5, 2017, at 11:08 AM, Milian Wolff milian.wolff@kdab.com=
=20
wrote:
> >> > On Tuesday, September 5, 2017 4:51:42 PM CEST Mathieu Desnoyers wrot=
e:
> >> >> ----- On Sep 5, 2017, at 10:34 AM, Milian Wolff milian.wolff@kdab.c=
om
> >=20
> > wrote:
> >> >> > Hey all,
> >> >> >=20
> >> >> > I have noticed a very large overhead when linking against
> >> >> > liblttng-ust:
> >> >> >=20
> >> >> > ~~~~~
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ cat lttng-test.c
> >> >> > int main()
> >> >> > {
> >> >> >=20
> >> >> >  return 0;
> >> >> >=20
> >> >> > }
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ gcc -O2 -g -ldl lttng-test.c
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ perf stat -r 5 ./a.out
> >> >> >=20
> >> >> > Performance counter stats for './a.out' (5 runs):
> >> >> >          0.209587      task-clock (msec)         #    0.596 CPUs
> >> >> >          utilized
> >> >> >=20
> >> >> > ( +-  8.76% )
> >> >> >=20
> >> >> >                 0      context-switches          #    0.000 K/sec
> >> >> >                 0      cpu-migrations            #    0.000 K/sec
> >> >> >               =20
> >> >> >                49      page-faults               #    0.235 M/sec
> >> >> >=20
> >> >> > ( +-  1.19% )
> >> >> >=20
> >> >> >           706,854      cycles                    #    3.373 GHz
> >> >> >=20
> >> >> > ( +-  8.82% )
> >> >> >=20
> >> >> >           773,603      instructions              #    1.09  insn =
per
> >> >> >           cycle
> >> >> >=20
> >> >> > ( +-  0.75% )
> >> >> >=20
> >> >> >           147,128      branches                  #  701.987 M/sec
> >> >> >=20
> >> >> > ( +-  0.70% )
> >> >> >=20
> >> >> >             4,096      branch-misses             #    2.78% of all
> >> >> >             branches
> >> >> >=20
> >> >> > ( +-  5.27% )
> >> >> >=20
> >> >> >       0.000351422 seconds time elapsed
> >> >> >=20
> >> >> > ( +- 11.85% )
> >> >> >=20
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ gcc -O2 -g -ldl -llttng-ust lttng-test.c
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ perf stat -r 5 ./a.out
> >> >> >=20
> >> >> > Performance counter stats for './a.out' (5 runs):
> >> >> >          2.063040      task-clock (msec)         #    0.009 CPUs
> >> >> >          utilized
> >> >> >=20
> >> >> > ( +-  1.37% )
> >> >> >=20
> >> >> >                44      context-switches          #    0.021 M/sec
> >> >> >=20
> >> >> > ( +-  1.95% )
> >> >> >=20
> >> >> >                 2      cpu-migrations            #    0.776 K/sec
> >> >> >=20
> >> >> > ( +- 25.00% )
> >> >> >=20
> >> >> >               209      page-faults               #    0.101 M/sec
> >> >> >=20
> >> >> > ( +-  0.34% )
> >> >> >=20
> >> >> >         7,053,686      cycles                    #    3.419 GHz
> >> >> >=20
> >> >> > ( +-  2.03% )
> >> >> >=20
> >> >> >         6,893,783      instructions              #    0.98  insn =
per
> >> >> >         cycle
> >> >> >=20
> >> >> > ( +-  0.25% )
> >> >> >=20
> >> >> >         1,342,492      branches                  #  650.735 M/sec
> >> >> >=20
> >> >> > ( +-  0.20% )
> >> >> >=20
> >> >> >            29,390      branch-misses             #    2.19% of all
> >> >> >            branches
> >> >> >=20
> >> >> > ( +-  0.61% )
> >> >> >=20
> >> >> >       0.225597302 seconds time elapsed
> >> >> >=20
> >> >> > ( +-  6.68% )
> >> >> > ~~~~~
> >> >> >=20
> >> >> > This is without any LTTng session configured. If I enable LTTng
> >> >> > kernel
> >> >> > and
> >> >> > userspace events, this becomes even worse:
> >> >> >=20
> >> >> > ~~~~~
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ cat $(which run_lttng_trace.sh)
> >> >> > #!/bin/sh
> >> >> >=20
> >> >> > if [ -z "$(pidof lttng-sessiond)" ]; then
> >> >> >=20
> >> >> >    sudo lttng-sessiond --daemonize
> >> >> >=20
> >> >> > fi
> >> >> >=20
> >> >> > sudo lttng create -o ~/lttng-traces/$(date -Iseconds)
> >> >> > sudo lttng enable-channel kernel -k --subbuf-size 16M --num-subbu=
f 8
> >> >> > sudo lttng enable-event -c kernel -k -a
> >> >> > sudo lttng enable-channel ust -u --subbuf-size 16M --num-subbuf 8
> >> >> > sudo lttng enable-event -c ust -u lttng_ust_tracef:*
> >> >> > sudo lttng start
> >> >> > $@
> >> >> > sudo lttng stop
> >> >> >=20
> >> >> > sudo chmod a+rx -R ~/lttng-traces
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ run_lttng_trace.sh perf stat -r 5 ./a.out
> >> >> > Session auto-20170905-162818 created.
> >> >> > Traces will be written in
> >> >> > /home/milian/lttng-traces/2017-09-05T16:28:18+02:00 Kernel channel
> >> >> > kernel
> >> >> > enabled for session auto-20170905-162818
> >> >> > All Kernel events are enabled in channel kernel
> >> >> > UST channel ust enabled for session auto-20170905-162818
> >> >> > UST event lttng_ust_tracef:* created in channel ust
> >> >> > Tracing started for session auto-20170905-162818
> >> >> >=20
> >> >> > Performance counter stats for './a.out' (5 runs):
> >> >> >          4.937820      task-clock (msec)         #    0.005 CPUs
> >> >> >          utilized
> >> >> >=20
> >> >> > ( +-  1.28% )
> >> >> >=20
> >> >> >               117      context-switches          #    0.024 M/sec
> >> >> >=20
> >> >> > ( +-  0.70% )
> >> >> >=20
> >> >> >                 3      cpu-migrations            #    0.608 K/sec
> >> >> >=20
> >> >> > ( +- 23.57% )
> >> >> >=20
> >> >> >               245      page-faults               #    0.050 M/sec
> >> >> >=20
> >> >> > ( +-  0.20% )
> >> >> >=20
> >> >> >        16,541,355      cycles                    #    3.350 GHz
> >> >> >=20
> >> >> > ( +-  0.94% )
> >> >> >=20
> >> >> >        20,611,637      instructions              #    1.25  insn =
per
> >> >> >        cycle
> >> >> >=20
> >> >> > ( +-  0.23% )
> >> >> >=20
> >> >> >         3,580,525      branches                  #  725.123 M/sec
> >> >> >=20
> >> >> > ( +-  0.19% )
> >> >> >=20
> >> >> >            52,093      branch-misses             #    1.45% of all
> >> >> >            branches
> >> >> >=20
> >> >> > ( +-  1.73% )
> >> >> >=20
> >> >> >       0.965545882 seconds time elapsed
> >> >> >=20
> >> >> > ( +- 16.96% )
> >> >> >=20
> >> >> > Waiting for data availability...
> >> >> > Tracing stopped for session auto-20170905-162818
> >> >> > ~~~~~
> >> >> >=20
> >> >> > I see this ~1s delay during startup in nearly all test applicatio=
ns
> >> >> > where
> >> >> > I
> >> >> > wanted to use lttng-ust. In tracecompass, and according to perf
> >> >> > sleep
> >> >> > time
> >> >> > profiling, this seems to be mostly due to extensive sleeping on
> >> >> > mutex
> >> >> > locks
> >> >> > (from ust_lock in liblttng-ust). With perf trace, I also see
> >> >> > membarrier
> >> >> > taking a lot of time:
> >> >> >=20
> >> >> > ~~~~~
> >> >> > # without a running lttng session:
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ perf trace --duration 1 ./a.out
> >> >> >=20
> >> >> >     6.492 (52.468 ms): a.out/23672 recvmsg(fd: 3<socket:[1178439]=
>,
> >=20
> > msg:
> >> >> > 0x7fbe2fbb1070                  ) =3D 1
> >> >> >=20
> >> >> >     5.077 (54.271 ms): a.out/23671 futex(uaddr: 0x7fbe30d508a0, o=
p:
> >> >> > WAIT_BITSET|PRIV|CLKRT, utime: 0x7ffc474ff5a0, val3: 4294967295) =
=3D 0
> >> >> >=20
> >> >> >    59.598 (79.379 ms): a.out/23671 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   138.984 (39.945 ms): a.out/23671 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >    59.621 (119.324 ms): a.out/23672 futex(uaddr: 0x7fbe303e54c0, =
op:
> >> >> >    WAIT|
> >> >> >=20
> >> >> > PRIV, val: 2                    ) =3D 0
> >> >> >=20
> >> >> >   179.045 (79.918 ms): a.out/23671 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   258.971 (39.997 ms): a.out/23671 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   299.052 (79.883 ms): a.out/23671 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   378.942 (59.988 ms): a.out/23671 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   439.022 (69.908 ms): a.out/23671 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   508.937 (80.027 ms): a.out/23671 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> > # with a running lttng session:
> >> >> > =E2=94=8Cmilian@milian-kdab2:/tmp
> >> >> > =E2=94=94$ run_lttng_trace.sh perf trace --duration 1 ./a.out
> >> >> >=20
> >> >> >     6.666 (392.496 ms): a.out-ust/23790 recvmsg(fd:
> >> >> >     3<socket:[1185362]>,
> >> >=20
> >> > msg:
> >> >> > 0x7fcd81d8a0b0                  ) =3D 612
> >> >> >=20
> >> >> >   400.238 (68.452 ms): a.out-ust/23790 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   468.698 (39.983 ms): a.out-ust/23790 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   510.567 (98.113 ms): a.out-ust/23790 recvmsg(fd:
> >> >> >   3<socket:[1185362]>,
> >> >=20
> >> > msg:
> >> >> > 0x7fcd81d8a070                  ) =3D 1
> >> >> >=20
> >> >> >     6.467 (603.500 ms): a.out/23789 futex(uaddr: 0x7fcd82f298a0, =
op:
> >> >> > WAIT_BITSET|PRIV|CLKRT, utime: 0x7fff4df6c970, val3: 4294967295) =
=3D 0
> >> >> >=20
> >> >> >   610.020 ( 6.307 ms): a.out/23789 futex(uaddr: 0x7fcd82f29960, o=
p:
> >> >> >   WAIT|
> >> >> >=20
> >> >> > PRIV, val: 2                    ) =3D 0
> >> >> >=20
> >> >> >   616.446 (62.265 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   678.721 (59.916 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   616.332 (122.335 ms): a.out-ust/23790 futex(uaddr: 0x7fcd82f299=
60,
> >=20
> > op:
> >> >> > WAIT|PRIV, val: 2                    ) =3D 0
> >> >> >=20
> >> >> >   738.976 (49.658 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   788.642 (49.987 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   739.014 (99.644 ms): a.out-ust/23790 futex(uaddr: 0x7fcd825be4c=
0,
> >> >> >   op:
> >> >> >   WAIT|
> >> >> >=20
> >> >> > PRIV, val: 2                    ) =3D 0
> >> >> >=20
> >> >> >   838.651 (49.977 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   888.636 (69.983 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >   838.662 (119.978 ms): a.out-ust/23790 futex(uaddr: 0x7fcd825be4=
c0,
> >=20
> > op:
> >> >> > WAIT|PRIV, val: 2                    ) =3D 0
> >> >> >=20
> >> >> >   958.739 (59.873 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >  1018.621 (80.058 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >  1098.782 (49.844 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >  1148.634 (59.998 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >  1208.731 (69.940 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >  1278.680 (79.947 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >  1358.727 (39.881 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >  1398.616 (39.980 ms): a.out/23789 membarrier(cmd: 1
> >> >> >=20
> >> >> > ) =3D 0
> >> >> >=20
> >> >> >     6.640 (1432.157 ms): a.out-ust/23791 futex(uaddr: 0x7fcd82f90=
000
> >> >> >=20
> >> >> > ) =3D -1 (null) INTERNAL ERROR: strerror_r(512, 0x7ffdbc5467a0,
> >> >> > 128)=3D22
> >> >> > ~~~~~
> >> >> >=20
> >> >> > This makes lttng-ust pretty much unusable for any short-lived
> >> >> > application.
> >> >> > Is this a known limitation?
> >> >>=20
> >> >> This kind of delay is not completely unexpected, but a bit higher t=
han
> >> >> I
> >> >> would expect. I'm interested in figuring out if most of this delay
> >> >> happens
> >> >> to be caused by sys_membarrier, either directly, or indirectly
> >> >> (through a
> >> >> lock).
> >> >=20
> >> > See my other email which adds some harder numbers from a perf sleep
> >> > record.
> >> >=20
> >> >> > I'm using lttng-ust on Arch from the AUR packages, i.e. LTTng 2.9=
=2E4.
> >> >> > I've
> >> >> > seen this problem also on Ubuntu 17.04 though I didn't do any of =
the
> >> >> > above measurements there. So far, I suspected the ust statedump to
> >> >> > take
> >> >> > too much time, but I disabled that one for the measurements above.
> >> >> >=20
> >> >> > Any help would be appreciated
> >> >>=20
> >> >> Can you reproduce with a Linux kernel that has CONFIG_MEMBARRIER=3D=
n and
> >> >> share the performance results ?
> >> >=20
> >> > I'd have to recompile the kernel, which is something I don't like to
> >> > do.
> >> > Why is this required, or put differently - why would the kernel opti=
on
> >> > influence the userspace LTTng library?
> >>=20
> >> liburcu 0.9.x and 0.10.x (a dependency of lttng-ust) uses the membarri=
er
> >> system call to speed up tracing, at the expense of slower execution of
> >> tracing state update.
> >>=20
> >> I'm currently proposing a new sys_membarrier command for
> >> PRIVATE_EXPEDITED
> >> (single-process) use cases which should execute much faster than the
> >> non-expedited SHARED command currently implemented.
> >>=20
> >> liburcu 0.9 and 0.10 detects that this system call is available, and u=
ses
> >> it when it can.
> >=20
> > May I ask whether you have such a configuration available? The test cas=
e I
> > have submitted should be easy to reproduce for everyone. Compiling my o=
wn
> > kernel version takes a huge amount of time which I'm quite frankly not
> > willing to invest at this point.
>=20
> We have reproduced the situation, and it's pointing towards our use of the
> sys_membarrier system call. We'll try narrowing it down between its use by
> lttng-ust (liburcu-bp.so) or by lttng-sessiond (liburcu.so).
>=20
> You can try to patch liburcu so it won't try using sys_membarrier at all
> (see attached patch)

It does improve the situation tremendously. I just compiled v0.10.0-6-g6447=
802=20
with and without the patch to record the numbers below. Note that apparentl=
y=20
your latest patch [1] in git master alone is not enough to fix the performa=
nce=20
bug, I do need to apply the patch you send by mail, too.

[1]: https://github.com/urcu/userspace-rcu/commit/
64478021edcf7a5ac3bca3fa9e8b8108d2fbb9b6

But once I also apply the patch you send by mail, things start to fly. In t=
he=20
below, "before" means running against userspace-rcu v0.10.0-6-g6447802,=20
"after" means running against the same version with your emailed patch appl=
ied=20
on top.

Measurement without an active LTTng session:

~~~~~
# before:
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ perf stat -r 5 ./a.out

 Performance counter stats for './a.out' (5 runs):

          3.973288      task-clock (msec)         #    0.005 CPUs utilized =
          =20
( +-  0.39% )
               153      context-switches          #    0.039 M/sec         =
          =20
( +-  1.43% )
                 2      cpu-migrations            #    0.554 K/sec         =
          =20
( +- 26.50% )
               315      page-faults               #    0.079 M/sec         =
          =20
( +-  0.21% )
        13,257,360      cycles                    #    3.337 GHz           =
          =20
( +-  0.34% )
        14,906,461      instructions              #    1.12  insn per cycle=
          =20
( +-  0.11% )
         2,910,368      branches                  #  732.483 M/sec         =
          =20
( +-  0.10% )
            42,766      branch-misses             #    1.47% of all branche=
s         =20
( +-  0.89% )

       0.851654352 seconds time elapsed                                    =
     =20
( +-  4.33% )

# after:
=E2=94=8Cmilian@milian-kdab2:/tmp
=E2=94=94$ perf stat -r 5 ./a.out

 Performance counter stats for './a.out' (5 runs):

          3.608242      task-clock (msec)         #    0.056 CPUs utilized =
          =20
( +-  1.84% )
               138      context-switches          #    0.038 M/sec         =
          =20
( +-  2.70% )
                 1      cpu-migrations            #    0.277 K/sec         =
        =20
               313      page-faults               #    0.087 M/sec         =
          =20
( +-  0.27% )
        12,022,499      cycles                    #    3.332 GHz           =
          =20
( +-  1.73% )
        14,861,318      instructions              #    1.24  insn per cycle=
          =20
( +-  0.32% )
         2,902,920      branches                  #  804.525 M/sec         =
          =20
( +-  0.32% )
            38,264      branch-misses             #    1.32% of all branche=
s         =20
( +-  0.78% )

       0.063929538 seconds time elapsed                                    =
     =20
( +- 10.93% )
~~~~~

With an active LTTng session:

~~~~~
# before:
 Performance counter stats for './a.out' (5 runs):

          9.152925      task-clock (msec)         #    0.005 CPUs utilized =
          =20
( +-  1.13% )
               216      context-switches          #    0.024 M/sec         =
          =20
( +-  2.83% )
                 4      cpu-migrations            #    0.459 K/sec         =
          =20
( +- 11.66% )
               370      page-faults               #    0.040 M/sec         =
          =20
( +-  0.20% )
        31,311,283      cycles                    #    3.421 GHz           =
          =20
( +-  0.69% )
        40,509,922      instructions              #    1.29  insn per cycle=
          =20
( +-  0.40% )
         7,192,651      branches                  #  785.831 M/sec         =
          =20
( +-  0.33% )
            90,264      branch-misses             #    1.25% of all branche=
s         =20
( +-  1.46% )

       1.839545247 seconds time elapsed                                    =
     =20
( +-  6.95% )

# after:
 Performance counter stats for './a.out' (5 runs):

          7.052094      task-clock (msec)         #    0.026 CPUs utilized =
          =20
( +-  1.45% )
               190      context-switches          #    0.027 M/sec         =
          =20
( +-  4.88% )
                 1      cpu-migrations            #    0.142 K/sec         =
          =20
( +- 44.72% )
               335      page-faults               #    0.048 M/sec         =
          =20
( +-  0.37% )
        24,105,408      cycles                    #    3.418 GHz           =
          =20
( +-  1.39% )
        35,100,950      instructions              #    1.46  insn per cycle=
          =20
( +-  0.17% )
         6,197,972      branches                  #  878.884 M/sec         =
          =20
( +-  0.15% )
            56,045      branch-misses             #    0.90% of all branche=
s         =20
( +-  1.41% )

       0.272121270 seconds time elapsed                                    =
     =20
( +- 52.41% )
~~~~~

> > I simply wonder whether anyone else is actually using lttng-ust, or if
> > they
> > are, whether they are only doing that for long-lived applications where
> > this overhead is not noticeable?
>=20
> It appears that this application startup slowdown mainly appears with
> LTTng linked against liburcu 0.9 and 0.10 running with rather recent
> kernels. This would explain why you are the first one to report this acro=
ss
> our user base.

Thank you, that explains it.

=2D-=20
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart3032029.J450EsyL5D
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDEIw
ggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra0D00SOTq9bus3/mx
gUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT
/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTqRvaq8aWccm+KOMjTcE6s2mj6
RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmOupyTf1Qib+cpukNJnQmwygjD
8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATwwggE4MB8GA1UdIwQYMBaAFLuv
fgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8B
Af8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUw
QzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1
dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Au
Y29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkI
BtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/
AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZ
lPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNq
bzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzOb
XYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5I
SYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmU
dp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3CVJqb1XWeKIJ8
4F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR
1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBlQwggU8oAMCAQICEAf6KCF9+1doL2oE
OTPysLwwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0w
OwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMB4XDTE3MDUyMzAwMDAwMFoXDTIwMDUyMjIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0G
A1UEERMGNjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNV
BAkTD05vcnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRh
bGVucyBEYXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNV
BAsMOklzc3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1h
bmFnZXIxHzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBX
b2xmZjEkMCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxrzfNBVvRbiAknuTBXuQnNm9sLIFLo0vbPB6kswk78A3tA++Zn5c
lQUHhGlQq1cdYxagnUpqwvG3Sod15mPSOLkAPf/mabLN7p+lFbRaUP+97ZkTZtvb4BCC3osIEFI4
G393OSFWqc2qmIPE/SwSASbAA20Fcaa2M6P1lhOk/ttUh2jIurTPF0wUycIA7lBddrOgaOA8e2m6
iLTNHtlrfRbBaUX91D5ebY+UWmIjXSQ9+CtutMzBkwnF0rZKririvOkklg9VzEGNQVHrQfDF2s/U
pOtmtuVSwElauGT/KALyCFuIrYC1pmaKH8S1xODJqiRaf6jH8E+KQzKjyM/ErwIDAQABo4IB1TCC
AdEwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFN+m99RtIuA1bSdw
6b1brOX7X3AJMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29s
ZmZAa2RhYi5jb20wDQYJKoZIhvcNAQELBQADggEBABf47LSJADqH+ow9INv3QM1NC/qq2bjxGvsZ
68iD11VEUAFlsYfsVTgQqUirwPVTYenXtwVBELHZyywsui1JxL7HKQetLQegDDP/RyfjReVaWxhy
3OpuItsgLVbru9QVgPifnoBFPtfZcwjeJDmeSbLT8oj4Rd0KYBOIve7WKvsfNPsNwfbLwY2zILkE
LjxZcVi2AwZHDyab+dzL/3YcLuJj1lSawBGn7ilpcdZydlv4aye51pD/MemLIYLcylt+ImrmjnTV
y+QlAHRF3s5FE8yAr+W1MBD/1bKZCSgFt8VQoAlz3hiQh8QqZp4Zl8WuVL4+mP/mT6VDEWgq/0Bo
cukxggJuMIICagIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EAf6KCF9+1doL2oEOTPysLwwDQYJYIZIAWUDBAIBBQCggZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwOTA3MDc1MDEyWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgDp48RSsN45d1G62FBbWg8BUML7lP
cfA+5Y1ouKtw8nAwDQYJKoZIhvcNAQEBBQAEggEAp08tzQmDY67nkw6gCkUELUv3XZE0XWMOsXoU
WxVhE1NCk3cmb1qJL3c50BibeqYxyn4m7IvxcKZ/DH5GxyoPofChs42ZYeJiaAK6CDAxR1KfyN3U
NMYkqQihbLvv9+RsHqXI3TLfyJz8FgCEf+2eLDyOKNe6trHJSvjYem+ebhHyuUT3cv3j8E6ybjd/
8dbJsCfja1JzYNyjzkhspoSnpvl0zIcS3d5PalQ2zTdCJWmZTQx+h7brNVUkGwtgA1M93KY4rco/
dkTfTbtA0nVSg/ak6czHrKaAc0OQI2jRHRwdHdZOf3ocPb5dPx+YFl2WNk1Nf1IUrZaZZazxw0wh
pwAAAAAAAA==


--nextPart3032029.J450EsyL5D--




--===============6735125071035004926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6735125071035004926==--
