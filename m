From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: [RFC] User space stack trace on system calls
Date: Fri, 30 Aug 2013 23:38:30 -0400
Message-ID: <52216536.40709__28326.6152990565$1377920368$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VFc1J-0002g3-O5
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 23:38:44 -0400
Received: by mail-qe0-f54.google.com with SMTP id cz11so67309qeb.13
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 20:38:36 -0700 (PDT)
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

Hi,

To locate where are made system calls in an application, I developed two
prototypes that dumps stack traces.

The first one is using event context [1]. When an tracepoint is reached,
then the stack trace of the currently running userspace thread is done
and saved. This event context can be attached to any event, thus this
technique is general. The drawback is that the context is defined per
channel, thus the user will usually wants a separate channel for
selected events. The other drawback is related to the way lttng handles
system call events. By enabling system calls, we get automatically both
entries and exits events in a single channel, and thus the same user
space stack trace is dumped twice. It also requires changes to lttng-tools.

To avoid this issue, I also tried to create one event called
sys_entry_callsite that is called only on sys_entry [2]. Thus, the stack
trace is recorded only once. It's also possible to enable it with all
other events in one channel. It's less flexible, but easier to use. It
also requires to define a tracepoint in a module, so on latest ubuntu,
it requires the modules to be signed. The code that dumps the stack
trace is called only when the actual tracepoint is enabled. We actually
found a way to insert code inside the probe with code blocks that
returns a value. Thanks to Simon Marquis for this C trick!

Both can have their use cases, so maybe both could be used? Anyway, I
post both of them for discussion.

[1]
https://github.com/giraldeau/lttng-modules/blob/addons/lttng-context-callstack.c
[2]
https://github.com/giraldeau/lttng-modules/blob/addons/addons/lttng-syscall-entry.c

Thanks!

Francis Giraldeau
