From: yin sun <sunyin51@gmail.com>
Subject: cases that kernel module uses lttng to trace its own
	code
Date: Tue, 19 Feb 2013 22:10:44 -0800
Message-ID: <CAKPZSeAKPCBTAH+zphCfv5JwQLjTuPwogFaDEbLXjF1RgQfxFQ__17512.812317773$1361340730$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sunyin51@gmail.com>) id 1U82ta-0004iZ-Pb
	for lttng-dev@lists.lttng.org; Wed, 20 Feb 2013 01:11:11 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp2so2671444pbb.6
	for <lttng-dev@lists.lttng.org>; Tue, 19 Feb 2013 22:11:05 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

Is there any example that a loadable kernel module utilize lttng
tracepoint to trace its own code. Not those ready made probes.

In this case, what minimal lttng modules do I have to load?

Thanks,
/Yin
