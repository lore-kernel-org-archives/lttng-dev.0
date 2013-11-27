From: kumar s <skumar.m226@gmail.com>
Subject: Re: Fwd: liburcu error: Cannot find -lurcu
Date: Wed, 27 Nov 2013 15:25:14 +0530
Message-ID: <CAO_Arvqv8RFkAMFGPEBJY0aOWA2f57TEirugmF-1+BMXZ7PcWw__47194.7655584247$1385546207$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5DE7@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0395547217=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f45.google.com ([209.85.215.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1Vlbq4-00072a-J7
	for lttng-dev@lists.lttng.org; Wed, 27 Nov 2013 04:55:31 -0500
Received: by mail-la0-f45.google.com with SMTP id eh20so5057215lab.4
	for <lttng-dev@lists.lttng.org>; Wed, 27 Nov 2013 01:55:14 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267A5DE7@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0395547217==
Content-Type: multipart/alternative; boundary=001a1134989cf418c704ec2597f8

--001a1134989cf418c704ec2597f8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I was able to fix the error, i did a small change in
doc/examples/Makefile.examples.template file.

 ifdef CC
 CC =3D mips64-octeon-linux-gnu-gcc
 endif

I changed ifndef to ifdef.

The install.log file :

Making install in .
make[1]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
  CC     wfqueue.lo
  CC     wfcqueue.lo
  CC     wfstack.lo
  CCLD   liburcu-common.la
  CC     urcu.lo
  CC     urcu-pointer.lo
  CCLD   liburcu.la
  CC     urcu-qsbr.lo
  CCLD   liburcu-qsbr.la
  CC     liburcu_mb_la-urcu.lo
  CC     liburcu_mb_la-urcu-pointer.lo
  CCLD   liburcu-mb.la
  CC     liburcu_signal_la-urcu.lo
  CC     liburcu_signal_la-urcu-pointer.lo
  CCLD   liburcu-signal.la
  CC     urcu-bp.lo
  CCLD   liburcu-bp.la
  CC     rculfqueue.lo
  CC     rculfstack.lo
  CC     lfstack.lo
  CC     rculfhash.lo
  CC     rculfhash-mm-order.lo
  CC     rculfhash-mm-chunk.lo
  CC     rculfhash-mm-mmap.lo
  CCLD   liburcu-cds.la
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/lib"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/lib"
 /bin/sh ./libtool   --mode=3Dinstall /usr/bin/install -c   liburcu-common.=
la
liburcu.la liburcu-qsbr.la liburcu-mb.la liburcu-signal.la liburcu-bp.la
liburcu-cds.la'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-r=
cu/urcu_install/lib'
libtool: install: /usr/bin/install -c .libs/liburcu-common.so.3.0.0
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-common.so.3.0.0
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-common.so.3.0.0 liburcu-common.so.3 || { rm -f
liburcu-common.so.3 && ln -s liburcu-common.so.3.0.0 liburcu-common.so.3;
}; })
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-common.so.3.0.0 liburcu-common.so || { rm -f
liburcu-common.so && ln -s liburcu-common.so.3.0.0 liburcu-common.so; }; })
libtool: install: /usr/bin/install -c .libs/liburcu-common.lai
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/
liburcu-common.la
libtool: install: warning: relinking `liburcu.la'
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu; /bin/sh
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/libtool
 --silent --tag CC --mode=3Drelink mips64-octeon-linux-gnu-gcc -Wall -g -O2
-lpthread -version-info 3:0:0 -o liburcu.la -rpath
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
urcu.lo urcu-pointer.lo liburcu-common.la )
libtool: install: /usr/bin/install -c .libs/liburcu.so.3.0.0T
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu.so.3.0.0
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu.so.3.0.0 liburcu.so.3 || { rm -f liburcu.so.3 && ln
-s liburcu.so.3.0.0 liburcu.so.3; }; })
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu.so.3.0.0 liburcu.so || { rm -f liburcu.so && ln -s
liburcu.so.3.0.0 liburcu.so; }; })
libtool: install: /usr/bin/install -c .libs/liburcu.lai
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/
liburcu.la
libtool: install: warning: relinking `liburcu-qsbr.la'
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu; /bin/sh
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/libtool
 --silent --tag CC --mode=3Drelink mips64-octeon-linux-gnu-gcc -Wall -g -O2
-lpthread -version-info 3:0:0 -o liburcu-qsbr.la -rpath
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
urcu-qsbr.lo urcu-pointer.lo liburcu-common.la )
libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.so.3.0.0T
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-qsbr.so.3.0.0
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-qsbr.so.3.0.0 liburcu-qsbr.so.3 || { rm -f
liburcu-qsbr.so.3 && ln -s liburcu-qsbr.so.3.0.0 liburcu-qsbr.so.3; }; })
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-qsbr.so.3.0.0 liburcu-qsbr.so || { rm -f
liburcu-qsbr.so && ln -s liburcu-qsbr.so.3.0.0 liburcu-qsbr.so; }; })
libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.lai
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/
liburcu-qsbr.la
libtool: install: warning: relinking `liburcu-mb.la'
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu; /bin/sh
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/libtool
 --silent --tag CC --mode=3Drelink mips64-octeon-linux-gnu-gcc -DRCU_MB -g
-O2 -lpthread -version-info 3:0:0 -o liburcu-mb.la -rpath
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
liburcu_mb_la-urcu.lo liburcu_mb_la-urcu-pointer.lo liburcu-common.la )
libtool: install: /usr/bin/install -c .libs/liburcu-mb.so.3.0.0T
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-mb.so.3.0.0
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-mb.so.3.0.0 liburcu-mb.so.3 || { rm -f
liburcu-mb.so.3 && ln -s liburcu-mb.so.3.0.0 liburcu-mb.so.3; }; })
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-mb.so.3.0.0 liburcu-mb.so || { rm -f liburcu-mb.so &&
ln -s liburcu-mb.so.3.0.0 liburcu-mb.so; }; })
libtool: install: /usr/bin/install -c .libs/liburcu-mb.lai
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/
liburcu-mb.la
libtool: install: warning: relinking `liburcu-signal.la'
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu; /bin/sh
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/libtool
 --silent --tag CC --mode=3Drelink mips64-octeon-linux-gnu-gcc -DRCU_SIGNAL
-g -O2 -lpthread -version-info 3:0:0 -o liburcu-signal.la -rpath
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
liburcu_signal_la-urcu.lo liburcu_signal_la-urcu-pointer.lo
liburcu-common.la )
libtool: install: /usr/bin/install -c .libs/liburcu-signal.so.3.0.0T
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-signal.so.3.0.0
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-signal.so.3.0.0 liburcu-signal.so.3 || { rm -f
liburcu-signal.so.3 && ln -s liburcu-signal.so.3.0.0 liburcu-signal.so.3;
}; })
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-signal.so.3.0.0 liburcu-signal.so || { rm -f
liburcu-signal.so && ln -s liburcu-signal.so.3.0.0 liburcu-signal.so; }; })
libtool: install: /usr/bin/install -c .libs/liburcu-signal.lai
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/
liburcu-signal.la
libtool: install: warning: relinking `liburcu-bp.la'
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu; /bin/sh
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/libtool
 --silent --tag CC --mode=3Drelink mips64-octeon-linux-gnu-gcc -Wall -g -O2
-lpthread -version-info 3:0:0 -o liburcu-bp.la -rpath
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
urcu-bp.lo urcu-pointer.lo liburcu-common.la )
libtool: install: /usr/bin/install -c .libs/liburcu-bp.so.3.0.0T
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-bp.so.3.0.0
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-bp.so.3.0.0 liburcu-bp.so.3 || { rm -f
liburcu-bp.so.3 && ln -s liburcu-bp.so.3.0.0 liburcu-bp.so.3; }; })
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-bp.so.3.0.0 liburcu-bp.so || { rm -f liburcu-bp.so &&
ln -s liburcu-bp.so.3.0.0 liburcu-bp.so; }; })
libtool: install: /usr/bin/install -c .libs/liburcu-bp.lai
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/
liburcu-bp.la
libtool: install: warning: relinking `liburcu-cds.la'
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu; /bin/sh
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/libtool
 --silent --tag CC --mode=3Drelink mips64-octeon-linux-gnu-gcc -Wall -g -O2
-lpthread -version-info 3:0:0 -o liburcu-cds.la -rpath
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
rculfqueue.lo rculfstack.lo lfstack.lo rculfhash.lo rculfhash-mm-order.lo
rculfhash-mm-chunk.lo rculfhash-mm-mmap.lo liburcu-common.la )
libtool: install: /usr/bin/install -c .libs/liburcu-cds.so.3.0.0T
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-cds.so.3.0.0
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-cds.so.3.0.0 liburcu-cds.so.3 || { rm -f
liburcu-cds.so.3 && ln -s liburcu-cds.so.3.0.0 liburcu-cds.so.3; }; })
libtool: install: (cd
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
&& { ln -s -f liburcu-cds.so.3.0.0 liburcu-cds.so || { rm -f liburcu-cds.so
&& ln -s liburcu-cds.so.3.0.0 liburcu-cds.so; }; })
libtool: install: /usr/bin/install -c .libs/liburcu-cds.lai
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/
liburcu-cds.la
libtool: install: /usr/bin/install -c .libs/liburcu-common.a
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-common.a
libtool: install: chmod 644
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-common.a
libtool: install: mips64-octeon-linux-gnu-ranlib
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-common.a
libtool: install: /usr/bin/install -c .libs/liburcu.a
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu.a
libtool: install: chmod 644
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu.a
libtool: install: mips64-octeon-linux-gnu-ranlib
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu.a
libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.a
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-qsbr.a
libtool: install: chmod 644
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-qsbr.a
libtool: install: mips64-octeon-linux-gnu-ranlib
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-qsbr.a
libtool: install: /usr/bin/install -c .libs/liburcu-mb.a
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-mb.a
libtool: install: chmod 644
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-mb.a
libtool: install: mips64-octeon-linux-gnu-ranlib
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-mb.a
libtool: install: /usr/bin/install -c .libs/liburcu-signal.a
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-signal.a
libtool: install: chmod 644
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-signal.a
libtool: install: mips64-octeon-linux-gnu-ranlib
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-signal.a
libtool: install: /usr/bin/install -c .libs/liburcu-bp.a
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-bp.a
libtool: install: chmod 644
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-bp.a
libtool: install: mips64-octeon-linux-gnu-ranlib
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-bp.a
libtool: install: /usr/bin/install -c .libs/liburcu-cds.a
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-cds.a
libtool: install: chmod 644
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-cds.a
libtool: install: mips64-octeon-linux-gnu-ranlib
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib/liburcu-cds.a
libtool: finish:
PATH=3D"/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk/OCTEON=
-SDK/tools/bin:/home/shkumar/Development_Merge/NewOCT/OCTEON_SDK/octeon_sdk=
/OCTEON-SDK/host/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/sh=
kumar/bin:/sbin"
ldconfig -n
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/lib
----------------------------------------------------------------------
Libraries have been installed in:

 /home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/lib

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the `-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the `LD_RUN_PATH' environment variable
     during linking
   - use the `-Wl,-rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to `/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu"
 /usr/bin/install -c -m 644 README ChangeLog
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include"
 /usr/bin/install -c -m 644 urcu.h urcu-bp.h urcu-call-rcu.h urcu-defer.h
urcu-pointer.h urcu-qsbr.h urcu-flavor.h
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include"
/bin/mkdir -p
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu/static'
 /usr/bin/install -c -m 644  ./urcu/static/lfstack.h
./urcu/static/rculfqueue.h ./urcu/static/rculfstack.h
./urcu/static/urcu-bp.h ./urcu/static/urcu.h ./urcu/static/urcu-pointer.h
./urcu/static/urcu-qsbr.h ./urcu/static/wfcqueue.h ./urcu/static/wfqueue.h
./urcu/static/wfstack.h
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu/static'
/bin/mkdir -p
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu/map'
 /usr/bin/install -c -m 644  ./urcu/map/urcu-bp.h ./urcu/map/urcu.h
./urcu/map/urcu-qsbr.h
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu/map'
/bin/mkdir -p
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu/arch'
 /usr/bin/install -c -m 644  urcu/arch/generic.h
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu/arch'
/bin/mkdir -p
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu/uatomic'
 /usr/bin/install -c -m 644  urcu/uatomic/generic.h
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu/uatomic'
/bin/mkdir -p
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu'
 /usr/bin/install -c -m 644  urcu/compiler.h urcu/hlist.h urcu/list.h
urcu/rculist.h urcu/rcuhlist.h urcu/system.h urcu/futex.h urcu/wfstack.h
urcu/wfqueue.h urcu/rculfstack.h urcu/rculfqueue.h urcu/ref.h urcu/cds.h
urcu/urcu_ref.h urcu/urcu-futex.h urcu/uatomic_arch.h urcu/rculfhash.h
urcu/wfcqueue.h urcu/lfstack.h urcu/tls-compat.h
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include"
/bin/mkdir -p
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu'
 /usr/bin/install -c -m 644  urcu/arch.h urcu/uatomic.h urcu/config.h
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/include/urcu'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/lib/pkgconfig"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/lib/pkgconfig"
 /usr/bin/install -c -m 644 liburcu-cds.pc liburcu.pc liburcu-bp.pc
