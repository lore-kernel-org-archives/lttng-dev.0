From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: TMF: inconsistencies in the context vtid reporting
Date: Fri, 22 Mar 2013 17:24:59 -0400
Message-ID: <514CCC2B.1040802__21596.0986599841$1363987690$gmane$org@voxpopuli.im>
References: <CAPkDDd7B50XiXCGsc0QGq6+gZxeEOGQ=tB536vSy3k9RqbcdjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1UJ9Ub-0002Ax-Tp
	for lttng-dev@lists.lttng.org; Fri, 22 Mar 2013 17:27:18 -0400
In-Reply-To: <CAPkDDd7B50XiXCGsc0QGq6+gZxeEOGQ=tB536vSy3k9RqbcdjQ@mail.gmail.com>
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

On 13-03-22 06:02 AM, S=E9bastien Barth=E9l=E9my wrote:
> Hello,
>
> I'm using simultaneous kernel and userspace tracing in order to
> understand how a multi threaded application (mis)behaves at shutdown.
>
> The idea is to use userspace tracepoints in the application, augmented
> with the vtid context, in order to know which thread is calling what
> and to relate that with the threads lifespan as reconstructed from the
> kernel scheduler traces.
>
> First, is the approach ok? Am I right to expect the vtid attached to
> ust event to match the tid shown in the reconstructed kernel scheduler
> state?

It should work, yes. However note that the concept of "vtid" (virtual
thread ID) is used to differentiate the tid assigned to a process when
used within a container (LXC) vs. its tid on the host. You could use
context.tid too, but if you don't use containers those two should be the
same.

> Should I expect "time shifts" between the kernel and userspace traces
> (which would make the correlation harder).

Ideally no, but depending on your kernel/libc versions, UST might not
have access to the same time sources as the kernel tracer, so you could
get small offsets. Maybe one of the tracer devs can give a better
explanation.

>
> I was hoping to see the unix signals in the kernel trace too but could
> not find them so far.
>
> So now, the problem is that I get inconsistencies: some UST events
> report a vtid which is shown as waiting by the kernel trace (both in
> the Control Flow and the Resources views). How could a waiting thread
> trigger an UST event?
>
> I believe my kernel trace is complete, since the following command
> shows no output.
>
>     $ babeltrace lttng-traces/auto-20130321-172308/kernel/ > /dev/null
>
> My userspace trace is not complete. But I believe it does not matter,
> because the missing events are seconds before the time window I'm
> interested in, and AFAIK, there is no state reconstruction involved
> (but may be there is?).

It could happen ; maybe the tracer missed an important sched_switch
event that set a process in a particular state. I wouldn't recommend
running analyses on traces with missing events, some information could
be all wrong.

Unless you are on an embedded platform with very limited memory, it's
usually safe to increase the buffer size to a couple MBs. See
--enable-channel and --subbuf-size in the LTTng man page. I have to warn
you about https://bugs.lttng.org/issues/228 in advance though...

I still think the default value should be higher (and have the embedded
guys use --subbuf-size to reduce it), but I don't call those shots ;)

> I eventually came to a more blatant inconsistency: the displayed
> context vtid of an event is not always the same.
>
> [...]
>
> I'm using TMF 2.0.0.201303211612 (nightly build from yesterday).

Are your traces available somewhere (if they can be made public)? I
would like to take a look at it, it seems the CTF parser gets confused
between vtid and vpid for some weird reason...

> And by the way, thank your for the support I already got on IRC
> yesterday, you're a dream project to work with.

Thanks! That's encouraging to hear ;)


Cheers,
Alex
