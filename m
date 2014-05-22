From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [MODULES RFC PATCH] Add PID field to block_* events
Date: Thu, 22 May 2014 07:50:34 -0600
Message-ID: <537E00AA.50804__40775.8402325728$1400772071$gmane$org@kernel.dk>
References: <1400707755-17355-1-git-send-email-jdesfossez@efficios.com>
 <779054188.21437.1400709697119.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <axboe@kernel.dk>) id 1WnTOM-0001xN-Ho
 for lttng-dev@lists.lttng.org; Thu, 22 May 2014 09:50:47 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so2555954pbb.11
 for <lttng-dev@lists.lttng.org>; Thu, 22 May 2014 06:50:36 -0700 (PDT)
In-Reply-To: <779054188.21437.1400709697119.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: lttng-dev@lists.lttng.org

On 2014-05-21 16:01, Mathieu Desnoyers wrote:
> CCing Jens Axboe, who really know better than I do about the block
> layer! Also adding Steven, since he maintains the Linux upstream block
> layer instrumentation (closely matching the lttng-modules version).

The blktrace parts are still maintained by me, actually not sure why it 
moved location.

> ----- Original Message -----
>> From: "Julien Desfossez" <jdesfossez@efficios.com>
>> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
>> Cc: lttng-dev@lists.lttng.org, "Julien Desfossez" <jdesfossez@efficios.com>
>> Sent: Wednesday, May 21, 2014 5:29:15 PM
>> Subject: [MODULES RFC PATCH] Add PID field to block_* events
>>
>> Most of the block events have the "comm" field, but we have no way to
>> match a block event to a certain PID which makes performing accurate
>> per-process analyses difficult.
>
> Color me clueless, but isn't the block I/O activity independent of
> the PID which triggers the I/O (e.g. issuing the read(), write(),
> (and so on) system calls) for read ahead, writeback kernel thread
> activity ? Or perhaps are those just rare special case, and for
> the usual case we can use the current PID in which the block layer
> tracepoints are hit as indicator of which PID triggered the I/O ?

It's usually only disconnected for the case of async writes. But even 
for that case, it's interesting to see who is submitting the IO. 
blktrace already issues a pid note, though, for every new process that 
does IO. So what problem are we trying to solve here? The case of 
multiple threads with the same ->comm?

-- 
Jens Axboe
