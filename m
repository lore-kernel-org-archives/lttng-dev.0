From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Babel-trace exit with 0(Zero)
Date: Wed, 27 Feb 2019 09:41:07 -0500
Message-ID: <20190227144107.GC9757__23136.8240247079$1551278491$gmane$org@joraj-alpa>
References: <925694812.5908095.1551268639884.ref@mail.yahoo.com>
 <925694812.5908095.1551268639884@mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 448dfF60MHzgJY
 for <lttng-dev@lists.lttng.org>; Wed, 27 Feb 2019 09:41:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <925694812.5908095.1551268639884@mail.yahoo.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: RAJAN GUPTA <rajangpt58@yahoo.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Rajan,

On Wed, Feb 27, 2019 at 11:57:19AM +0000, RAJAN GUPTA via lttng-dev wrote:
> Hi,
> We are using Lttng version 2.10.3 to stream and capture trace and error logs
> form node in live mode.

Side note, the stable 2.10 branch latest release is 2.10.6. I encourage you to
upgrade regardless of this problem.

> Once session is created and streaming starts on node,
> suddenly babel-trace exit with code 0(Zero) and restart. This happens in a

AFAIK we do not provide any automatic way to start babeltrace on
session creation. Can you explain how babeltrace is launched? Are you using
"lttng view"? Launching it manually on another host? Are you using a wrapper for
babeltrace that tries to connect to a session in a loop?

> silent loop until we kill the lttng process.

Babeltrace does not have an auto respawn mechanism, if it exit something else is
starting it.

> Is this a known issue and if so is it going to be addresses in future versions
> of lttng or yet to be fixed ?
> Any help will be appreciated.

The first step, and one you should have done before sending this email, is to
read [1] and gather as much information as possible, at least logs for:
babeltrace, lttng-session, lttng-relayd . Then open a bug on [2].

[1] https://lttng.org/community/#bug-reporting-guidelines
[2] https://bugs.lttng.org/

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
