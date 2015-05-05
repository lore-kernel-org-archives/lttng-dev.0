From: =?UTF-8?B?U8OpYmFzdGllbiBMb3JyYWlu?=
 <sebastien.lorrain01@gmail.com>
Subject: Re: Added information about PID namespace to tracepoints
Date: Tue, 05 May 2015 14:17:45 -0400
Message-ID: <55490949.7050903__22194.5303412669$1430849923$gmane$org@gmail.com>
References: <551AC231.102@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030905050102040806060105"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sebastien.lorrain01@gmail.com>) id 1YphPT-0002QZ-PA
 for lttng-dev@lists.lttng.org; Tue, 05 May 2015 14:17:38 -0400
Received: by qcbgy10 with SMTP id gy10so39658229qcb.3
 for <lttng-dev@lists.lttng.org>; Tue, 05 May 2015 11:17:30 -0700 (PDT)
In-Reply-To: <551AC231.102@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--------------030905050102040806060105
Content-Type: multipart/alternative;
 boundary="------------040909090109070009040005"


--------------040909090109070009040005
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id t45IHpPU024685

Hello everyone,

We changed the patch code a bit to include all of the VTIDs of a task=20
nested deep down in an arbitrary level of pid namespace.
For example, if a task is running inside a container nested in another=20
container, our patch will display the TID of the task from the point of=20
view of :

 1. The root container (or the host)
 2. The parent container
 3. The container the task is running into

We also rebased on master, and everything is running smooth and fine on=20
our test machine (linux 3.19.3).
It should support down to linux 3.8.1.

Here is an example of a field:

sched_process_fork: { cpu_id =3D 0 }, { parent_comm =3D "bash", parent_ti=
d =3D=20
10739, parent_pid =3D 10739, parent_ns_inum =3D 4026532365, child_comm =3D=
=20
"bash", child_tid =3D 10968, _vtids_length =3D 3, vtids =3D [ [0] =3D 109=
68, [1]=20
=3D 2658, [2] =3D 1265 ], child_pid =3D 10968, child_ns_inum =3D 40265323=
65 }

Any comments are greatly appreciated!

Sebastien & Francis.


On 03/31/15 11:50, S=C3=A9bastien Lorrain wrote:
> Hello fellow LTTNG devs,
>
> We are students from Polytechnique Montreal and we are currently=20
> working on an TraceCompass analysis module for Linux containers=20
> (LXC/Docker/Etc...). The information we track is mostly CPU usage by=20
> pid namespace, which would allow the identification of CPU-utilization=20
> related bottlenecks on a Linux container host.
>
> We tried to come up with targeted information to recreate the=20
> container/PID namespace tree of a Linux host and we have modified=20
> lttng-modules to be able to do so :
> https://github.com/Selora/lttng-modules
>
> In our analysis, we try to re-use as many information that was already=20
> available in the LTTNG kernel tracer. We build our container/namespace=20
> tree using the tasks and their parent recursively (using only the=20
> pid/vppid/ppid). However, we were unable to have a reliable model=20
> without some light modifications on some tracepoints.
> _/
> The modifications to the lttng-modulues where the following:/_
>
> We added the PID namespace INode (from /proc/PID/ns/pid) to the LTTNG=20
> statedump tracepoint.
>
> Also, to track new task/containers that would spawn during the tracing=20
> session, we also added multiple fields to the /sched_process_fork/ even=
t :
>
>   * Added a VTID field for the children task. This is mandatory in our
>     analysis, as we keep track of VTID/TID association.
>   * Added a/parent_ns_inum/ and /child_ns_inum/ field wich represent
>     the pid namespaces inodes of the parent and child task respectively.
>       o The /parent_ns_inum/ is "not mandatory" in our analysis, but
>         it keeps things simple as we don't have to track TID from
>         parent containers and it keeps the code relatively independant
>         wheter statedump is enabled or not.
>       o The /child_ns_inum///IS mandatory, because even if we keep
>         track of the PID/VPID/PPID/VPPID that have spawned, it is
>         possible to "inject" a task in an already existing namespace
>         without repareting it to the child reaper of the container
>         (this means the task is sent in a namespace, but it is not
>         part of the process tree of the container of that namespace)
>
> We hope to integrate our analysis to TraceCompass soon, and without=20
> the modification to the LTTNG tracer approved, we would be unable to=20
> proceed throught code review.
> We would be really grateful to the community if we could have=20
> feedback, and we will make every modifications possibles to have our=20
> analysis up and working!
>
> The code is supposed to work on kernel version 3.8 through 3.19.
> It was tested on 3.18 and 3.19, and I'am going to test it for 3.8 today.
>
> Cheers,
> Sebastien & Francis.
>


