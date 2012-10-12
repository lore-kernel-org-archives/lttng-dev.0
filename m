From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Amount of trace folders created for the same tool
Date: Fri, 12 Oct 2012 07:01:12 -0400
Message-ID: <20121012110112.GB14821__41090.6453188092$1350039705$gmane$org@Krystal>
References: <6539770C71C3814BB0BFC2DBEBD105080137BE38@CORPUSMX30B.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TMczR-0001ff-G8
	for lttng-dev@lists.lttng.org; Fri, 12 Oct 2012 07:01:13 -0400
Content-Disposition: inline
In-Reply-To: <6539770C71C3814BB0BFC2DBEBD105080137BE38@CORPUSMX30B.corp.emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Chang, Zheng" <Zheng.Chang@emc.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Chang, Zheng (Zheng.Chang@emc.com) wrote:
> Hi,
> 
>  
> 
> I have a command line tool that calls tracepoint to generate trace.
> 
> But it quits once the process is done. So Lttng will create different
> folders for it because its pid gets changed every time.
> 
> This tool gets called hundreds times per day and I'm confused by how to
> manage these trace info.
> 
>  
> 
> Is there a way or feature to avoid this case? 

Not yet, but we're working on "global, per user" UST buffers for LTTng
2.2. This will solve your issue.

Thanks,

Mathieu

> 
>  
> 
> Thanks
> 
> -Zheng
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
