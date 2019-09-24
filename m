From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [EXTERNAL] Re: Problem with application changing UID
Date: Tue, 24 Sep 2019 12:06:04 -0400
Message-ID: <20190924160604.GK187569__33217.2008392931$1569341184$gmane$org@joraj-alpa>
References: <SN4PR0601MB3614967ABCE12621B316C89D91840@SN4PR0601MB3614.namprd06.prod.outlook.com>
 <20190924150754.GG187569@joraj-alpa>
 <SN4PR0601MB36143DD719CB75559F9ABDD891840@SN4PR0601MB3614.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46d5dq09JDz1N3K
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 12:06:06 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 96B022C8A0B
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 12:06:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <SN4PR0601MB36143DD719CB75559F9ABDD891840@SN4PR0601MB3614.namprd06.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "Kramer, Zach" <Zach.Kramer@cognex.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Zach,

Forgot to add that you might want to look at available UST wrappers depending on the
nature of your daemon application.

https://lttng.org/docs/v2.10/#doc-using-lttng-ust-with-daemons
https://lttng.org/docs/v2.10/#doc-liblttng-ust-fd

Cheers
-- 
Jonathan Rajotte-Julien
EfficiOS