--------------040909090109070009040005
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id t45IHpPU024685

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hello everyone,<br>
    <br>
    We changed the patch code a bit to include all of the VTIDs of a
    task nested deep down in an arbitrary level of pid namespace.<br>
    For example, if a task is running inside a container nested in
    another container, our patch will display the TID of the task from
    the point of view of :<br>
    <ol>
      <li>The root container (or the host)<br>
      </li>
      <li>The parent container</li>
      <li>The container the task is running into<br>
      </li>
    </ol>
    We also rebased on master, and everything is running smooth and fine
    on our test machine (linux 3.19.3). <br>
    It should support down to linux 3.8.1.<br>
    <br>
    Here is an example of a field<big> </big><big>: </big><br>
    <br>
    <font face=3D"Courier New, Courier, monospace">sched_process_fork: {
      cpu_id =3D 0 }, { parent_comm =3D "bash", parent_tid =3D 10739,
      parent_pid =3D 10739, parent_ns_inum =3D 4026532365, child_comm =3D
      "bash", child_tid =3D 10968, _vtids_length =3D 3, vtids =3D [ [0] =3D
      10968, [1] =3D 2658, [2] =3D 1265 ], child_pid =3D 10968, child_ns_=
inum
      =3D 4026532365 }</font><br>
    <br>
    Any comments are greatly appreciated!<br>
    <br>
    Sebastien &amp; Francis.<br>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 03/31/15 11:50, S=C3=A9bastien Lorr=
ain
      wrote:<br>
    </div>
    <blockquote cite=3D"mid:551AC231.102@gmail.com" type=3D"cite">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Du=
tf-8">
      Hello fellow LTTNG devs,<br>
      <br>
      We are students from Polytechnique Montreal and we are currently
      working on an TraceCompass analysis module for Linux containers
      (LXC/Docker/Etc...). The information we track is mostly CPU usage
      by pid namespace, which would allow the identification of
      CPU-utilization related bottlenecks on a Linux container host.<br>
      <br>
      We tried to come up with targeted information to recreate the
      container/PID namespace tree of a Linux host and we have modified
      lttng-modules to be able to do so :<br>
      <a moz-do-not-send=3D"true"
        href=3D"https://github.com/Selora/lttng-modules">https://github.c=
om/Selora/lttng-modules</a><br>
      <br>
      In our analysis, we try to re-use as many information that was
      already available in the LTTNG kernel tracer. We build our
      container/namespace tree using the tasks and their parent
      recursively (using only the pid/vppid/ppid). However, we were
      unable to have a reliable model without some light modifications
      on some tracepoints.<br>
      <u><i><br>
          The modifications to the lttng-modulues where the following:</i=
></u><br>
      <br>
      We added the PID namespace INode (from /proc/PID/ns/pid) to the
      LTTNG statedump tracepoint.<br>
      <br>
      Also, to track new task/containers that would spawn during the
      tracing session, we also added multiple fields to the <i>sched_proc=
ess_fork</i>
      event :<br>
      <ul>
        <li>Added a VTID field for the children task. This is mandatory
          in our analysis, as we keep track of VTID/TID association.</li>
        <li>Added a<i> parent_ns_inum</i> and <i>child_ns_inum</i>
          field wich represent the pid namespaces inodes of the parent
          and child task respectively.</li>
        <ul>
          <li>The <i>parent_ns_inum</i> is "not mandatory" in our
            analysis, but it keeps things simple as we don't have to
            track TID from parent containers and it keeps the code
            relatively independant wheter statedump is enabled or not.</l=
i>
          <li>The <i>child_ns_inum</i><i> </i>IS mandatory, because
            even if we keep track of the PID/VPID/PPID/VPPID that have
            spawned, it is possible to "inject" a task in an already
            existing namespace without repareting it to the child reaper
            of the container (this means the task is sent in a
            namespace, but it is not part of the process tree of the
            container of that namespace)</li>
        </ul>
      </ul>
      <p>We hope to integrate our analysis to TraceCompass soon, and
        without the modification to the LTTNG tracer approved, we would
        be unable to proceed throught code review.<br>
        We would be really grateful to the community if we could have
        feedback, and we will make every modifications possibles to have
        our analysis up and working!<br>
      </p>
      <p>The code is supposed to work on kernel version 3.8 through
        3.19.<br>
        It was tested on 3.18 and 3.19, and I'am going to test it for
        3.8 today.<br>
      </p>
      <p>Cheers,<br>
        Sebastien &amp; Francis.<br>
      </p>
    </blockquote>
    <br>
  </body>
</html>

--------------040909090109070009040005--

--------------030905050102040806060105
Content-Type: text/x-patch;
 name="0001-Added-namespace-info-in-sched_fork-and-statedump.patch"
Content-Disposition: attachment;
 filename*0="0001-Added-namespace-info-in-sched_fork-and-statedump.patch"
Content-Transfer-Encoding: 7bit

From 46e5eb49eb6f7688d696ef7c7c5108a121c8af33 Mon Sep 17 00:00:00 2001
From: Lrouge <sebastien.lorrain01@gmail.com>
Date: Wed, 15 Apr 2015 11:53:53 -0400
Subject: [PATCH] Added namespace info in sched_fork and statedump

Modifications to sched_fork :
Added a field for parent and child pid namespace inode (as in /proc/$PID/ns/pid). Also added a field for the child VTID.

