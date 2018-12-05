From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Cost of enabling context field procname
Date: Wed, 5 Dec 2018 12:04:09 -0500
Message-ID: <20181205170409.GA26650__46520.4137647108$1544029342$gmane$org@joraj-alpa>
References: <AM6PR07MB4868FE662DA42A674E2A6091C1A80@AM6PR07MB4868.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 4394pB4np6zy8B
 for <lttng-dev@lists.lttng.org>; Wed,  5 Dec 2018 12:04:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <AM6PR07MB4868FE662DA42A674E2A6091C1A80@AM6PR07MB4868.eurprd07.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonas Andersson L <jonas.l.andersson@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jonas,

Good question.

Let's take a look at the source code.

We should find what we are looking for in liblttng-ust/lttng-context-procname.c [1].

[1] https://github.com/lttng/lttng-ust/blob/master/liblttng-ust/lttng-context-procname.c

The comment at the top hint that we do cache the result and perform lookup only
one time except for case where the cache is reset.

You can dig a bit more if you want but most of the job is done in
wrapper_getprocname.

As for the cost, I guess we could find this doing a "simulation" using the same
TLS scheme and measuring the cost of accessing procname the first time and each
subsequent access to the TLS.

Mathieu Desnoyers might have more information on this and also the cost of
having context information compare to not having any at all.

I'm curious. What spiked your interest in this?

Cheers

On Wed, Dec 05, 2018 at 12:21:22PM +0000, Jonas Andersson L wrote:
> Hi
> 
> I'm interested in information regarding the cost of enabling procname context field. Is this field cached and read only at initialization or is the thread name fetched at each trace point? Thanks!
> 
> BR, Jonas

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
