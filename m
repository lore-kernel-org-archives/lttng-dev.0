From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Debian specific userspace RCU configure override
 (ARMv7 Beagle Bone Black)
Date: Mon, 16 Jun 2014 15:00:54 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD359C171E__30384.4655900777$1402930922$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WwYP6-0000z8-RC
 for lttng-dev@lists.lttng.org; Mon, 16 Jun 2014 11:01:04 -0400
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

   Further progress with LTTng on Beagle Bone Black.  Having forced userspa=
ce-rcu to ignore the dmb instruction (CONFIG_RCU_ARM_HAVE_DMB undefined), l=
ttng-tools installs in the no-kernel, no-user-space case.  It also installs=
 in the just-user-space case, but there is something potentially wrong with=
 lttng-ust.  Testing the lttng-modules cases will have to wait until I get =
a new BBB kernel built that has CONFIG_TRACEPOINTS turned on.

   The dmb instruction problem still stands.

   lttng-userspace emits a long list of warnings during its make:

CC lttng-ust-malloc.lo
In file included from ../include/lttng/ust-tracepoint-event.h:367:0,
                               from ../include/lttng/tracepoint-event.h:62,
                               from ust_libc.h:93,
                               from lttng-ust-malloc.c:29:
././ust_libc.h: In function '__event_prepare_filter_stack__ust_libc___mallo=
c':
././ust_libc.h:35:1: warning: cast from pointer to integer of different siz=
e [-Wpointer-to-int-cast]
...

   This recurs on five lines.

   Despite this, sample user-space events are captured as expected.  Babelt=
race also installs, and the trace looks okay.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC) Cyber s=E9curit=E9 pour les missions essentielles (CME) =
| Mission Critical Cyber Security (MCCS) RDDC - Centre de recherches de Val=
cartier | DRDC - Valcartier Research Centre
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada <http://www.valcartier.drdc-r=
ddc.gc.ca/>
