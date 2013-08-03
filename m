From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Lttng API
Date: Fri, 2 Aug 2013 21:22:59 -0400
Message-ID: <20130803012259.GF9033__36419.330261606$1375493025$gmane$org@Krystal>
References: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A222279@ESESSMB105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V5QYe-0003TT-BX
	for lttng-dev@lists.lttng.org; Fri, 02 Aug 2013 21:23:04 -0400
Content-Disposition: inline
In-Reply-To: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A222279@ESESSMB105.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stanislav Vovk <stanislav.vovk@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Stanislav Vovk (stanislav.vovk@ericsson.com) wrote:
> Hi,
> 
> I did not find any snapshot handling in the lttng.h! Only create
> session in a snapshot mode but nothing about taking a snapshot. Is it
> something that will be added?

Hi Stanislav,

Please have a look at include/lttng/snapshot.h for this API.

Best regards,

Mathieu

> 
> Cheers,
> Stanislav

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
