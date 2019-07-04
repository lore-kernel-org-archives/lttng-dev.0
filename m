From: Carlo Caione <carlo.caione@gmail.com>
Subject: Re: events injection / merging traces
Date: Thu, 4 Jul 2019 16:21:34 +0100
Message-ID: <74d67aa2-a9ba-6882-a079-a23879443ef5__40824.1861312249$1562253719$gmane$org@gmail.com>
References: <ed6a7951-d2eb-71ff-be87-dcdb07be7881@gmail.com>
 <20190704145226.GB9334@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by lists.lttng.org (Postfix) with ESMTPS id 45fhXK52pDz10P6
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 11:21:37 -0400 (EDT)
Received: by mail-wr1-x42d.google.com with SMTP id c2so7014940wrm.8
 for <lttng-dev@lists.lttng.org>; Thu, 04 Jul 2019 08:21:37 -0700 (PDT)
In-Reply-To: <20190704145226.GB9334@joraj-alpa>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 04/07/2019 15:52, Jonathan Rajotte-Julien wrote:
> Hi Carlo,

Hi Jonathan,
thank you for your reply, quite enlightening.

> This leads to, as always, whats is the end goal here?

This is the context: I'm tracing a Linux kernel (using LTTng) while in 
parallel I'm tracing a process running in a bare-metal OS (running on 
the same machine but on different cores using a partitioning hypervisor).

The binary trace data obtained from the bare-metal OS is converted to 
CTF using babeltrace in a format resembling LTTng (to be analyzed with 
TraceCompass).

The goal here is merge the two traces to have a global picture of what's 
going on in the system.

--
Carlo Caione
