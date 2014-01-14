From: Corey Minyard <minyard@acm.org>
Subject: Re: Extract lttng trace from kernel coredump
Date: Tue, 14 Jan 2014 14:39:43 -0600
Message-ID: <52D5A08F.4020204__46877.9459748932$1389733097$gmane$org@acm.org>
References: <52D46B33.4010401@acm.org> <20140114184243.GC8177@thessa>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tcminyard@gmail.com>) id 1W3Am7-00005B-7G
	for lttng-dev@lists.lttng.org; Tue, 14 Jan 2014 15:39:56 -0500
Received: by mail-ob0-f172.google.com with SMTP id vb8so166804obc.31
	for <lttng-dev@lists.lttng.org>; Tue, 14 Jan 2014 12:39:45 -0800 (PST)
In-Reply-To: <20140114184243.GC8177@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 01/14/2014 12:42 PM, David Goulet wrote:
> On 13 Jan (16:39:47), Corey Minyard wrote:
>> I'm working on a feature to allow an lttng trace to be extracted from a
>> kernel coredump, and I'm wondering the best way to proceed.  I've looked
>> at extracting from the existing data structures, but that would require
>> something to always have a trace file open and it looks more than a
>> little complicated.  I was thinking instead of having a different trace
>> channel for configuring this coredump and some globals to point to the
>> various data structures.  Would that be the best way to pursue this?  Is
>> there a better way, perhaps?
> Oh yes we do actually already have a way to do that :)
>
> Please see:
> https://git.lttng.org/?p=lttng-tools.git;a=tree;f=extras/core-handler;h=29ded89a71fd36e159d671ca1f405cea394f8683;hb=HEAD
>
> With the snapshot feature, it's quite easy to do that. Hope that helps
> you with what you are trying to achieve.

I did see that, but it seems to be for an application coredump.  I was
looking for something that would work for a kernel coredump.  So that if
the kernel crashes, you can use kdump to extract the kernel core and
then extract the LTT buffers from that.  The idea is that if the kernel
crashes, you can get some idea of what was happening before the crash.


Thanks,

-corey

> Cheers!
> David
>
>> Thanks,
>>
>> -corey
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
