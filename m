From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: liburcu error: Cannot find -lurcu
Date: Fri, 22 Nov 2013 13:57:06 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A5865__17173.3162635521$1385129116$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VjrEP-0004w4-GV
	for lttng-dev@lists.lttng.org; Fri, 22 Nov 2013 08:57:17 -0500
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

> Date: Fri, 22 Nov 2013 10:51:01 +0530
>
> I am using latest version of userspace. Cloned from userspace.git
>
>While Cross Compiling for Mips Architecture I get the following error.
>
>make  all-recursive
>make[1]: Entering directory `/home/kumar/userspace/userspace-rcu'
>Making all in .
>make[2]: Entering directory `/home/kumar/userspace/userspace-rcu'

   Aren't there a bunch of CC and CCLD messages missing from here?  Did you=
 edit this log or did your make really skip /userspace-rcu/. and go straigh=
t to /userspace-rcu/doc?

>make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu'
>Making all in doc
>make[2]: Entering directory `/home/kumar/userspace/userspace-rcu/doc'
>Making all in examples
>make[3]: Entering directory
>`/home/kumar/userspace/userspace-rcu/doc/examples'
>make -f dist-files/Makefile AM_CPPFLAGS=3D" -I../../../urcu/ -I../../../"
>AM_CFLAGS=3D'-g -O2' AM_LDFLAGS=3D' -L../../../.libs/
>-Wl,-rpath=3D"/home/kumar/userspace/userspace-rcu/doc/examples/../../.libs=
/"' all
>make[4]: Entering directory
>`/home/kumar/userspace/userspace-rcu/doc/examples'
>make -C hlist
>make[5]: Entering directory
>`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
>make -f Makefile.cds_hlist_add_head_rcu
>make[6]: Entering directory
>`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
>cc -g -O2 -Wall  -g -O2 -L../../../.libs/
>-Wl,-rpath=3D"/home/kumar/userspace/userspace-rcu/doc/examples/../../.libs=
/" \
>        -o cds_hlist_add_head_rcu cds_hlist_add_head_rcu.o -lurcu
>/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.so when
>searching for -lurcu
>/usr/bin/ld: skipping incompatible ../../../.libs//liburcu.a when searching
>for -lurcu
>/usr/bin/ld: cannot find -lurcu
>collect2: ld returned 1 exit status
>make[6]: *** [cds_hlist_add_head_rcu] Error 1
>make[6]: Leaving directory
>`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
>make[5]: *** [all] Error 2
>make[5]: Leaving directory
>`/home/kumar/userspace/userspace-rcu/doc/examples/hlist'
>make[4]: *** [all] Error 2
>make[4]: Leaving directory
>`/home/kumar/userspace/userspace-rcu/doc/examples'
>make[3]: *** [all-local] Error 2
>make[3]: Leaving directory
>`/home/kumar/userspace/userspace-rcu/doc/examples'
>make[2]: *** [all-recursive] Error 1
>make[2]: Leaving directory `/home/kumar/userspace/userspace-rcu/doc'
>make[1]: *** [all-recursive] Error 1
>make[1]: Leaving directory `/home/kumar/userspace/userspace-rcu'
>make: *** [all] Error 2
>
> How can I fix this?

   When you capture the log, be sure to get both stdout and stderr, by usin=
g e.g. 'make install &> install.log' or 'make install 2>&1 | tee install.lo=
g'.

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
