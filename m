From: Andre Bette <andreb@stud.fh-dortmund.de>
Subject: Using the additional Eclipse Kernel Trace Plugin Views
 (Control flow, Resources)
Date: Mon, 29 Apr 2013 12:40:56 +0200
Message-ID: <517E4E38.6030507__27614.9908117533$1367243084$gmane$org@stud.fh-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout1.fh-dortmund.de ([193.25.16.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <andreb@stud.fh-dortmund.de>) id 1UWlWC-0001c4-ML
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 06:41:12 -0400
Received: from [192.168.178.2] (dtmd-4d0bc7d7.pool.mediaWays.net
	[77.11.199.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout1.fh-dortmund.de (Postfix) with ESMTPSA id 9E01780AE
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 12:40:52 +0200 (CEST)
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
(The idea is to use a "fake" linux trace to use the two extra views. )?



Best Regards,
Andre
