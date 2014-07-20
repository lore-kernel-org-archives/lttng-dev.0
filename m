From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [RFC] lttng-modules system call tracing filtering
Date: Sun, 20 Jul 2014 11:54:53 -0400
Message-ID: <53CBE64D.7080607__41591.0539719791$1405871742$gmane$org@efficios.com>
References: <1789128836.17290.1405805963800.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1X8tS1-00040s-0Z
 for lttng-dev@lists.lttng.org; Sun, 20 Jul 2014 11:55:03 -0400
In-Reply-To: <1789128836.17290.1405805963800.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 14-07-19 05:39 PM, Mathieu Desnoyers wrote:
> Hi!
> 
> I just create a dev branch with system call filtering within LTTng
> modules. Currently, only enable-event is supported at the lttng-tools
> level for this. With this feature, you can specify exactly which system
> calls you want to trace.
> 
> Here are the dev branches:
> 
> https://github.com/compudj/lttng-modules-dev branch: syscall-filtering
> https://github.com/compudj/lttng-tools-dev/ branch: syscall-filtering

Great !

Just to clarify, what happens to the exit_syscall event ?
Is it still emitted for every syscall exit or only for the ones we
selected ?
Is it renamed ?

For the CLI usage, I think having a coma separated list would be more
friendly that having to enable each syscall in a separate command, but
I'm sure it is easy to have that.

Thanks !

Julien

> 
> To use it:
> 
> #ex 1
> lttng create
> lttng enable-event -k --syscall sys_open
> lttng enable-event -k --syscall sys_close
> lttng start; sleep 3; lttng stop; lttng view
> -> should only show sys_open and sys_close syscalls.
> 
> #ex 2
> lttng create
> lttng enable-event -k --syscall -a
> lttng start; sleep 3; lttng stop; lttng view
> -> should show all syscalls
> 
> #ex 3
> lttng create
> lttng enable-event -k --syscall -a
> lttng enable-event -k --syscall sys_open
> -> returns that the system call is already enabled.
> lttng start; sleep 3; lttng stop; lttng view
> -> should show all syscalls
> 
> #ex 4
> lttng create
> lttng enable-event -k --syscall sys_open
> lttng enable-event -k --syscall -a
> lttng start; sleep 3; lttng stop; lttng view
> -> should show all syscalls
> 
> ### Now about the disable-event part (not implemented in tools yet)
> ### This is the behavior I would like:
> 
> #ex 5 (TODO)
> lttng create
> lttng enable-event -k --syscall -a
> lttng disable-event -k --syscall sys_open
> lttng start; sleep 3; lttng stop; lttng view
> -> should show all syscalls except sys_open
> 
> #ex 6 (TODO)
> lttng create
> lttng disable-event -k --syscall sys_open
> -> should fail.
> 
> For the curious, I implement this "filtering" with a per-channel
> bitmap that represents which system calls to trace. We might need
> to double-check that I got the NR_syscalls right for each
> architecture, especially those with compatibility system call
> tables (64-bit archs having 32-bit compat syscalls). For the common
> case (all system calls are traced), the pointer to the array is NULL,
> so this is a simple pointer check, which is less expensive cache-wise
> than looking up within the bitmap.
> 
> As far as lttng-tools is concerned, what is a bit different is that
> system calls don't each get a file descriptor assigned, unlike other
> tracepoint events. Therefore, we interact with them at the channel
> level. If we can find a way to send the disable-event command directly
> to the channel, with the new "u.syscall.disable" flag I added to the
> lttng ABI, we should be able to use disable-event with syscalls.
> However, I'm not sure how deeply we need to modify lttng-tools for
> this.
> 
> Feedback is welcome,
> 
> Thanks !
> 
> Mathieu
> 
