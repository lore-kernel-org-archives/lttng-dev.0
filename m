From: "Kramer, Zach" <Zach.Kramer@cognex.com>
Subject: Re: [EXTERNAL] Re: Problem with application changing UID
Date: Tue, 24 Sep 2019 16:13:13 +0000
Message-ID: <SN4PR0601MB361479BD3396866D29AA39F791840__21000.0962646276$1569341610$gmane$org@SN4PR0601MB3614.namprd06.prod.outlook.com>
References: <SN4PR0601MB3614967ABCE12621B316C89D91840@SN4PR0601MB3614.namprd06.prod.outlook.com>
 <20190924150754.GG187569@joraj-alpa>
 <SN4PR0601MB36143DD719CB75559F9ABDD891840@SN4PR0601MB3614.namprd06.prod.outlook.com>
 <20190924160604.GK187569@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680104.outbound.protection.outlook.com [40.107.68.104])
 by lists.lttng.org (Postfix) with ESMTPS id 46d5p24tWyz1N4c
 for <lttng-dev@lists.lttng.org>; Tue, 24 Sep 2019 12:13:14 -0400 (EDT)
In-Reply-To: <20190924160604.GK187569@joraj-alpa>
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
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Jonathan,

Thanks for the extra info. We do indeed fork without a following exec call and I experimented with this preloading recently. When I experimented, I noticed no difference in the tracing when I preload liblttng-ust-fork.so. What exactly is the consequence of not doing this?

Thanks!


-----Original Message-----
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com> 
Sent: Tuesday, September 24, 2019 6:06 PM
To: Kramer, Zach <Zach.Kramer@cognex.com>
Cc: lttng-dev@lists.lttng.org
Subject: Re: [EXTERNAL] Re: [lttng-dev] Problem with application changing UID

Hi Zach,

Forgot to add that you might want to look at available UST wrappers depending on the nature of your daemon application.

https://nam04.safelinks.protection.outlook.com/?url=https%3A%2F%2Flttng.org%2Fdocs%2Fv2.10%2F%23doc-using-lttng-ust-with-daemons&amp;data=02%7C01%7CZach.Kramer%40cognex.com%7C5bd45c30c5bd4c48ad4c08d741091b32%7Cc12007a4882b4381b05ab783431570c7%7C1%7C0%7C637049379681260582&amp;sdata=R8O%2Be9j9O4O7pUAX5TAmLGQLGoIRKgg5k9vOixhTDHg%3D&amp;reserved=0
https://nam04.safelinks.protection.outlook.com/?url=https%3A%2F%2Flttng.org%2Fdocs%2Fv2.10%2F%23doc-liblttng-ust-fd&amp;data=02%7C01%7CZach.Kramer%40cognex.com%7C5bd45c30c5bd4c48ad4c08d741091b32%7Cc12007a4882b4381b05ab783431570c7%7C1%7C0%7C637049379681270586&amp;sdata=iNJnFMPDqCUzZS6a2hUrN4tGfpoInT5MgQYnANk6Y4g%3D&amp;reserved=0

Cheers
--
Jonathan Rajotte-Julien
EfficiOS
