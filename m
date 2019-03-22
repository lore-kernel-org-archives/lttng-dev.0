From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools v2] Change lttng_poll_wait
 behaviour of compat-poll to match compat-epoll
Date: Fri, 22 Mar 2019 11:04:36 -0400 (EDT)
Message-ID: <8703543.6154.1553267076349.JavaMail.zimbra__25639.0459647932$1553267098$gmane$org@efficios.com>
References: <20190321150453.7312-1-ylamarre@efficios.com>
 <20190321150453.7312-6-ylamarre@efficios.com>
 <CA+jJMxui0_5EF6XLH-9G90-yJEE63zdiBifTeF4i9iQp95D7tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44Qn4j6srvz184q
 for <lttng-dev@lists.lttng.org>; Fri, 22 Mar 2019 11:04:37 -0400 (EDT)
In-Reply-To: <CA+jJMxui0_5EF6XLH-9G90-yJEE63zdiBifTeF4i9iQp95D7tg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On Mar 21, 2019, at 4:25 PM, Jeremie Galarneau jeremie.galarneau@efficios.com wrote:

[...]
>> +               assert(idx < events->wait.nb_fd);
> 
> Not needed. Using assert() is fine to highlight assumptions across
> interfaces/functions and/or catch catastrophic internal errors. Here,
> this would be a very local condition that seems to be already
> enforced.
> 
> Reworking the 'for' condition to use 'i < events->wait.nb_fd' and
> breaking out early of the loop is also an option here.

The reason for using assert() here is to ensure that there is no discrepancy
between the number of active poll fd in the set and the value returned by
poll indicating that same number of active fds.

We'd need a kernel bug (or memory corruption) to have a mismatch, but I thought
having an assert in there would not hurt, since it might help diagnose issues
that cross user-kernel boundaries.

Thoughts ?

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
