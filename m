From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lttng trace" Read trace under windows
Date: Tue, 21 May 2019 10:48:11 -0400
Message-ID: <20190521144811.GA1071__673.065536987849$1558450119$gmane$org@joraj-alpa>
References: <CABRndgx7zGtAR_7eM8Vb7AorGkS4-2b8z8P5n9rv45-SMhuL0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 457dtG51Y4z1047
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 10:48:22 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 7B4D3BD539
 for <lttng-dev@lists.lttng.org>; Tue, 21 May 2019 10:48:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABRndgx7zGtAR_7eM8Vb7AorGkS4-2b8z8P5n9rv45-SMhuL0Q@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

On Mon, May 20, 2019 at 10:49:49PM -0700, Zvi Vered wrote:
> Hello,
> 
> I'm looking for a windows library that can read a trace ?

Babeltrace 1.5 can be build on cygwin.

> Or - detailed instructions on the structure of each file in the trace.

https://diamon.org/ctf/

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