liburcu-qsbr.pc liburcu-signal.pc liburcu-mb.pc
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/lib/pkgconfig'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
make[1]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
Making install in doc
make[1]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
Making install in examples
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make -f dist-files/Makefile AM_CPPFLAGS=3D" -I../../../urcu/ -I../../../"
AM_CFLAGS=3D'-g -O2' AM_LDFLAGS=3D' -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"'
 all
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make -C hlist
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
make -f Makefile.cds_hlist_add_head_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
make -f Makefile.cds_hlist_del_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_hlist_del_rcu.o cds_hlist_del_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_hlist_del_rcu cds_hlist_del_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
make -f Makefile.cds_hlist_for_each_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_hlist_for_each_rcu.o cds_hlist_for_each_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_hlist_for_each_rcu cds_hlist_for_each_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
make -f Makefile.cds_hlist_for_each_entry_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_hlist_for_each_entry_rcu.o cds_hlist_for_each_entry_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_hlist_for_each_entry_rcu cds_hlist_for_each_entry_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/hlist'
make -C list
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
make -f Makefile.cds_list_add_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_list_add_rcu.o cds_list_add_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_list_add_rcu cds_list_add_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
make -f Makefile.cds_list_add_tail_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_list_add_tail_rcu.o cds_list_add_tail_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_list_add_tail_rcu cds_list_add_tail_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
make -f Makefile.cds_list_del_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_list_del_rcu.o cds_list_del_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_list_del_rcu cds_list_del_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
make -f Makefile.cds_list_for_each_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_list_for_each_rcu.o cds_list_for_each_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_list_for_each_rcu cds_list_for_each_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
make -f Makefile.cds_list_for_each_entry_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_list_for_each_entry_rcu.o cds_list_for_each_entry_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_list_for_each_entry_rcu cds_list_for_each_entry_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
make -f Makefile.cds_list_replace_rcu
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_list_replace_rcu.o cds_list_replace_rcu.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_list_replace_rcu cds_list_replace_rcu.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list'
make -C urcu-flavors
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
make -f Makefile.qsbr
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o qsbr.o qsbr.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o qsbr qsbr.o -lurcu-qsbr
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
make -f Makefile.mb
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o mb.o mb.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o mb mb.o -lurcu-mb
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
make -f Makefile.membarrier
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o membarrier.o membarrier.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o membarrier membarrier.o -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
make -f Makefile.signal
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o signal.o signal.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o signal signal.o -lurcu-signal
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
make -f Makefile.bp
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o bp.o bp.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o bp bp.o -lurcu-bp
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/urcu-flavors'
make -C wfcqueue
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfcqueue'
make -f Makefile.cds_wfcq_enqueue
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfcqueue'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_wfcq_enqueue.o cds_wfcq_enqueue.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_wfcq_enqueue cds_wfcq_enqueue.o -lurcu-common
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfcqueue'
make -f Makefile.cds_wfcq_dequeue
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfcqueue'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_wfcq_dequeue.o cds_wfcq_dequeue.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_wfcq_dequeue cds_wfcq_dequeue.o -lurcu-common
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfcqueue'
make -f Makefile.cds_wfcq_splice
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfcqueue'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_wfcq_splice.o cds_wfcq_splice.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_wfcq_splice cds_wfcq_splice.o -lurcu-common
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfcqueue'
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfcqueue'
make -C rculfqueue
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfqueue'
make -f Makefile.cds_lfq_enqueue
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfqueue'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfq_enqueue.o cds_lfq_enqueue.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfq_enqueue cds_lfq_enqueue.o -lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfqueue'
make -f Makefile.cds_lfq_dequeue
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfqueue'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfq_dequeue.o cds_lfq_dequeue.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfq_dequeue cds_lfq_dequeue.o -lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfqueue'
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfqueue'
make -C wfstack
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfstack'
make -f Makefile.cds_wfs_push
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfstack'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_wfs_push.o cds_wfs_push.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_wfs_push cds_wfs_push.o -lurcu-common
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfstack'
make -f Makefile.cds_wfs_pop
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfstack'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_wfs_pop.o cds_wfs_pop.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_wfs_pop cds_wfs_pop.o -lurcu-common
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfstack'
make -f Makefile.cds_wfs_pop_all_blocking
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfstack'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_wfs_pop_all_blocking.o cds_wfs_pop_all_blocking.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_wfs_pop_all_blocking cds_wfs_pop_all_blocking.o -lurcu-common
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfstack'
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/wfstack'
make -C lfstack
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/lfstack'
make -f Makefile.cds_lfs_push
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/lfstack'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfs_push.o cds_lfs_push.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfs_push cds_lfs_push.o -lurcu-cds
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/lfstack'
make -f Makefile.cds_lfs_pop_blocking
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/lfstack'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfs_pop_blocking.o cds_lfs_pop_blocking.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfs_pop_blocking cds_lfs_pop_blocking.o -lurcu-cds
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/lfstack'
make -f Makefile.cds_lfs_pop_all_blocking
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/lfstack'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfs_pop_all_blocking.o cds_lfs_pop_all_blocking.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfs_pop_all_blocking cds_lfs_pop_all_blocking.o -lurcu-cds
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/lfstack'
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/lfstack'
make -C rculfhash
make[4]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make -f Makefile.cds_lfht_add
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfht_add.o cds_lfht_add.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfht_add cds_lfht_add.o -lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make -f Makefile.cds_lfht_add_unique
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfht_add_unique.o cds_lfht_add_unique.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfht_add_unique cds_lfht_add_unique.o -lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make -f Makefile.cds_lfht_add_replace
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfht_add_replace.o cds_lfht_add_replace.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfht_add_replace cds_lfht_add_replace.o -lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make -f Makefile.cds_lfht_del
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfht_del.o cds_lfht_del.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfht_del cds_lfht_del.o -lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make -f Makefile.cds_lfht_destroy
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfht_destroy.o cds_lfht_destroy.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfht_destroy cds_lfht_destroy.o -lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make -f Makefile.cds_lfht_lookup
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfht_lookup.o cds_lfht_lookup.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfht_lookup cds_lfht_lookup.o -lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make -f Makefile.cds_lfht_for_each_entry_duplicate
make[5]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
mips64-octeon-linux-gnu-gcc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g
-O2 \
-c -o cds_lfht_for_each_entry_duplicate.o
cds_lfht_for_each_entry_duplicate.c
mips64-octeon-linux-gnu-gcc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/../../.libs/"
\
-o cds_lfht_for_each_entry_duplicate cds_lfht_for_each_entry_duplicate.o
-lurcu-cds -lurcu
make[5]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make[4]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/rculfhash'
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make[3]: Nothing to be done for `install-exec-am'.
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples"
 /usr/bin/install -c -m 644 dist-files/Makefile Makefile.examples.template
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/hlist"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/hlist"
 /usr/bin/install -c -m 644 hlist/Makefile
hlist/Makefile.cds_hlist_add_head_rcu hlist/Makefile.cds_hlist_del_rcu
hlist/Makefile.cds_hlist_for_each_rcu
hlist/Makefile.cds_hlist_for_each_entry_rcu hlist/cds_hlist_add_head_rcu.c
hlist/cds_hlist_del_rcu.c hlist/cds_hlist_for_each_rcu.c
hlist/cds_hlist_for_each_entry_rcu.c
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/hlist'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/lfstack"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/lfstack"
 /usr/bin/install -c -m 644 lfstack/Makefile lfstack/Makefile.cds_lfs_push
lfstack/Makefile.cds_lfs_pop_blocking
lfstack/Makefile.cds_lfs_pop_all_blocking lfstack/cds_lfs_push.c
lfstack/cds_lfs_pop_blocking.c lfstack/cds_lfs_pop_all_blocking.c
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/lfstack'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/list"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/list"
 /usr/bin/install -c -m 644 list/Makefile list/Makefile.cds_list_add_rcu
list/Makefile.cds_list_add_tail_rcu list/Makefile.cds_list_del_rcu
list/Makefile.cds_list_for_each_rcu
list/Makefile.cds_list_for_each_entry_rcu
list/Makefile.cds_list_replace_rcu list/cds_list_add_rcu.c
list/cds_list_add_tail_rcu.c list/cds_list_del_rcu.c
list/cds_list_for_each_rcu.c list/cds_list_for_each_entry_rcu.c
list/cds_list_replace_rcu.c
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/list'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/rculfhash"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/rculfhash"
 /usr/bin/install -c -m 644 rculfhash/Makefile rculfhash/jhash.h
rculfhash/Makefile.cds_lfht_add rculfhash/Makefile.cds_lfht_add_unique
rculfhash/Makefile.cds_lfht_add_replace rculfhash/Makefile.cds_lfht_del
rculfhash/Makefile.cds_lfht_destroy rculfhash/Makefile.cds_lfht_lookup
rculfhash/Makefile.cds_lfht_for_each_entry_duplicate
rculfhash/cds_lfht_add.c rculfhash/cds_lfht_add_unique.c
rculfhash/cds_lfht_add_replace.c rculfhash/cds_lfht_del.c
rculfhash/cds_lfht_destroy.c rculfhash/cds_lfht_lookup.c
rculfhash/cds_lfht_for_each_entry_duplicate.c
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/rculfhash'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/rculfqueue"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/rculfqueue"
 /usr/bin/install -c -m 644 rculfqueue/Makefile
rculfqueue/Makefile.cds_lfq_enqueue rculfqueue/Makefile.cds_lfq_dequeue
rculfqueue/cds_lfq_enqueue.c rculfqueue/cds_lfq_dequeue.c
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/rculfqueue'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/urcu-flavors"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/urcu-flavors"
 /usr/bin/install -c -m 644 urcu-flavors/Makefile
urcu-flavors/Makefile.qsbr urcu-flavors/Makefile.mb
urcu-flavors/Makefile.membarrier urcu-flavors/Makefile.signal
urcu-flavors/Makefile.bp urcu-flavors/qsbr.c urcu-flavors/mb.c
urcu-flavors/membarrier.c urcu-flavors/signal.c urcu-flavors/bp.c
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/urcu-flavors'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/wfcqueue"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/wfcqueue"
 /usr/bin/install -c -m 644 wfcqueue/Makefile
wfcqueue/Makefile.cds_wfcq_enqueue wfcqueue/Makefile.cds_wfcq_dequeue
wfcqueue/Makefile.cds_wfcq_splice wfcqueue/cds_wfcq_enqueue.c
wfcqueue/cds_wfcq_dequeue.c wfcqueue/cds_wfcq_splice.c
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/wfcqueue'
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/wfstack"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/wfstack"
 /usr/bin/install -c -m 644 wfstack/Makefile wfstack/Makefile.cds_wfs_push
wfstack/Makefile.cds_wfs_pop wfstack/Makefile.cds_wfs_pop_all_blocking
wfstack/cds_wfs_push.c wfstack/cds_wfs_pop.c
wfstack/cds_wfs_pop_all_blocking.c
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu/examples/wfstack'
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s'
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
make[3]: Nothing to be done for `install-exec-am'.
test -z
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu"
|| /bin/mkdir -p
"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu"
 /usr/bin/install -c -m 644 rcu-api.txt cds-api.txt uatomic-api.txt
'/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_instal=
l/share/doc/userspace-rcu'
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
make[1]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc'
Making install in tests
make[1]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
Making install in common
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/commo=
n'
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/commo=
n'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/commo=
n'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/commo=
n'
Making install in unit
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/unit'
  CC     test_uatomic.o
  CCLD   test_uatomic
  CC     test_urcu_multiflavor.o
  CC     test_urcu_multiflavor-memb.o
  CC     test_urcu_multiflavor-mb.o
  CC     test_urcu_multiflavor-signal.o
  CC     test_urcu_multiflavor-qsbr.o
  CC     test_urcu_multiflavor-bp.o
  CCLD   test_urcu_multiflavor
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-memb.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-mb.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-signal.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-qsbr.o
  CC     test_urcu_multiflavor_dynlink-test_urcu_multiflavor-bp.o
  CCLD   test_urcu_multiflavor_dynlink
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/unit'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/unit'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/unit'
Making install in benchmark
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/bench=
mark'
  CC     test_urcu.o
  CC     urcu.o
  CC     urcu-pointer.o
  CC     wfcqueue.o
  CCLD   test_urcu
  CC     test_urcu_dynamic_link-test_urcu.o
  CC     test_urcu_dynamic_link-urcu.o
  CC     test_urcu_dynamic_link-urcu-pointer.o
  CC     test_urcu_dynamic_link-wfcqueue.o
  CCLD   test_urcu_dynamic_link
  CC     test_urcu_timing.o
  CCLD   test_urcu_timing
  CC     test_urcu_signal-test_urcu.o
  CC     test_urcu_signal-urcu.o
  CC     test_urcu_signal-urcu-pointer.o
  CC     test_urcu_signal-wfcqueue.o
  CCLD   test_urcu_signal
  CC     test_urcu_signal_dynamic_link-test_urcu.o
  CC     test_urcu_signal_dynamic_link-urcu.o
  CC     test_urcu_signal_dynamic_link-urcu-pointer.o
  CC     test_urcu_signal_dynamic_link-wfcqueue.o
  CCLD   test_urcu_signal_dynamic_link
  CC     test_urcu_signal_timing-test_urcu_timing.o
  CC     test_urcu_signal_timing-urcu.o
  CC     test_urcu_signal_timing-urcu-pointer.o
  CC     test_urcu_signal_timing-wfcqueue.o
  CCLD   test_urcu_signal_timing
  CC     test_rwlock_timing.o
  CCLD   test_rwlock_timing
  CC     test_rwlock.o
  CCLD   test_rwlock
  CC     test_perthreadlock_timing.o
  CCLD   test_perthreadlock_timing
  CC     test_perthreadlock.o
  CCLD   test_perthreadlock
  CC     test_urcu_yield-test_urcu.o
  CC     test_urcu_yield-urcu.o
  CC     test_urcu_yield-urcu-pointer.o
  CC     test_urcu_yield-wfcqueue.o
  CCLD   test_urcu_yield
  CC     test_urcu_signal_yield-test_urcu.o
  CC     test_urcu_signal_yield-urcu.o
  CC     test_urcu_signal_yield-urcu-pointer.o
  CC     test_urcu_signal_yield-wfcqueue.o
  CCLD   test_urcu_signal_yield
  CC     test_urcu_mb-test_urcu.o
  CC     test_urcu_mb-urcu.o
  CC     test_urcu_mb-urcu-pointer.o
  CC     test_urcu_mb-wfcqueue.o
  CCLD   test_urcu_mb
  CC     test_urcu_qsbr_timing.o
  CC     urcu-qsbr.o
  CCLD   test_urcu_qsbr_timing
  CC     test_urcu_qsbr.o
  CCLD   test_urcu_qsbr
  CC     test_mutex.o
  CCLD   test_mutex
  CC     test_looplen.o
  CCLD   test_looplen
  CC     test_urcu_gc.o
  CCLD   test_urcu_gc
  CC     test_urcu_signal_gc-test_urcu_gc.o
  CC     test_urcu_signal_gc-urcu.o
  CC     test_urcu_signal_gc-urcu-pointer.o
  CC     test_urcu_signal_gc-wfcqueue.o
  CCLD   test_urcu_signal_gc
  CC     test_urcu_lgc-test_urcu_gc.o
  CC     test_urcu_lgc-urcu.o
  CC     test_urcu_lgc-urcu-pointer.o
  CC     test_urcu_lgc-wfcqueue.o
  CCLD   test_urcu_lgc
  CC     test_urcu_mb_gc-test_urcu_gc.o
  CC     test_urcu_mb_gc-urcu.o
  CC     test_urcu_mb_gc-urcu-pointer.o
  CC     test_urcu_mb_gc-wfcqueue.o
  CCLD   test_urcu_mb_gc
  CC     test_urcu_qsbr_gc.o
  CCLD   test_urcu_qsbr_gc
  CC     test_urcu_qsbr_lgc-test_urcu_qsbr_gc.o
  CC     test_urcu_qsbr_lgc-urcu-qsbr.o
  CC     test_urcu_qsbr_lgc-urcu-pointer.o
  CC     test_urcu_qsbr_lgc-wfcqueue.o
  CCLD   test_urcu_qsbr_lgc
  CC     test_urcu_signal_lgc-test_urcu_gc.o
  CC     test_urcu_signal_lgc-urcu.o
  CC     test_urcu_signal_lgc-urcu-pointer.o
  CC     test_urcu_signal_lgc-wfcqueue.o
  CCLD   test_urcu_signal_lgc
  CC     test_urcu_mb_lgc-test_urcu_gc.o
  CC     test_urcu_mb_lgc-urcu.o
  CC     test_urcu_mb_lgc-urcu-pointer.o
  CC     test_urcu_mb_lgc-wfcqueue.o
  CCLD   test_urcu_mb_lgc
  CC     test_urcu_qsbr_dynamic_link-test_urcu_qsbr.o
  CC     test_urcu_qsbr_dynamic_link-urcu-qsbr.o
  CC     test_urcu_qsbr_dynamic_link-urcu-pointer.o
  CC     test_urcu_qsbr_dynamic_link-wfcqueue.o
  CCLD   test_urcu_qsbr_dynamic_link
  CC     test_urcu_defer.o
  CCLD   test_urcu_defer
  CC     test_urcu_assign.o
  CCLD   test_urcu_assign
  CC     test_urcu_assign_dynamic_link-test_urcu_assign.o
  CC     test_urcu_assign_dynamic_link-urcu.o
  CC     test_urcu_assign_dynamic_link-urcu-pointer.o
  CC     test_urcu_assign_dynamic_link-wfcqueue.o
  CCLD   test_urcu_assign_dynamic_link
  CC     test_urcu_bp.o
  CC     urcu-bp.o
  CCLD   test_urcu_bp
  CC     test_urcu_bp_dynamic_link-test_urcu_bp.o
  CC     test_urcu_bp_dynamic_link-urcu-bp.o
  CC     test_urcu_bp_dynamic_link-urcu-pointer.o
  CC     test_urcu_bp_dynamic_link-wfcqueue.o
  CCLD   test_urcu_bp_dynamic_link
  CC     test_cycles_per_loop.o
  CCLD   test_cycles_per_loop
  CC     test_urcu_lfq.o
  CCLD   test_urcu_lfq
  CC     test_urcu_wfq.o
  CCLD   test_urcu_wfq
  CC     test_urcu_lfs.o
  CCLD   test_urcu_lfs
  CC     test_urcu_wfs.o
  CCLD   test_urcu_wfs
  CC     test_urcu_lfs_rcu.o
  CCLD   test_urcu_lfs_rcu
  CC     test_urcu_wfcq.o
  CCLD   test_urcu_wfcq
  CC     test_urcu_wfq_dynlink-test_urcu_wfq.o
  CCLD   test_urcu_wfq_dynlink
  CC     test_urcu_wfs_dynlink-test_urcu_wfs.o
  CCLD   test_urcu_wfs_dynlink
  CC     test_urcu_wfcq_dynlink-test_urcu_wfcq.o
  CCLD   test_urcu_wfcq_dynlink
  CC     test_urcu_lfq_dynlink-test_urcu_lfq.o
  CC     test_urcu_lfq_dynlink-urcu.o
  CC     test_urcu_lfq_dynlink-urcu-pointer.o
  CC     test_urcu_lfq_dynlink-wfcqueue.o
  CCLD   test_urcu_lfq_dynlink
  CC     test_urcu_lfs_dynlink-test_urcu_lfs.o
  CC     test_urcu_lfs_dynlink-urcu.o
  CC     test_urcu_lfs_dynlink-urcu-pointer.o
  CC     test_urcu_lfs_dynlink-wfcqueue.o
  CCLD   test_urcu_lfs_dynlink
  CC     test_urcu_hash-test_urcu_hash.o
  CC     test_urcu_hash-test_urcu_hash_rw.o
  CC     test_urcu_hash-test_urcu_hash_unique.o
  CCLD   test_urcu_hash
  CC     test_urcu_lfs_rcu_dynlink-test_urcu_lfs_rcu.o
  CC     test_urcu_lfs_rcu_dynlink-urcu.o
  CC     test_urcu_lfs_rcu_dynlink-urcu-pointer.o
  CC     test_urcu_lfs_rcu_dynlink-wfcqueue.o
  CCLD   test_urcu_lfs_rcu_dynlink
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/bench=
mark'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/bench=
mark'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/bench=
mark'
Making install in regression
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regre=
ssion'
  CC     test_urcu_fork.o
  CC     urcu.o
  CC     urcu-pointer.o
  CC     wfcqueue.o
  CCLD   test_urcu_fork
  CC     rcutorture_urcu-urcutorture.o
  CCLD   rcutorture_urcu
  CC     rcutorture_urcu_signal-urcutorture.o
  CCLD   rcutorture_urcu_signal
  CC     rcutorture_urcu_mb-urcutorture.o
  CCLD   rcutorture_urcu_mb
  CC     rcutorture_urcu_bp-urcutorture.o
  CCLD   rcutorture_urcu_bp
  CC     rcutorture_urcu_qsbr-urcutorture.o
  CCLD   rcutorture_urcu_qsbr
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regre=
ssion'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regre=
ssion'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regre=
ssion'
make[2]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
make[3]: Entering directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
make[3]: Nothing to be done for `install-exec-am'.
make[3]: Nothing to be done for `install-data-am'.
make[3]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
make[2]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'
make[1]: Leaving directory
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests'


