From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Function tracer question
Date: Wed, 31 Jul 2019 11:46:38 -0400
Message-ID: <20190731154638.GA7872__2193.1706274458$1564588028$gmane$org@joraj-alpa>
References: <D03AF9AF-DCC4-4F87-ACAD-ED14DACD0031@gtri.gatech.edu>
 <20190716144250.GB20789@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45zHpy0yvlz1J5K
 for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2019 11:46:49 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5AB052B492D
 for <lttng-dev@lists.lttng.org>; Wed, 31 Jul 2019 11:46:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190716144250.GB20789@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Martin, Wilson" <Wilson.Martin@gtri.gatech.edu>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Martin,

> > I guess I could code my own ftrace hook function, put a custom tracepoint in the code, and then use the macros to push into lttng ring buffers. Maybe?

In supplement to my previous email, please take a look here [1].

[1] https://lttng.org/docs/v2.10/#doc-instrumenting-linux-kernel

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
