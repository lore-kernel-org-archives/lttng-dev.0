From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: lttng-ust under the hood
Date: Thu, 22 May 2014 18:21:29 +0200
Message-ID: <537E2409.7030902__27261.4749185324$1400775780$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=02194edd5d=gerlando.falauto@keymile.com>)
 id 1WnVka-0002sQ-Ja
 for lttng-dev@lists.lttng.org; Thu, 22 May 2014 12:21:54 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:51316
 helo=mailrelay.de.keymile.net)
 by mail-de.keymile.com with esmtp (Exim 4.76)
 (envelope-from <gerlando.falauto@keymile.com>) id 1WnVkH-0006Pr-2F
 for lttng-dev@lists.lttng.org; Thu, 22 May 2014 18:21:29 +0200
Received: from chber1-10555x.ch.keymile.net (chber1-10555x.ch.keymile.net
 [172.31.40.82])
 by mailrelay.de.keymile.net (8.12.2/8.12.2) with ESMTP id s4MGLSLf008782
 for <lttng-dev@lists.lttng.org>; Thu, 22 May 2014 18:21:28 +0200 (MEST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I'm still struggling to figure out why, depending on how I compile and 
link my application, I can get either custom tracepoint providers OR 
tracef() to work, but not both at the same time.

Is there any documentation explaining how lttng-ust is roughly supposed 
to work?
(i.e. linking trickeries, libraries needed in LD_PRELOAD, _LGPL_SOURCE, 
tracepoints, probes and so on...)

Thank you very much,
Gerlando
