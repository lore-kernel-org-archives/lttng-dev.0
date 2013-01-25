From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: How to debug the CTF struct problem?
Date: Thu, 24 Jan 2013 20:58:21 -0500
Message-ID: <20130125015821.GA19436__6289.4856826917$1359079146$gmane$org@Krystal>
References: <8E0A14A4C9B95B459AE214584119C1EB3BC90A1E@Hal.ad.unb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TyYYh-0002NV-7H
	for lttng-dev@lists.lttng.org; Thu, 24 Jan 2013 20:58:23 -0500
Content-Disposition: inline
In-Reply-To: <8E0A14A4C9B95B459AE214584119C1EB3BC90A1E@Hal.ad.unb.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yang Wang <yangw.wang5@unb.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Yang Wang (yangw.wang5@unb.ca) wrote:
> Hello
> 
> Could anybody know what causes the following problem? How to debug it?
> I guess somewhere a tracepoint is wrong, but I don't know which one as
> I have tons of tracepoints automatically generated and scattered in
> all the system files.

can you show us the content of:

/home/yang/lttng-traces/auto-20130124-190929/metadata

please ?

Also the output of babeltrace -d -v might help.

Thanks,

Mathieu

> 
> yang@yang-OptiPlex-990:~/j9home/home/yangwang/benchmarks$ lttng view
> Trace directory: /home/yang/lttng-traces/auto-20130124-190929
> 
> [error] ctf_struct_type_declarators_visit: duplicate field _string in struct
> [error] ctf_visitor_construct_metadata: event declaration error
> [error] Error in CTF metadata constructor -1
> [warning] Unable to open trace metadata for path "/home/yang/lttng-traces/auto-20130124-190929/ust/java-7907-20130124-190951".
> [warning] [Context] Cannot open_trace of the format /home/yang/lttng-traces/auto-20130124-190929/ust/java-7907-20130124-190951 .
> 
> Thanks in advance
> 
> Yang
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
