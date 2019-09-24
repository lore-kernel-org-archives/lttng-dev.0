From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [EXTERNAL] Re: Problem with application changing UID
Date: Tue, 24 Sep 2019 14:45:12 -0400
Message-ID: <20190924184512.GL187569__26227.4043679767$1569350735$gmane$org@joraj-alpa>
References: <SN4PR0601MB3614967ABCE12621B316C89D91840@SN4PR0601MB3614.namprd06.prod.outlook.com>
 <20190924150754.GG187569@joraj-alpa>
 <SN4PR0601MB36143DD719CB75559F9ABDD891840@SN4PR0601MB3614.namprd06.prod.outlook.com>
 <20190924160604.GK187569@joraj-alpa>
 <SN4PR0601MB361479BD3396866D29AA39F791840@SN4PR0601MB3614.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46d99P4L31z1NH9
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 14:45:13 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 0A686333C15
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 14:45:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <SN4PR0601MB361479BD3396866D29AA39F791840@SN4PR0601MB3614.namprd06.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Kramer, Zach" <Zach.Kramer@cognex.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Sep 24, 2019 at 04:13:13PM +0000, Kramer, Zach wrote:
> Hi Jonathan,
> 
> Thanks for the extra info. We do indeed fork without a following exec call and
> I experimented with this preloading recently. When I experimented, I noticed
> no difference in the tracing when I preload liblttng-ust-fork.so. What exactly
> is the consequence of not doing this?

It mostly ensure that the state of lttng-ust for the child is valid and the
child will register to lttng-sessiond. It allows the child to trace between the
fork call and the exec call if any.

https://github.com/lttng/lttng-ust/blob/f596de62e69d1942ec545b8ba6b8f8b7244f8fb4/liblttng-ust/lttng-ust-comm.c#L2097

So in your case you definitely need it.

The immediate consequence is that some context information will be completely wrong (pid/vtid).

Mathieu Desnoyers could provide more information on the deeper side effects of
not using the fork wrapper given that no exec call is done. I'm not completely
sure of the possible side effects on the tracing buffers.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
