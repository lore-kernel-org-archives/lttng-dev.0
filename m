From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: doubt regarding lttng
Date: Thu, 24 Jan 2019 09:56:38 -0500
Message-ID: <20190124145528.GA13273__35017.4608219945$1548341824$gmane$org@joraj-alpa>
References: <CACJrnZNMVyAMEAwofiTpOdtr=TtZb3nVzfyMzWs_+Xje8z96kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43llbv6lDDznhH
 for <lttng-dev@lists.lttng.org>; Thu, 24 Jan 2019 09:56:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACJrnZNMVyAMEAwofiTpOdtr=TtZb3nVzfyMzWs_+Xje8z96kg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Urmila R <urmilarajpurohith@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Thu, Jan 24, 2019 at 04:58:26PM +0530, Urmila R wrote:
> while creating an event rule getting error saying that requires a root
> lttng- session daemon as well as tracing group membership
> how can i resolve this problem

Read the doc. [1]

[1] https://lttng.org/docs/v2.10/#doc-tracing-the-linux-kernel
[2] https://lttng.org/docs/v2.10/#doc-tracing-group

It mostly depends on how lttng was installed since some ways of installing take
care of some steps for you.

The error message is pretty self explanatory. You both need a sessiond running
as root and the controlling user be either root or part of the "tracing" user
group.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
