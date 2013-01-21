From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Query on the rculist
Date: Mon, 21 Jan 2013 09:16:46 -0500
Message-ID: <20130121141645.GB31140__42741.041215095$1358777852$gmane$org@Krystal>
References: <50FCA183.8030201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TxIB5-0002Om-5R
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 09:16:47 -0500
Content-Disposition: inline
In-Reply-To: <50FCA183.8030201@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Liu Yuan <namei.unix@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Liu Yuan (namei.unix@gmail.com) wrote:
> Hi List,
> 
>    I noticed that there are just few functions suffixed with rcu for
> rculist. And from the source of Linux kernel rculist, I came up with
> some comments saying that list_empty_rcu() can be simply achieved by
> calling list_empty(). Is this true to urcu too? My questions is, are
> following equivalents true?
> 
>   list_empty_rcu -> list_empty

Yes.

>   list_del_init_rcu -> list_del_init

No.

> 
> If there are more equivalents, please show light on it.

I will prepare a patch to extend and document the list and rculist APIs.
Your feedback is welcome.

Thanks!

Mathieu

> 
> Thanks,
> Yuan

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
