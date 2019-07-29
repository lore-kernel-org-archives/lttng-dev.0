From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 1/4] userspace-rcu: Add lock-free singly
 linked list rculflist
Date: Mon, 29 Jul 2019 09:45:24 -0400 (EDT)
Message-ID: <2135438495.917.1564407924224.JavaMail.zimbra__41842.3551179998$1564407953$gmane$org@efficios.com>
References: <1564407331-25820-1-git-send-email-junchangwang@gmail.com>
 <1564407331-25820-2-git-send-email-junchangwang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45y1Ct3YMgz187W
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 09:45:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E645325DFEE
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 09:45:24 -0400 (EDT)
In-Reply-To: <1564407331-25820-2-git-send-email-junchangwang@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Junchang Wang <junchangwang@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@linux.ibm.com>
List-Id: lttng-dev@lists.lttng.org

----- On Jul 29, 2019, at 9:35 AM, Junchang Wang junchangwang@gmail.com wrote:

> Signed-off-by: Junchang Wang <junchangwang@gmail.com>

Hi Junchang,

Thanks for submitting this! I've been on vacation for the past two weeks,
hence the delay in reply.

A few points:

I think we should move the implementation of find/insert/delete to a .c
file (rather than headers) because at least two of those functions are
larger than 10 lines, and therefore don't fall under the "trivial"
category.

I also notice that the implementation you propose is GPLv2+. Would you
be willing to re-license your contribution under LGPLv2.1 or LGPLv2.1+ ?
This is the license we use for the entire Userspace RCU library. liburcu
is meant to be used by non-GPL/LGPL programs as well.

I'll wait until I get an answer from you on those points before digging
further into the code.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
