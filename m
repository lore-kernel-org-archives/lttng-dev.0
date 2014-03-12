From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 08/20] tracing: Warn if a
 tracepoint is not set via debugfs
Date: Wed, 12 Mar 2014 15:30:06 -0400
Message-ID: <20140312153006.7acea4a8__34369.2631031901$1394652681$gmane$org@gandalf.local.home>
References: <20140307150920.881849073@goodmis.org>
	<1501695915.977.1394634294978.JavaMail.zimbra@efficios.com>
	<20140312111100.42ea41c2@gandalf.local.home>
	<20140312114611.43547df7@gandalf.local.home>
	<437054772.1403.1394640336308.JavaMail.zimbra@efficios.com>
	<20140312121813.1e0102aa@gandalf.local.home>
	<285520930.1511.1394642395537.JavaMail.zimbra@efficios.com>
	<20140312135059.2d497b58@gandalf.local.home>
	<1906756968.1732.1394650035535.JavaMail.zimbra@efficios.com>
	<20140312145802.4819511e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]
	helo=cdptpa-oedge-vip.email.rr.com)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rostedt@goodmis.org>) id 1WNor0-0002jT-E6
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 15:30:20 -0400
In-Reply-To: <20140312145802.4819511e@gandalf.local.home>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, "Frank Ch. Eigler" <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lttng-dev <lttng-dev@lists.lttng.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, 12 Mar 2014 14:58:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Two modules should not have the same name. Is there any duplicate
> tracepoints you are aware of. Namespace collisions in tracepoints
> should be avoided, as that would cause people to trace things they did
> not intend on tracing.
> 
> That should be a new patch as well. Enforce unique tracepoint names.

This may be why you are not understanding what I want. It's the way
things are implemented today, which I believe are wrong. I see what you
did. You have probes that are registered, and tracepoints that are
where the code lies. You just add and remove probes from a hash list,
and then you loop through all the tracepoints seeing if the iter->name
matches a probe->name.

I'm fine with keeping the probe separate, but there really should be
no more than just a one to one mapping between probes and tracepoints.
Have the probe point to the matching tracepoint. The probe is
registered, it enables the tracepoint static key, when it's ref count
goes to zero, it disables the tracepoint static key. We can get rid of
that loop then, as well as the duplicate names between probes and
tracepoints.

Here's the steps we should take:

1) Prevent duplicate tracepoints. They are just namespace collisions
that we already try to avoid. How to do this? We may need to add a
hlist_node to the tracepoint structure, and keep them in a hash by name.
Check for collisions when the name is added to the hash.

2) Change the way tracepoints are enabled. Do not do a loop of all
tracepoints, but instead have the first probe of a tracepoint enable
it, and the last one to disable it. This would require a pointer from
the probe to the tracepoint it represents. Again, it should not
represent more than one.

3) On module unload, it would be the responsibility of the user to
unload all the tracepoints that may have been enabled for a module. We
can add a mod pointer in the probe to make this easier, as well as to
the tp_module structure.

The way tracepoints are today are to handle two completely different
tracepoints with the same name. That should be avoided, and will make
things much less complex.

Then you can easily handle the accounting of modules loading and
unloading in your module, and the tracepoint code will match what the
rest of the kernel does for resource management.

-- Steve
