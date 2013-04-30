From: Andre Bette <andreb@stud.fh-dortmund.de>
Subject: Using the additional Eclipse Kernel Trace Plugin Views
 (Control flow, Resources)
Date: Tue, 30 Apr 2013 11:21:06 +0200
Message-ID: <517F8D02.4090202__47221.762353047$1367313706$gmane$org@stud.fh-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.fh-dortmund.de ([193.25.16.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <andreb@stud.fh-dortmund.de>) id 1UX6kI-0002rc-D3
	for lttng-dev@lists.lttng.org; Tue, 30 Apr 2013 05:21:10 -0400
Received: from [192.168.178.2] (dtmd-4db26b1a.pool.mediaWays.net
	[77.178.107.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout1.fh-dortmund.de (Postfix) with ESMTPSA id 6E56DAB3B
	for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2013 11:21:04 +0200 (CEST)
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

Hi to everyone,
in my project I am tracing a embedded system with a non linux OS. Output 
format is CTF. I really like the two extra views in the Eclipse Kernel 
Trace Visualization (Control flow, Resources).

Is there a simple way to use this two views  with an non linux trace ?
Is there any documentation about the Linux kernel trace format( the 
extra info added into the CTF format) or how the
data(e.g. prozesses) is processed in the Eclipse Kernel Trace Plugin 
(The idea is to use a "fake" linux trace to use the two extra views )?



Best Regards,
Andre
