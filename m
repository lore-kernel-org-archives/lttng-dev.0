From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: sched_switch event
Date: Thu, 6 Feb 2014 20:04:06 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD267DFAF9__30130.7876747616$1391717124$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WBVBP-0007Tk-Qf
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 15:04:29 -0500
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

   In linux-source-3.2.0/include/trace/events/sched.h, or
   linux-headers-3.2.0-53/include/trace/events/sched.h, or
   lttng-modules/instrumentation/events/mainline/sched.h,
   we have in part:

TRACE_EVENT(sched_switch,

	TP_PROTO(struct task_struct *prev,
		 struct task_struct *next),

	TP_ARGS(prev, next),

	TP_STRUCT__entry(
		__array(	char,	prev_comm,	TASK_COMM_LEN	)
		__field(	pid_t,	prev_pid			)
		__field(	int,	prev_prio			)
		__field(	long,	prev_state			)
		__array(	char,	next_comm,	TASK_COMM_LEN	)
		__field(	pid_t,	next_pid			)
		__field(	int,	next_prio			)
	),

	TP_fast_assign(
		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
		__entry->prev_pid	=3D prev->pid;
		__entry->prev_prio	=3D prev->prio;
		__entry->prev_state	=3D __trace_sched_switch_state(prev);
		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
		__entry->next_pid	=3D next->pid;
		__entry->next_prio	=3D next->prio;
	),

	TP_printk("prev_comm=3D%s prev_pid=3D%d prev_prio=3D%d prev_state=3D%s%s =
=3D=3D> next_comm=3D%s next_pid=3D%d next_prio=3D%d",
		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
		__entry->prev_state & (TASK_STATE_MAX-1) ?
		  __print_flags(__entry->prev_state & (TASK_STATE_MAX-1), "|",
				{ 1, "S"} , { 2, "D" }, { 4, "T" }, { 8, "t" },
				{ 16, "Z" }, { 32, "X" }, { 64, "x" },
				{ 128, "W" }) : "R",
		__entry->prev_state & TASK_STATE_MAX ? "+" : "",
		__entry->next_comm, __entry->next_pid, __entry->next_prio)
);

   Note how the TP_fast_assign lines are switching __entry->next_comm and _=
_entry->prev_comm, unlike the TP_printk lines.

   In lttng-modules/instrumentation/events/lttng-module/sched.h, we find:

	TP_STRUCT__entry(
		__array_text(	char,	prev_comm,	TASK_COMM_LEN	)
		__field(	pid_t,	prev_tid			)
		__field(	int,	prev_prio			)
		__field(	long,	prev_state			)
		__array_text(	char,	next_comm,	TASK_COMM_LEN	)
		__field(	pid_t,	next_tid			)
		__field(	int,	next_prio			)
	),

   Which is probably why nobody noticed this before, since LTTng traces cor=
rectly identify the previous and next processes in the sched_switch event.

   This is an upstream Linux kernel bug or what?

   Another question is: if the kernel tracepoint event definitions appearin=
g in the source are ignored, why are they included at all?

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
