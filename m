From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: liburcu error: Cannot find -lurcu
Date: Fri, 22 Nov 2013 15:46:15 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A58A5__16074.4580127814$1385135237$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1Vjsvx-00067T-Dh
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 10:46:23 -0500
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> I edited the log to show only the error. The detailed log is  :

   Copy-writer's tip: when omitting irrelevant parts from a log (or convers=
ation quote), indicate the omission with an ellipsis (e.g. '(...)' or '[...=
]').

> $ make
> make  all-recursive
> [...]
>  CC     wfstack.lo
>  CCLD   liburcu-common.la
>  CC     urcu.lo

   That's the line that creates liburcu.so.  It seems to succeed, albeit wi=
th a number of warnings.

> In file included from urcu.c:530:
> urcu-call-rcu-impl.h: In function 'alloc_cpu_call_rcu_data':
> urcu-call-rcu-impl.h:150: warning: implicit declaration of function 'rpl_=
malloc'
> urcu-call-rcu-impl.h:150: warning: assignment makes pointer from integer =
without a cast
> [...]
>  CC     urcu-pointer.lo
> [...]
> make -f Makefile.cds_hlist_add_head_rcu
> make[6]: Entering directory
> `/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
> cc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \
>        -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c cc -g -O2 =
-Wall  -g -O2 -L../../../.libs/ -Wl,-rpath=3D"/home/kumar/userspace/userspa=
ce-rcu/doc/examples/../../.libs/" \
>        -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
> /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when search=
ing for -lurcu

   But when we get here and try to use liburcu.so for the first time, it tu=
rns out to be "incompatible".

> /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when searchi=
ng for -lurcu
> /usr/bin/ld: cannot find -lurcu
> collect2: ld returned 1 exit status
> make[6]: *** [cds_hlist_add_head_rcu] Error 1
> [...]

   Except for the warnings, your make log matches mine up to the fatal libu=
rcu.so incompatibility error.

   Could the compiler be misconfigured?  Try making a small test .so and ap=
plication pair.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
