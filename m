From: John Steele Scott <toojays@toojays.net>
Subject: Enumerated types in lttng-ust traces?
Date: Thu, 21 Jun 2012 11:00:12 +0930
Message-ID: <jrttfa$8go$1__20780.5367456332$1340242264$gmane$org@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from plane.gmane.org ([80.91.229.3])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gcsld-lttng-dev@m.gmane.org>) id 1ShWEM-0001Hm-PT
	for lttng-dev@lists.lttng.org; Wed, 20 Jun 2012 21:30:42 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcsld-lttng-dev@m.gmane.org>) id 1ShWEH-0003jn-KE
	for lttng-dev@lists.lttng.org; Thu, 21 Jun 2012 03:30:40 +0200
Received: from 146.174.200.100 ([146.174.200.100])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Thu, 21 Jun 2012 03:30:37 +0200
Received: from toojays by 146.174.200.100 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <lttng-dev@lists.lttng.org>; Thu, 21 Jun 2012 03:30:37 +0200
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

It seems that the CTF supports enumerations, and babeltrace has support for pretty-printing them. But how do you get lttng-ust to emit them? Is this possible?

Right now I'm just using ctf_integer, but it seems like there should be way to show human-readable enumeration names in the trace.

cheers,

John
