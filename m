From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: New LTTNG user : Question about Kprobe and	function
	commandline options
Date: Sun, 23 Jun 2013 10:21:41 -0400
Message-ID: <20130623142140.GC21999__23555.6087959141$1371997338$gmane$org@Krystal>
References: <CAPxN80BVxGkHob1CcQOZcSBcskiN5p3yC78+O5PHSSRr1HU=FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Content-Disposition: inline
In-Reply-To: <CAPxN80BVxGkHob1CcQOZcSBcskiN5p3yC78+O5PHSSRr1HU=FA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jessica Foest <jessica.foest@gmail.com>
Cc: lttng-dev@lists.lttng.org, lttng-dev-request@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jessica Foest (jessica.foest@gmail.com) wrote:
> Hi,
> i tried to apply kprobe to a system call , so i used probe and function
> option :
> 
> lttng enable-event aname -k --probe sys_open+0x0
> this command returns ip value
> 
> lttng enable-event aname -k --function sys_open
> this command returns ip and parent_ip values .
> 
> what does these values ip and parent_ip means ?

ip: instruction pointer of the function,
parent_ip: instruction pointer of the caller.

> 
> I try to apply probe and function options to some kernel symbols like
> initialized date (like xen_vcpu_info symbol), read only data (like
> linux_prob_banner symbol) and code (like reserve_ebda_region symbol) it
> displays to me : Enable kernel event failed ,warning some command went(s)
> wrong.
> Did i make a mistake or it's a limitation in LTTng ?

It's kprobes: you can only add breakpoints to code, not data.

Thanks,

Mathieu

> regards.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