I have an issue with lttng-tools build, which i will raise in a new thread.

Thank you
Skumar


On Mon, Nov 25, 2013 at 10:10 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> > Date: Mon, 25 Nov 2013 12:11:09 +0530
> > From: kumar s <skumar.m226@gmail.com>
> >
> > I tried test .so and app ,compiled with mips gcc . it worked fine
> without throwing any errors.
> >
> > configuring with static library works fine but shared lib throws this
> error. I have attached the log below.
> >
> > *Static Library build*
> >
> > CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu_insta=
ll
> --host=3Dmips64-octeon-linux-gnu --disable-shared
> > configure: WARNING: if you wanted to set the --build type, don't use
> --host.
> > [...]
> > checking if libtool supports shared libraries... yes
> > *checking whether to build shared libraries... no*
> > checking whether to build static libraries... yes
> > [...]
> > configure: creating ./config.status
> > config.status: creating Makefile
> > config.status: creating doc/Makefile
> > config.status: creating doc/examples/Makefile
> > config.status: creating tests/Makefile
> > config.status: creating tests/common/Makefile
> > config.status: creating tests/unit/Makefile
> > config.status: creating tests/benchmark/Makefile
> > config.status: creating tests/regression/Makefile
> > config.status: creating liburcu.pc
> > config.status: creating liburcu-bp.pc
> > config.status: creating liburcu-cds.pc
> > config.status: creating liburcu-qsbr.pc
> > config.status: creating liburcu-mb.pc
> > config.status: creating liburcu-signal.pc
> > config.status: creating config.h
> > config.status: config.h is unchanged
> > config.status: creating urcu/config.h
> > config.status: urcu/config.h is unchanged
>
>    The two "config.h is unchanged" messages are the only ones different
> from my configure.log.  Did you install from a clean system?
>
> > config.status: linking urcu/arch/mips.h to urcu/arch.h
> > config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h
> > config.status: executing depfiles commands
> > config.status: executing libtool commands
> > SMP support enabled.
> > Thread Local Storage (TLS): __thread.
>
> > [shkumar@shrayanth userspace-rcu]$ make
> > make  all-recursive
> > make[1]: Entering directory
> `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
> > Making all in .
> > make[2]: Entering directory
> `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
> >   CC     wfqueue.lo
> >   CC     wfcqueue.lo
> > [...]
> >   CC     urcu.lo
>
>    At least the warnings have disappeared.
>
> > [...]
> >   CCLD   test_urcu_lfs_rcu_dynlink
> > make[3]: Leaving directory
> `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/ben=
chmark'
> > Making all in regression
> > make[3]: Entering directory
> `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/reg=
ression'
> >   CC     test_urcu_fork.o
> >   CC     urcu.o
> > [...]
> > make[1]: Leaving directory
> `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
>
>    Your log is identical to mine, except for the paths, of course.
>
> > *Shared-library build.*
> >
> > CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu_insta=
ll
> --host=3Dmips64-octeon-linux-gnu --enable-shared
> > configure: WARNING: if you wanted to set the --build type, don't use
> --host.
> > [...]
> > checking if libtool supports shared libraries... yes
> > *checking whether to build shared libraries... yes*
> > checking whether to build static libraries... yes
> > [...]
> > configure: creating ./config.status
> > [...]
> > config.status: creating config.h
> > config.status: config.h is unchanged
> > config.status: creating urcu/config.h
> > config.status: urcu/config.h is unchanged
> > config.status: linking urcu/arch/mips.h to urcu/arch.h
> > config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h
> > config.status: executing depfiles commands
> > config.status: executing libtool commands
> > SMP support enabled.
> > Thread Local Storage (TLS): __thread.
>
> > [shkumar@shrayanth userspace-rcu]$ make
> > make  all-recursive
> > make[1]: Entering directory
> `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu'
> > Making all in .
> > [...]
> > cc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \
> >         -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c
> > cc -g -O2 -Wall  -g -O2 -L../../../.libs/ \
> >
> -Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/userspace-=
rcu/doc/examples/../../.libs/"
> \
> >         -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
> > /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when
> searching for -lurcu
> > /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when
> searching for -lurcu
> > /usr/bin/ld: cannot find -lurcu
> > collect2: ld returned 1 exit status
> > make[6]: *** [cds_hlist_add_head_rcu] Error 1
> > [...]
>
>    The incompatibility message occurs because you're trying to mix
> bitnesses (a 32-bit liburcu.so won't link with a 64-bit application and
> vice-versa).
>
>    Could the replacement of gcc by cc somehow be responsible?  How come
> the Makefile isn't using CC =3D mips64-octeon-linux-gnu-gcc (or so it see=
ms)?
>
> > is userspace lib required to build lttng-tools (latest version from git=
)?
> > It throws this error while trying to configure..
> >
> > [...]
> > checking for grp.h... yes
> > checking for pthread_create in -lpthread... yes
> > checking for poptGetContext in -lpopt... yes
> > checking for uuid_generate in -luuid... yes
> > checking whether cds_list_add is declared... no
> > configure: error: liburcu >=3D 0.7.2 or newer is needed
>
> > skumar
>
>    Yes, lttng-tools requires userspace-rcu, although it can be built
> without lttng-modules and/or lttng-ust.
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection &
> Countermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l
> Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D
> Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>

--001a1134989cf418c704ec2597f8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I was able to fix the error, i did =
a small change in doc/examples/Makefile.examples.template file.</div><div><=
br></div><div><div>=A0ifdef CC</div><div>=A0CC =3D mips64-octeon-linux-gnu-=
gcc</div>
<div>=A0endif</div></div><div><br></div><div>I changed ifndef to ifdef.=A0<=
/div><div><br></div><div>The install.log file :</div><div><br></div><div><d=
iv>Making install in .</div><div>make[1]: Entering directory `/home/shkumar=
/Development_Merge/NewOCT/userspace/userspace-rcu&#39;</div>
<div>=A0 CC =A0 =A0 wfqueue.lo</div><div>=A0 CC =A0 =A0 wfcqueue.lo</div><d=
iv>=A0 CC =A0 =A0 wfstack.lo</div><div>=A0 CCLD =A0 <a href=3D"http://libur=
cu-common.la">liburcu-common.la</a></div><div>=A0 CC =A0 =A0 urcu.lo</div><=
div>=A0 CC =A0 =A0 urcu-pointer.lo</div>
<div>=A0 CCLD =A0 <a href=3D"http://liburcu.la">liburcu.la</a></div><div>=
=A0 CC =A0 =A0 urcu-qsbr.lo</div><div>=A0 CCLD =A0 <a href=3D"http://liburc=
u-qsbr.la">liburcu-qsbr.la</a></div><div>=A0 CC =A0 =A0 liburcu_mb_la-urcu.=
lo</div><div>=A0 CC =A0 =A0 liburcu_mb_la-urcu-pointer.lo</div>
<div>=A0 CCLD =A0 <a href=3D"http://liburcu-mb.la">liburcu-mb.la</a></div><=
div>=A0 CC =A0 =A0 liburcu_signal_la-urcu.lo</div><div>=A0 CC =A0 =A0 libur=
cu_signal_la-urcu-pointer.lo</div><div>=A0 CCLD =A0 <a href=3D"http://libur=
cu-signal.la">liburcu-signal.la</a></div>
<div>=A0 CC =A0 =A0 urcu-bp.lo</div><div>=A0 CCLD =A0 <a href=3D"http://lib=
urcu-bp.la">liburcu-bp.la</a></div><div>=A0 CC =A0 =A0 rculfqueue.lo</div><=
div>=A0 CC =A0 =A0 rculfstack.lo</div><div>=A0 CC =A0 =A0 lfstack.lo</div><=
div>=A0 CC =A0 =A0 rculfhash.lo</div>
<div>=A0 CC =A0 =A0 rculfhash-mm-order.lo</div><div>=A0 CC =A0 =A0 rculfhas=
h-mm-chunk.lo</div><div>=A0 CC =A0 =A0 rculfhash-mm-mmap.lo</div><div>=A0 C=
CLD =A0 <a href=3D"http://liburcu-cds.la">liburcu-cds.la</a></div><div>make=
[2]: Entering directory `/home/shkumar/Development_Merge/NewOCT/userspace/u=
serspace-rcu&#39;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/lib&quot; || /bin/mkdir -p &quot;/home/shkumar/Developm=
ent_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib&quot;</div><div>
=A0/bin/sh ./libtool =A0 --mode=3Dinstall /usr/bin/install -c =A0 <a href=
=3D"http://liburcu-common.la">liburcu-common.la</a> <a href=3D"http://libur=
cu.la">liburcu.la</a> <a href=3D"http://liburcu-qsbr.la">liburcu-qsbr.la</a=
> <a href=3D"http://liburcu-mb.la">liburcu-mb.la</a> <a href=3D"http://libu=
rcu-signal.la">liburcu-signal.la</a> <a href=3D"http://liburcu-bp.la">libur=
cu-bp.la</a> <a href=3D"http://liburcu-cds.la">liburcu-cds.la</a> &#39;/hom=
e/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib=
&#39;</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-common.so.3.0.0 /h=
ome/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/l=
ib/liburcu-common.so.3.0.0</div><div>libtool: install: (cd /home/shkumar/De=
velopment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib &amp;&amp; =
{ ln -s -f liburcu-common.so.3.0.0 liburcu-common.so.3 || { rm -f liburcu-c=
ommon.so.3 &amp;&amp; ln -s liburcu-common.so.3.0.0 liburcu-common.so.3; };=
 })</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s -f liburcu-common.so.3.0=
