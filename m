From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [MODULES RFC PATCH] Add PID field to block_* events
Date: Thu, 22 May 2014 10:29:15 -0400
Message-ID: <537E09BB.7000808__36046.5295533233$1400769038$gmane$org@efficios.com>
References: <1400707755-17355-1-git-send-email-jdesfossez@efficios.com>
 <779054188.21437.1400709697119.JavaMail.zimbra@efficios.com>
 <537E00AA.50804@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1WnTzo-0002AB-UN
 for lttng-dev@lists.lttng.org; Thu, 22 May 2014 10:29:30 -0400
In-Reply-To: <537E00AA.50804@kernel.dk>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jens Axboe <axboe@kernel.dk>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: lttng-dev@lists.lttng.org

On 14-05-22 09:50 AM, Jens Axboe wrote:
> On 2014-05-21 16:01, Mathieu Desnoyers wrote:
>> CCing Jens Axboe, who really know better than I do about the block
>> layer! Also adding Steven, since he maintains the Linux upstream block
>> layer instrumentation (closely matching the lttng-modules version).
> 
> The blktrace parts are still maintained by me, actually not sure why it
> moved location.
> 
>> ----- Original Message -----
>>> From: "Julien Desfossez" <jdesfossez@efficios.com>
>>> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
>>> Cc: lttng-dev@lists.lttng.org, "Julien Desfossez"
>>> <jdesfossez@efficios.com>
>>> Sent: Wednesday, May 21, 2014 5:29:15 PM
>>> Subject: [MODULES RFC PATCH] Add PID field to block_* events
>>>
>>> Most of the block events have the "comm" field, but we have no way to
>>> match a block event to a certain PID which makes performing accurate
>>> per-process analyses difficult.
>>
>> Color me clueless, but isn't the block I/O activity independent of
>> the PID which triggers the I/O (e.g. issuing the read(), write(),
>> (and so on) system calls) for read ahead, writeback kernel thread
>> activity ? Or perhaps are those just rare special case, and for
>> the usual case we can use the current PID in which the block layer
>> tracepoints are hit as indicator of which PID triggered the I/O ?
> 
> It's usually only disconnected for the case of async writes. But even
> for that case, it's interesting to see who is submitting the IO.
> blktrace already issues a pid note, though, for every new process that
> does IO. So what problem are we trying to solve here? The case of
> multiple threads with the same ->comm?

Yes, exactly.
My original intent was to link the system calls to actual block requests
and identify the requests that hit the cache. But since the link between
these events is not obvious, I'm thinking of computing a per-thread
disk/cache hit ratio.

Thanks,

Julien
