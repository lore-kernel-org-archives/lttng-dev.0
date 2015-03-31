From: =?UTF-8?B?U8OpYmFzdGllbiBMb3JyYWlu?=
 <sebastien.lorrain01@gmail.com>
Subject: Added information about PID namespace to tracepoints
Date: Tue, 31 Mar 2015 11:50:09 -0400
Message-ID: <551AC231.102__39113.7955630713$1427817093$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0996413185=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sebastien.lorrain01@gmail.com>) id 1YcyQU-0007bJ-2m
 for lttng-dev@lists.lttng.org; Tue, 31 Mar 2015 11:50:11 -0400
Received: by qcgx3 with SMTP id x3so17148610qcg.3
 for <lttng-dev@lists.lttng.org>; Tue, 31 Mar 2015 08:49:56 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Francis Jolivet <francis.jolivet@gmail.com>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0996413185==
Content-Type: multipart/alternative;
 boundary="------------060001030802090606080206"

This is a multi-part message in MIME format.
--------------060001030802090606080206
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello fellow LTTNG devs,

We are students from Polytechnique Montreal and we are currently working 
on an TraceCompass analysis module for Linux containers 
(LXC/Docker/Etc...). The information we track is mostly CPU usage by pid 
namespace, which would allow the identification of CPU-utilization 
related bottlenecks on a Linux container host.

We tried to come up with targeted information to recreate the 
container/PID namespace tree of a Linux host and we have modified 
lttng-modules to be able to do so :
https://github.com/Selora/lttng-modules

In our analysis, we try to re-use as many information that was already 
available in the LTTNG kernel tracer. We build our container/namespace 
tree using the tasks and their parent recursively (using only the 
pid/vppid/ppid). However, we were unable to have a reliable model 
without some light modifications on some tracepoints.
_/
The modifications to the lttng-modulues where the following:/_

We added the PID namespace INode (from /proc/PID/ns/pid) to the LTTNG 
statedump tracepoint.

Also, to track new task/containers that would spawn during the tracing 
session, we also added multiple fields to the /sched_process_fork/ event :

  * Added a VTID field for the children task. This is mandatory in our
    analysis, as we keep track of VTID/TID association.
  * Added a/parent_ns_inum/ and /child_ns_inum/ field wich represent the
    pid namespaces inodes of the parent and child task respectively.
      o The /parent_ns_inum/ is "not mandatory" in our analysis, but it
        keeps things simple as we don't have to track TID from parent
        containers and it keeps the code relatively independant wheter
        statedump is enabled or not.
      o The /child_ns_inum///IS mandatory, because even if we keep track
        of the PID/VPID/PPID/VPPID that have spawned, it is possible to
        "inject" a task in an already existing namespace without
        repareting it to the child reaper of the container (this means
        the task is sent in a namespace, but it is not part of the
        process tree of the container of that namespace)

We hope to integrate our analysis to TraceCompass soon, and without the 
modification to the LTTNG tracer approved, we would be unable to proceed 
throught code review.
We would be really grateful to the community if we could have feedback, 
and we will make every modifications possibles to have our analysis up 
and working!

The code is supposed to work on kernel version 3.8 through 3.19.
It was tested on 3.18 and 3.19, and I'am going to test it for 3.8 today.

Cheers,
Sebastien & Francis.


--------------060001030802090606080206
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hello fellow LTTNG devs,<br>
    <br>
    We are students from Polytechnique Montreal and we are currently
    working on an TraceCompass analysis module for Linux containers
    (LXC/Docker/Etc...). The information we track is mostly CPU usage by
    pid namespace, which would allow the identification of
    CPU-utilization related bottlenecks on a Linux container host.<br>
    <br>
    We tried to come up with targeted information to recreate the
    container/PID namespace tree of a Linux host and we have modified
    lttng-modules to be able to do so :<br>
    <a href="https://github.com/Selora/lttng-modules">https://github.com/Selora/lttng-modules</a><br>
    <br>
    In our analysis, we try to re-use as many information that was
    already available in the LTTNG kernel tracer. We build our
    container/namespace tree using the tasks and their parent
    recursively (using only the pid/vppid/ppid). However, we were unable
    to have a reliable model without some light modifications on some
    tracepoints.<br>
    <u><i><br>
        The modifications to the lttng-modulues where the following:</i></u><br>
    <br>
    We added the PID namespace INode (from /proc/PID/ns/pid) to the
    LTTNG statedump tracepoint.<br>
    <br>
    Also, to track new task/containers that would spawn during the
    tracing session, we also added multiple fields to the <i>sched_process_fork</i>
    event :<br>
    <ul>
      <li>Added a VTID field for the children task. This is mandatory in
        our analysis, as we keep track of VTID/TID association.</li>
      <li>Added a<i> parent_ns_inum</i> and <i>child_ns_inum</i> field
        wich represent the pid namespaces inodes of the parent and child
        task respectively.</li>
      <ul>
        <li>The <i>parent_ns_inum</i> is "not mandatory" in our
          analysis, but it keeps things simple as we don't have to track
          TID from parent containers and it keeps the code relatively
          independant wheter statedump is enabled or not.</li>
        <li>The <i>child_ns_inum</i><i> </i>IS mandatory, because even
          if we keep track of the PID/VPID/PPID/VPPID that have spawned,
          it is possible to "inject" a task in an already existing
          namespace without repareting it to the child reaper of the
          container (this means the task is sent in a namespace, but it
          is not part of the process tree of the container of that
          namespace)</li>
      </ul>
    </ul>
    <p>We hope to integrate our analysis to TraceCompass soon, and
      without the modification to the LTTNG tracer approved, we would be
      unable to proceed throught code review.<br>
      We would be really grateful to the community if we could have
      feedback, and we will make every modifications possibles to have
      our analysis up and working!<br>
    </p>
    <p>The code is supposed to work on kernel version 3.8 through 3.19.<br>
      It was tested on 3.18 and 3.19, and I'am going to test it for 3.8
      today.<br>
    </p>
    <p>Cheers,<br>
      Sebastien &amp; Francis.<br>
    </p>
  </body>
</html>

--------------060001030802090606080206--


--===============0996413185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0996413185==--
