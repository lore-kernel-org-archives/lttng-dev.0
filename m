From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTng UST - Bug #292] (Confirmed) Generated header
	files	should not conflict with ust or standard ones.
Date: Thu, 2 May 2013 16:24:09 -0400
Message-ID: <20130502202409.GD15675__1970.14239752225$1367526282$gmane$org@Krystal>
References: <redmine.issue-292.20120703142718@lttng.org>
	<redmine.journal-592.20120704161930@lttng.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY030-0006MP-Kd
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 16:24:10 -0400
Content-Disposition: inline
In-Reply-To: <redmine.journal-592.20120704161930@lttng.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: bugs@lttng.org, lttng-dev@lists.lttng.org, Yannick Brosseau <yannick.brosseau@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Hi Yannick,

This bug has been opened in July 2012. Any ETA for resolution ?

Thanks,

Mathieu

* bugs@lttng.org (bugs@lttng.org) wrote:
> 
> Issue #292 has been updated by Yannick Brosseau.
> 
> Subject changed from Lttng-gen-tp need additional error messages to Generated header files should not conflict with ust or standard ones. 
> Status changed from Needs feedback to Confirmed
> 
> 
> ----------------------------------------
> Bug #292: Generated header files should not conflict with ust or standard ones. 
> https://bugs.lttng.org/issues/292#change-592
> 
> Author: Matthew Khouzam
> Status: Confirmed
> Priority: Normal
> Assignee: Yannick Brosseau
> Category: 
> Target version: 
> 
> 
> In Lttng-UST 2.0 if a given tracepoint file (foo.tp) has tracepint_events with domains that are not "foo" the tracepoint will not compile. This would be good to have a warning/error for, since if you don't it will just cause errors in the compilation phase which are _very_ difficult to understand. 
> 
> 
> -- 
> You have received this notification because you have either subscribed to it, or are involved in it.
> To change your notification preferences, please click here: http://bugs.lttng.org/my/account

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
