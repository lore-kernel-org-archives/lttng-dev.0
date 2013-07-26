From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Misc questions regarding kernel tracing
Date: Fri, 26 Jul 2013 16:16:02 -0400
Message-ID: <51F2D902.80701__28890.2538516142$1374869822$gmane$org@voxpopuli.im>
References: <CAPkDDd4QX-Coj5rnqZp5pLjrzWOUDOvRu+6PWZW+EOYAEH0vtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1V2oQq-0002qD-Dy
	for lttng-dev@lists.lttng.org; Fri, 26 Jul 2013 16:16:14 -0400
In-Reply-To: <CAPkDDd4QX-Coj5rnqZp5pLjrzWOUDOvRu+6PWZW+EOYAEH0vtw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?S=E9bastien_Barth=E9l=E9my?= <barthelemy@crans.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi S=E9bastien,

On 13-07-26 12:36 PM, S=E9bastien Barth=E9l=E9my wrote:
> Hello all,
>
> I am investigating a problem on a rt system which misses deadlines under
> load. Yet another occasion to use LTTng! But this comes with a bunch of
> newcomer questions.
>
> I'd like to reconstruct the state of the scheduler (the control view in
> eclipse) with the minimum amount of traces from the kernel. So far I
> recorded only the sched* events and it seems ok. But I suspect I should
> also enable some lttng_statedump* to garantee a clean state at the very
> beginning of the trace. Could you confirm this?

Yes, statedump events will help with the inital state (the statedump
doesn't happen exactly at the beginning of the trace, but shortly
after). In many cases, you have a lot of processes running, but for
those that stay idle for the whole trace, you would not see them at all
unless you enable the state dump.

> Also, I see threads which do "clone" a lot in the eclipse control view, b=
ut
> looking at the raw traces (only the sched* events) I do not understand how
> eclipse can figure it out. Is this an artefact of trying to use a kernel
> trace which misses the syscall events or can I trust these "clone"?

To create new entries in the list, it looks at "sched_process_fork". The
initial state of those processes is set to the state of its parent
process, which is normally (always?) a "sys_clone" at that time.

If the state of the parent is not available, it will default to
"sys_clone". This can happen for events happening before the statedump
for example.

> More generally, is there a comprehensive guide somewhere that you would
> recommend in order to understand the precise meaning of these sched* even=
ts?

Probably the kernel documentation? I've asked around and never found a
clear answer ;)

In Eclipse/TMF, you can look at LttngKernelStateProvider.java to see how
different events are handled. The syntax is a bit verbose, but it should
be straightforward. It started with my (limited) knowledge of kernel
events and states, and evolved iteratively as bugs/errors were reported.

> Is there a way to trim a trace (remove the beginning and/or the end)
> without compromising the scheduler state reconstruction?

We do plan to have a trim/export feature, but it's not implemented yet.
The viewer already has all the information needed to create the full
state at any point in the trace, so it could recreate a "statedump" for
any trimmed interval.

> I sometimes miss kernel events. Is there a point in using different
> channels for kernel and user space traces (besides giving them distinct
> sizes)? I suspect they're already effectively different even if they have
> the same name. Also, I have increased the subbuffer size a lot, but did n=
ot
> change the number of subbuffers. Would that help preventing missed events?

Yeah, lost events are a big problem for state and other types of
analysis. Garbage in, garbage out! Increasing the buffer sizes helps,
but if the tracer produces events faster than the consumer can write
them, for anything other than a very short trace it will start dropping
events at some point.

Writing the trace to a fast drive, like a Ramdisk or a SSD, could help.
Also, try reducing the number of enabled events. As more and more kernel
tracepoints are exposed through LTTng, "enable-event -a -k" starts
generating more and more events. For specific analyzes it's becoming
important to only enable the subset of events that are required.


Cheers,
Alexandre

>
> Thanks!
>
