From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [for-next][PATCH 08/20] tracing: Warn if a tracepoint is not
 set via debugfs
Date: Wed, 12 Mar 2014 14:58:02 -0400
Message-ID: <20140312145802.4819511e@gandalf.local.home>
References: <20140307150920.881849073@goodmis.org>
	<1501695915.977.1394634294978.JavaMail.zimbra@efficios.com>
	<20140312111100.42ea41c2@gandalf.local.home>
	<20140312114611.43547df7@gandalf.local.home>
	<437054772.1403.1394640336308.JavaMail.zimbra@efficios.com>
	<20140312121813.1e0102aa@gandalf.local.home>
	<285520930.1511.1394642395537.JavaMail.zimbra@efficios.com>
	<20140312135059.2d497b58@gandalf.local.home>
	<1906756968.1732.1394650035535.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1906756968.1732.1394650035535.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Johannes Berg <johannes.berg@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lttng-dev <lttng-dev@lists.lttng.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: lttng-dev@lists.lttng.org

On Wed, 12 Mar 2014 18:47:15 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
 
> > On module unload, the events are destroyed.
> 
> Isn't trace_event.c responsible for dealing with tracepoint probes rather
> than call sites ? This is quite different. A tracepoint probe "foo" is only
> located within a single module (the one you are unloading here). However,
> if you try to unload a module that contains the callsite "foo", you have no
> guarantee that no other modules also contain this callsite, and therefore
> you cannot destroy the associated name, probe, nor data objects.

No module should have the same tracepoint name as another module.
That's just broken. Although we do not technically enforce this, in
practice that has been the case.


> 
> > 
> > Thus, what your module should do, is exactly what event_remove() does.
> > On module unload, you unregister any of the tracepoints that were
> > registered. Just like any other module resource. If you request a
> > resource on the behalf of a module, it is up to you to free it when the
> > module is unloaded.
> 
> You seem to try to apply a logic that works in the case of the probes
> defined by trace event to tracepoint call sites, but the fact is that
> they are very different. Or again perhaps I'm just on the wrong track.
> 
> > 
> > The tracepoint code will just destroy what it set up when the module
> > was loaded. It's up to your module to clean up the allocations that you
> > made when the module was loaded on unload. Just like we do for all
> > other resources.
> > 
> > Mathieu, stop thinking that tracepoints are special. They are not.
> 
> I'm trying to understand how module going of tracepoint probes and
> call sites can be considered the same. What am I missing ?

What creates the tracepoint probe? For all purposes, it should be
either created on boot up (on core tracepoints), or when a module is
loaded.

Two modules should not have the same name. Is there any duplicate
tracepoints you are aware of. Namespace collisions in tracepoints
should be avoided, as that would cause people to trace things they did
not intend on tracing.

That should be a new patch as well. Enforce unique tracepoint names.

-- Steve
