From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re:
 =?utf-8?b?5Zue5aSNOlJlOiAgUHJvcyBhbmQgQ29ucyBvZiBM?=
 =?utf-8?q?TTng?=
Date: Mon, 22 Jul 2019 18:20:48 -0400
Message-ID: <20190722222048.GB803__20830.0949003146$1563834068$gmane$org@joraj-alpa>
References: <tencent_512CCCEA391C638F165F4530@qq.com>
 <20190716153057.GC20789@joraj-alpa>
 <tencent_6333ED5120A484314E433472@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45swzj5p4yz16rF
 for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2019 18:20:49 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 18FA3265CB9
 for <lttng-dev@lists.lttng.org>; Mon, 22 Jul 2019 18:20:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <tencent_6333ED5120A484314E433472@qq.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?B?5p2o5rW3?= <hai.yang@magic-shield.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

> As to LD_PRELOAD, it is also used for privilege escalation. Will it be regarded as vulnerability and forbidden on some Linux systems?

It could yes.
In that case you will be limited to the syscalls interface for the libc
observability unless you instrument it and distribute it.

Cheers.
