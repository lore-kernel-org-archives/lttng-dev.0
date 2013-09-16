From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC] API/ABI for consumerd and relayd health check
Date: Mon, 16 Sep 2013 08:56:10 -0400
Message-ID: <20130916125609.GA22237__10043.342333711$1379336231$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VLYLb-0005LE-5O
	for lttng-dev@lists.lttng.org; Mon, 16 Sep 2013 08:56:17 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: dgoulet@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi!

I'd need some feedback on how you think would be best to present the API
to users for health check, as well as the ABI.

I got the instrumentation part pretty much straightened out, but we need
to make some decisions for the user API.

Do you think we should extend enum lttng_health_component or introduce a
new API function besides lttng_health_check() ? Should we continue
extending lttng/lttng.h, or introduce these in a lttng/health.h ?

One thing that makes matters a bit difficult is that there may be
multiple concurrent e.g. root relayd running, which is not the case for
sessiond nor consumerd.

Also, how do you think we should organize the named unix socket for
communication (file names and so on ?).

Ideas are appreciated,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
