From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Question about file descriptor of sockets and pipes
Date: Thu, 19 Jul 2012 18:04:37 -0400
Message-ID: <20120719220437.GB28181__32541.1464590163$1342735511$gmane$org@Krystal>
References: <CABy43G9mrdgQ_rnoCpFzBtHSxP=W3umtUWyvKzQ4_VTb46Ppxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Srypr-0007gN-27
	for lttng-dev@lists.lttng.org; Thu, 19 Jul 2012 18:04:39 -0400
Content-Disposition: inline
In-Reply-To: <CABy43G9mrdgQ_rnoCpFzBtHSxP=W3umtUWyvKzQ4_VTb46Ppxw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rui Han <r.han@umiami.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Rui Han (r.han@umiami.edu) wrote:
> Hi All,
> 
> What does the number "6454" and "6455" in the following dump information
> stand for? Are they pipe number and socket number? How did they generated,
> I want to figure out what process is using it, where should I start? Thank
> you very much.
> 
> lttng_statedump_file_descriptor: { cpu_id = 0 }, { pid = 1, fd = 3,
> filename = "pipe:[6454]" }
> lttng_statedump_file_descriptor: { cpu_id = 0 }, { pid = 1, fd = 7,
> filename = "socket:[6455]" }

This is the file name assigned internally to the pipe and socket file
descriptors by the Linux kernel. You might want to compare this with the
output of "lsof". This might be the "NODE" value (to be confirmed).

Thanks,

Mathieu

> 
> Regards,
> Rui

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
