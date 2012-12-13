From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: How to document existing tracepoints (e.g. doxygen)
Date: Thu, 13 Dec 2012 06:46:14 -0500
Message-ID: <20121213114614.GB9780__21583.1428104595$1355399530$gmane$org@Krystal>
References: <CALe+Z03oNt7L8=5CJUY1ss+-yWBvoTevv=En_4E58Y8d=m_x9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Tj7F5-0003ig-Ib
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 06:46:19 -0500
Content-Disposition: inline
In-Reply-To: <CALe+Z03oNt7L8=5CJUY1ss+-yWBvoTevv=En_4E58Y8d=m_x9A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Blunck <jblunck@infradead.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jan Blunck (jblunck@infradead.org) wrote:
> List,
> 
> Does anyone have experience or thoughts on how to document existing
> tracepoints?
> 
> I tried to do that with doxygen but it did not work out of the box.
> The target audience are sysadmins that should not or could not be
> forced to read the source.

I'd think that doxygen would be appropriate. What issues did you run
into when trying going down that route ?

Thanks,

Mathieu

> 
> Regards,
> Jan
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
