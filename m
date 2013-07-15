From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Problem compiling Babeltrace 1.1.1 python
	bindings	with old Bison
Date: Mon, 15 Jul 2013 09:01:53 -0400
Message-ID: <20130715130152.GA16339__2015.20285704664$1373893346$gmane$org@Krystal>
References: <OFAC6F4FD9.22CFFBB5-ONC2257BA8.0043725C-C2257BA8.0043C772@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UyiPa-0002ld-3z
	for lttng-dev@lists.lttng.org; Mon, 15 Jul 2013 09:01:54 -0400
Content-Disposition: inline
In-Reply-To: <OFAC6F4FD9.22CFFBB5-ONC2257BA8.0043725C-C2257BA8.0043C772@il.ibm.com>
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
> Seems like the configure script doesn't fail when bison version is too 
> old. I am using bison 2.3, which doesn't support pure parser generation, 
> causing a failure in formats/ctf/metadata/ctf-parser.y :
> 
> The following line expects a value to the define:
> 
> %define api.pure
> 
> Adding "true" or "full" doesn't help either.

Please refer to Babeltrace README file. Bison 2.4 is required. Indeed,
we could make configure automatically detect this. Patches are welcome.

Thanks,

Mathieu

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
