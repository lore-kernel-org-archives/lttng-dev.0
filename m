From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Getting SIGBUS in babeltrace - occasionally
Date: Wed, 24 Jul 2013 08:34:11 -0400
Message-ID: <20130724123411.GA15791__2515.91458586535$1374669431$gmane$org@Krystal>
References: <OF7F44BB67.0C2115DF-ONC2257BB2.003205F9-C2257BB2.00323AF2@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V1yGj-0007Na-H1
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 08:34:17 -0400
Content-Disposition: inline
In-Reply-To: <OF7F44BB67.0C2115DF-ONC2257BB2.003205F9-C2257BB2.00323AF2@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Amit Margalit (AMITM@il.ibm.com) wrote:
> Hi,
> 
> I am getting occasional SIGBUS inside _aligned_integer_read() in 
> ./formats/ctf/types/integer.c
> 
> Here is the backtrace, maybe someone could take a look and suggest 
> something:

It looks like you're hitting the internal checks for overflow on the
buffer boundaries.

On which babeltrace version can you reproduce it ? Did you do any
modification to babeltrace on your own on top ?

Are you getting this with a lttng-ust or lttng-modules trace ? If yes,
which version of the tool has generated the trace ?

Can you provide a sample trace that triggers this issue ?

Can you give us the detailed sequence of steps you use to reproduce ?

Thanks,

Mathieu

> #0  _aligned_integer_read (definition=0x954320, ppos=0x106e028) at 
> integer.c:81
> #1  ctf_integer_read (ppos=0x106e028, definition=0x954320) at 
> integer.c:224
> #2  0x00007ffff070e36e in generic_rw (definition=<optimized out>, 
> pos=0x106e028) at ../include/babeltrace/types.h:133
> #3  bt_struct_rw (ppos=0x106e028, definition=0x9542e0) at struct.c:56
> #4  0x00007ffff13f7fda in generic_rw (definition=<optimized out>, 
> pos=0x106e028) at ../../include/babeltrace/types.h:133
> #5  ctf_packet_seek (stream_pos=0x106e028, index=<optimized out>, 
> whence=<optimized out>) at ctf.c:860
> #6  0x00007ffff070a3f1 in seek_file_stream_by_timestamp 
> (cfs=cfs@entry=0x106cf90, timestamp=timestamp@entry=1374636821498972926) 
> at iterator.c:141
> #7  0x00007ffff070aa96 in seek_ctf_trace_by_timestamp 
> (stream_heap=0x176d310, timestamp=1374636821498972926, tin=<optimized 
> out>) at iterator.c:188
> #8  bt_iter_set_pos (iter=iter@entry=0xfdafa0, iter_pos=0x2bf59f0) at 
> iterator.c:439
> #9  0x00007ffff1624f01 in _wrap__bt_iter_set_pos (self=<optimized out>, 
> args=<optimized out>) at babeltrace_wrap.c:3805
> #10 0x00007ffff7b28c0c in call_function (oparg=<optimized out>, 
> pp_stack=<optimized out>) at Python/ceval.c:3679
> #11 PyEval_EvalFrameEx (f=0x1c243c0, throwflag=<optimized out>) at 
> Python/ceval.c:2370
> #12 0x00007ffff7b2e0d2 in PyEval_EvalCodeEx (co=0xa8e5d0, 
> globals=<optimized out>, locals=<optimized out>, args=0x2088cc8, 
> argcount=0, kws=0x0, kwcount=0, defs=0x0, defcount=0, closure=0x0)
>     at Python/ceval.c:2942
> .
> .
> .
> 
> Any suggestions are welcome.
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
