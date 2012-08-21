From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Question] the return of
	babeltrace's	bt_context_create
Date: Tue, 21 Aug 2012 08:05:32 -0400
Message-ID: <20120821120531.GA13784__44966.8258814656$1345550763$gmane$org@Krystal>
References: <CANFwon3dYkyqf4K+gCZ35-eEvVwNRP56pYOF0wwkHDPY-FxyDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T3nDB-0004c9-EM
	for lttng-dev@lists.lttng.org; Tue, 21 Aug 2012 08:05:33 -0400
Content-Disposition: inline
In-Reply-To: <CANFwon3dYkyqf4K+gCZ35-eEvVwNRP56pYOF0wwkHDPY-FxyDg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hui Zhu <teawater@gmail.com>, jdesfossez@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I will let Julien look into this,

Thanks,

Mathieu

* Hui Zhu (teawater@gmail.com) wrote:
> Hi,
> 
> The comments of this function said:
> Returns an allocated context on success and NULL on error
> 
> But when babeltrace use this function, it didn't check the return
> value of bt_context_create:
> 	ctx = bt_context_create();
> 
> 	ret = bt_context_add_traces_recursive(ctx, opt_input_path,
> 			opt_input_format, NULL);
> 
> Could you tell me why?  Thanks a lot.
> 
> Best,
> Hui
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
