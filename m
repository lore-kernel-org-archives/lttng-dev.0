From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 6/8] Change lttng_poll_wait
 behaviour of compat-poll to match compat-epoll
Date: Wed, 20 Mar 2019 17:20:06 -0400 (EDT)
Message-ID: <1346573439.4715.1553116806538.JavaMail.zimbra__20124.6565369487$1553116818$gmane$org@efficios.com>
References: <20190319211735.7187-1-ylamarre@efficios.com>
 <20190319211735.7187-7-ylamarre@efficios.com>
 <1287337982.4641.1553110957561.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44PjVv4TKhz182f
 for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2019 17:20:07 -0400 (EDT)
In-Reply-To: <1287337982.4641.1553110957561.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yannick Lamarre <ylamarre@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On Mar 20, 2019, at 3:42 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Mar 19, 2019, at 5:17 PM, Yannick Lamarre ylamarre@efficios.com wrote:
> 
>> This removes the need to verify for eventless file descriptors and
>> mitigates risks of bug due to behaviour mismatch.
>> 
>> Signed-off-by: Yannick Lamarre <ylamarre@efficios.com>
>> ---
>> src/common/compat/compat-poll.c | 26 +++++++++++++++++++++++---
>> 1 file changed, 23 insertions(+), 3 deletions(-)
>> 
>> diff --git a/src/common/compat/compat-poll.c b/src/common/compat/compat-poll.c
>> index b7c17df7..27e2002b 100644
>> --- a/src/common/compat/compat-poll.c
>> +++ b/src/common/compat/compat-poll.c
>> @@ -292,6 +292,8 @@ error:
>> int compat_poll_wait(struct lttng_poll_event *events, int timeout)
>> {
>> 	int ret;
>> +	int count = 0, idx;
>> +	struct pollfd swapfd;
> 
> The declaration scope of swapfd should be narrower (see below).
> 
>> 
>> 	if (events == NULL || events->current.events == NULL) {
>> 		ERR("poll wait arguments error");
>> @@ -324,10 +326,28 @@ int compat_poll_wait(struct lttng_poll_event *events, int
>> timeout)
>> 	}
>> 
>> 	/*
>> -	 * poll() should always iterate on all FDs since we handle the pollset in
>> -	 * user space and after poll returns, we have to try every fd for a match.
>> +	 * Swap all nonzero revents pollfd structs to the beginning of the array to
>> +	 * emulate cpmpat-epoll behaviour.
> 
> cpmpat -> compat
> 
>> 	 */
>> -	return events->wait.nb_fd;
>> +	if ( ret != events->wait.nb_fd && ret != 0) {
> 
> remove space after if (.
> 
>> +		while (count < ret && events->wait.events[count].revents != 0) {
>> +			count += 1;
>> +		}
>> +		idx = count + 1;
>> +		while (count < ret) {
>> +			if (events->wait.events[idx].revents != 0) {
> 
> You should declare swapfd in this scope.
> 
>> +				swapfd = events->wait.events[idx];
>> +				events->wait.events[idx] = events->wait.events[count];
>> +				events->wait.events[count] = swapfd;
>> +				count += 1;
>> +			}
>> +			if (idx < (events->wait.nb_fd - 1)) {
>> +				idx += 1;
>> +			}
>> +		}
> 
> I don't think this algorithm does what is written on the box. :-/

Based on our in-person discussion, this algorithm seems to work, but
would benefit from clearer variable names, and comments. Let's continue
the discussion on a v2.

Thanks,

Mathieu


> 
> Thanks,
> 
> Mathieu
> 
> 
>> +	}
>> +
>> +	return ret;
>> 
>> error:
>> 	return -1;
>> --
>> 2.11.0
>> 
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
