From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: how to get the sockaddr struct from its pointer
	in	kernel tracing
Date: Tue, 31 Jul 2012 12:29:08 -0400
Message-ID: <20120731162907.GA32234__21751.7281104394$1343752170$gmane$org@Krystal>
References: <CABy43G-atS7UTMYnjTBv_dnZa6jE7fb2TTF2VZ6X66JLoaASww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SwFJl-0006tN-SP
	for lttng-dev@lists.lttng.org; Tue, 31 Jul 2012 12:29:09 -0400
Content-Disposition: inline
In-Reply-To: <CABy43G-atS7UTMYnjTBv_dnZa6jE7fb2TTF2VZ6X66JLoaASww@mail.gmail.com>
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
> Hi,
> 
> In the sys_connect and sys_bind kernel tracing, a pointer to the socdaddr
> struct has been dumped. (i.e. the second argument in sys_bind: { cpu_id = 0
> }, { fd = 39, umyaddr = 0x7FE18E3D0B80, addrlen = 0xC }). What if I want to
> access the struct for the IP and port number related to the socket? Is
> there an easy way to do this? Please give me some hints. Thank you very
> much.

current, none.

A "quick" way to do this might be to add a tracepoint into these system
calls.

Eventually, we might look into supporting writing complex data
structures into lttng-modules, but this would require close integration
with the Linux kernel sources.

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
