From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup:
 Assertion `pollfd == ht_cleanup_pipe[0]' failed.
Date: Thu, 20 Mar 2014 13:54:55 +0100
Message-ID: <532AE51F.6030406__13629.1672163226$1395320155$gmane$org@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=0156caad95=gerlando.falauto@keymile.com>)
	id 1WQcV0-00087r-18
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 08:55:09 -0400
Received: from frodo.de.keymile.net ([10.9.1.54]:34150
	helo=mailrelay.de.keymile.net)
	by mail-de.keymile.com with esmtp (Exim 4.76)
	(envelope-from <gerlando.falauto@keymile.com>) id 1WQcUp-0004OZ-2u
	for lttng-dev@lists.lttng.org; Thu, 20 Mar 2014 13:54:55 +0100
Received: from chber1-10555x.ch.keymile.net ([172.31.40.82])
	by mailrelay.de.keymile.net (8.12.2/8.12.2) with ESMTP id
	s2KCssLf002451
	for <lttng-dev@lists.lttng.org>; Thu, 20 Mar 2014 13:54:55 +0100 (MET)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I'm trying to bring lttng-tools up to date, but I get the following message:

lttng-sessiond: ht-cleanup.c:92: thread_ht_cleanup: Assertion `pollfd == 
ht_cleanup_pipe[0]' failed.

I noticed this was already filed as a bug:
http://redmine.dorsal.polymtl.ca/issues/747

I tried implementing the solution proposed on the comment:

 >We should add a check to see if the revent is 0 at the beginning of
 >the loop, and continue to the next loop iteration if it is the case.

But this doesn't seem to help.

Any suggestion?

Thank you,
Gerlando