.0 liburcu-common.so || { rm -f liburcu-common.so &amp;&amp; ln -s liburcu-=
common.so.3.0.0 liburcu-common.so; }; })</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-common.lai /home/s=
hkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/<a=
 href=3D"http://liburcu-common.la">liburcu-common.la</a></div><div>libtool:=
 install: warning: relinking `<a href=3D"http://liburcu.la">liburcu.la</a>&=
#39;</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu; /bin/sh /home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/libtool =A0--silent --tag CC --mode=3Drelink mips64-octeon-linu=
x-gnu-gcc -Wall -g -O2 -lpthread -version-info 3:0:0 -o <a href=3D"http://l=
iburcu.la">liburcu.la</a> -rpath /home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/urcu_install/lib urcu.lo urcu-pointer.lo <a href=3D"ht=
tp://liburcu-common.la">liburcu-common.la</a> )</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu.so.3.0.0T /home/sh=
kumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/lib=
urcu.so.3.0.0</div><div>libtool: install: (cd /home/shkumar/Development_Mer=
ge/NewOCT/userspace/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s -f li=
burcu.so.3.0.0 liburcu.so.3 || { rm -f liburcu.so.3 &amp;&amp; ln -s liburc=
u.so.3.0.0 liburcu.so.3; }; })</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s -f liburcu.so.3.0.0 libu=
rcu.so || { rm -f liburcu.so &amp;&amp; ln -s liburcu.so.3.0.0 liburcu.so; =
}; })</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu.lai /home/shkumar/=
Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/<a href=
=3D"http://liburcu.la">liburcu.la</a></div><div>libtool: install: warning: =
relinking `<a href=3D"http://liburcu-qsbr.la">liburcu-qsbr.la</a>&#39;</div=
>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu; /bin/sh /home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/libtool =A0--silent --tag CC --mode=3Drelink mips64-octeon-linu=
x-gnu-gcc -Wall -g -O2 -lpthread -version-info 3:0:0 -o <a href=3D"http://l=
iburcu-qsbr.la">liburcu-qsbr.la</a> -rpath /home/shkumar/Development_Merge/=
NewOCT/userspace/userspace-rcu/urcu_install/lib urcu-qsbr.lo urcu-pointer.l=
o <a href=3D"http://liburcu-common.la">liburcu-common.la</a> )</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.so.3.0.0T /ho=
me/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/li=
b/liburcu-qsbr.so.3.0.0</div><div>libtool: install: (cd /home/shkumar/Devel=
opment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib &amp;&amp; { l=
n -s -f liburcu-qsbr.so.3.0.0 liburcu-qsbr.so.3 || { rm -f liburcu-qsbr.so.=
3 &amp;&amp; ln -s liburcu-qsbr.so.3.0.0 liburcu-qsbr.so.3; }; })</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s -f liburcu-qsbr.so.3.0.0=
 liburcu-qsbr.so || { rm -f liburcu-qsbr.so &amp;&amp; ln -s liburcu-qsbr.s=
o.3.0.0 liburcu-qsbr.so; }; })</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.lai /home/shk=
umar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/<a h=
ref=3D"http://liburcu-qsbr.la">liburcu-qsbr.la</a></div><div>libtool: insta=
ll: warning: relinking `<a href=3D"http://liburcu-mb.la">liburcu-mb.la</a>&=
#39;</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu; /bin/sh /home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/libtool =A0--silent --tag CC --mode=3Drelink mips64-octeon-linu=
x-gnu-gcc -DRCU_MB -g -O2 -lpthread -version-info 3:0:0 -o <a href=3D"http:=
//liburcu-mb.la">liburcu-mb.la</a> -rpath /home/shkumar/Development_Merge/N=
ewOCT/userspace/userspace-rcu/urcu_install/lib liburcu_mb_la-urcu.lo liburc=
u_mb_la-urcu-pointer.lo <a href=3D"http://liburcu-common.la">liburcu-common=
.la</a> )</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-mb.so.3.0.0T /home=
/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/=
liburcu-mb.so.3.0.0</div><div>libtool: install: (cd /home/shkumar/Developme=
nt_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s=
 -f liburcu-mb.so.3.0.0 liburcu-mb.so.3 || { rm -f liburcu-mb.so.3 &amp;&am=
p; ln -s liburcu-mb.so.3.0.0 liburcu-mb.so.3; }; })</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s -f liburcu-mb.so.3.0.0 l=
iburcu-mb.so || { rm -f liburcu-mb.so &amp;&amp; ln -s liburcu-mb.so.3.0.0 =
liburcu-mb.so; }; })</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-mb.lai /home/shkum=
ar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/<a hre=
f=3D"http://liburcu-mb.la">liburcu-mb.la</a></div><div>libtool: install: wa=
rning: relinking `<a href=3D"http://liburcu-signal.la">liburcu-signal.la</a=
>&#39;</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu; /bin/sh /home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/libtool =A0--silent --tag CC --mode=3Drelink mips64-octeon-linu=
x-gnu-gcc -DRCU_SIGNAL -g -O2 -lpthread -version-info 3:0:0 -o <a href=3D"h=
ttp://liburcu-signal.la">liburcu-signal.la</a> -rpath /home/shkumar/Develop=
ment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib liburcu_signal_l=
a-urcu.lo liburcu_signal_la-urcu-pointer.lo <a href=3D"http://liburcu-commo=
n.la">liburcu-common.la</a> )</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-signal.so.3.0.0T /=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/=
lib/liburcu-signal.so.3.0.0</div><div>libtool: install: (cd /home/shkumar/D=
evelopment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib &amp;&amp;=
 { ln -s -f liburcu-signal.so.3.0.0 liburcu-signal.so.3 || { rm -f liburcu-=
signal.so.3 &amp;&amp; ln -s liburcu-signal.so.3.0.0 liburcu-signal.so.3; }=
; })</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s -f liburcu-signal.so.3.0=
.0 liburcu-signal.so || { rm -f liburcu-signal.so &amp;&amp; ln -s liburcu-=
signal.so.3.0.0 liburcu-signal.so; }; })</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-signal.lai /home/s=
hkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/<a=
 href=3D"http://liburcu-signal.la">liburcu-signal.la</a></div><div>libtool:=
 install: warning: relinking `<a href=3D"http://liburcu-bp.la">liburcu-bp.l=
a</a>&#39;</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu; /bin/sh /home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/libtool =A0--silent --tag CC --mode=3Drelink mips64-octeon-linu=
x-gnu-gcc -Wall -g -O2 -lpthread -version-info 3:0:0 -o <a href=3D"http://l=
iburcu-bp.la">liburcu-bp.la</a> -rpath /home/shkumar/Development_Merge/NewO=
CT/userspace/userspace-rcu/urcu_install/lib urcu-bp.lo urcu-pointer.lo <a h=
ref=3D"http://liburcu-common.la">liburcu-common.la</a> )</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-bp.so.3.0.0T /home=
/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/=
liburcu-bp.so.3.0.0</div><div>libtool: install: (cd /home/shkumar/Developme=
nt_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s=
 -f liburcu-bp.so.3.0.0 liburcu-bp.so.3 || { rm -f liburcu-bp.so.3 &amp;&am=
p; ln -s liburcu-bp.so.3.0.0 liburcu-bp.so.3; }; })</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s -f liburcu-bp.so.3.0.0 l=
iburcu-bp.so || { rm -f liburcu-bp.so &amp;&amp; ln -s liburcu-bp.so.3.0.0 =
liburcu-bp.so; }; })</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-bp.lai /home/shkum=
ar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/<a hre=
f=3D"http://liburcu-bp.la">liburcu-bp.la</a></div><div>libtool: install: wa=
rning: relinking `<a href=3D"http://liburcu-cds.la">liburcu-cds.la</a>&#39;=
</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu; /bin/sh /home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/libtool =A0--silent --tag CC --mode=3Drelink mips64-octeon-linu=
x-gnu-gcc -Wall -g -O2 -lpthread -version-info 3:0:0 -o <a href=3D"http://l=
iburcu-cds.la">liburcu-cds.la</a> -rpath /home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/urcu_install/lib rculfqueue.lo rculfstack.lo l=
fstack.lo rculfhash.lo rculfhash-mm-order.lo rculfhash-mm-chunk.lo rculfhas=
h-mm-mmap.lo <a href=3D"http://liburcu-common.la">liburcu-common.la</a> )</=
div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-cds.so.3.0.0T /hom=
e/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib=
/liburcu-cds.so.3.0.0</div><div>libtool: install: (cd /home/shkumar/Develop=
ment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib &amp;&amp; { ln =
-s -f liburcu-cds.so.3.0.0 liburcu-cds.so.3 || { rm -f liburcu-cds.so.3 &am=
p;&amp; ln -s liburcu-cds.so.3.0.0 liburcu-cds.so.3; }; })</div>
<div>libtool: install: (cd /home/shkumar/Development_Merge/NewOCT/userspace=
/userspace-rcu/urcu_install/lib &amp;&amp; { ln -s -f liburcu-cds.so.3.0.0 =
liburcu-cds.so || { rm -f liburcu-cds.so &amp;&amp; ln -s liburcu-cds.so.3.=
0.0 liburcu-cds.so; }; })</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-cds.lai /home/shku=
mar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/<a hr=
ef=3D"http://liburcu-cds.la">liburcu-cds.la</a></div><div>libtool: install:=
 /usr/bin/install -c .libs/liburcu-common.a /home/shkumar/Development_Merge=
/NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu-common.a</div>
<div>libtool: install: chmod 644 /home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/urcu_install/lib/liburcu-common.a</div><div>libtool: i=
nstall: mips64-octeon-linux-gnu-ranlib /home/shkumar/Development_Merge/NewO=
CT/userspace/userspace-rcu/urcu_install/lib/liburcu-common.a</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu.a /home/shkumar/De=
velopment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu.a</=
div><div>libtool: install: chmod 644 /home/shkumar/Development_Merge/NewOCT=
/userspace/userspace-rcu/urcu_install/lib/liburcu.a</div>
<div>libtool: install: mips64-octeon-linux-gnu-ranlib /home/shkumar/Develop=
ment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu.a</div><=
div>libtool: install: /usr/bin/install -c .libs/liburcu-qsbr.a /home/shkuma=
r/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu=
-qsbr.a</div>
<div>libtool: install: chmod 644 /home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/urcu_install/lib/liburcu-qsbr.a</div><div>libtool: ins=
tall: mips64-octeon-linux-gnu-ranlib /home/shkumar/Development_Merge/NewOCT=
/userspace/userspace-rcu/urcu_install/lib/liburcu-qsbr.a</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-mb.a /home/shkumar=
/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu-=
mb.a</div><div>libtool: install: chmod 644 /home/shkumar/Development_Merge/=
NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu-mb.a</div>
<div>libtool: install: mips64-octeon-linux-gnu-ranlib /home/shkumar/Develop=
ment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu-mb.a</di=
v><div>libtool: install: /usr/bin/install -c .libs/liburcu-signal.a /home/s=
hkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/li=
burcu-signal.a</div>
<div>libtool: install: chmod 644 /home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/urcu_install/lib/liburcu-signal.a</div><div>libtool: i=
nstall: mips64-octeon-linux-gnu-ranlib /home/shkumar/Development_Merge/NewO=
CT/userspace/userspace-rcu/urcu_install/lib/liburcu-signal.a</div>
<div>libtool: install: /usr/bin/install -c .libs/liburcu-bp.a /home/shkumar=
/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu-=
bp.a</div><div>libtool: install: chmod 644 /home/shkumar/Development_Merge/=
NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu-bp.a</div>
<div>libtool: install: mips64-octeon-linux-gnu-ranlib /home/shkumar/Develop=
ment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/liburcu-bp.a</di=
v><div>libtool: install: /usr/bin/install -c .libs/liburcu-cds.a /home/shku=
mar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/libur=
cu-cds.a</div>
<div>libtool: install: chmod 644 /home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/urcu_install/lib/liburcu-cds.a</div><div>libtool: inst=
all: mips64-octeon-linux-gnu-ranlib /home/shkumar/Development_Merge/NewOCT/=
userspace/userspace-rcu/urcu_install/lib/liburcu-cds.a</div>
<div>libtool: finish: PATH=3D&quot;/home/shkumar/Development_Merge/NewOCT/O=
CTEON_SDK/octeon_sdk/OCTEON-SDK/tools/bin:/home/shkumar/Development_Merge/N=
ewOCT/OCTEON_SDK/octeon_sdk/OCTEON-SDK/host/bin:/usr/bin:/bin:/usr/local/sb=
in:/usr/sbin:/sbin:/home/shkumar/bin:/sbin&quot; ldconfig -n /home/shkumar/=
Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib</div>
<div>----------------------------------------------------------------------=
</div><div>Libraries have been installed in:</div><div>=A0 =A0/home/shkumar=
/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib</div><di=
v>
<br></div><div>If you ever happen to want to link against installed librari=
es</div><div>in a given directory, LIBDIR, you must either use libtool, and=
</div><div>specify the full pathname of the library, or use the `-LLIBDIR&#=
39;</div>
<div>flag during linking and do at least one of the following:</div><div>=
=A0 =A0- add LIBDIR to the `LD_LIBRARY_PATH&#39; environment variable</div>=
<div>=A0 =A0 =A0during execution</div><div>=A0 =A0- add LIBDIR to the `LD_R=
UN_PATH&#39; environment variable</div>
<div>=A0 =A0 =A0during linking</div><div>=A0 =A0- use the `-Wl,-rpath -Wl,L=
IBDIR&#39; linker flag</div><div>=A0 =A0- have your system administrator ad=
d LIBDIR to `/etc/ld.so.conf&#39;</div><div><br></div><div>See any operatin=
g system documentation about shared libraries for</div>
<div>more information, such as the ld(1) and ld.so(8) manual pages.</div><d=
iv>----------------------------------------------------------------------</=
div><div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/use=
rspace-rcu/urcu_install/share/doc/userspace-rcu&quot; || /bin/mkdir -p &quo=
t;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_insta=
ll/share/doc/userspace-rcu&quot;</div>
<div>=A0/usr/bin/install -c -m 644 README ChangeLog &#39;/home/shkumar/Deve=
lopment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/share/doc/userspa=
ce-rcu&#39;</div><div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/=
userspace/userspace-rcu/urcu_install/include&quot; || /bin/mkdir -p &quot;/=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/=
include&quot;</div>
<div>=A0/usr/bin/install -c -m 644 urcu.h urcu-bp.h urcu-call-rcu.h urcu-de=
fer.h urcu-pointer.h urcu-qsbr.h urcu-flavor.h &#39;/home/shkumar/Developme=
nt_Merge/NewOCT/userspace/userspace-rcu/urcu_install/include&#39;</div><div=
>
test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/urcu_install/include&quot; || /bin/mkdir -p &quot;/home/shkumar/Developme=
nt_Merge/NewOCT/userspace/userspace-rcu/urcu_install/include&quot;</div>
<div>/bin/mkdir -p &#39;/home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/urcu_install/include/urcu/static&#39;</div><div>=A0/usr/bin/ins=
tall -c -m 644 =A0./urcu/static/lfstack.h ./urcu/static/rculfqueue.h ./urcu=
/static/rculfstack.h ./urcu/static/urcu-bp.h ./urcu/static/urcu.h ./urcu/st=
atic/urcu-pointer.h ./urcu/static/urcu-qsbr.h ./urcu/static/wfcqueue.h ./ur=
cu/static/wfqueue.h ./urcu/static/wfstack.h &#39;/home/shkumar/Development_=
Merge/NewOCT/userspace/userspace-rcu/urcu_install/include/urcu/static&#39;<=
/div>
<div>/bin/mkdir -p &#39;/home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/urcu_install/include/urcu/map&#39;</div><div>=A0/usr/bin/instal=
l -c -m 644 =A0./urcu/map/urcu-bp.h ./urcu/map/urcu.h ./urcu/map/urcu-qsbr.=
h &#39;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_=
install/include/urcu/map&#39;</div>
<div>/bin/mkdir -p &#39;/home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/urcu_install/include/urcu/arch&#39;</div><div>=A0/usr/bin/insta=
ll -c -m 644 =A0urcu/arch/generic.h &#39;/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/urcu_install/include/urcu/arch&#39;</div>
<div>/bin/mkdir -p &#39;/home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/urcu_install/include/urcu/uatomic&#39;</div><div>=A0/usr/bin/in=
stall -c -m 644 =A0urcu/uatomic/generic.h &#39;/home/shkumar/Development_Me=
rge/NewOCT/userspace/userspace-rcu/urcu_install/include/urcu/uatomic&#39;</=
div>
<div>/bin/mkdir -p &#39;/home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/urcu_install/include/urcu&#39;</div><div>=A0/usr/bin/install -c=
 -m 644 =A0urcu/compiler.h urcu/hlist.h urcu/list.h urcu/rculist.h urcu/rcu=
hlist.h urcu/system.h urcu/futex.h urcu/wfstack.h urcu/wfqueue.h urcu/rculf=
stack.h urcu/rculfqueue.h urcu/ref.h urcu/cds.h urcu/urcu_ref.h urcu/urcu-f=
utex.h urcu/uatomic_arch.h urcu/rculfhash.h urcu/wfcqueue.h urcu/lfstack.h =
urcu/tls-compat.h &#39;/home/shkumar/Development_Merge/NewOCT/userspace/use=
rspace-rcu/urcu_install/include/urcu&#39;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/include&quot; || /bin/mkdir -p &quot;/home/shkumar/Deve=
lopment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/include&quot;</di=
v>
<div>/bin/mkdir -p &#39;/home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/urcu_install/include/urcu&#39;</div><div>=A0/usr/bin/install -c=
 -m 644 =A0urcu/arch.h urcu/uatomic.h urcu/config.h &#39;/home/shkumar/Deve=
lopment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/include/urcu&#39;=
</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/lib/pkgconfig&quot; || /bin/mkdir -p &quot;/home/shkuma=
r/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/pkgconf=
ig&quot;</div>
<div>=A0/usr/bin/install -c -m 644 liburcu-cds.pc liburcu.pc liburcu-bp.pc =
liburcu-qsbr.pc liburcu-signal.pc liburcu-mb.pc &#39;/home/shkumar/Developm=
ent_Merge/NewOCT/userspace/userspace-rcu/urcu_install/lib/pkgconfig&#39;</d=
iv>
<div>make[2]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu&#39;</div><div>make[1]: Leaving directory `/home/shkum=
ar/Development_Merge/NewOCT/userspace/userspace-rcu&#39;</div><div>Making i=
nstall in doc</div>
<div>make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/doc&#39;</div><div>Making install in examples</div><d=
iv>make[2]: Entering directory `/home/shkumar/Development_Merge/NewOCT/user=
space/userspace-rcu/doc/examples&#39;</div>
<div>make -f dist-files/Makefile AM_CPPFLAGS=3D&quot; -I../../../urcu/ -I..=
/../../&quot; AM_CFLAGS=3D&#39;-g -O2&#39; AM_LDFLAGS=3D&#39; -L../../../.l=
ibs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/doc/examples/../../.libs/&quot;&#39; =A0all</div>
<div>make[3]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/doc/examples&#39;</div><div>make -C hlist</div><div>m=
ake[4]: Entering directory `/home/shkumar/Development_Merge/NewOCT/userspac=
e/userspace-rcu/doc/examples/hlist&#39;</div>
<div>make -f Makefile.cds_hlist_add_head_rcu</div><div>make[5]: Entering di=
rectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc=
/examples/hlist&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall =
-I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_hlist_ad=
d_head_rcu.o cds_hlist_add_head_rcu.c</div><div>mips64-octeon-linux-gnu-gcc=
 -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/=
Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&=
quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_hlist_add_h=
ead_rcu cds_hlist_add_head_rcu.o -lurcu</div><div>make[5]: Leaving director=
y `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examp=
les/hlist&#39;</div>
<div>make -f Makefile.cds_hlist_del_rcu</div><div>make[5]: Entering directo=
ry `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/exam=
ples/hlist&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../=
../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_hlist_de=
l_rcu.o cds_hlist_del_rcu.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -W=
all =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Developmen=
t_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</d=
iv>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_hlist_del_r=
cu cds_hlist_del_rcu.o -lurcu</div><div>make[5]: Leaving directory `/home/s=
hkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/hlist&=
#39;</div>
<div>make -f Makefile.cds_hlist_for_each_rcu</div><div>make[5]: Entering di=
rectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc=
/examples/hlist&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall =
-I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_hlist_fo=
r_each_rcu.o cds_hlist_for_each_rcu.c</div><div>mips64-octeon-linux-gnu-gcc=
 -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/=
Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&=
quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_hlist_for_e=
ach_rcu cds_hlist_for_each_rcu.o -lurcu</div><div>make[5]: Leaving director=
y `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examp=
les/hlist&#39;</div>
<div>make -f Makefile.cds_hlist_for_each_entry_rcu</div><div>make[5]: Enter=
ing directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-r=
cu/doc/examples/hlist&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 =
-Wall -I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_hlist_fo=
r_each_entry_rcu.o cds_hlist_for_each_entry_rcu.c</div><div>mips64-octeon-l=
inux-gnu-gcc -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/h=
ome/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/.=
./../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_hlist_for_e=
ach_entry_rcu cds_hlist_for_each_entry_rcu.o -lurcu</div><div>make[5]: Leav=
ing directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-r=
cu/doc/examples/hlist&#39;</div>
<div>make[4]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc/examples/hlist&#39;</div><div>make -C list</div><d=
iv>make[4]: Entering directory `/home/shkumar/Development_Merge/NewOCT/user=
space/userspace-rcu/doc/examples/list&#39;</div>
<div>make -f Makefile.cds_list_add_rcu</div><div>make[5]: Entering director=
y `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examp=
les/list&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../..=
/../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_list_add=
_rcu.o cds_list_add_rcu.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wal=
l =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_=
Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div=
>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_list_add_rc=
u cds_list_add_rcu.o -lurcu</div><div>make[5]: Leaving directory `/home/shk=
umar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/list&#39=
;</div>
<div>make -f Makefile.cds_list_add_tail_rcu</div><div>make[5]: Entering dir=
ectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/=
examples/list&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I=
../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_list_add=
_tail_rcu.o cds_list_add_tail_rcu.c</div><div>mips64-octeon-linux-gnu-gcc -=
g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/De=
velopment_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&qu=
ot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_list_add_ta=
il_rcu cds_list_add_tail_rcu.o -lurcu</div><div>make[5]: Leaving directory =
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list&#39;</div>
<div>make -f Makefile.cds_list_del_rcu</div><div>make[5]: Entering director=
y `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examp=
les/list&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../..=
/../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_list_del=
_rcu.o cds_list_del_rcu.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wal=
l =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_=
Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div=
>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_list_del_rc=
u cds_list_del_rcu.o -lurcu</div><div>make[5]: Leaving directory `/home/shk=
umar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/list&#39=
;</div>
<div>make -f Makefile.cds_list_for_each_rcu</div><div>make[5]: Entering dir=
ectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/=
examples/list&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I=
../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_list_for=
_each_rcu.o cds_list_for_each_rcu.c</div><div>mips64-octeon-linux-gnu-gcc -=
g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/De=
velopment_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&qu=
ot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_list_for_ea=
ch_rcu cds_list_for_each_rcu.o -lurcu</div><div>make[5]: Leaving directory =
`/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/example=
s/list&#39;</div>
<div>make -f Makefile.cds_list_for_each_entry_rcu</div><div>make[5]: Enteri=
ng directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/list&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -W=
all -I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_list_for=
_each_entry_rcu.o cds_list_for_each_entry_rcu.c</div><div>mips64-octeon-lin=
ux-gnu-gcc -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/hom=
e/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../=
../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_list_for_ea=
ch_entry_rcu cds_list_for_each_entry_rcu.o -lurcu</div><div>make[5]: Leavin=
g directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu=
/doc/examples/list&#39;</div>
<div>make -f Makefile.cds_list_replace_rcu</div><div>make[5]: Entering dire=
ctory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/e=
xamples/list&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I.=
./../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_list_rep=
lace_rcu.o cds_list_replace_rcu.c</div><div>mips64-octeon-linux-gnu-gcc -g =
-O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Deve=
lopment_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot=
; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_list_replac=
e_rcu cds_list_replace_rcu.o -lurcu</div><div>make[5]: Leaving directory `/=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/=
list&#39;</div>
<div>make[4]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc/examples/list&#39;</div><div>make -C urcu-flavors<=
/div><div>make[4]: Entering directory `/home/shkumar/Development_Merge/NewO=
CT/userspace/userspace-rcu/doc/examples/urcu-flavors&#39;</div>
<div>make -f Makefile.qsbr</div><div>make[5]: Entering directory `/home/shk=
umar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/urcu-fla=
vors&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../../../=
urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o qsbr.o qsbr.=
c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g -O2 -L../../../.=
libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/NewOCT/userspace/u=
serspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o qsbr qsbr.o -lu=
rcu-qsbr</div><div>make[5]: Leaving directory `/home/shkumar/Development_Me=
rge/NewOCT/userspace/userspace-rcu/doc/examples/urcu-flavors&#39;</div><div=
>
make -f Makefile.mb</div><div>make[5]: Entering directory `/home/shkumar/De=
velopment_Merge/NewOCT/userspace/userspace-rcu/doc/examples/urcu-flavors&#3=
9;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../../../urcu/ -=
I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o mb.o mb.c</d=
iv><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g -O2 -L../../../.libs=
/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/NewOCT/userspace/users=
pace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o mb mb.o -lurcu-=
mb</div><div>make[5]: Leaving directory `/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/doc/examples/urcu-flavors&#39;</div><div>make =
-f Makefile.membarrier</div>
<div>make[5]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/doc/examples/urcu-flavors&#39;</div><div>mips64-octeo=
n-linux-gnu-gcc =A0-g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o membarrier.o=
 membarrier.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g -O2 =
-L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/NewOCT=
/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o membarrier memb=
arrier.o -lurcu</div><div>make[5]: Leaving directory `/home/shkumar/Develop=
ment_Merge/NewOCT/userspace/userspace-rcu/doc/examples/urcu-flavors&#39;</d=
iv>
<div>make -f Makefile.signal</div><div>make[5]: Entering directory `/home/s=
hkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/urcu-f=
lavors&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../../.=
./urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o signal.o sig=
nal.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g -O2 -L../../=
../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/NewOCT/userspa=
ce/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o signal signal.o=
 -lurcu-signal</div><div>make[5]: Leaving directory `/home/shkumar/Developm=
ent_Merge/NewOCT/userspace/userspace-rcu/doc/examples/urcu-flavors&#39;</di=
v>
<div>make -f Makefile.bp</div><div>make[5]: Entering directory `/home/shkum=
ar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/urcu-flavo=
rs&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../../../ur=
cu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o bp.o bp.c</d=
iv><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g -O2 -L../../../.libs=
/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/NewOCT/userspace/users=
pace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o bp bp.o -lurcu-=
bp</div><div>make[5]: Leaving directory `/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/doc/examples/urcu-flavors&#39;</div><div>make[=
4]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/userspace/use=
rspace-rcu/doc/examples/urcu-flavors&#39;</div>
<div>make -C wfcqueue</div><div>make[4]: Entering directory `/home/shkumar/=
Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/wfcqueue&#39;=
</div><div>make -f Makefile.cds_wfcq_enqueue</div><div>make[5]: Entering di=
rectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc=
/examples/wfcqueue&#39;</div>
<div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../../../urcu/ -I../../.=
./ -g -O2 \</div><div><span class=3D"" style=3D"white-space:pre">		</span>-=
c -o cds_wfcq_enqueue.o cds_wfcq_enqueue.c</div><div>mips64-octeon-linux-gn=
u-gcc -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shk=
umar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.l=
ibs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_wfcq_enqueu=
e cds_wfcq_enqueue.o -lurcu-common</div><div>make[5]: Leaving directory `/h=
ome/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/w=
fcqueue&#39;</div>
<div>make -f Makefile.cds_wfcq_dequeue</div><div>make[5]: Entering director=
y `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examp=
les/wfcqueue&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I.=
./../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_wfcq_deq=
ueue.o cds_wfcq_dequeue.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wal=
l =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_=
Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div=
>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_wfcq_dequeu=
e cds_wfcq_dequeue.o -lurcu-common</div><div>make[5]: Leaving directory `/h=
ome/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/w=
fcqueue&#39;</div>
<div>make -f Makefile.cds_wfcq_splice</div><div>make[5]: Entering directory=
 `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/exampl=
