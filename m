From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [lttng-modules PATCH] Add uprobes support
Date: Mon, 14 Jan 2013 13:18:35 -0500
Message-ID: <50F44BFB.3070206__13355.9309797876$1358187570$gmane$org@gmail.com>
References: <1358131230-3446-1-git-send-email-yannick.brosseau@gmail.com>
	<50F448D6.7050600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TuocJ-0000ib-3T
	for lttng-dev@lists.lttng.org; Mon, 14 Jan 2013 13:18:39 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so5449631iea.24
	for <lttng-dev@lists.lttng.org>; Mon, 14 Jan 2013 10:18:37 -0800 (PST)
In-Reply-To: <50F448D6.7050600@redhat.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Josh Stone <jistone@redhat.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-01-14 13:05, Josh Stone wrote:
> On 01/13/2013 06:40 PM, Yannick Brosseau wrote:
>> +	ret = uprobe_register(event->u.uprobe.inode,
>> +			event->u.uprobe.offset,
>> +			&event->u.uprobe.up_consumer);
>> +	uprobe_unregister(event->u.uprobe.inode,
>> +			event->u.uprobe.offset,
>> +			&event->u.uprobe.up_consumer);
> I'm guessing that you're using a Fedora kernel? :)
Oh, you're right... I did not realize that the vanilla kernel did not
contains those export.
>
> These functions are not yet exported upstream, but coincidentally I just
> posted a patch for that a few days ago:
>
>   https://patchwork.kernel.org/patch/1962891/
>   https://lkml.org/lkml/2013/1/13/118
>
> If there's any more complaint about this, maybe you can chime in to
> advocate for lttng's needs too.
>
Ok, I'll weight in if necessary.

Yannick
