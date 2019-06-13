From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: (no subject)
Date: Thu, 13 Jun 2019 11:38:23 -0400
Message-ID: <20190613153823.GC972__44496.0925074824$1560440331$gmane$org@joraj-alpa>
References: <CABRndgyzXQaYpefcMEMt1ShbqVKaf9vLJOXaL2cgUZMik4=xxw@mail.gmail.com>
 <CAB4xu_0h-q6En3_hDODbKuXd1=4_e0car73pP8Cf=LNWMKjh_g@mail.gmail.com>
 <CABRndgwEg3wYLbyfobjxdEKd8O1dAu+B+PwS-0A5gxURjKj_WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45PnvV4f4Fz17Mw
 for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2019 11:38:30 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E183A1E1376
 for <lttng-dev@lists.lttng.org>; Thu, 13 Jun 2019 11:38:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABRndgwEg3wYLbyfobjxdEKd8O1dAu+B+PwS-0A5gxURjKj_WA@mail.gmail.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

> Can you please estimate when version 2 will be released ?

When it is ready. A lot of work was done on that side in the last 6 month, the
list of bugs and stuff to get done is shrinking everyday.

> Can you please provide sample code that uses Babeltrace to read metadata,
> channel ?

The source code for decoding the metadata TSDL is available here [1] if I'm not
mistaken. The header is only the tip of the iceberg.

[1] https://github.com/efficios/babeltrace/tree/stable-1.5/formats/ctf/metadata

I'm not sure if we expose the metadata information directly to the API.

See [2] for the API documentation of babeltrace 1.5

[2] http://git.efficios.com/?p=babeltrace.git;a=blob;f=doc/API.txt;h=e13e6adf3545d306e36c2496dd2feb50479d1eea

> > >
> > > I want to write a simple babeltrace for windows.
> >

I'm not convinced that rewriting an open source project is the right way to go
about that. Even more when there is already efforts being conducted for supporting
Windows.

What is the end goal here? What are you trying to achieve?

Do you want a basic cli that can read traces and output text trace?
Do you want to build a tool around ctf and need a reader/writer lib?

Please provide context so that we can help you achieve your goal.

Cheers
-- 
Jonathan Rajotte-Julien
EfficiOS
