From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: sched_switch event
Date: Thu, 6 Feb 2014 20:18:27 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267DFB0B__46230.9808972806$1391718002$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WBVP7-0007ax-S2
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 15:18:43 -0500
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

-----Message d'origine-----
>   In linux-source-3.2.0/include/trace/events/sched.h, or
>   linux-headers-3.2.0-53/include/trace/events/sched.h, or
>   lttng-modules/instrumentation/events/mainline/sched.h,
>   we have in part:
>
>	TP_fast_assign(
>		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>		__entry->prev_pid	=3D prev->pid;
>		__entry->prev_prio	=3D prev->prio;
>		__entry->prev_state	=3D __trace_sched_switch_state(prev);
>		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
>		__entry->next_pid	=3D next->pid;
>		__entry->next_prio	=3D next->prio;
>	),

   Scratch that, lttng-modules/instrumentation/events/lttng-module/sched.h =
has the same code, and I now realise the TP_fast_assign is not switching th=
e prev_comm and next_comm fields (it is correctly mapping __entry->next_com=
m to next->comm), it's just that the copies are declared out of order.  TP_=
fast_assign is essentially a parallelised process.

   Sorry about the false alarm.

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC) Cyber s=E9curit=E9 pour les missions essentielles (CME) =
| Mission Critical Cyber Security (MCCS) R & D pour la d=E9fense Canada - V=
alcartier (RDDC Valcartier) | Defence R&D Canada - Valcartier (DRDC Valcart=
ier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada <http://www.valcartier.drdc=
-rddc.gc.ca/>
