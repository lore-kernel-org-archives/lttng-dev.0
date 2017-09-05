From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: large liblttng-ust startup overhead (ust_lock)
Date: Tue, 05 Sep 2017 17:10:41 +0200
Message-ID: <5963588.vVBsjV779J__4330.98747530511$1504624320$gmane$org@milian-kdab2>
References: <2117884.c1kuPXoiOA@milian-kdab2> <5409371.Vv1znlTa4X@milian-kdab2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1719252573500168083=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
 by lists.lttng.org (Postfix) with ESMTPS id 3xmqsc2pLczCT2
 for <lttng-dev@lists.lttng.org>; Tue,  5 Sep 2017 15:10:43 +0000 (UTC)
In-Reply-To: <5409371.Vv1znlTa4X@milian-kdab2>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1719252573500168083==
Content-Type: multipart/signed; boundary="nextPart3031736.xiS8yMp5Lp"; micalg="sha256"; protocol="application/pkcs7-signature"

--nextPart3031736.xiS8yMp5Lp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, September 5, 2017 4:52:42 PM CEST Milian Wolff wrote:
> On Tuesday, September 5, 2017 4:34:54 PM CEST Milian Wolff wrote:
> > Hey all,
> >=20
> > I have noticed a very large overhead when linking against liblttng-ust:
> >=20
> > ~~~~~
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ cat lttng-test.c
> > int main()
> > {
> >=20
> >   return 0;
> >=20
> > }
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ gcc -O2 -g -ldl lttng-test.c
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ perf stat -r 5 ./a.out
> >=20
> >  Performance counter stats for './a.out' (5 runs):
> >           0.209587      task-clock (msec)         #    0.596 CPUs utili=
zed
> >=20
> > ( +-  8.76% )
> >=20
> >                  0      context-switches          #    0.000 K/sec
> >                  0      cpu-migrations            #    0.000 K/sec
> >                =20
> >                 49      page-faults               #    0.235 M/sec
> >=20
> > ( +-  1.19% )
> >=20
> >            706,854      cycles                    #    3.373 GHz
> >=20
> > ( +-  8.82% )
> >=20
> >            773,603      instructions              #    1.09  insn per
> >            cycle
> >=20
> > ( +-  0.75% )
> >=20
> >            147,128      branches                  #  701.987 M/sec
> >=20
> > ( +-  0.70% )
> >=20
> >              4,096      branch-misses             #    2.78% of all
> >              branches
> >=20
> > ( +-  5.27% )
> >=20
> >        0.000351422 seconds time elapsed
> >=20
> > ( +- 11.85% )
> >=20
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ gcc -O2 -g -ldl -llttng-ust lttng-test.c
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ perf stat -r 5 ./a.out
> >=20
> >  Performance counter stats for './a.out' (5 runs):
> >           2.063040      task-clock (msec)         #    0.009 CPUs utili=
zed
> >=20
> > ( +-  1.37% )
> >=20
> >                 44      context-switches          #    0.021 M/sec
> >=20
> > ( +-  1.95% )
> >=20
> >                  2      cpu-migrations            #    0.776 K/sec
> >=20
> > ( +- 25.00% )
> >=20
> >                209      page-faults               #    0.101 M/sec
> >=20
> > ( +-  0.34% )
> >=20
> >          7,053,686      cycles                    #    3.419 GHz
> >=20
> > ( +-  2.03% )
> >=20
> >          6,893,783      instructions              #    0.98  insn per
> >          cycle
> >=20
> > ( +-  0.25% )
> >=20
> >          1,342,492      branches                  #  650.735 M/sec
> >=20
> > ( +-  0.20% )
> >=20
> >             29,390      branch-misses             #    2.19% of all
> >             branches
> >=20
> > ( +-  0.61% )
> >=20
> >        0.225597302 seconds time elapsed
> >=20
> > ( +-  6.68% )
> > ~~~~~
> >=20
> > This is without any LTTng session configured. If I enable LTTng kernel =
and
> > userspace events, this becomes even worse:
> >=20
> > ~~~~~
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ cat $(which run_lttng_trace.sh)
> > #!/bin/sh
> >=20
> > if [ -z "$(pidof lttng-sessiond)" ]; then
> >=20
> >     sudo lttng-sessiond --daemonize
> >=20
> > fi
> >=20
> > sudo lttng create -o ~/lttng-traces/$(date -Iseconds)
> > sudo lttng enable-channel kernel -k --subbuf-size 16M --num-subbuf 8
> > sudo lttng enable-event -c kernel -k -a
> > sudo lttng enable-channel ust -u --subbuf-size 16M --num-subbuf 8
> > sudo lttng enable-event -c ust -u lttng_ust_tracef:*
> > sudo lttng start
> > $@
> > sudo lttng stop
> >=20
> > sudo chmod a+rx -R ~/lttng-traces
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ run_lttng_trace.sh perf stat -r 5 ./a.out
> > Session auto-20170905-162818 created.
> > Traces will be written in
> > /home/milian/lttng-traces/2017-09-05T16:28:18+02:00 Kernel channel kern=
el
> > enabled for session auto-20170905-162818
> > All Kernel events are enabled in channel kernel
> > UST channel ust enabled for session auto-20170905-162818
> > UST event lttng_ust_tracef:* created in channel ust
> > Tracing started for session auto-20170905-162818
> >=20
> >  Performance counter stats for './a.out' (5 runs):
> >           4.937820      task-clock (msec)         #    0.005 CPUs utili=
zed
> >=20
> > ( +-  1.28% )
> >=20
> >                117      context-switches          #    0.024 M/sec
> >=20
> > ( +-  0.70% )
> >=20
> >                  3      cpu-migrations            #    0.608 K/sec
> >=20
> > ( +- 23.57% )
> >=20
> >                245      page-faults               #    0.050 M/sec
> >=20
> > ( +-  0.20% )
> >=20
> >         16,541,355      cycles                    #    3.350 GHz
> >=20
> > ( +-  0.94% )
> >=20
> >         20,611,637      instructions              #    1.25  insn per
> >         cycle
> >=20
> > ( +-  0.23% )
> >=20
> >          3,580,525      branches                  #  725.123 M/sec
> >=20
> > ( +-  0.19% )
> >=20
> >             52,093      branch-misses             #    1.45% of all
> >             branches
> >=20
> > ( +-  1.73% )
> >=20
> >        0.965545882 seconds time elapsed
> >=20
> > ( +- 16.96% )
> >=20
> > Waiting for data availability...
> > Tracing stopped for session auto-20170905-162818
> > ~~~~~
> >=20
> > I see this ~1s delay during startup in nearly all test applications whe=
re
> > I
> > wanted to use lttng-ust. In tracecompass, and according to perf sleep t=
ime
> > profiling, this seems to be mostly due to extensive sleeping on mutex
> > locks
> > (from ust_lock in liblttng-ust). With perf trace, I also see membarrier
> > taking a lot of time:
> >=20
> > ~~~~~
> > # without a running lttng session:
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ perf trace --duration 1 ./a.out
> >=20
> >      6.492 (52.468 ms): a.out/23672 recvmsg(fd: 3<socket:[1178439]>, ms=
g:
> > 0x7fbe2fbb1070                  ) =3D 1
> >=20
> >      5.077 (54.271 ms): a.out/23671 futex(uaddr: 0x7fbe30d508a0, op:
> > WAIT_BITSET|PRIV|CLKRT, utime: 0x7ffc474ff5a0, val3: 4294967295) =3D 0
> >=20
> >     59.598 (79.379 ms): a.out/23671 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    138.984 (39.945 ms): a.out/23671 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >     59.621 (119.324 ms): a.out/23672 futex(uaddr: 0x7fbe303e54c0, op:
> >     WAIT|
> >=20
> > PRIV, val: 2                    ) =3D 0
> >=20
> >    179.045 (79.918 ms): a.out/23671 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    258.971 (39.997 ms): a.out/23671 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    299.052 (79.883 ms): a.out/23671 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    378.942 (59.988 ms): a.out/23671 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    439.022 (69.908 ms): a.out/23671 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    508.937 (80.027 ms): a.out/23671 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> > # with a running lttng session:
> > =E2=94=8Cmilian@milian-kdab2:/tmp
> > =E2=94=94$ run_lttng_trace.sh perf trace --duration 1 ./a.out
> >=20
> >      6.666 (392.496 ms): a.out-ust/23790 recvmsg(fd: 3<socket:[1185362]=
>,
> >=20
> > msg: 0x7fcd81d8a0b0                  ) =3D 612
> >=20
> >    400.238 (68.452 ms): a.out-ust/23790 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    468.698 (39.983 ms): a.out-ust/23790 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    510.567 (98.113 ms): a.out-ust/23790 recvmsg(fd: 3<socket:[1185362]>,
> >=20
> > msg: 0x7fcd81d8a070                  ) =3D 1
> >=20
> >      6.467 (603.500 ms): a.out/23789 futex(uaddr: 0x7fcd82f298a0, op:
> > WAIT_BITSET|PRIV|CLKRT, utime: 0x7fff4df6c970, val3: 4294967295) =3D 0
> >=20
> >    610.020 ( 6.307 ms): a.out/23789 futex(uaddr: 0x7fcd82f29960, op: WA=
IT|
> >=20
> > PRIV, val: 2                    ) =3D 0
> >=20
> >    616.446 (62.265 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    678.721 (59.916 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    616.332 (122.335 ms): a.out-ust/23790 futex(uaddr: 0x7fcd82f29960, o=
p:
> > WAIT|PRIV, val: 2                    ) =3D 0
> >=20
> >    738.976 (49.658 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    788.642 (49.987 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    739.014 (99.644 ms): a.out-ust/23790 futex(uaddr: 0x7fcd825be4c0, op:
> > WAIT| PRIV, val: 2                    ) =3D 0
> >=20
> >    838.651 (49.977 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    888.636 (69.983 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >    838.662 (119.978 ms): a.out-ust/23790 futex(uaddr: 0x7fcd825be4c0, o=
p:
> > WAIT|PRIV, val: 2                    ) =3D 0
> >=20
> >    958.739 (59.873 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >   1018.621 (80.058 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >   1098.782 (49.844 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >   1148.634 (59.998 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >   1208.731 (69.940 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >   1278.680 (79.947 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >   1358.727 (39.881 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >   1398.616 (39.980 ms): a.out/23789 membarrier(cmd: 1
> >=20
> > ) =3D 0
> >=20
> >      6.640 (1432.157 ms): a.out-ust/23791 futex(uaddr: 0x7fcd82f90000
> >=20
> > ) =3D -1 (null) INTERNAL ERROR: strerror_r(512, 0x7ffdbc5467a0, 128)=3D=
22
> > ~~~~~
> >=20
> > This makes lttng-ust pretty much unusable for any short-lived applicati=
on.
> > Is this a known limitation?
> >=20
> > I'm using lttng-ust on Arch from the AUR packages, i.e. LTTng 2.9.4. I'=
ve
> > seen this problem also on Ubuntu 17.04 though I didn't do any of the ab=
ove
> > measurements there. So far, I suspected the ust statedump to take too m=
uch
> > time, but I disabled that one for the measurements above.
> >=20
> > Any help would be appreciated
>=20
> Here's the perf sleep record data when no session is configured:
>=20
> ~~~~~
> 100% =3D 848.063336375 ms
>=20
> # Overhead      Pid:Command    Shared Object     Symbol          Source:L=
ine
> # ........  .................  ................  ..............=20
> ........... #
>     76.50%    10336:a.out-ust  [kernel.vmlinux]  [k] __schedule  core.c:0
>=20
>             ---__schedule core.c:0
>                schedule
>                futex_wait_queue_me futex.c:0
>                futex_wait futex.c:0
>                do_futex
>                sys_futex
>                do_syscall_64
>                return_from_SYSCALL_64 .tmp_entry_64.o:0
>                syscall
>                ust_listener_thread futex.h:65
>                /usr/include/urcu/futex.h:65 (inline)
>                /usr/include/urcu/futex.h:97 (inline)
>                /home/milian/projects/src/lttng/lttng-ust/liblttng-ust/ltt=
ng-
> ust-comm.c:1311 (inline)
>                /home/milian/projects/src/lttng/lttng-ust/liblttng-ust/ltt=
ng-
> ust-comm.c:1373 (inline)
>=20
>     15.79%    10335:a.out-ust  [kernel.vmlinux]  [k] __schedule  core.c:0
>=20
>             ---__schedule core.c:0
>                schedule
>=20
>                 --15.70%--futex_wait_queue_me futex.c:0
>                           futex_wait futex.c:0
>                           do_futex
>                           sys_futex
>                           do_syscall_64
>                           return_from_SYSCALL_64 .tmp_entry_64.o:0
>                           __lll_lock_wait
>                           pthread_mutex_lock
>=20
>                            --15.69%--0x2338
>                                      0x3b29
>                                      __nptl_deallocate_tsd.part.4
> pthread_create.c:0
>                                      start_thread pthread_create.c:0
>                                      __clone
>=20
>      7.72%    10334:a.out      [kernel.vmlinux]  [k] __schedule  core.c:0
>=20
>             ---__schedule core.c:0
>                schedule
>                futex_wait_queue_me futex.c:0
>                futex_wait futex.c:0
>                do_futex
>                sys_futex
>                do_syscall_64
>                return_from_SYSCALL_64 .tmp_entry_64.o:0
>                do_futex_wait sem_timedwait.c:0
>                __new_sem_wait_slow sem_timedwait.c:0
>                lttng_ust_init.part.3 lttng-ust-comm.c:1757
>                call_init.part.0 dl-init.c:0
>                _dl_init
>                _dl_start_user
>=20
> ~~~~~
>=20
> Here's the perf sleep record data for an existing session:
>=20
> ~~~~~
> 100% =3D 3.0793293265 s
>=20
> # Overhead      Pid:Command    Shared Object     Symbol          Source:L=
ine
> # ........  .................  ................  ..............=20
> ........... #
>     52.10%    10762:a.out-ust  [kernel.vmlinux]  [k] __schedule  core.c:0
>=20
>             ---__schedule core.c:0
>                schedule
>                futex_wait_queue_me futex.c:0
>                futex_wait futex.c:0
>                do_futex
>                sys_futex
>                do_syscall_64
>                return_from_SYSCALL_64 .tmp_entry_64.o:0
>                syscall
>                ust_listener_thread futex.h:65
>                /usr/include/urcu/futex.h:65 (inline)
>                /usr/include/urcu/futex.h:97 (inline)
>                /home/milian/projects/src/lttng/lttng-ust/liblttng-ust/ltt=
ng-
> ust-comm.c:1311 (inline)
>                /home/milian/projects/src/lttng/lttng-ust/liblttng-ust/ltt=
ng-
> ust-comm.c:1373 (inline)
>=20
>     27.09%    10761:a.out-ust  [kernel.vmlinux]  [k] __schedule  core.c:0
>=20
>             ---__schedule core.c:0
>                schedule
>=20
>                |--13.69%--schedule_timeout
>                |
>                |          unix_stream_read_generic af_unix.c:0
>                |          unix_stream_recvmsg af_unix.c:0
>                |          sock_recvmsg
>                |          ___sys_recvmsg socket.c:0
>                |          __sys_recvmsg
>                |          sys_recvmsg
>                |          do_syscall_64
>                |          return_from_SYSCALL_64 .tmp_entry_64.o:0
>                |          __libc_recvmsg
>                |          ustcomm_recv_unix_sock lttng-ust-comm.c:307
>=20
>                 --13.40%--futex_wait_queue_me futex.c:0
>                           futex_wait futex.c:0
>                           do_futex
>                           sys_futex
>                           do_syscall_64
>                           return_from_SYSCALL_64 .tmp_entry_64.o:0
>                           __lll_lock_wait
>                           pthread_mutex_lock
>=20
>                           |--8.41%--0x2338
>                           |
>                           |          0x3b29
>                           |          __nptl_deallocate_tsd.part.4
>=20
> pthread_create.c:0
>=20
>                           |          start_thread pthread_create.c:0
>                           |          __clone
>=20
>                            --4.99%--ust_lock_nocheck lttng-ust-comm.c:178
>=20
>     20.81%    10760:a.out      [kernel.vmlinux]  [k] __schedule  core.c:0
>=20
>             ---__schedule core.c:0
>                schedule
>=20
>                 --20.81%--futex_wait_queue_me futex.c:0
>                           futex_wait futex.c:0
>                           do_futex
>                           sys_futex
>                           do_syscall_64
>                           return_from_SYSCALL_64 .tmp_entry_64.o:0
>=20
>                            --20.77%--do_futex_wait sem_timedwait.c:0
>                                      __new_sem_wait_slow sem_timedwait.c:0
>                                      lttng_ust_init.part.3 lttng-ust-comm=
=2Ec:
> 1757
>                                      call_init.part.0 dl-init.c:0
>                                      _dl_init
>                                      _dl_start_user
>=20
> ~~~~~
>=20
> Hope that helps

One thing that is apparent from the above, and can also be made visible by=
=20
adding some visible output to the application before quitting it: It's not =
the=20
main thread that's blocked initially. Rather, the main thread spins up the=
=20
secondary -ust threads, then runs its code and finishes before the -ust=20
threads manage to initialize. Before the main thread then quits, it waits f=
or=20
the ust threads to finish.

=2D-=20
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
--nextPart3031736.xiS8yMp5Lp
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTcwOTA1MTUxMDQxWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgX1mClsJggYDC2BCOJ+GvDJzx8Eqm
ZB6zVB/1ETIP3hwwDQYJKoZIhvcNAQEBBQAEggEAdgXzu4eAvlJxzKEPQHiW6tb22w7BwDPMPgnr
Mn+89Otb0Ouio3QmecQl6SNpCmSDOOTemjWW9AzYxlqlLglm2ZAz3I3S9WGF3/E/AHlWNIW5nE3X
cAfiQNSvWTmp6VWJDIgI8NQvteNTzNy/MyMToJWB1l2pjM996AeL8zi3RDndMAvlHyQxBeaBvGWX
6spkVPzRCqDMdHkSkXBUMrnYohq3/gpHxFio+c2CEB9DBo3Rbe8vj3xgJpCCSm5TTPtp9jAj2f4B
B4e+bKfBoZpIsMotCYK0L/buQ3bcZqM50XKF0TdLiF1f4A1s424scW6GU8ZJZdZB6kxxqBY0bjH9
VwAAAAAAAA==


--nextPart3031736.xiS8yMp5Lp--




--===============1719252573500168083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1719252573500168083==--
