From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Use MAP_POPULATE to reduce
 pagefault when available
Date: Mon, 29 Jul 2019 14:44:36 -0400 (EDT)
Message-ID: <1669745760.2413.1564425876417.JavaMail.zimbra__2878.78877004317$1564425892$gmane$org@efficios.com>
References: <20190729182356.21025-1-jonathan.rajotte-julien@efficios.com>
 <107439491.2361.1564425123412.JavaMail.zimbra@efficios.com>
 <88fc6fd6-bdc1-402b-32c6-f3b48674f931@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45y7s12mryz1Fr9
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 14:44:37 -0400 (EDT)
In-Reply-To: <88fc6fd6-bdc1-402b-32c6-f3b48674f931@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Yiteng Guo <guoyiteng@gmail.com>
List-Id: lttng-dev@lists.lttng.org

----- On Jul 29, 2019, at 2:41 PM, Sebastien Boisvert sboisvert@gydle.com wrote:

> nits:
> 
> On 2019-07-29 2:32 p.m., Mathieu Desnoyers wrote:
>>> A similar flag seems to exists on freebsd (MAP_PREFAULT_READ) but I do
>> 
>> exists -> exit
> 
> exist ?

Indeed :)

> 
> 
>>> [1] https://lists.lttng.org/pipermail/lttng-dev/2019-July/029122.html
>>>
>>> Tested-by: Yiteng Guo <guoyiteng@gmail.com> [1]
>> 
>> I think you might want to add a # before [1] so automated tools don't
>> get confused here. But even better, just describe it has been tested
>> above in the commit message.
> 
> The "Link:" tag can be used for that.

Yes, good point!

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