es/wfcqueue&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I..=
/../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_wfcq_spl=
ice.o cds_wfcq_splice.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =
=A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Me=
rge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_wfcq_splice=
 cds_wfcq_splice.o -lurcu-common</div><div>make[5]: Leaving directory `/hom=
e/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/wfc=
queue&#39;</div>
<div>make[4]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc/examples/wfcqueue&#39;</div><div>make -C rculfqueu=
e</div><div>make[4]: Entering directory `/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/doc/examples/rculfqueue&#39;</div>
<div>make -f Makefile.cds_lfq_enqueue</div><div>make[5]: Entering directory=
 `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/exampl=
es/rculfqueue&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I=
../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfq_enqu=
eue.o cds_lfq_enqueue.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =
=A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Me=
rge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfq_enqueue=
 cds_lfq_enqueue.o -lurcu-cds -lurcu</div><div>make[5]: Leaving directory `=
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples=
/rculfqueue&#39;</div>
<div>make -f Makefile.cds_lfq_dequeue</div><div>make[5]: Entering directory=
 `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/exampl=
es/rculfqueue&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I=
../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfq_dequ=
eue.o cds_lfq_dequeue.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =
=A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Me=
rge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfq_dequeue=
 cds_lfq_dequeue.o -lurcu-cds -lurcu</div><div>make[5]: Leaving directory `=
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples=
/rculfqueue&#39;</div>
<div>make[4]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc/examples/rculfqueue&#39;</div><div>make -C wfstack=
</div><div>make[4]: Entering directory `/home/shkumar/Development_Merge/New=
OCT/userspace/userspace-rcu/doc/examples/wfstack&#39;</div>
<div>make -f Makefile.cds_wfs_push</div><div>make[5]: Entering directory `/=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/=
wfstack&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../../=
../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_wfs_push=
.o cds_wfs_push.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g =
-O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_wfs_push cd=
s_wfs_push.o -lurcu-common</div><div>make[5]: Leaving directory `/home/shku=
mar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/wfstack&#=
39;</div>
<div>make -f Makefile.cds_wfs_pop</div><div>make[5]: Entering directory `/h=
ome/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/w=
fstack&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../../.=
./urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_wfs_pop.=
o cds_wfs_pop.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g -O=
2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/NewO=
CT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_wfs_pop cds=
_wfs_pop.o -lurcu-common</div><div>make[5]: Leaving directory `/home/shkuma=
r/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/wfstack&#39=
;</div>
<div>make -f Makefile.cds_wfs_pop_all_blocking</div><div>make[5]: Entering =
directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/d=
oc/examples/wfstack&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -W=
all -I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_wfs_pop_=
all_blocking.o cds_wfs_pop_all_blocking.c</div><div>mips64-octeon-linux-gnu=
-gcc -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shku=
mar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.li=
bs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_wfs_pop_all=
_blocking cds_wfs_pop_all_blocking.o -lurcu-common</div><div>make[5]: Leavi=
ng directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rc=
u/doc/examples/wfstack&#39;</div>
<div>make[4]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc/examples/wfstack&#39;</div><div>make -C lfstack</d=
iv><div>make[4]: Entering directory `/home/shkumar/Development_Merge/NewOCT=
/userspace/userspace-rcu/doc/examples/lfstack&#39;</div>
<div>make -f Makefile.cds_lfs_push</div><div>make[5]: Entering directory `/=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/=
lfstack&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../../=
../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfs_push=
.o cds_lfs_push.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g =
-O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfs_push cd=
s_lfs_push.o -lurcu-cds</div><div>make[5]: Leaving directory `/home/shkumar=
/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/lfstack&#39;=
</div>
<div>make -f Makefile.cds_lfs_pop_blocking</div><div>make[5]: Entering dire=
ctory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/e=
xamples/lfstack&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall =
-I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfs_pop_=
blocking.o cds_lfs_pop_blocking.c</div><div>mips64-octeon-linux-gnu-gcc -g =
-O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Deve=
lopment_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot=
; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfs_pop_blo=
cking cds_lfs_pop_blocking.o -lurcu-cds</div><div>make[5]: Leaving director=
y `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examp=
les/lfstack&#39;</div>
<div>make -f Makefile.cds_lfs_pop_all_blocking</div><div>make[5]: Entering =
directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/d=
oc/examples/lfstack&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -W=
all -I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfs_pop_=
all_blocking.o cds_lfs_pop_all_blocking.c</div><div>mips64-octeon-linux-gnu=
-gcc -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shku=
mar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.li=
bs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfs_pop_all=
_blocking cds_lfs_pop_all_blocking.o -lurcu-cds</div><div>make[5]: Leaving =
directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/d=
oc/examples/lfstack&#39;</div>
<div>make[4]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc/examples/lfstack&#39;</div><div>make -C rculfhash<=
/div><div>make[4]: Entering directory `/home/shkumar/Development_Merge/NewO=
CT/userspace/userspace-rcu/doc/examples/rculfhash&#39;</div>
<div>make -f Makefile.cds_lfht_add</div><div>make[5]: Entering directory `/=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/=
rculfhash&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../.=
./../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfht_add=
.o cds_lfht_add.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g =
-O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfht_add cd=
s_lfht_add.o -lurcu-cds -lurcu</div><div>make[5]: Leaving directory `/home/=
shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/rculf=
hash&#39;</div>
<div>make -f Makefile.cds_lfht_add_unique</div><div>make[5]: Entering direc=
tory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/ex=
amples/rculfhash&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall=
 -I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfht_add=
_unique.o cds_lfht_add_unique.c</div><div>mips64-octeon-linux-gnu-gcc -g -O=
2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Develo=
pment_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; =
\</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfht_add_un=
ique cds_lfht_add_unique.o -lurcu-cds -lurcu</div><div>make[5]: Leaving dir=
ectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/=
examples/rculfhash&#39;</div>
<div>make -f Makefile.cds_lfht_add_replace</div><div>make[5]: Entering dire=
ctory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/e=
xamples/rculfhash&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wal=
l -I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfht_add=
_replace.o cds_lfht_add_replace.c</div><div>mips64-octeon-linux-gnu-gcc -g =
-O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Deve=
lopment_Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot=
; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfht_add_re=
place cds_lfht_add_replace.o -lurcu-cds -lurcu</div><div>make[5]: Leaving d=
irectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/do=
c/examples/rculfhash&#39;</div>
<div>make -f Makefile.cds_lfht_del</div><div>make[5]: Entering directory `/=
home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/=
rculfhash&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I../.=
./../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfht_del=
.o cds_lfht_del.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g =
-O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/Ne=
wOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfht_del cd=
s_lfht_del.o -lurcu-cds -lurcu</div><div>make[5]: Leaving directory `/home/=
shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples/rculf=
hash&#39;</div>
<div>make -f Makefile.cds_lfht_destroy</div><div>make[5]: Entering director=
y `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examp=
les/rculfhash&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I=
../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfht_des=
troy.o cds_lfht_destroy.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wal=
l =A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_=
Merge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div=
>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfht_destro=
y cds_lfht_destroy.o -lurcu-cds -lurcu</div><div>make[5]: Leaving directory=
 `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/exampl=
es/rculfhash&#39;</div>
<div>make -f Makefile.cds_lfht_lookup</div><div>make[5]: Entering directory=
 `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/exampl=
es/rculfhash&#39;</div><div>mips64-octeon-linux-gnu-gcc =A0-g -O2 -Wall -I.=
./../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfht_loo=
kup.o cds_lfht_lookup.c</div><div>mips64-octeon-linux-gnu-gcc -g -O2 -Wall =
=A0-g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/shkumar/Development_Me=
rge/NewOCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfht_lookup=
 cds_lfht_lookup.o -lurcu-cds -lurcu</div><div>make[5]: Leaving directory `=
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/examples=
/rculfhash&#39;</div>
<div>make -f Makefile.cds_lfht_for_each_entry_duplicate</div><div>make[5]: =
Entering directory `/home/shkumar/Development_Merge/NewOCT/userspace/usersp=
ace-rcu/doc/examples/rculfhash&#39;</div><div>mips64-octeon-linux-gnu-gcc =
=A0-g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-c -o cds_lfht_for=
_each_entry_duplicate.o cds_lfht_for_each_entry_duplicate.c</div><div>mips6=
4-octeon-linux-gnu-gcc -g -O2 -Wall =A0-g -O2 -L../../../.libs/ -Wl,-rpath=
=3D&quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc=
/examples/../../.libs/&quot; \</div>
<div><span class=3D"" style=3D"white-space:pre">		</span>-o cds_lfht_for_ea=
ch_entry_duplicate cds_lfht_for_each_entry_duplicate.o -lurcu-cds -lurcu</d=
iv><div>make[5]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/=
userspace/userspace-rcu/doc/examples/rculfhash&#39;</div>
<div>make[4]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc/examples/rculfhash&#39;</div><div>make[3]: Leaving=
 directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/=
doc/examples&#39;</div>
<div>make[3]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/doc/examples&#39;</div><div>make[3]: Nothing to be do=
ne for `install-exec-am&#39;.</div><div>test -z &quot;/home/shkumar/Develop=
ment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/share/doc/userspace-=
rcu/examples&quot; || /bin/mkdir -p &quot;/home/shkumar/Development_Merge/N=
ewOCT/userspace/userspace-rcu/urcu_install/share/doc/userspace-rcu/examples=
&quot;</div>
<div>=A0/usr/bin/install -c -m 644 dist-files/Makefile Makefile.examples.te=
mplate &#39;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/=
urcu_install/share/doc/userspace-rcu/examples&#39;</div><div>test -z &quot;=
/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install=
/share/doc/userspace-rcu/examples/hlist&quot; || /bin/mkdir -p &quot;/home/=
shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/share=
/doc/userspace-rcu/examples/hlist&quot;</div>
<div>=A0/usr/bin/install -c -m 644 hlist/Makefile hlist/Makefile.cds_hlist_=
add_head_rcu hlist/Makefile.cds_hlist_del_rcu hlist/Makefile.cds_hlist_for_=
each_rcu hlist/Makefile.cds_hlist_for_each_entry_rcu hlist/cds_hlist_add_he=
ad_rcu.c hlist/cds_hlist_del_rcu.c hlist/cds_hlist_for_each_rcu.c hlist/cds=
_hlist_for_each_entry_rcu.c &#39;/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/urcu_install/share/doc/userspace-rcu/examples/hlist&#3=
9;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/share/doc/userspace-rcu/examples/lfstack&quot; || /bin/=
mkdir -p &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-r=
cu/urcu_install/share/doc/userspace-rcu/examples/lfstack&quot;</div>
<div>=A0/usr/bin/install -c -m 644 lfstack/Makefile lfstack/Makefile.cds_lf=
s_push lfstack/Makefile.cds_lfs_pop_blocking lfstack/Makefile.cds_lfs_pop_a=
ll_blocking lfstack/cds_lfs_push.c lfstack/cds_lfs_pop_blocking.c lfstack/c=
ds_lfs_pop_all_blocking.c &#39;/home/shkumar/Development_Merge/NewOCT/users=
pace/userspace-rcu/urcu_install/share/doc/userspace-rcu/examples/lfstack&#3=
9;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/share/doc/userspace-rcu/examples/list&quot; || /bin/mkd=
ir -p &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/=
urcu_install/share/doc/userspace-rcu/examples/list&quot;</div>
<div>=A0/usr/bin/install -c -m 644 list/Makefile list/Makefile.cds_list_add=
_rcu list/Makefile.cds_list_add_tail_rcu list/Makefile.cds_list_del_rcu lis=
t/Makefile.cds_list_for_each_rcu list/Makefile.cds_list_for_each_entry_rcu =
list/Makefile.cds_list_replace_rcu list/cds_list_add_rcu.c list/cds_list_ad=
d_tail_rcu.c list/cds_list_del_rcu.c list/cds_list_for_each_rcu.c list/cds_=
list_for_each_entry_rcu.c list/cds_list_replace_rcu.c &#39;/home/shkumar/De=
velopment_Merge/NewOCT/userspace/userspace-rcu/urcu_install/share/doc/users=
pace-rcu/examples/list&#39;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/share/doc/userspace-rcu/examples/rculfhash&quot; || /bi=
n/mkdir -p &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace=
-rcu/urcu_install/share/doc/userspace-rcu/examples/rculfhash&quot;</div>
<div>=A0/usr/bin/install -c -m 644 rculfhash/Makefile rculfhash/jhash.h rcu=
lfhash/Makefile.cds_lfht_add rculfhash/Makefile.cds_lfht_add_unique rculfha=
sh/Makefile.cds_lfht_add_replace rculfhash/Makefile.cds_lfht_del rculfhash/=
Makefile.cds_lfht_destroy rculfhash/Makefile.cds_lfht_lookup rculfhash/Make=
file.cds_lfht_for_each_entry_duplicate rculfhash/cds_lfht_add.c rculfhash/c=
ds_lfht_add_unique.c rculfhash/cds_lfht_add_replace.c rculfhash/cds_lfht_de=
l.c rculfhash/cds_lfht_destroy.c rculfhash/cds_lfht_lookup.c rculfhash/cds_=
lfht_for_each_entry_duplicate.c &#39;/home/shkumar/Development_Merge/NewOCT=
/userspace/userspace-rcu/urcu_install/share/doc/userspace-rcu/examples/rcul=
fhash&#39;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/share/doc/userspace-rcu/examples/rculfqueue&quot; || /b=
in/mkdir -p &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspac=
e-rcu/urcu_install/share/doc/userspace-rcu/examples/rculfqueue&quot;</div>
<div>=A0/usr/bin/install -c -m 644 rculfqueue/Makefile rculfqueue/Makefile.=
cds_lfq_enqueue rculfqueue/Makefile.cds_lfq_dequeue rculfqueue/cds_lfq_enqu=
eue.c rculfqueue/cds_lfq_dequeue.c &#39;/home/shkumar/Development_Merge/New=
OCT/userspace/userspace-rcu/urcu_install/share/doc/userspace-rcu/examples/r=
culfqueue&#39;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/share/doc/userspace-rcu/examples/urcu-flavors&quot; || =
/bin/mkdir -p &quot;/home/shkumar/Development_Merge/NewOCT/userspace/usersp=
ace-rcu/urcu_install/share/doc/userspace-rcu/examples/urcu-flavors&quot;</d=
iv>
<div>=A0/usr/bin/install -c -m 644 urcu-flavors/Makefile urcu-flavors/Makef=
ile.qsbr urcu-flavors/Makefile.mb urcu-flavors/Makefile.membarrier urcu-fla=
vors/Makefile.signal urcu-flavors/Makefile.bp urcu-flavors/qsbr.c urcu-flav=
ors/mb.c urcu-flavors/membarrier.c urcu-flavors/signal.c urcu-flavors/bp.c =
&#39;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_in=
stall/share/doc/userspace-rcu/examples/urcu-flavors&#39;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/share/doc/userspace-rcu/examples/wfcqueue&quot; || /bin=
/mkdir -p &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-=
rcu/urcu_install/share/doc/userspace-rcu/examples/wfcqueue&quot;</div>
<div>=A0/usr/bin/install -c -m 644 wfcqueue/Makefile wfcqueue/Makefile.cds_=
wfcq_enqueue wfcqueue/Makefile.cds_wfcq_dequeue wfcqueue/Makefile.cds_wfcq_=
splice wfcqueue/cds_wfcq_enqueue.c wfcqueue/cds_wfcq_dequeue.c wfcqueue/cds=
_wfcq_splice.c &#39;/home/shkumar/Development_Merge/NewOCT/userspace/usersp=
ace-rcu/urcu_install/share/doc/userspace-rcu/examples/wfcqueue&#39;</div>
<div>test -z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/urcu_install/share/doc/userspace-rcu/examples/wfstack&quot; || /bin/=
mkdir -p &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-r=
cu/urcu_install/share/doc/userspace-rcu/examples/wfstack&quot;</div>
<div>=A0/usr/bin/install -c -m 644 wfstack/Makefile wfstack/Makefile.cds_wf=
s_push wfstack/Makefile.cds_wfs_pop wfstack/Makefile.cds_wfs_pop_all_blocki=
ng wfstack/cds_wfs_push.c wfstack/cds_wfs_pop.c wfstack/cds_wfs_pop_all_blo=
cking.c &#39;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu=
/urcu_install/share/doc/userspace-rcu/examples/wfstack&#39;</div>
<div>make[3]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc/examples&#39;</div><div>make[2]: Leaving directory=
 `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc/exampl=
es&#39;</div>
<div>make[2]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/doc&#39;</div><div>make[3]: Entering directory `/home=
/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc&#39;</div>
<div>make[3]: Nothing to be done for `install-exec-am&#39;.</div><div>test =
-z &quot;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urc=
u_install/share/doc/userspace-rcu&quot; || /bin/mkdir -p &quot;/home/shkuma=
r/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_install/share/doc/u=
serspace-rcu&quot;</div>
<div>=A0/usr/bin/install -c -m 644 rcu-api.txt cds-api.txt uatomic-api.txt =
&#39;/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/urcu_in=
stall/share/doc/userspace-rcu&#39;</div><div>make[3]: Leaving directory `/h=
ome/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc&#39;</div>
<div>make[2]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/doc&#39;</div><div>make[1]: Leaving directory `/home/s=
hkumar/Development_Merge/NewOCT/userspace/userspace-rcu/doc&#39;</div><div>
Making install in tests</div><div>make[1]: Entering directory `/home/shkuma=
r/Development_Merge/NewOCT/userspace/userspace-rcu/tests&#39;</div><div>Mak=
ing install in common</div><div>make[2]: Entering directory `/home/shkumar/=
Development_Merge/NewOCT/userspace/userspace-rcu/tests/common&#39;</div>
<div>make[3]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/tests/common&#39;</div><div>make[3]: Nothing to be do=
ne for `install-exec-am&#39;.</div><div>make[3]: Nothing to be done for `in=
stall-data-am&#39;.</div>
<div>make[3]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/tests/common&#39;</div><div>make[2]: Leaving directory=
 `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/comm=
on&#39;</div>
<div>Making install in unit</div><div>make[2]: Entering directory `/home/sh=
kumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/unit&#39;</div=
><div>=A0 CC =A0 =A0 test_uatomic.o</div><div>=A0 CCLD =A0 test_uatomic</di=
v><div>
=A0 CC =A0 =A0 test_urcu_multiflavor.o</div><div>=A0 CC =A0 =A0 test_urcu_m=
ultiflavor-memb.o</div><div>=A0 CC =A0 =A0 test_urcu_multiflavor-mb.o</div>=
<div>=A0 CC =A0 =A0 test_urcu_multiflavor-signal.o</div><div>=A0 CC =A0 =A0=
 test_urcu_multiflavor-qsbr.o</div>
