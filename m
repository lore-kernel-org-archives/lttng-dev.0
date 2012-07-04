From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [babeltrace] FTS does not support large files on
	32-bit
Date: Wed, 04 Jul 2012 16:37:42 -0400
Message-ID: <4FF4A996.8040606__4628.84663506902$1341434299$gmane$org@gmail.com>
References: <20120630185335.GA31235@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-gh0-f176.google.com ([209.85.160.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SmWKc-0006OU-Az
	for lttng-dev@lists.lttng.org; Wed, 04 Jul 2012 16:37:50 -0400
Received: by ghbz10 with SMTP id z10so7825845ghb.35
	for <lttng-dev@lists.lttng.org>; Wed, 04 Jul 2012 13:37:44 -0700 (PDT)
In-Reply-To: <20120630185335.GA31235@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jdesfossez@efficios.com
List-Id: lttng-dev@lists.lttng.org

On 2012-06-30 14:53, Mathieu Desnoyers wrote:
> Hi Yannick,
>
> The babeltrace commit:
>
> We should therefore go back to FTW to support large files on 32-bit. Is
> there any reason why we moved from ftw to fts ?
>

FTS does not use callbacks, which makes it easier to use.
Also since it was supposed to be part of the babeltrace API, not having
to manage a callbacks looked better.

Might had other reasons at the time, but now I don't see any more.

Yannick
