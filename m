From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: TMF: inconsistencies in the context vtid reporting
Date: Tue, 26 Mar 2013 11:03:11 -0400
Message-ID: <5151B8AF.1030009__45468.7333586209$1364310381$gmane$org@voxpopuli.im>
References: <CAPkDDd7B50XiXCGsc0QGq6+gZxeEOGQ=tB536vSy3k9RqbcdjQ@mail.gmail.com>
	<514CCC2B.1040802@voxpopuli.im>
	<CAPkDDd5pARpnYQPTJNY0cMZTZZogq-pg6EpJrgiGZ_aS1Zet1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1UKVRM-0002f5-Sx
	for lttng-dev@lists.lttng.org; Tue, 26 Mar 2013 11:05:33 -0400
In-Reply-To: <CAPkDDd5pARpnYQPTJNY0cMZTZZogq-pg6EpJrgiGZ_aS1Zet1A@mail.gmail.com>
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

On 13-03-26 07:24 AM, S=E9bastien Barth=E9l=E9my wrote:
>
>>> I believe my kernel trace is complete, since the following command
>>> shows no output.
>>>
>>>     $ babeltrace lttng-traces/auto-20130321-172308/kernel/ > /dev/null
>>>
>>> My userspace trace is not complete. But I believe it does not matter,
>>> because the missing events are seconds before the time window I'm
>>> interested in, and AFAIK, there is no state reconstruction involved
>>> (but may be there is?).
>> It could happen ; maybe the tracer missed an important sched_switch
>> event that set a process in a particular state. I wouldn't recommend
>> running analyses on traces with missing events, some information could
>> be all wrong.
> My kernel trace is *not* reported as incomplete, so I do not think I'm
> missing sched_switch event. Should I?

My bad, I read too quickly ;) The kernel state system (which populates
the Control Flow View and co.) only uses the kernel trace, so if you're
not missing events in that one you sould be fine.

If you create an experiment only with your UST trace, does the vtid show
correctly? Alternatively, if you create an experiment with your UST and
a second unrelated trace, are the results still the same?
