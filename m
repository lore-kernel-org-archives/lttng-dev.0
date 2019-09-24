From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: use newly created event
 filter for condition check
Date: Tue, 24 Sep 2019 11:22:23 -0400
Message-ID: <20190924152223.GI187569__17868.9457288542$1569338557$gmane$org@joraj-alpa>
References: <20190924145316.21302-1-jonathan.rajotte-julien@efficios.com>
 <325249304.599.1569337736318.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46d4gN03srz1MwD
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 11:22:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <325249304.599.1569337736318.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

> > 4c5e3185d75ffe90b04107744693964d9051fb6b introduced a regression while
> > fixing the filter and filter_expression ownership.
> 
> What is this commit ? I'm having trouble finding it. Can you double-check and
> provide the commit Subject as well ?

Seems like I copied the parent tree commit.

See v2

Cheers
