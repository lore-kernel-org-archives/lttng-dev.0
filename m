From: kumar s <skumar.m226@gmail.com>
Subject: Re: liburcu error: Cannot find -lurcu
Date: Fri, 22 Nov 2013 20:29:25 +0530
Message-ID: <CAO_ArvocQpPL2b0oFG27eW_wjdZi3gE-qFaNDoFdx90wbsFrfw__49271.4192755104$1385132442$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5865@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389518206=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <skumar.m226@gmail.com>) id 1VjsCh-0004KV-J4
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 09:59:39 -0500
Received: by mail-lb0-f174.google.com with SMTP id c11so1025765lbj.33
	for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2013 06:59:25 -0800 (PST)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD267A5865@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

--===============0389518206==
Content-Type: multipart/alternative; boundary=001a11c23f1c97baec04ebc54288

--001a11c23f1c97baec04ebc54288
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

HELLO,

I edited the log to show only the error. The detailed log is  :


[shkumar@shrayanth userspace-rcu]$ make
make  all-recursive
make[1]: Entering directory `/home/kumar/userspace/userspace-rcu'
Making all in .
make[2]: Entering directory `/home/kumar/userspace/userspace-rcu'
  CC     wfqueue.lo
  CC     wfcqueue.lo
  CC     wfstack.lo
  CCLD   liburcu-common.la
  CC     urcu.lo
In file included from urcu.c:530:
urcu-call-rcu-impl.h: In function 'alloc_cpu_call_rcu_data':
urcu-call-rcu-impl.h:150: warning: implicit declaration of function
'rpl_malloc'
urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'call_rcu_data_init':
urcu-call-rcu-impl.h:380: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'free_all_cpu_call_rcu_data_memb':
urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integer
without a cast
In file included from urcu.c:531:
urcu-defer-impl.h: In function 'rcu_defer_register_thread_memb':
urcu-defer-impl.h:424: warning: assignment makes pointer from integer
without a cast
  CC     urcu-pointer.lo
  CCLD   liburcu.la
  CC     urcu-qsbr.lo
In file included from urcu-qsbr.c:456:
urcu-call-rcu-impl.h: In function 'alloc_cpu_call_rcu_data':
urcu-call-rcu-impl.h:150: warning: implicit declaration of function
'rpl_malloc'
urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'call_rcu_data_init':
urcu-call-rcu-impl.h:380: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'free_all_cpu_call_rcu_data':
urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integer
without a cast
In file included from urcu-qsbr.c:457:
urcu-defer-impl.h: In function 'rcu_defer_register_thread_qsbr':
urcu-defer-impl.h:424: warning: assignment makes pointer from integer
without a cast
  CCLD   liburcu-qsbr.la
  CC     liburcu_mb_la-urcu.lo
In file included from urcu.c:530:
urcu-call-rcu-impl.h: In function 'alloc_cpu_call_rcu_data':
urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'call_rcu_data_init':
urcu-call-rcu-impl.h:380: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'free_all_cpu_call_rcu_data_mb':
urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integer
without a cast
In file included from urcu.c:531:
urcu-defer-impl.h: In function 'rcu_defer_register_thread_mb':
urcu-defer-impl.h:424: warning: assignment makes pointer from integer
without a cast
  CC     liburcu_mb_la-urcu-pointer.lo
  CCLD   liburcu-mb.la
  CC     liburcu_signal_la-urcu.lo
In file included from urcu.c:530:
urcu-call-rcu-impl.h: In function 'alloc_cpu_call_rcu_data':
urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'call_rcu_data_init':
urcu-call-rcu-impl.h:380: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'free_all_cpu_call_rcu_data_sig':
urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integer
without a cast
In file included from urcu.c:531:
urcu-defer-impl.h: In function 'rcu_defer_register_thread_sig':
urcu-defer-impl.h:424: warning: assignment makes pointer from integer
without a cast
  CC     liburcu_signal_la-urcu-pointer.lo
  CCLD   liburcu-signal.la
  CC     urcu-bp.lo
