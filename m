From: Corey Minyard <minyard@acm.org>
Subject: Re: Extract lttng trace from kernel coredump
Date: Sat, 18 Jan 2014 12:29:52 -0600
Message-ID: <52DAC820.7000005__29729.3166550391$1390088479$gmane$org@acm.org>
References: <52D46B33.4010401@acm.org> <20140114184243.GC8177@thessa>
	<52D5A08F.4020204@acm.org>
	<1303248645.9400.1390063653581.JavaMail.zimbra@efficios.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tcminyard@gmail.com>) id 1W4aee-0001uZ-8r
	for lttng-dev@lists.lttng.org; Sat, 18 Jan 2014 13:30:02 -0500
Received: by mail-ob0-f176.google.com with SMTP id gq1so3631204obb.7
	for <lttng-dev@lists.lttng.org>; Sat, 18 Jan 2014 10:29:54 -0800 (PST)
In-Reply-To: <1303248645.9400.1390063653581.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 01/18/2014 10:47 AM, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Corey Minyard" <minyard@acm.org>
>> To: "David Goulet" <dgoulet@efficios.com>
>> Cc: lttng-dev@lists.lttng.org
>> Sent: Tuesday, January 14, 2014 3:39:43 PM
>> Subject: Re: [lttng-dev] Extract lttng trace from kernel coredump
>>
>> On 01/14/2014 12:42 PM, David Goulet wrote:
>>> On 13 Jan (16:39:47), Corey Minyard wrote:
>>>> I'm working on a feature to allow an lttng trace to be extracted from a
>>>> kernel coredump, and I'm wondering the best way to proceed.  I've looked
>>>> at extracting from the existing data structures, but that would require
>>>> something to always have a trace file open and it looks more than a
>>>> little complicated.  I was thinking instead of having a different trace
>>>> channel for configuring this coredump and some globals to point to the
>>>> various data structures.  Would that be the best way to pursue this?  Is
>>>> there a better way, perhaps?
>>> Oh yes we do actually already have a way to do that :)
>>>
>>> Please see:
>>> https://git.lttng.org/?p=lttng-tools.git;a=tree;f=extras/core-handler;h=29ded89a71fd36e159d671ca1f405cea394f8683;hb=HEAD
>>>
>>> With the snapshot feature, it's quite easy to do that. Hope that helps
>>> you with what you are trying to achieve.
>> I did see that, but it seems to be for an application coredump.  I was
>> looking for something that would work for a kernel coredump.  So that if
>> the kernel crashes, you can use kdump to extract the kernel core and
>> then extract the LTT buffers from that.  The idea is that if the kernel
>> crashes, you can get some idea of what was happening before the crash.
> Something along these lines have been proposed a while back on the ML,
> but it was against an old LTTng version (0.x):
>
> http://lists.lttng.org/pipermail/lttng-dev/2010-August/014239.html
>
> It might be interesting to adapt it to the newer LTTng 2.x. Anyone interested
> to look into this ?

That was done by a colleague of mine.  However, things appear to have
changed so much since then that it doesn't seem simple to extract a
trace from memory.  It could be done, but I'm currently looking at
adding a separate transport that writes to a simpler per-core circular
data structure and doesn't actually ever generate any output.  Since it
doesn't generate any output, it can be much simpler.

But I am certainly open to suggestions on how to do this, and happy to
have anything included back into the mainline.

And I'm still learning about the internals of LTT.

Thanks,

-corey
