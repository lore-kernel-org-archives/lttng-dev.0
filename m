From: Julien Desfossez <jdesfossez@efficios.com>
Subject: LTTng 2.5 save/load feature feedback
Date: Fri, 30 May 2014 11:54:02 -0400
Message-ID: <5388A99A.9000506__38217.3802507625$1401465319$gmane$org@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1WqP8F-0002Sd-WF
 for lttng-dev@lists.lttng.org; Fri, 30 May 2014 11:54:17 -0400
Received: from [10.123.45.140] (184-94-60-62.dedicated.allstream.net
 [184.94.60.62])
 by fukushima.klipix.org (Postfix) with ESMTPSA id A3CA3460071
 for <lttng-dev@lists.lttng.org>; Fri, 30 May 2014 17:54:03 +0200 (CEST)
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

Hi,

I recently tried the new save/load feature and I have some feedback I'd
like to share.

My understanding was that I could create some kind of profile for
complex tracing setups. Lttngtop is a good example, because we have a
specific set of events and contexts to enable (to avoid doing -k -a).
So as my normal user (part of the tracing group and with a sessiond
started as root), I created a typical lttngtop session like that :

lttng create lttngtop
lttng enable-event -k
lttng_statedump_start,lttng_statedump_end,lttng_statedump_process_state,lttng_statedump_file_descriptor,lttng_statedump_vm_map,lttng_statedump_network_interface,lttng_statedump_interrupt,sched_process_free,sched_switch,sched_process_fork
-s lttngtop
lttng enable-event -k --syscall -a -s lttngtop
lttng add-context -k -t pid -t procname -t tid -t ppid -t
perf:cache-misses -t perf:major-faults -t perf:branch-load-misses -s
lttngtop
lttng save lttngtop

I then destroyed the session and did
lttng load lttngtop

Everything went fine (except for the already known bug of all the
contexts information not recorded in the XML file). As expected, the XML
file was saved in ~/.lttng/sessions/lttngtop.lttng.

What surprised me was to see this message when later on I started
manually a lttng-sessiond as my user (after it had been killed) :
Error: Failed to load session lttngtop: Tracing the kernel requires a
root lttng-sessiond daemon, as well as "tracing" group membership or
root user ID for the lttng client.
Error: Session load failed: Tracing the kernel requires a root
lttng-sessiond daemon, as well as "tracing" group membership or root
user ID for the lttng client.

I did not expect that the saved sessions would try to auto load when the
sessiond was starting. I did not try with system-wide sessions, but
that's the same, I don't really expect that all sessions to be
automatically loaded on startup. I think a sysadmin (or even the lttng
installer) could make some tracing profiles available to the users in
there so that they can use them when needed.
Also, the fact that a user sessiond tries to load a session that clearly
requires a root sessiond is kind of confusing.

I can see the value of having auto-loaded sessions, but I think it
should be configurable, either directly in the XML (just like to
"started" option) or with sessions saved in a different path (for
example ~/.lttng/auto-sessions/). Also, I think that our users are never
really spawning manually a sessiond, so maybe the "lttng load -a" is
more suited for the auto-loading process.

So we could maybe add an option to the "lttng save" command that allows
the user to specify if the session should be auto-loaded. With that in
mind, should the users part of the tracing group allowed to save
auto-loading kernel sessions in the system-wide tracing directory, or
will they have to ask an admin to manually install their profile ?

I apologize for not providing this kind of feedback when the RFC was
posted here, I just realized these usability details when I actually
experimented the feature.

Thanks,

Julien
