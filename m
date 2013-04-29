From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Using the additional Eclipse Kernel Trace Plugin
 Views (Control flow, Resources)
Date: Mon, 29 Apr 2013 13:05:29 -0400
Message-ID: <517EA859.5010203__33534.3995284804$1367255336$gmane$org@voxpopuli.im>
References: <517E4E38.6030507@stud.fh-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1UWrYo-0004hW-4p
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 13:08:18 -0400
In-Reply-To: <517E4E38.6030507@stud.fh-dortmund.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andre Bette <andreb@stud.fh-dortmund.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 13-04-29 06:40 AM, Andre Bette wrote:
> Hi to everyone,
> in my project I am tracing a embedded system with a non linux OS.
> Output format is CTF. I really like the two extra views in the Eclipse
> Kernel Trace Visualization (Control flow, Resources).
>
> Is there a simple way to use this two views  with an non linux trace ?
> Is there any documentation about the Linux kernel trace format( the
> extra info added into the CTF format) or how the
> data(e.g. prozesses) is processed in the Eclipse Kernel Trace Plugin
> (The idea is to use a "fake" linux trace to use the two extra views. )?

Hi Andre,

This is definitely possible, the idea will be to build a custom state
system provider to populate your view. This seems to be a hot topic
recently! Here's a copy of an email I sent internally last week on the
subject.

(just note that we are currently in the process of cleaning up our APIs.
So if you pull from master later this week, IStateChangeInput should be
renamed to ITmfStateProvider, and CtfKernelStateInput to
LttngKernelStateProvider. But the functionality will remain the same.)


Hi all,

Unfortunately we don't really have any complete documentation about the
state system and its usage (we had some at some point but it quickly
became outdated...) Our goal is to move to state providers defined in
external files, like XML files, instead of being done programmatically
for every trace type. This will make it easier for people to implement
their own. It's still at the early stages now though, but you can follow
/ comment on this discussion on the linuxtools-dev mailing list:
http://dev.eclipse.org/mhonarc/lists/linuxtools-dev/msg02500.html
(and the follow-ups).

But for now, if you want to use a state system and related views in your
own plugins, you will have to define the state provider in Java code.
The idea of this class is to indicate which trace events will cause
which *state changes*. Which is why it's called IStateChangeInput, it's
an input of state changes.
For example, in Linux kernel traces, the "sched_switch" event will
change a process from the "running" state to the "idle" state, and
another process from "idle" to "running".
You can look at CtfKernelStateInput.java in the TMF git tree, it shows
you how we do it for our LTTng-kernel trace analysis.
You can also look at CtfKernelTrace#buildStateSystem to see how to tell
a given trace type to use a given state input.

With that done, once you load your trace in TMF and assign it your trace
type, it should index and build the requested state system. Views will
now be able to query it. You can look for example at
ControlFlowView.java and search for
"getStateSystems().get(CtfKernelTrace.STATE_ID)" and the following
lines. You'll see how the view queries the state system for information.

Finally, you can look at an old blog post I made at
http://www.dorsal.polymtl.ca/blog/alexandre-montplaisir/introduction-state-history
It explains in particular the notion of attribute, state change, current
state, etc. "Event handler" is now what we call the "state provider" or
"state change input".


This is just a high-level overview, if you have any other question or if
something is not clear, don't hesitate to contact me!

Cheers,
Alexandre


>
>
>
> Best Regards,
> Andre
>
