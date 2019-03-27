From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Question related to LTTng
Date: Wed, 27 Mar 2019 10:20:53 -0400
Message-ID: <20190327142037.GA5617__34424.4232795731$1553696479$gmane$org@joraj-alpa>
References: <CAEWVvOTEJjw3kYfPfrcW68Ux6fy1g5utoHBpy=o++d71rxddbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44Tqt63b8zz17gM
 for <lttng-dev@lists.lttng.org>; Wed, 27 Mar 2019 10:21:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAEWVvOTEJjw3kYfPfrcW68Ux6fy1g5utoHBpy=o++d71rxddbg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Ravindra Kumar Meena <rmeena840@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Ravindra,

On Wed, Mar 27, 2019 at 04:53:23PM +0530, Ravindra Kumar Meena wrote:
> Hi Developers,
> 
> I am working on a project where I want Trace Compass to analyze and display
> some information. I wanna ask a few things:

This mailing list is focused on lttng/babeltrace/urcu. If you have question
regarding Tracecompass please use their mailing list. [1]

[1] https://accounts.eclipse.org/mailing-list/tracecompass-dev

> 
> Q1. Is there any way to extend Trace Compass to work trace data in CTF
> format?

AFAIK, Tracecompass have a CTF reader and have multiple extension point to
analyze the data.

> 
> Q2. How trace data(CTF) can be converted to Linux kernel trace data(LTTng)
> which Trace Compass already understands?

Linux kernel trace data are understood based on a model of the kernel state
transition. A ctf trace could be translated based on the model that
Tracecompass uses.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
