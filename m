From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Managing trace sizes
Date: Fri, 3 May 2013 08:29:19 -0400
Message-ID: <20130503122919.GA30913__48812.5857817524$1367584193$gmane$org@Krystal>
References: <13959c7e325.1340654510569746171.-9152529687053830431@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UYF72-0005ix-Mc
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 08:29:20 -0400
Content-Disposition: inline
In-Reply-To: <13959c7e325.1340654510569746171.-9152529687053830431@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "jsilver.pmc@gmail.com" <jsilver.pmc@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Jon,

Sorry for the late reply,

* jsilver.pmc@gmail.com (jsilver.pmc@gmail.com) wrote:
> Are there any ways currently, or planned, or other suggestions, to
> address these within LTTng?
> - compression of trace data

There is room for that in the CTF specification, but LTTng does not
implement trace compression yet.

> - rolling or rotating trace files
> - limiting the amount of disk space LTTng will use

These are available as new features in LTTng 2.2 (--tracefile-size and
--tracefile-count).

Thanks,

Mathieu

> 
> Thanks,
> Jon
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
