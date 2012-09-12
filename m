From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: list configured filters in LTTng Tools 2.1
Date: Wed, 12 Sep 2012 15:14:00 -0400
Message-ID: <20120912191400.GA31291__36222.0537187115$1347477272$gmane$org@Krystal>
References: <5050CD26.6020707@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TBsNu-0005ca-KT
	for lttng-dev@lists.lttng.org; Wed, 12 Sep 2012 15:14:02 -0400
Content-Disposition: inline
In-Reply-To: <5050CD26.6020707@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Bernd Hufmann (Bernd.Hufmann@ericsson.com) wrote:
> Hello
>
> I configured a filter for UST events (lttng enable event -u ust*  
> --filter 'signal==10101') and I want to retrieve that information  
> afterwards. I used "lttng list mySession" and it only shows [with  
> filters]. Is it possible to retrieve the actual filter expression? If  
> not, it would be good to add this possibility.

We could. Please add a feature request on the bugs.lttng.org bugtracker
against the lttng-tools project.

Thanks,

Mathieu

>
> Best Regards
> Bernd
>
>
> -- 
> This Communication is Confidential. We only send and receive email on  
> the basis of the terms set out at www.ericsson.com/email_disclaimer
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