Modifications to lttng_statedump_process_state :
Added a field for the pid namespace inode of the task.
---
 .../events/lttng-module/lttng-statedump.h          | 11 ++++
 instrumentation/events/lttng-module/sched.h        | 66 +++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/instrumentation/events/lttng-module/lttng-statedump.h b/instrumentation/events/lttng-module/lttng-statedump.h
index 2369037..db4f990 100644
--- a/instrumentation/events/lttng-module/lttng-statedump.h
+++ b/instrumentation/events/lttng-module/lttng-statedump.h
@@ -8,6 +8,14 @@
 #include <linux/nsproxy.h>
 #include <linux/pid_namespace.h>
 #include <linux/types.h>
+#include <linux/version.h>
+
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0))
+#define lttng_proc_inum ns.inum
+#else
+#define lttng_proc_inum proc_inum
+#endif
 
 LTTNG_TRACEPOINT_EVENT(lttng_statedump_start,
 	TP_PROTO(struct lttng_session *session),
@@ -60,6 +68,9 @@ LTTNG_TRACEPOINT_EVENT(lttng_statedump_process_state,
 		ctf_integer(int, submode, submode)
 		ctf_integer(int, status, status)
 		ctf_integer(int, ns_level, pid_ns ? pid_ns->level : 0)
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0))
+		ctf_integer(unsigned int, ns_inum, pid_ns ? pid_ns->lttng_proc_inum: 0)
+#endif
 	)
 )
 
diff --git a/instrumentation/events/lttng-module/sched.h b/instrumentation/events/lttng-module/sched.h
index ac61bce..00a7218 100644
--- a/instrumentation/events/lttng-module/sched.h
+++ b/instrumentation/events/lttng-module/sched.h
@@ -6,12 +6,21 @@
 
 #include "../../../probes/lttng-tracepoint-event.h"
 #include <linux/sched.h>
+#include <linux/pid_namespace.h>
 #include <linux/binfmts.h>
 #include <linux/version.h>
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,9,0))
 #include <linux/sched/rt.h>
 #endif
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,19,0))
+#define lttng_proc_inum ns.inum
+#else
+#define lttng_proc_inum proc_inum
+#endif
+
+#define LTTNG_MAX_PID_NS_LEVEL 32
+
 #ifndef _TRACE_SCHED_DEF_
 #define _TRACE_SCHED_DEF_
 
@@ -288,19 +297,74 @@ LTTNG_TRACEPOINT_EVENT(sched_process_wait,
  * == child_pid, while creation of a thread yields to child_tid !=
  * child_pid.
  */
-LTTNG_TRACEPOINT_EVENT(sched_process_fork,
+LTTNG_TRACEPOINT_EVENT_CODE(sched_process_fork,
 
 	TP_PROTO(struct task_struct *parent, struct task_struct *child),
 
 	TP_ARGS(parent, child),
 
+	TP_locvar(
+		pid_t vtids[LTTNG_MAX_PID_NS_LEVEL];
+		size_t ns_level;
+	),
+
+	TP_code(
+		if (child) {
+			int ns_level;
+			struct pid* child_pid;
+			unsigned int i;
+
+			child_pid = task_pid(child);
+			ns_level = child_pid->level + 1;
+			if(ns_level > LTTNG_MAX_PID_NS_LEVEL)
+			{
+				ns_level = LTTNG_MAX_PID_NS_LEVEL;
+			}
+
+			tp_locvar->ns_level = ns_level;
+			for(i = 0; i < ns_level; ++i)
+			{
+				tp_locvar->vtids[i] = child_pid->numbers[i].nr;
+			}
+		}
+	),
+
 	TP_FIELDS(
 		ctf_array_text(char, parent_comm, parent->comm, TASK_COMM_LEN)
 		ctf_integer(pid_t, parent_tid, parent->pid)
 		ctf_integer(pid_t, parent_pid, parent->tgid)
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0))
+		ctf_integer(unsigned int, parent_ns_inum,
+			({
+				unsigned int parent_ns_inum = 0;
+				if (parent) {
+					struct pid_namespace* pid_ns;
+					pid_ns = task_active_pid_ns(parent);
+					if(pid_ns) {
+						parent_ns_inum = pid_ns->lttng_proc_inum;
+					}
+				}
+				parent_ns_inum;
+			}))
+#endif
 		ctf_array_text(char, child_comm, child->comm, TASK_COMM_LEN)
 		ctf_integer(pid_t, child_tid, child->pid)
+		ctf_sequence(pid_t, vtids, tp_locvar->vtids, u8, tp_locvar->ns_level)
 		ctf_integer(pid_t, child_pid, child->tgid)
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,8,0))
+		ctf_integer(unsigned int, child_ns_inum,
+			({
+			unsigned int child_ns_inum = 0;
+			if (child) {
+				struct pid_namespace* pid_ns;
+				pid_ns = task_active_pid_ns(child);
+				if(pid_ns) {
+					child_ns_inum = pid_ns->lttng_proc_inum;
+				}
+			}
+			child_ns_inum;
+			}))
+#endif
 	)
 )
 
-- 
2.3.5


--------------030905050102040806060105
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------030905050102040806060105--