In file included from urcu-bp.c:654:
urcu-call-rcu-impl.h: In function 'alloc_cpu_call_rcu_data':
urcu-call-rcu-impl.h:150: warning: implicit declaration of function
'rpl_malloc'
urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'call_rcu_data_init':
urcu-call-rcu-impl.h:380: warning: assignment makes pointer from integer
without a cast
urcu-call-rcu-impl.h: In function 'free_all_cpu_call_rcu_data_bp':
urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integer
without a cast
In file included from urcu-bp.c:655:
urcu-defer-impl.h: In function 'rcu_defer_register_thread_bp':
urcu-defer-impl.h:424: warning: assignment makes pointer from integer
without a cast
  CCLD   liburcu-bp.la
  CC     rculfqueue.lo
  CC     rculfstack.lo
  CC     lfstack.lo
  CC     rculfhash.lo
rculfhash.c: In function '__cds_lfht_resize_lazy_launch':
rculfhash.c:1980: warning: implicit declaration of function 'rpl_malloc'
rculfhash.c:1980: warning: assignment makes pointer from integer without a
cast
  CC     rculfhash-mm-order.lo
  CC     rculfhash-mm-chunk.lo
  CC     rculfhash-mm-mmap.lo
  CCLD   liburcu-cds.la
make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu'
Making all in doc
make[2]: Entering directory `/home/kumar/userspace/userspace-rcu/doc'
Making all in examples
make[3]: Entering directory
`/home/kumar/userspace/userspace-rcu/doc/examples'
make -f dist-files/Makefile AM_CPPFLAGS=3D" -I../../../urcu/ -I../../../"
AM_CFLAGS=3D'-g -O2' AM_LDFLAGS=3D' -L../../../.libs/
-Wl,-rpath=3D"/home/kumar/userspace/userspace-rcu/doc/examples/../../.libs/=
"'
all
make[4]: Entering directory
`/home/kumar/userspace/userspace-rcu/doc/examples'
make -C hlist
make[5]: Entering directory
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
make -f Makefile.cds_hlist_add_head_rcu
make[6]: Entering directory
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
cc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \
        -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c
cc -g -O2 -Wall  -g -O2 -L../../../.libs/
-Wl,-rpath=3D"/home/kumar/userspace/userspace-rcu/doc/examples/../../.libs/=
" \
        -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when
searching for -lurcu
/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when searching
for -lurcu
/usr/bin/ld: cannot find -lurcu
collect2: ld returned 1 exit status
make[6]: *** [cds_hlist_add_head_rcu] Error 1
make[6]: Leaving directory
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
make[5]: *** [all] Error 2
make[5]: Leaving directory
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
make[4]: *** [all] Error 2
make[4]: Leaving directory
`/home/kumar/userspace/userspace-rcu/doc/examples'
make[3]: *** [all-local] Error 2
make[3]: Leaving directory
`/home/kumar/userspace/userspace-rcu/doc/examples'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/kumar/userspace/userspace-rcu'
make: *** [all] Error 2


Thank you
Skumar

On Fri, Nov 22, 2013 at 7:27 PM, Thibault, Daniel <
Daniel.Thibault@drdc-rddc.gc.ca> wrote:

> > Date: Fri, 22 Nov 2013 10:51:01 +0530
> >
> > I am using latest version of userspace. Cloned from userspace.git
> >
> >While Cross Compiling for Mips Architecture I get the following error.
> >
> >make  all-recursive
> >make[1]: Entering directory `/home/kumar/userspace/userspace-rcu'
> >Making all in .
> >make[2]: Entering directory `/home/kumar/userspace/userspace-rcu'
>
>    Aren't there a bunch of CC and CCLD messages missing from here?  Did
> you edit this log or did your make really skip /userspace-rcu/. and go
> straight to /userspace-rcu/doc?
>
> >make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu'
> >Making all in doc
> >make[2]: Entering directory `/home/kumar/userspace/userspace-rcu/doc'
> >Making all in examples
> >make[3]: Entering directory
> >`/home/kumar/userspace/userspace-rcu/doc/examples'
> >make -f dist-files/Makefile AM_CPPFLAGS=3D" -I../../../urcu/ -I../../../=
"
> >AM_CFLAGS=3D'-g -O2' AM_LDFLAGS=3D' -L../../../.libs/
> >-Wl,-rpath=3D"/home/kumar/userspace/userspace-rcu/doc/examples/../../.li=
bs/"'
> all
> >make[4]: Entering directory
> >`/home/kumar/userspace/userspace-rcu/doc/examples'
> >make -C hlist
> >make[5]: Entering directory
> >`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
> >make -f Makefile.cds_hlist_add_head_rcu
> >make[6]: Entering directory
> >`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
> >cc -g -O2 -Wall  -g -O2 -L../../../.libs/
> >-Wl,-rpath=3D"/home/kumar/userspace/userspace-rcu/doc/examples/../../.li=
bs/"
> \
> >        -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
> >/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when
> >searching for -lurcu
> >/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when
> searching
> >for -lurcu
> >/usr/bin/ld: cannot find -lurcu
> >collect2: ld returned 1 exit status
> >make[6]: *** [cds_hlist_add_head_rcu] Error 1
> >make[6]: Leaving directory
> >`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
> >make[5]: *** [all] Error 2
> >make[5]: Leaving directory
> >`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
> >make[4]: *** [all] Error 2
> >make[4]: Leaving directory
> >`/home/kumar/userspace/userspace-rcu/doc/examples'
> >make[3]: *** [all-local] Error 2
> >make[3]: Leaving directory
> >`/home/kumar/userspace/userspace-rcu/doc/examples'
> >make[2]: *** [all-recursive] Error 1
> >make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc'
> >make[1]: *** [all-recursive] Error 1
> >make[1]: Leaving directory `/home/kumar/userspace/userspace-rcu'
> >make: *** [all] Error 2
> >
> > How can I fix this?
>
>    When you capture the log, be sure to get both stdout and stderr, by
> using e.g. 'make install &> install.log' or 'make install 2>&1 | tee
> install.log'.
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

--001a11c23f1c97baec04ebc54288
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>HELLO,<br><br></div>I edited the log to sho=
w only the error. The detailed log is=A0 :<br><br><br>[shkumar@shrayanth us=
erspace-rcu]$ make<br>make=A0 all-recursive<br>make[1]: Entering directory =
`/home/kumar/userspace/userspace-rcu&#39;<br>
Making all in .<br>make[2]: Entering directory `/home/kumar/userspace/users=
pace-rcu&#39;<br>=A0 CC=A0=A0=A0=A0 wfqueue.lo<br>=A0 CC=A0=A0=A0=A0 wfcque=
ue.lo<br>=A0 CC=A0=A0=A0=A0 wfstack.lo<br>=A0 CCLD=A0=A0 <a href=3D"http://=
liburcu-common.la">liburcu-common.la</a><br>
=A0 CC=A0=A0=A0=A0 urcu.lo<br>In file included from urcu.c:530:<br>urcu-cal=
l-rcu-impl.h: In function &#39;alloc_cpu_call_rcu_data&#39;:<br>urcu-call-r=
cu-impl.h:150: warning: implicit declaration of function &#39;rpl_malloc&#3=
9;<br>
urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer wi=
thout a cast<br>urcu-call-rcu-impl.h: In function &#39;call_rcu_data_init&#=
39;:<br>urcu-call-rcu-impl.h:380: warning: assignment makes pointer from in=
teger without a cast<br>
urcu-call-rcu-impl.h: In function &#39;free_all_cpu_call_rcu_data_memb&#39;=
:<br>urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integ=
er without a cast<br>In file included from urcu.c:531:<br>urcu-defer-impl.h=
: In function &#39;rcu_defer_register_thread_memb&#39;:<br>
urcu-defer-impl.h:424: warning: assignment makes pointer from integer witho=
ut a cast<br>=A0 CC=A0=A0=A0=A0 urcu-pointer.lo<br>=A0 CCLD=A0=A0 <a href=
=3D"http://liburcu.la">liburcu.la</a><br>=A0 CC=A0=A0=A0=A0 urcu-qsbr.lo<br=
>In file included from urcu-qsbr.c:456:<br>
urcu-call-rcu-impl.h: In function &#39;alloc_cpu_call_rcu_data&#39;:<br>urc=
u-call-rcu-impl.h:150: warning: implicit declaration of function &#39;rpl_m=
alloc&#39;<br>urcu-call-rcu-impl.h:150: warning: assignment makes pointer f=
rom integer without a cast<br>
urcu-call-rcu-impl.h: In function &#39;call_rcu_data_init&#39;:<br>urcu-cal=
l-rcu-impl.h:380: warning: assignment makes pointer from integer without a =
cast<br>urcu-call-rcu-impl.h: In function &#39;free_all_cpu_call_rcu_data&#=
39;:<br>
urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integer wi=
thout a cast<br>In file included from urcu-qsbr.c:457:<br>urcu-defer-impl.h=
: In function &#39;rcu_defer_register_thread_qsbr&#39;:<br>urcu-defer-impl.=
h:424: warning: assignment makes pointer from integer without a cast<br>
=A0 CCLD=A0=A0 <a href=3D"http://liburcu-qsbr.la">liburcu-qsbr.la</a><br>=
=A0 CC=A0=A0=A0=A0 liburcu_mb_la-urcu.lo<br>In file included from urcu.c:53=
0:<br>urcu-call-rcu-impl.h: In function &#39;alloc_cpu_call_rcu_data&#39;:<=
br>urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer=
 without a cast<br>
urcu-call-rcu-impl.h: In function &#39;call_rcu_data_init&#39;:<br>urcu-cal=
l-rcu-impl.h:380: warning: assignment makes pointer from integer without a =
cast<br>urcu-call-rcu-impl.h: In function &#39;free_all_cpu_call_rcu_data_m=
b&#39;:<br>
urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integer wi=
thout a cast<br>In file included from urcu.c:531:<br>urcu-defer-impl.h: In =
function &#39;rcu_defer_register_thread_mb&#39;:<br>urcu-defer-impl.h:424: =
warning: assignment makes pointer from integer without a cast<br>
=A0 CC=A0=A0=A0=A0 liburcu_mb_la-urcu-pointer.lo<br>=A0 CCLD=A0=A0 <a href=
=3D"http://liburcu-mb.la">liburcu-mb.la</a><br>=A0 CC=A0=A0=A0=A0 liburcu_s=
ignal_la-urcu.lo<br>In file included from urcu.c:530:<br>urcu-call-rcu-impl=
.h: In function &#39;alloc_cpu_call_rcu_data&#39;:<br>
urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer wi=
thout a cast<br>urcu-call-rcu-impl.h: In function &#39;call_rcu_data_init&#=
39;:<br>urcu-call-rcu-impl.h:380: warning: assignment makes pointer from in=
teger without a cast<br>
urcu-call-rcu-impl.h: In function &#39;free_all_cpu_call_rcu_data_sig&#39;:=
<br>urcu-call-rcu-impl.h:741: warning: assignment makes pointer from intege=
r without a cast<br>In file included from urcu.c:531:<br>urcu-defer-impl.h:=
 In function &#39;rcu_defer_register_thread_sig&#39;:<br>
urcu-defer-impl.h:424: warning: assignment makes pointer from integer witho=
ut a cast<br>=A0 CC=A0=A0=A0=A0 liburcu_signal_la-urcu-pointer.lo<br>=A0 CC=
LD=A0=A0 <a href=3D"http://liburcu-signal.la">liburcu-signal.la</a><br>=A0 =
CC=A0=A0=A0=A0 urcu-bp.lo<br>
In file included from urcu-bp.c:654:<br>urcu-call-rcu-impl.h: In function &=
#39;alloc_cpu_call_rcu_data&#39;:<br>urcu-call-rcu-impl.h:150: warning: imp=
licit declaration of function &#39;rpl_malloc&#39;<br>urcu-call-rcu-impl.h:=
150: warning: assignment makes pointer from integer without a cast<br>
urcu-call-rcu-impl.h: In function &#39;call_rcu_data_init&#39;:<br>urcu-cal=
l-rcu-impl.h:380: warning: assignment makes pointer from integer without a =
cast<br>urcu-call-rcu-impl.h: In function &#39;free_all_cpu_call_rcu_data_b=
p&#39;:<br>
urcu-call-rcu-impl.h:741: warning: assignment makes pointer from integer wi=
thout a cast<br>In file included from urcu-bp.c:655:<br>urcu-defer-impl.h: =
In function &#39;rcu_defer_register_thread_bp&#39;:<br>urcu-defer-impl.h:42=
4: warning: assignment makes pointer from integer without a cast<br>
=A0 CCLD=A0=A0 <a href=3D"http://liburcu-bp.la">liburcu-bp.la</a><br>=A0 CC=
=A0=A0=A0=A0 rculfqueue.lo<br>=A0 CC=A0=A0=A0=A0 rculfstack.lo<br>=A0 CC=A0=
=A0=A0=A0 lfstack.lo<br>=A0 CC=A0=A0=A0=A0 rculfhash.lo<br>rculfhash.c: In =
function &#39;__cds_lfht_resize_lazy_launch&#39;:<br>
rculfhash.c:1980: warning: implicit declaration of function &#39;rpl_malloc=
&#39;<br>rculfhash.c:1980: warning: assignment makes pointer from integer w=
ithout a cast<br>=A0 CC=A0=A0=A0=A0 rculfhash-mm-order.lo<br>=A0 CC=A0=A0=
=A0=A0 rculfhash-mm-chunk.lo<br>
=A0 CC=A0=A0=A0=A0 rculfhash-mm-mmap.lo<br>=A0 CCLD=A0=A0 <a href=3D"http:/=
/liburcu-cds.la">liburcu-cds.la</a><br>make[2]: Leaving directory `/home/ku=
mar/userspace/userspace-rcu&#39;<br>Making all in doc<br>make[2]: Entering =
directory `/home/kumar/userspace/userspace-rcu/doc&#39;<br>
Making all in examples<br>make[3]: Entering directory `/home/kumar/userspac=
e/userspace-rcu/doc/examples&#39;<br>make -f dist-files/Makefile AM_CPPFLAG=
S=3D&quot; -I../../../urcu/ -I../../../&quot; AM_CFLAGS=3D&#39;-g -O2&#39; =
AM_LDFLAGS=3D&#39; -L../../../.libs/ -Wl,-rpath=3D&quot;/home/kumar/userspa=
ce/userspace-rcu/doc/examples/../../.libs/&quot;&#39;=A0 all<br>
make[4]: Entering directory `/home/kumar/userspace/userspace-rcu/doc/exampl=
es&#39;<br>make -C hlist<br>make[5]: Entering directory `/home/kumar/usersp=
ace/userspace-rcu/doc/examples/hlist&#39;<br>make -f Makefile.cds_hlist_add=
_head_rcu<br>
make[6]: Entering directory `/home/kumar/userspace/userspace-rcu/doc/exampl=
es/hlist&#39;<br>cc=A0 -g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \<b=
r>=A0=A0=A0 =A0=A0=A0 -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu=
.c<br>cc -g -O2 -Wall=A0 -g -O2 -L../../../.libs/ -Wl,-rpath=3D&quot;/home/=
kumar/userspace/userspace-rcu/doc/examples/../../.libs/&quot; \<br>
=A0=A0=A0 =A0=A0=A0 -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lur=
cu<br>/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when se=
arching for -lurcu<br>/usr/bin/ld: skipping incompatible ../../../.libs//li=
burcu.a when searching for -lurcu<br>
/usr/bin/ld: cannot find -lurcu<br>collect2: ld returned 1 exit status<br>m=
ake[6]: *** [cds_hlist_add_head_rcu] Error 1<br>make[6]: Leaving directory =
`/home/kumar/userspace/userspace-rcu/doc/examples/hlist&#39;<br>make[5]: **=
* [all] Error 2<br>
make[5]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc/example=
s/hlist&#39;<br>make[4]: *** [all] Error 2<br>make[4]: Leaving directory `/=
home/kumar/userspace/userspace-rcu/doc/examples&#39;<br>make[3]: *** [all-l=
ocal] Error 2<br>
make[3]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc/example=
s&#39;<br>make[2]: *** [all-recursive] Error 1<br>make[2]: Leaving director=
y `/home/kumar/userspace/userspace-rcu/doc&#39;<br>make[1]: *** [all-recurs=
ive] Error 1<br>
make[1]: Leaving directory `/home/kumar/userspace/userspace-rcu&#39;<br>mak=
e: *** [all] Error 2<br><br><br></div>Thank you<br></div>Skumar<br><div><di=
v><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fr=
i, Nov 22, 2013 at 7:27 PM, Thibault, Daniel <span dir=3D"ltr">&lt;<a href=
=3D"mailto:Daniel.Thibault@drdc-rddc.gc.ca" target=3D"_blank">Daniel.Thibau=
lt@drdc-rddc.gc.ca</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">&gt; Date: Fri, 22 Nov 20=
13 10:51:01 +0530<br>
<div>&gt;<br>
&gt; I am using latest version of userspace. Cloned from userspace.git<br>
&gt;<br>
&gt;While Cross Compiling for Mips Architecture I get the following error.<=
br>
&gt;<br>
&gt;make =A0all-recursive<br>
&gt;make[1]: Entering directory `/home/kumar/userspace/userspace-rcu&#39;<b=
r>
&gt;Making all in .<br>
&gt;make[2]: Entering directory `/home/kumar/userspace/userspace-rcu&#39;<b=
r>
<br>
</div>=A0 =A0Aren&#39;t there a bunch of CC and CCLD messages missing from =
here? =A0Did you edit this log or did your make really skip /userspace-rcu/=
. and go straight to /userspace-rcu/doc?<br>
<div><div><br>
&gt;make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu&#39;<br=
>
&gt;Making all in doc<br>
&gt;make[2]: Entering directory `/home/kumar/userspace/userspace-rcu/doc&#3=
9;<br>
&gt;Making all in examples<br>
&gt;make[3]: Entering directory<br>
&gt;`/home/kumar/userspace/userspace-rcu/doc/examples&#39;<br>
&gt;make -f dist-files/Makefile AM_CPPFLAGS=3D&quot; -I../../../urcu/ -I../=
../../&quot;<br>
&gt;AM_CFLAGS=3D&#39;-g -O2&#39; AM_LDFLAGS=3D&#39; -L../../../.libs/<br>
&gt;-Wl,-rpath=3D&quot;/home/kumar/userspace/userspace-rcu/doc/examples/../=
../.libs/&quot;&#39; all<br>
&gt;make[4]: Entering directory<br>
&gt;`/home/kumar/userspace/userspace-rcu/doc/examples&#39;<br>
&gt;make -C hlist<br>
&gt;make[5]: Entering directory<br>
&gt;`/home/kumar/userspace/userspace-rcu/doc/examples/hlist&#39;<br>
&gt;make -f Makefile.cds_hlist_add_head_rcu<br>
&gt;make[6]: Entering directory<br>
&gt;`/home/kumar/userspace/userspace-rcu/doc/examples/hlist&#39;<br>
&gt;cc -g -O2 -Wall =A0-g -O2 -L../../../.libs/<br>
&gt;-Wl,-rpath=3D&quot;/home/kumar/userspace/userspace-rcu/doc/examples/../=
../.libs/&quot; \<br>
&gt; =A0 =A0 =A0 =A0-o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lur=
cu<br>
&gt;/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when<br>
&gt;searching for -lurcu<br>
&gt;/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when searc=
hing<br>
&gt;for -lurcu<br>
&gt;/usr/bin/ld: cannot find -lurcu<br>
&gt;collect2: ld returned 1 exit status<br>
&gt;make[6]: *** [cds_hlist_add_head_rcu] Error 1<br>
&gt;make[6]: Leaving directory<br>
&gt;`/home/kumar/userspace/userspace-rcu/doc/examples/hlist&#39;<br>
&gt;make[5]: *** [all] Error 2<br>
&gt;make[5]: Leaving directory<br>
&gt;`/home/kumar/userspace/userspace-rcu/doc/examples/hlist&#39;<br>
&gt;make[4]: *** [all] Error 2<br>
&gt;make[4]: Leaving directory<br>
&gt;`/home/kumar/userspace/userspace-rcu/doc/examples&#39;<br>
&gt;make[3]: *** [all-local] Error 2<br>
&gt;make[3]: Leaving directory<br>
&gt;`/home/kumar/userspace/userspace-rcu/doc/examples&#39;<br>
&gt;make[2]: *** [all-recursive] Error 1<br>
&gt;make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc&#39=
;<br>
&gt;make[1]: *** [all-recursive] Error 1<br>
&gt;make[1]: Leaving directory `/home/kumar/userspace/userspace-rcu&#39;<br=
>
&gt;make: *** [all] Error 2<br>
&gt;<br>
</div></div>&gt; How can I fix this?<br>
<br>
=A0 =A0When you capture the log, be sure to get both stdout and stderr, by =
using e.g. &#39;make install &amp;&gt; install.log&#39; or &#39;make instal=
l 2&gt;&amp;1 | tee install.log&#39;.<br>
<br>
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
</blockquote></div><br></div></div></div></div></div></div>

--001a11c23f1c97baec04ebc54288--


--===============0389518206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0389518206==--
