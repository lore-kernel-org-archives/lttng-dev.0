From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [for-next][PATCH 08/20] tracing: Warn if a tracepoint is not
 set via debugfs
Date: Wed, 12 Mar 2014 16:39:55 +0000 (UTC)
Message-ID: <285520930.1511.1394642395537.JavaMail.zimbra@efficios.com>
References: <20140307150920.881849073@goodmis.org> <1752080128.130.1394559263621.JavaMail.zimbra@efficios.com> <20140311151357.077c5a68@gandalf.local.home> <1501695915.977.1394634294978.JavaMail.zimbra@efficios.com> <20140312111100.42ea41c2@gandalf.local.home> <20140312114611.43547df7@gandalf.local.home> <437054772.1403.1394640336308.JavaMail.zimbra@efficios.com> <20140312121813.1e0102aa@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140312121813.1e0102aa@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Johannes Berg <johannes.berg@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lttng-dev <lttng-dev@lists.lttng.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Steven Rostedt" <rostedt@goodmis.org>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@kernel.org>, "Frederic
> Weisbecker" <fweisbec@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Johannes Berg"
> <johannes.berg@intel.com>, "Linus Torvalds" <torvalds@linux-foundation.org>, "Peter Zijlstra"
> <peterz@infradead.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
> "lttng-dev" <lttng-dev@lists.lttng.org>, "Rusty Russell" <rusty@rustcorp.com.au>
> Sent: Wednesday, March 12, 2014 12:18:13 PM
> Subject: Re: [for-next][PATCH 08/20] tracing: Warn if a tracepoint is not set via debugfs
> 
> On Wed, 12 Mar 2014 16:05:36 +0000 (UTC)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > ----- Original Message -----
> > > From: "Steven Rostedt" <rostedt@goodmis.org>
> > > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > > Cc: "Frank Ch. Eigler" <fche@redhat.com>, linux-kernel@vger.kernel.org,
> > > "Ingo Molnar" <mingo@kernel.org>, "Frederic
> > > Weisbecker" <fweisbec@gmail.com>, "Andrew Morton"
> > > <akpm@linux-foundation.org>, "Johannes Berg"
> > > <johannes.berg@intel.com>, "Linus Torvalds"
> > > <torvalds@linux-foundation.org>, "Peter Zijlstra"
> > > <peterz@infradead.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Greg
> > > Kroah-Hartman" <gregkh@linuxfoundation.org>,
> > > "lttng-dev" <lttng-dev@lists.lttng.org>, "Rusty Russell"
> > > <rusty@rustcorp.com.au>
> > > Sent: Wednesday, March 12, 2014 11:46:11 AM
> > > Subject: Re: [for-next][PATCH 08/20] tracing: Warn if a tracepoint is not
> > > set via debugfs
> > > 
> > > 
> > > To sum up this thread, and get the signal vs noise ratio up.
> > > 
> > > On Wed, 12 Mar 2014 11:11:00 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > 
> > > > The solution I like the most that I believe will work for both of us,
> > > > is to to move this magic "enable tracepoint in the future" to your
> > > > LTTng module. Have your module register a module load and unload
> > > > handler
> > > > to be able to see the tracepoints that exist in the module, and you can
> > > > enable them then. When a module is unloaded, your module can do the
> > > > accounting to record that, and the state of its tracepoints.
> > > 
> > > This is my final proposal.
> > > 
> > > I'll add the patch that removes the tracepoint on failure along with
> > > returning -ENODEV. That way, there will be no registered tracepoints
> > > that do not exist.
> > > 
> > > I'll also make sure that on module unload, the tracepoints are disabled
> > > for the module as well.
> > 
> > Do you mean that the tracepoint probe will be unregistered from within
> > tracepoint.c whenever all modules containing tracepoint call sites are
> > unloaded ? If so, how do you plan to handle ownership of the "name",
> > "probe" and "data" pointer ? They belong to the tracer. Would they simply
> > leak ?
> 
> Are you telling me it's not possible to delete the entire probe?

The ownership flow is the following:

1) Tracer creates name, probe, data objects. The probe can be typically
   code within a probe provider module, which needs to have a reference
   count incremented. The name and data objects can be dynamically allocated,
   or in some special cases part of a probe provider module (again with
   refcount incremented).

2) The tracer registers the tracepoint probe. If registration returns 0,
   the tracer should not free those elements until it calls tracepoint
   probe unregister for that (name, probe, data) tuple.

3) Tracer calls tracepoint probe unregister for the (name, probe, data) tuple.

4) Tracer calls tracepoint_synchronize_unregister() to ensure quiescence
   of tracepoint call sites wrt the probe that has just been unregistered.

5) Tracer can free/unref the probe provider module.

> 
> What I'm proposing is to do what the trace events do. Delete everything
> associated to the tracepoints associated to the module.

Is your intent to have a module "going" notifier in tracepoint.c managing
ownership of objects it does not own ? If not, I guess I'm not understanding
your proposal fully.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
