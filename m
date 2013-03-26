From: =?ISO-8859-1?Q?S=E9bastien_Barth=E9l=E9my?= <barthelemy@crans.org>
Subject: Re: TMF: inconsistencies in the context vtid reporting
Date: Tue, 26 Mar 2013 12:24:36 +0100
Message-ID: <CAPkDDd5pARpnYQPTJNY0cMZTZZogq-pg6EpJrgiGZ_aS1Zet1A__27170.9164874212$1364297146$gmane$org@mail.gmail.com>
References: <CAPkDDd7B50XiXCGsc0QGq6+gZxeEOGQ=tB536vSy3k9RqbcdjQ@mail.gmail.com>
	<514CCC2B.1040802@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sebastien.barthelemy@gmail.com>) id 1UKRze-0000rZ-Eb
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 07:24:42 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so615323wib.9
	for <lttng-dev@lists.lttng.org>; Tue, 26 Mar 2013 04:24:36 -0700 (PDT)
In-Reply-To: <514CCC2B.1040802@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Fri, Mar 22, 2013 at 10:24 PM, Alexandre Montplaisir
<alexmonthy@voxpopuli.im> wrote:
> Hi S=E9bastien,
>
> On 13-03-22 06:02 AM, S=E9bastien Barth=E9l=E9my wrote:
>> Hello,
>>
>> I'm using simultaneous kernel and userspace tracing in order to
>> understand how a multi threaded application (mis)behaves at shutdown.
>>
>> The idea is to use userspace tracepoints in the application, augmented
>> with the vtid context, in order to know which thread is calling what
>> and to relate that with the threads lifespan as reconstructed from the
>> kernel scheduler traces.
>>
>> First, is the approach ok? Am I right to expect the vtid attached to
>> ust event to match the tid shown in the reconstructed kernel scheduler
>> state?
>
> It should work, yes. However note that the concept of "vtid" (virtual
> thread ID) is used to differentiate the tid assigned to a process when
> used within a container (LXC) vs. its tid on the host. You could use
> context.tid too, but if you don't use containers those two should be the
> same.

Thank you for the clarification. I didn't knew tip could be attached
to a UST event.

>> I believe my kernel trace is complete, since the following command
>> shows no output.
>>
>>     $ babeltrace lttng-traces/auto-20130321-172308/kernel/ > /dev/null
>>
>> My userspace trace is not complete. But I believe it does not matter,
>> because the missing events are seconds before the time window I'm
>> interested in, and AFAIK, there is no state reconstruction involved
>> (but may be there is?).
>
> It could happen ; maybe the tracer missed an important sched_switch
> event that set a process in a particular state. I wouldn't recommend
> running analyses on traces with missing events, some information could
> be all wrong.

My kernel trace is *not* reported as incomplete, so I do not think I'm
missing sched_switch event. Should I?

> Unless you are on an embedded platform with very limited memory, it's
> usually safe to increase the buffer size to a couple MBs. See
> --enable-channel and --subbuf-size in the LTTng man page. I have to warn
> you about https://bugs.lttng.org/issues/228 in advance though...

ok, thank you for the tip.

> I still think the default value should be higher (and have the embedded
> guys use --subbuf-size to reduce it), but I don't call those shots ;)
>
>> I eventually came to a more blatant inconsistency: the displayed
>> context vtid of an event is not always the same.
>>
>> [...]
>>
>> I'm using TMF 2.0.0.201303211612 (nightly build from yesterday).
>
> Are your traces available somewhere (if they can be made public)? I
> would like to take a look at it, it seems the CTF parser gets confused
> between vtid and vpid for some weird reason...

No, sorry, I cannot easily share the trace. And I have not found a simple w=
ay
to trig the bug.
