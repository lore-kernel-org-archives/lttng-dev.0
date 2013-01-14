From: Josh Stone <jistone@redhat.com>
Subject: Re: [lttng-modules PATCH] Add uprobes support
Date: Mon, 14 Jan 2013 10:05:10 -0800
Message-ID: <50F448D6.7050600__28797.3668113866$1358186762$gmane$org@redhat.com>
References: <1358131230-3446-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jistone@redhat.com>) id 1TuoPN-0000bi-0G
	for lttng-dev@lists.lttng.org; Mon, 14 Jan 2013 13:05:17 -0500
In-Reply-To: <1358131230-3446-1-git-send-email-yannick.brosseau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 01/13/2013 06:40 PM, Yannick Brosseau wrote:
> +	ret = uprobe_register(event->u.uprobe.inode,
> +			event->u.uprobe.offset,
> +			&event->u.uprobe.up_consumer);

> +	uprobe_unregister(event->u.uprobe.inode,
> +			event->u.uprobe.offset,
> +			&event->u.uprobe.up_consumer);

I'm guessing that you're using a Fedora kernel? :)

These functions are not yet exported upstream, but coincidentally I just
posted a patch for that a few days ago:

  https://patchwork.kernel.org/patch/1962891/
  https://lkml.org/lkml/2013/1/13/118

If there's any more complaint about this, maybe you can chime in to
advocate for lttng's needs too.

Thanks,
Josh
