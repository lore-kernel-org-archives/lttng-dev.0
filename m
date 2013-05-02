From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: LTTng-UST memory requirements
Date: Thu, 2 May 2013 09:29:46 -0400
Message-ID: <20130502132946.GD7035__46437.1889982887$1367501433$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB23FCE56C@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UXta2-0002zK-5U
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 09:29:50 -0400
Content-Disposition: inline
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB23FCE56C@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David OShea (David.OShea@quantum.com) wrote:
> Hi all,
> 
> Are any details available of the memory requirements for LTTng?

I guess you'll have to measure this.

One important point to consider is the memory requirements for trace
buffers, which are user-configurable.

Thanks,

Mathieu

>  I'm
> particularly interested in UST, and not only the case where tracing is
> being performed, but also when no session is started.  For example.:
> 
> - Session daemon memory requirements: I assume this would be a
> function of the number of tracepoints, trace providers, attached
> processes, sessions, etc.
> 
> - Consumer daemon memory requirements: how many of these would there be, how much memory does each use
> 
> - In-application memory requirements: I assume this would also be a function of the number of trace providers, trace points, etc.
> 
> Thanks in advance,
> David
> 
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
