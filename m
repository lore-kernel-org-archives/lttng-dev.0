From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Difficulty extending existing tracepoint's reporting
Date: Tue, 15 Oct 2019 09:36:42 -0400
Message-ID: <20191015133642.GA23844__8093.08488839946$1571146627$gmane$org@joraj-alpa>
References: <CAOxd4f5xL_OWh79s0kG0X9cFbgdkqZqzodnkOjVHwGndHOT75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46sxKw1w3Yzq83
 for <lttng-dev@lists.lttng.org>; Tue, 15 Oct 2019 09:36:52 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id A85AD341DC3
 for <lttng-dev@lists.lttng.org>; Tue, 15 Oct 2019 09:36:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAOxd4f5xL_OWh79s0kG0X9cFbgdkqZqzodnkOjVHwGndHOT75g@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: David Boles <biblioboles@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi David,

Did you add the lttng tracepoint definition in instrumentation/events/lttng-module/block.h
as it is done with block_rq_complete? (in lttng-modules source tree)

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
