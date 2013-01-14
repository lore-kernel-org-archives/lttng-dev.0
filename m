From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-modules PATCH] Add uprobes support
Date: Mon, 14 Jan 2013 14:54:11 -0500
Message-ID: <50F46263.9000807__11035.7599835426$1358193295$gmane$org@efficios.com>
References: <1358131230-3446-1-git-send-email-yannick.brosseau@gmail.com>
	<50F448D6.7050600@redhat.com> <50F44BFB.3070206@gmail.com>
	<20130114195104.GA11211@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Tuq6l-0001Tx-RD
	for lttng-dev@lists.lttng.org; Mon, 14 Jan 2013 14:54:12 -0500
In-Reply-To: <20130114195104.GA11211@Krystal>
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

+1

Especially because Uprobe is in mainline since 3.5, would be nice to
support it before it gets in 3.8+ ...

Cheers!
David

Mathieu Desnoyers:
> * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
>> On 2013-01-14 13:05, Josh Stone wrote:
>>> On 01/13/2013 06:40 PM, Yannick Brosseau wrote:
>>>> +	ret = uprobe_register(event->u.uprobe.inode,
>>>> +			event->u.uprobe.offset,
>>>> +			&event->u.uprobe.up_consumer);
>>>> +	uprobe_unregister(event->u.uprobe.inode,
>>>> +			event->u.uprobe.offset,
>>>> +			&event->u.uprobe.up_consumer);
>>> I'm guessing that you're using a Fedora kernel? :)
>> Oh, you're right... I did not realize that the vanilla kernel did not
>> contains those export.
>>>
>>> These functions are not yet exported upstream, but coincidentally I just
>>> posted a patch for that a few days ago:
>>>
>>>   https://patchwork.kernel.org/patch/1962891/
>>>   https://lkml.org/lkml/2013/1/13/118
>>>
>>> If there's any more complaint about this, maybe you can chime in to
>>> advocate for lttng's needs too.
>>>
>> Ok, I'll weight in if necessary.
> 
> Yes, we should be able to help out if needed.
> 
> Meanwhile, we could use kallsyms to lookup these symbols and use them,
> as we already do in a couple of header under wrappers/ in lttng-modules.
> 
> Thanks,
> 
> Mathieu
> 
