From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Fwd: liburcu error: Cannot find -lurcu
Date: Mon, 25 Nov 2013 16:40:48 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A5DE7__21349.9214071364$1385397709$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VkzDO-0001pb-3X
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 11:40:56 -0500
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

> Date: Mon, 25 Nov 2013 12:11:09 +0530
> From: kumar s <skumar.m226@gmail.com>
>
> I tried test .so and app ,compiled with mips gcc . it worked fine without=
 throwing any errors.
>
> configuring with static library works fine but shared lib throws this err=
or. I have attached the log below.
>
> *Static Library build*
>
> CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu_install=
 --host=3Dmips64-octeon-linux-gnu --disable-shared
> configure: WARNING: if you wanted to set the --build type, don't use --ho=
st.
> [...]
> checking if libtool supports shared libraries... yes
> *checking whether to build shared libraries... no*
> checking whether to build static libraries... yes
> [...]
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: creating doc/Makefile
> config.status: creating doc/examples/Makefile
> config.status: creating tests/Makefile
> config.status: creating tests/common/Makefile
> config.status: creating tests/unit/Makefile
> config.status: creating tests/benchmark/Makefile
> config.status: creating tests/regression/Makefile
> config.status: creating liburcu.pc
> config.status: creating liburcu-bp.pc
> config.status: creating liburcu-cds.pc
> config.status: creating liburcu-qsbr.pc
> config.status: creating liburcu-mb.pc
> config.status: creating liburcu-signal.pc
> config.status: creating config.h
> config.status: config.h is unchanged
> config.status: creating urcu/config.h
> config.status: urcu/config.h is unchanged

   The two "config.h is unchanged" messages are the only ones different fro=
m my configure.log.  Did you install from a clean system?

> config.status: linking urcu/arch/mips.h to urcu/arch.h
> config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h
> config.status: executing depfiles commands
> config.status: executing libtool commands
> SMP support enabled.
> Thread Local Storage (TLS): __thread.

> [shkumar@shrayanth userspace-rcu]$ make
> make  all-recursive
> make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/users=
pace/userspace-rcu'
> Making all in .
> make[2]: Entering directory `/home/shkumar/Development_Merge/NewOCT/users=
pace/userspace-rcu'
>   CC     wfqueue.lo
>   CC     wfcqueue.lo
> [...]
>   CC     urcu.lo

   At least the warnings have disappeared.

> [...]
>   CCLD   test_urcu_lfs_rcu_dynlink
> make[3]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/usersp=
ace/userspace-rcu/tests/benchmark'
> Making all in regression
> make[3]: Entering directory `/home/shkumar/Development_Merge/NewOCT/users=
pace/userspace-rcu/tests/regression'
>   CC     test_urcu_fork.o
>   CC     urcu.o
> [...]
> make[1]: Leaving directory `/home/shkumar/Development_Merge/NewOCT/usersp=
ace/userspace-rcu'

   Your log is identical to mine, except for the paths, of course.

> *Shared-library build.*
>
> CC=3Dmips64-octeon-linux-gnu-gcc ./configure prefix=3D$(pwd)/urcu_install=
 --host=3Dmips64-octeon-linux-gnu --enable-shared
> configure: WARNING: if you wanted to set the --build type, don't use --ho=
st.
> [...]
> checking if libtool supports shared libraries... yes
> *checking whether to build shared libraries... yes*
> checking whether to build static libraries... yes
> [...]
> configure: creating ./config.status
> [...]
> config.status: creating config.h
> config.status: config.h is unchanged
> config.status: creating urcu/config.h
> config.status: urcu/config.h is unchanged
> config.status: linking urcu/arch/mips.h to urcu/arch.h
> config.status: linking urcu/uatomic/mips.h to urcu/uatomic.h
> config.status: executing depfiles commands
> config.status: executing libtool commands
> SMP support enabled.
> Thread Local Storage (TLS): __thread.

> [shkumar@shrayanth userspace-rcu]$ make
> make  all-recursive
> make[1]: Entering directory `/home/shkumar/Development_Merge/NewOCT/users=
pace/userspace-rcu'
> Making all in .
> [...]
> cc  -g -O2 -Wall -I../../../urcu/ -I../../../ -g -O2 \
>         -c -o cds_hlist_add_head_rcu.o cds_hlist_add_head_rcu.c
> cc -g -O2 -Wall  -g -O2 -L../../../.libs/ \
>         -Wl,-rpath=3D"/home/shkumar/Development_Merge/NewOCT/userspace/us=
erspace-rcu/doc/examples/../../.libs/" \
>         -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
> /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when search=
ing for -lurcu
> /usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when searchi=
ng for -lurcu
> /usr/bin/ld: cannot find -lurcu
> collect2: ld returned 1 exit status
> make[6]: *** [cds_hlist_add_head_rcu] Error 1
> [...]

   The incompatibility message occurs because you're trying to mix bitnesse=
s (a 32-bit liburcu.so won't link with a 64-bit application and vice-versa).

   Could the replacement of gcc by cc somehow be responsible?  How come the=
 Makefile isn't using CC =3D mips64-octeon-linux-gnu-gcc (or so it seems)?

> is userspace lib required to build lttng-tools (latest version from git)?
> It throws this error while trying to configure..
>
> [...]
> checking for grp.h... yes
> checking for pthread_create in -lpthread... yes
> checking for poptGetContext in -lpopt... yes
> checking for uuid_generate in -luuid... yes
> checking whether cds_list_add is declared... no
> configure: error: liburcu >=3D 0.7.2 or newer is needed

> skumar

   Yes, lttng-tools requires userspace-rcu, although it can be built withou=
t lttng-modules and/or lttng-ust.

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
