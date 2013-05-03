From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: babeltrace assertion "`pos->offset
	<=	pos->content_size' failed"
Date: Fri, 3 May 2013 09:15:39 -0400
Message-ID: <20130503131538.GA31382__12011.4075638869$1367586975$gmane$org@Krystal>
References: <50461F57.5010401@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UYFps-00067V-7G
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 09:15:40 -0400
Content-Disposition: inline
In-Reply-To: <50461F57.5010401@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wade Farnsworth <wade_farnsworth@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Are you still experiencing this issue ?

Thanks,

Mathieu

* Wade Farnsworth (wade_farnsworth@mentor.com) wrote:
> Hi,
>
> I'm occasionally seeing the following error when I pass a trace through  
> babeltrace:
>
> babeltrace: ../../include/babeltrace/ctf/types.h:203: ctf_pos_get_event:  
> Assertion `pos->offset <= pos->content_size' failed.
> Aborted
>
> Here are my platform details:
>
> Board: ARM Pandaboard
> Kernel: v3.1.0 from  
> git://dev.omapzoom.org/pub/scm/integration/kernel-ubuntu.git
> lttng-modules: v2.0.5
> lttng-tools: v2.0.3
> babeltrace: 1.0.0-rc5
>
> Now, I'm not very familiar with the internal workings of, but it seems  
> like this situation should be prevented by the call to v_cmpxchg in  
> lib_ring_buffer_check_deliver() which claims to have exclusive subbuffer  
> access when the content_size field is written.  Is this understanding  
> correct?
>
> Does anyone have any suggestions on where the problem might be?  Any  
> help you might be able to give me would be appreciated.
>
> Thanks,
>
> Wade Farnsworth
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