<div>=A0 CC =A0 =A0 test_urcu_multiflavor-bp.o</div><div>=A0 CCLD =A0 test_=
urcu_multiflavor</div><div>=A0 CC =A0 =A0 test_urcu_multiflavor_dynlink-tes=
t_urcu_multiflavor.o</div><div>=A0 CC =A0 =A0 test_urcu_multiflavor_dynlink=
-test_urcu_multiflavor-memb.o</div>
<div>=A0 CC =A0 =A0 test_urcu_multiflavor_dynlink-test_urcu_multiflavor-mb.=
o</div><div>=A0 CC =A0 =A0 test_urcu_multiflavor_dynlink-test_urcu_multifla=
vor-signal.o</div><div>=A0 CC =A0 =A0 test_urcu_multiflavor_dynlink-test_ur=
cu_multiflavor-qsbr.o</div>
<div>=A0 CC =A0 =A0 test_urcu_multiflavor_dynlink-test_urcu_multiflavor-bp.=
o</div><div>=A0 CCLD =A0 test_urcu_multiflavor_dynlink</div><div>make[3]: E=
ntering directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspa=
ce-rcu/tests/unit&#39;</div>
<div>make[3]: Nothing to be done for `install-exec-am&#39;.</div><div>make[=
3]: Nothing to be done for `install-data-am&#39;.</div><div>make[3]: Leavin=
g directory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu=
/tests/unit&#39;</div>
<div>make[2]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/tests/unit&#39;</div><div>Making install in benchmark<=
/div><div>make[2]: Entering directory `/home/shkumar/Development_Merge/NewO=
CT/userspace/userspace-rcu/tests/benchmark&#39;</div>
<div>=A0 CC =A0 =A0 test_urcu.o</div><div>=A0 CC =A0 =A0 urcu.o</div><div>=
=A0 CC =A0 =A0 urcu-pointer.o</div><div>=A0 CC =A0 =A0 wfcqueue.o</div><div=
>=A0 CCLD =A0 test_urcu</div><div>=A0 CC =A0 =A0 test_urcu_dynamic_link-tes=
t_urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_dynamic_link-urcu.o</div>
<div>=A0 CC =A0 =A0 test_urcu_dynamic_link-urcu-pointer.o</div><div>=A0 CC =
=A0 =A0 test_urcu_dynamic_link-wfcqueue.o</div><div>=A0 CCLD =A0 test_urcu_=
dynamic_link</div><div>=A0 CC =A0 =A0 test_urcu_timing.o</div><div>=A0 CCLD=
 =A0 test_urcu_timing</div>
<div>=A0 CC =A0 =A0 test_urcu_signal-test_urcu.o</div><div>=A0 CC =A0 =A0 t=
est_urcu_signal-urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_signal-urcu-point=
er.o</div><div>=A0 CC =A0 =A0 test_urcu_signal-wfcqueue.o</div><div>=A0 CCL=
D =A0 test_urcu_signal</div>
<div>=A0 CC =A0 =A0 test_urcu_signal_dynamic_link-test_urcu.o</div><div>=A0=
 CC =A0 =A0 test_urcu_signal_dynamic_link-urcu.o</div><div>=A0 CC =A0 =A0 t=
est_urcu_signal_dynamic_link-urcu-pointer.o</div><div>=A0 CC =A0 =A0 test_u=
rcu_signal_dynamic_link-wfcqueue.o</div>
<div>=A0 CCLD =A0 test_urcu_signal_dynamic_link</div><div>=A0 CC =A0 =A0 te=
st_urcu_signal_timing-test_urcu_timing.o</div><div>=A0 CC =A0 =A0 test_urcu=
_signal_timing-urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_signal_timing-urcu=
-pointer.o</div><div>
=A0 CC =A0 =A0 test_urcu_signal_timing-wfcqueue.o</div><div>=A0 CCLD =A0 te=
st_urcu_signal_timing</div><div>=A0 CC =A0 =A0 test_rwlock_timing.o</div><d=
iv>=A0 CCLD =A0 test_rwlock_timing</div><div>=A0 CC =A0 =A0 test_rwlock.o</=
div><div>=A0 CCLD =A0 test_rwlock</div>
<div>=A0 CC =A0 =A0 test_perthreadlock_timing.o</div><div>=A0 CCLD =A0 test=
_perthreadlock_timing</div><div>=A0 CC =A0 =A0 test_perthreadlock.o</div><d=
iv>=A0 CCLD =A0 test_perthreadlock</div><div>=A0 CC =A0 =A0 test_urcu_yield=
-test_urcu.o</div><div>
=A0 CC =A0 =A0 test_urcu_yield-urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_yi=
eld-urcu-pointer.o</div><div>=A0 CC =A0 =A0 test_urcu_yield-wfcqueue.o</div=
><div>=A0 CCLD =A0 test_urcu_yield</div><div>=A0 CC =A0 =A0 test_urcu_signa=
l_yield-test_urcu.o</div>
<div>=A0 CC =A0 =A0 test_urcu_signal_yield-urcu.o</div><div>=A0 CC =A0 =A0 =
test_urcu_signal_yield-urcu-pointer.o</div><div>=A0 CC =A0 =A0 test_urcu_si=
gnal_yield-wfcqueue.o</div><div>=A0 CCLD =A0 test_urcu_signal_yield</div><d=
iv>=A0 CC =A0 =A0 test_urcu_mb-test_urcu.o</div>
<div>=A0 CC =A0 =A0 test_urcu_mb-urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_=
mb-urcu-pointer.o</div><div>=A0 CC =A0 =A0 test_urcu_mb-wfcqueue.o</div><di=
v>=A0 CCLD =A0 test_urcu_mb</div><div>=A0 CC =A0 =A0 test_urcu_qsbr_timing.=
o</div><div>=A0 CC =A0 =A0 urcu-qsbr.o</div>
<div>=A0 CCLD =A0 test_urcu_qsbr_timing</div><div>=A0 CC =A0 =A0 test_urcu_=
qsbr.o</div><div>=A0 CCLD =A0 test_urcu_qsbr</div><div>=A0 CC =A0 =A0 test_=
mutex.o</div><div>=A0 CCLD =A0 test_mutex</div><div>=A0 CC =A0 =A0 test_loo=
plen.o</div><div>=A0 CCLD =A0 test_looplen</div>
<div>=A0 CC =A0 =A0 test_urcu_gc.o</div><div>=A0 CCLD =A0 test_urcu_gc</div=
><div>=A0 CC =A0 =A0 test_urcu_signal_gc-test_urcu_gc.o</div><div>=A0 CC =
=A0 =A0 test_urcu_signal_gc-urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_signa=
l_gc-urcu-pointer.o</div><div>
=A0 CC =A0 =A0 test_urcu_signal_gc-wfcqueue.o</div><div>=A0 CCLD =A0 test_u=
rcu_signal_gc</div><div>=A0 CC =A0 =A0 test_urcu_lgc-test_urcu_gc.o</div><d=
iv>=A0 CC =A0 =A0 test_urcu_lgc-urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_l=
gc-urcu-pointer.o</div><div>
=A0 CC =A0 =A0 test_urcu_lgc-wfcqueue.o</div><div>=A0 CCLD =A0 test_urcu_lg=
c</div><div>=A0 CC =A0 =A0 test_urcu_mb_gc-test_urcu_gc.o</div><div>=A0 CC =
=A0 =A0 test_urcu_mb_gc-urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_mb_gc-urc=
u-pointer.o</div><div>=A0 CC =A0 =A0 test_urcu_mb_gc-wfcqueue.o</div>
<div>=A0 CCLD =A0 test_urcu_mb_gc</div><div>=A0 CC =A0 =A0 test_urcu_qsbr_g=
c.o</div><div>=A0 CCLD =A0 test_urcu_qsbr_gc</div><div>=A0 CC =A0 =A0 test_=
urcu_qsbr_lgc-test_urcu_qsbr_gc.o</div><div>=A0 CC =A0 =A0 test_urcu_qsbr_l=
gc-urcu-qsbr.o</div><div>
=A0 CC =A0 =A0 test_urcu_qsbr_lgc-urcu-pointer.o</div><div>=A0 CC =A0 =A0 t=
est_urcu_qsbr_lgc-wfcqueue.o</div><div>=A0 CCLD =A0 test_urcu_qsbr_lgc</div=
><div>=A0 CC =A0 =A0 test_urcu_signal_lgc-test_urcu_gc.o</div><div>=A0 CC =
=A0 =A0 test_urcu_signal_lgc-urcu.o</div>
<div>=A0 CC =A0 =A0 test_urcu_signal_lgc-urcu-pointer.o</div><div>=A0 CC =
=A0 =A0 test_urcu_signal_lgc-wfcqueue.o</div><div>=A0 CCLD =A0 test_urcu_si=
gnal_lgc</div><div>=A0 CC =A0 =A0 test_urcu_mb_lgc-test_urcu_gc.o</div><div=
>=A0 CC =A0 =A0 test_urcu_mb_lgc-urcu.o</div>
<div>=A0 CC =A0 =A0 test_urcu_mb_lgc-urcu-pointer.o</div><div>=A0 CC =A0 =
=A0 test_urcu_mb_lgc-wfcqueue.o</div><div>=A0 CCLD =A0 test_urcu_mb_lgc</di=
v><div>=A0 CC =A0 =A0 test_urcu_qsbr_dynamic_link-test_urcu_qsbr.o</div><di=
v>=A0 CC =A0 =A0 test_urcu_qsbr_dynamic_link-urcu-qsbr.o</div>
<div>=A0 CC =A0 =A0 test_urcu_qsbr_dynamic_link-urcu-pointer.o</div><div>=
=A0 CC =A0 =A0 test_urcu_qsbr_dynamic_link-wfcqueue.o</div><div>=A0 CCLD =
=A0 test_urcu_qsbr_dynamic_link</div><div>=A0 CC =A0 =A0 test_urcu_defer.o<=
/div><div>=A0 CCLD =A0 test_urcu_defer</div>
<div>=A0 CC =A0 =A0 test_urcu_assign.o</div><div>=A0 CCLD =A0 test_urcu_ass=
ign</div><div>=A0 CC =A0 =A0 test_urcu_assign_dynamic_link-test_urcu_assign=
.o</div><div>=A0 CC =A0 =A0 test_urcu_assign_dynamic_link-urcu.o</div><div>=
=A0 CC =A0 =A0 test_urcu_assign_dynamic_link-urcu-pointer.o</div>
<div>=A0 CC =A0 =A0 test_urcu_assign_dynamic_link-wfcqueue.o</div><div>=A0 =
CCLD =A0 test_urcu_assign_dynamic_link</div><div>=A0 CC =A0 =A0 test_urcu_b=
p.o</div><div>=A0 CC =A0 =A0 urcu-bp.o</div><div>=A0 CCLD =A0 test_urcu_bp<=
/div><div>=A0 CC =A0 =A0 test_urcu_bp_dynamic_link-test_urcu_bp.o</div>
<div>=A0 CC =A0 =A0 test_urcu_bp_dynamic_link-urcu-bp.o</div><div>=A0 CC =
=A0 =A0 test_urcu_bp_dynamic_link-urcu-pointer.o</div><div>=A0 CC =A0 =A0 t=
est_urcu_bp_dynamic_link-wfcqueue.o</div><div>=A0 CCLD =A0 test_urcu_bp_dyn=
amic_link</div><div>
=A0 CC =A0 =A0 test_cycles_per_loop.o</div><div>=A0 CCLD =A0 test_cycles_pe=
r_loop</div><div>=A0 CC =A0 =A0 test_urcu_lfq.o</div><div>=A0 CCLD =A0 test=
_urcu_lfq</div><div>=A0 CC =A0 =A0 test_urcu_wfq.o</div><div>=A0 CCLD =A0 t=
est_urcu_wfq</div><div>=A0 CC =A0 =A0 test_urcu_lfs.o</div>
<div>=A0 CCLD =A0 test_urcu_lfs</div><div>=A0 CC =A0 =A0 test_urcu_wfs.o</d=
iv><div>=A0 CCLD =A0 test_urcu_wfs</div><div>=A0 CC =A0 =A0 test_urcu_lfs_r=
cu.o</div><div>=A0 CCLD =A0 test_urcu_lfs_rcu</div><div>=A0 CC =A0 =A0 test=
_urcu_wfcq.o</div><div>=A0 CCLD =A0 test_urcu_wfcq</div>
<div>=A0 CC =A0 =A0 test_urcu_wfq_dynlink-test_urcu_wfq.o</div><div>=A0 CCL=
D =A0 test_urcu_wfq_dynlink</div><div>=A0 CC =A0 =A0 test_urcu_wfs_dynlink-=
test_urcu_wfs.o</div><div>=A0 CCLD =A0 test_urcu_wfs_dynlink</div><div>=A0 =
CC =A0 =A0 test_urcu_wfcq_dynlink-test_urcu_wfcq.o</div>
<div>=A0 CCLD =A0 test_urcu_wfcq_dynlink</div><div>=A0 CC =A0 =A0 test_urcu=
_lfq_dynlink-test_urcu_lfq.o</div><div>=A0 CC =A0 =A0 test_urcu_lfq_dynlink=
-urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_lfq_dynlink-urcu-pointer.o</div>=
<div>=A0 CC =A0 =A0 test_urcu_lfq_dynlink-wfcqueue.o</div>
<div>=A0 CCLD =A0 test_urcu_lfq_dynlink</div><div>=A0 CC =A0 =A0 test_urcu_=
lfs_dynlink-test_urcu_lfs.o</div><div>=A0 CC =A0 =A0 test_urcu_lfs_dynlink-=
urcu.o</div><div>=A0 CC =A0 =A0 test_urcu_lfs_dynlink-urcu-pointer.o</div><=
div>=A0 CC =A0 =A0 test_urcu_lfs_dynlink-wfcqueue.o</div>
<div>=A0 CCLD =A0 test_urcu_lfs_dynlink</div><div>=A0 CC =A0 =A0 test_urcu_=
hash-test_urcu_hash.o</div><div>=A0 CC =A0 =A0 test_urcu_hash-test_urcu_has=
h_rw.o</div><div>=A0 CC =A0 =A0 test_urcu_hash-test_urcu_hash_unique.o</div=
><div>=A0 CCLD =A0 test_urcu_hash</div>
<div>=A0 CC =A0 =A0 test_urcu_lfs_rcu_dynlink-test_urcu_lfs_rcu.o</div><div=
>=A0 CC =A0 =A0 test_urcu_lfs_rcu_dynlink-urcu.o</div><div>=A0 CC =A0 =A0 t=
est_urcu_lfs_rcu_dynlink-urcu-pointer.o</div><div>=A0 CC =A0 =A0 test_urcu_=
lfs_rcu_dynlink-wfcqueue.o</div>
<div>=A0 CCLD =A0 test_urcu_lfs_rcu_dynlink</div><div>make[3]: Entering dir=
ectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/test=
s/benchmark&#39;</div><div>make[3]: Nothing to be done for `install-exec-am=
&#39;.</div>
<div>make[3]: Nothing to be done for `install-data-am&#39;.</div><div>make[=
3]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/userspace/use=
rspace-rcu/tests/benchmark&#39;</div><div>make[2]: Leaving directory `/home=
/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/benchmark&#=
39;</div>
<div>Making install in regression</div><div>make[2]: Entering directory `/h=
ome/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regressi=
on&#39;</div><div>=A0 CC =A0 =A0 test_urcu_fork.o</div><div>=A0 CC =A0 =A0 =
urcu.o</div>
<div>=A0 CC =A0 =A0 urcu-pointer.o</div><div>=A0 CC =A0 =A0 wfcqueue.o</div=
><div>=A0 CCLD =A0 test_urcu_fork</div><div>=A0 CC =A0 =A0 rcutorture_urcu-=
urcutorture.o</div><div>=A0 CCLD =A0 rcutorture_urcu</div><div>=A0 CC =A0 =
=A0 rcutorture_urcu_signal-urcutorture.o</div>
<div>=A0 CCLD =A0 rcutorture_urcu_signal</div><div>=A0 CC =A0 =A0 rcutortur=
e_urcu_mb-urcutorture.o</div><div>=A0 CCLD =A0 rcutorture_urcu_mb</div><div=
>=A0 CC =A0 =A0 rcutorture_urcu_bp-urcutorture.o</div><div>=A0 CCLD =A0 rcu=
torture_urcu_bp</div>
<div>=A0 CC =A0 =A0 rcutorture_urcu_qsbr-urcutorture.o</div><div>=A0 CCLD =
=A0 rcutorture_urcu_qsbr</div><div>make[3]: Entering directory `/home/shkum=
ar/Development_Merge/NewOCT/userspace/userspace-rcu/tests/regression&#39;</=
div><div>
make[3]: Nothing to be done for `install-exec-am&#39;.</div><div>make[3]: N=
othing to be done for `install-data-am&#39;.</div><div>make[3]: Leaving dir=
ectory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/test=
s/regression&#39;</div>
<div>make[2]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/tests/regression&#39;</div><div>make[2]: Entering dire=
ctory `/home/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests=
&#39;</div>
<div>make[3]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/tests&#39;</div><div>make[3]: Nothing to be done for =
`install-exec-am&#39;.</div><div>make[3]: Nothing to be done for `install-d=
ata-am&#39;.</div>
<div>make[3]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/tests&#39;</div><div>make[2]: Leaving directory `/home=
/shkumar/Development_Merge/NewOCT/userspace/userspace-rcu/tests&#39;</div>
<div>make[1]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/tests&#39;</div></div><div><br></div><div><br></div><d=
iv>I have an issue with lttng-tools build, which i will raise in a new thre=
ad.</div>
<div><br></div><div>Thank you</div><div>Skumar</div></div><div class=3D"gma=
il_extra"><br><br><div class=3D"gmail_quote">On Mon, Nov 25, 2013 at 10:10 =
PM, Thibault, Daniel <span dir=3D"ltr">&lt;<a href=3D"mailto:Daniel.Thibaul=
t@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibault@drdc-rddc.gc.ca</a>&gt=
;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">&gt; Date: Mon, 25 Nov 2013 12:11:09 +0530<b=
r>
&gt; From: kumar s &lt;<a href=3D"mailto:skumar.m226@gmail.com">skumar.m226=
@gmail.com</a>&gt;<br>
<div class=3D"im">&gt;<br>
&gt; I tried test .so and app ,compiled with mips gcc . it worked fine with=
out throwing any errors.<br>
&gt;<br>
&gt; configuring with static library works fine but shared lib throws this =
error. I have attached the log below.<br>
&gt;<br>
</div>&gt; *Static Library build*<br>
<div class=3D"im">&gt;<br>
&gt; CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu_inst=
all --host=3Dmips64-octeon-linux-gnu --disable-shared<br>
&gt; configure: WARNING: if you wanted to set the --build type, don&#39;t u=
se --host.<br>
</div>&gt; [...]<br>
<div class=3D"im">&gt; checking if libtool supports shared libraries... yes=
<br>
</div>&gt; *checking whether to build shared libraries... no*<br>
<div class=3D"im">&gt; checking whether to build static libraries... yes<br=
>
</div>&gt; [...]<br>
<div class=3D"im">&gt; configure: creating ./config.status<br>
&gt; config.status: creating Makefile<br>
&gt; config.status: creating doc/Makefile<br>
&gt; config.status: creating doc/examples/Makefile<br>
&gt; config.status: creating tests/Makefile<br>
&gt; config.status: creating tests/common/Makefile<br>
&gt; config.status: creating tests/unit/Makefile<br>
&gt; config.status: creating tests/benchmark/Makefile<br>
&gt; config.status: creating tests/regression/Makefile<br>
&gt; config.status: creating liburcu.pc<br>
&gt; config.status: creating liburcu-bp.pc<br>
&gt; config.status: creating liburcu-cds.pc<br>
&gt; config.status: creating liburcu-qsbr.pc<br>
&gt; config.status: creating liburcu-mb.pc<br>
&gt; config.status: creating liburcu-signal.pc<br>
&gt; config.status: creating config.h<br>
&gt; config.status: config.h is unchanged<br>
&gt; config.status: creating urcu/config.h<br>
&gt; config.status: urcu/config.h is unchanged<br>
<br>
</div>=A0 =A0The two &quot;config.h is unchanged&quot; messages are the onl=
y ones different from my configure.log. =A0Did you install from a clean sys=
tem?<br>
<div class=3D"im"><br>
&gt; config.status: linking urcu/arch/mips.h to urcu/arch.h<br>
&gt; config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h<br>
&gt; config.status: executing depfiles commands<br>
&gt; config.status: executing libtool commands<br>
&gt; SMP support enabled.<br>
&gt; Thread Local Storage (TLS): __thread.<br>
<br>
&gt; [shkumar@shrayanth userspace-rcu]$ make<br>
&gt; make =A0all-recursive<br>
&gt; make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu&#39;<br>
&gt; Making all in .<br>
&gt; make[2]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu&#39;<br>
&gt; =A0 CC =A0 =A0 wfqueue.lo<br>
&gt; =A0 CC =A0 =A0 wfcqueue.lo<br>
</div>&gt; [...]<br>
&gt; =A0 CC =A0 =A0 urcu.lo<br>
<br>
=A0 =A0At least the warnings have disappeared.<br>
<br>
&gt; [...]<br>
<div class=3D"im">&gt; =A0 CCLD =A0 test_urcu_lfs_rcu_dynlink<br>
&gt; make[3]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/use=
rspace/userspace-rcu/tests/benchmark&#39;<br>
&gt; Making all in regression<br>
&gt; make[3]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu/tests/regression&#39;<br>
&gt; =A0 CC =A0 =A0 test_urcu_fork.o<br>
&gt; =A0 CC =A0 =A0 urcu.o<br>
</div>&gt; [...]<br>
<div class=3D"im">&gt; make[1]: Leaving directory `/home/shkumar/Developmen=
t_Merge/NewOCT/userspace/userspace-rcu&#39;<br>
<br>
</div>=A0 =A0Your log is identical to mine, except for the paths, of course=
.<br>
<br>
&gt; *Shared-library build.*<br>
<div class=3D"im">&gt;<br>
&gt; CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu_inst=
all --host=3Dmips64-octeon-linux-gnu --enable-shared<br>
&gt; configure: WARNING: if you wanted to set the --build type, don&#39;t u=
se --host.<br>
</div>&gt; [...]<br>
<div class=3D"im">&gt; checking if libtool supports shared libraries... yes=
<br>
</div>&gt; *checking whether to build shared libraries... yes*<br>
<div class=3D"im">&gt; checking whether to build static libraries... yes<br=
>
</div>&gt; [...]<br>
&gt; configure: creating ./config.status<br>
&gt; [...]<br>
<div class=3D"im">&gt; config.status: creating config.h<br>
&gt; config.status: config.h is unchanged<br>
&gt; config.status: creating urcu/config.h<br>
&gt; config.status: urcu/config.h is unchanged<br>
&gt; config.status: linking urcu/arch/mips.h to urcu/arch.h<br>
&gt; config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h<br>
&gt; config.status: executing depfiles commands<br>
&gt; config.status: executing libtool commands<br>
&gt; SMP support enabled.<br>
&gt; Thread Local Storage (TLS): __thread.<br>
<br>
&gt; [shkumar@shrayanth userspace-rcu]$ make<br>
&gt; make =A0all-recursive<br>
&gt; make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/us=
erspace/userspace-rcu&#39;<br>
&gt; Making all in .<br>
</div>&gt; [...]<br>
<div class=3D"im">&gt; cc =A0-g -O2 -Wall -I../../../urcu/ -I../../../ -g -=
O2 \<br>
&gt; =A0 =A0 =A0 =A0 -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.=
c<br>
&gt; cc -g -O2 -Wall =A0-g -O2 -L../../../.libs/ \<br>
&gt; =A0 =A0 =A0 =A0 -Wl,-rpath=3D&quot;/home/shkumar/Development_Merge/New=
OCT/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \<br>
&gt; =A0 =A0 =A0 =A0 -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lu=
rcu<br>
&gt; /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when sea=
rching for -lurcu<br>
&gt; /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when sear=
ching for -lurcu<br>
&gt; /usr/bin/ld: cannot find -lurcu<br>
&gt; collect2: ld returned 1 exit status<br>
&gt; make[6]: *** [cds_hlist_add_head_rcu] Error 1<br>
</div>&gt; [...]<br>
<br>
=A0 =A0The incompatibility message occurs because you&#39;re trying to mix =
bitnesses (a 32-bit liburcu.so won&#39;t link with a 64-bit application and=
 vice-versa).<br>
<br>
=A0 =A0Could the replacement of gcc by cc somehow be responsible? =A0How co=
me the Makefile isn&#39;t using CC =3D mips64-octeon-linux-gnu-gcc (or so i=
t seems)?<br>
<br>
&gt; is userspace lib required to build lttng-tools (latest version from gi=
t)?<br>
<div class=3D"im">&gt; It throws this error while trying to configure..<br>
&gt;<br>
</div><div class=3D"im">&gt; [...]<br>
&gt; checking for grp.h... yes<br>
&gt; checking for pthread_create in -lpthread... yes<br>
&gt; checking for poptGetContext in -lpopt... yes<br>
&gt; checking for uuid_generate in -luuid... yes<br>
&gt; checking whether cds_list_add is declared... no<br>
&gt; configure: error: liburcu &gt;=3D 0.7.2 or newer is needed<br>
<br>
</div>&gt; skumar<br>
<br>
=A0 =A0Yes, lttng-tools requires userspace-rcu, although it can be built wi=
thout lttng-modules and/or lttng-ust.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
Daniel U. Thibault<br>
Protection des syst=E8mes et contremesures (PSC) | Systems Protection &amp;=
 Countermeasures (SPC)<br>
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)<br>
R &amp; D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence=
 R&amp;D Canada - Valcartier (DRDC Valcartier)<br>
2459 route de la Bravoure<br>
Qu=E9bec QC =A0G3J 1X5<br>
CANADA<br>
Vox : (418) 844-4000 x4245<br>
Fax : (418) 844-4538<br>
NAC : 918V QSDJ &lt;<a href=3D"http://www.travelgis.com/map.asp?addr=3D918V=
%20QSDJ" target=3D"_blank">http://www.travelgis.com/map.asp?addr=3D918V%20Q=
SDJ</a>&gt;<br>
Gouvernement du Canada | Government of Canada<br>
&lt;<a href=3D"http://www.valcartier.drdc-rddc.gc.ca/" target=3D"_blank">ht=
tp://www.valcartier.drdc-rddc.gc.ca/</a>&gt;<br>
</div></div></blockquote></div><br></div>

--001a1134989cf418c704ec2597f8--


--===============0395547217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0395547217==--
