From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: CentOS 7 and liburcu-common.so.3
Date: Wed, 15 Jul 2015 21:25:18 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD8AB0314C__30362.8311878585$1436995586$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1ZFUBA-0008GR-Qj
 for lttng-dev@lists.lttng.org; Wed, 15 Jul 2015 17:25:29 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I've grabbed recent source tarballs of the LTTng suite:

lttng-modules a606b6e 2.6.2-2 (2.6.0-rc1-101) 25 jun 2015 13:30:55
userspace-rcu b0a841b 0.8.7-13 (0.8.0-96) 8 Jul 2015 18:43:01
lttng-ust d8ecdf4 2.6.2.-20 (2.6.0-rc1-82)  8 Jul 2015 18:31:27
lttng-tools 7daee93 2.6.0-88 (2.6.0-rc1-241) 13 Jul 2015 15:21:01

and built them on two systems.  The first is a Ubuntu 15.04 vivid 3.19.0-16=
-generic x86_64, the second is a CentOS Linux release 7.1.1503 (Core) 3.10.=
0-229.el7 x86_64.
The first is also host to the second, which is a virtual machine.

Everything built and installed fine on both systems.  However, something ha=
ppens on the CentOS that does not on the Ubuntu (both are virgin, with no t=
racing group yet, nor any automatic lttng-sessiond daemon):

$ su
# lttng create test_session
Spawning a session daemon
Warning: No tracing group detected
Session test_session created.
Traces will be written in /root/lttng-traces/ test_session-20150715-165116
# lttng enable-event -k -a

At this point, Ubuntu goes on with:

Warning: No tracing group detected
All Kernel events are enabled in channel channel0

While CentOS 7 does:

lttng-consumerd: error while loading shared libraries: liburcu-common.so.3:=
 cannot open shared object file: No such file or directory
Error: Condition timed out.  The consumer thread was never ready. Killing it
Error: Fatal error spawning consumer control thread
Error: Events: Kernel consumer start failed (channel channel0, session test=
_session)
Error: Command error

At this point the system monitor shows lttng-sessiond and lttng-consumerd s=
till up (so I guess the killing failed too).  If I then kill lttng-sessiond:

# kill 3425
# PERROR - 17:22:17.123456 [3425/3425]: kernel consumer err_sock close: Bad=
 file descriptor (in close_consumer_sockets() at main.c:529)

What's strange is that liburcu-common.so.3 is present in the CentOS system,=
 in the same place, and is found in the same way by 'whereis'.  Any clues?

Daniel U. Thibault, M.Sc.=B2

Scientifique de la d=E9fense, CME-PSC, Centre de recherches de Valcartier
Recherche et d=E9veloppement pour la d=E9fense Canada / Gouvernement du Can=
ada
daniel.thibault@drdc-rddc.gc.ca / T=E9l: 418-844-4000x4245 T=E9l=E9c: 418-8=
44-4538
daniel.thibault@forces.gc.ca / T=E9l: 418-844-4000x4245 T=E9l=E9c: 418-844-=
4538

Defence Scientist, MCCS-SPC, Valcartier Research Centre =

Defence Research and Development Canada=A0/ Government of Canada
daniel.thibault@drdc-rddc.gc.ca / Tel: 418-844-4000x4245 Fax: 418-844-4538
daniel.thibault@forces.gc.ca / Tel: 418-844-4000x4245 Fax: 418-844-4538

DRDC is an agency of the Department of National Defence / RDDC est une agen=
ce du minist=E8re de la D=E9fense nationale
