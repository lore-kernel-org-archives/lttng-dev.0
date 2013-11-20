From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: loglevel: <<UNKNOWN>>
Date: Wed, 20 Nov 2013 21:04:43 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267A2E4E__3814.29246995157$1384981547$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VjEx2-0003bp-CQ
	for lttng-dev@lists.lttng.org; Wed, 20 Nov 2013 16:04:50 -0500
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

   Something strange is going on in one of my virtual machines.  I was fool=
ing around with defining events, creating and deleting sessions, etc., and =
now the list of kernel tracepoints (lttng list -k) contains several entries=
 where the loglevel reads a corrupt value.  Specifically:

      skb_consume (loglevel: <<UNKNOWN>> (577)) (type:tracepoint)
      skb_copy_datagram_iovec (loglevel: <<UNKNOWN>> (1140980544)) (type:tr=
acepoint)
      sched_switch (loglevel: <<UNKNOWN>> (6647407)) (type:tracepoint)
      sched_migrate_task (loglevel: <<UNKNOWN>> (1140883008)) (type:tracepo=
int)
      sched_process_free (loglevel: <<UNKNOWN>> (51088)) (type:tracepoint)
      regulator_enable (loglevel: <<UNKNOWN>> (1140998064)) (type:tracepoin=
t)
      regulator_enable_delay (loglevel: <<UNKNOWN>> (1140998080)) (type:tra=
cepoint)
      power_machine_suspend (loglevel: <<UNKNOWN>> (52)) (type:tracepoint)

   None of these events were the subject of kprobe or kretprobe events, exc=
ept maybe sched_switch.

   This weirdness went away after a restart of lttng-sessiond.  I've saved =
the VM with this corrupt system in case anyone wants to investigate.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
