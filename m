From: changz <zheng.chang@emc.com>
Subject: Question about lttng daemons
Date: Thu, 26 Jul 2012 16:28:24 +0800
Message-ID: <5010FFA8.9000706__49385.1008745425$1343291350$gmane$org@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1SuJR7-00011D-1a
	for lttng-dev@lists.lttng.org; Thu, 26 Jul 2012 04:28:45 -0400
Received: from hop04-l1d11-si03.isus.emc.com (HOP04-L1D11-SI03.isus.emc.com
	[10.254.111.23])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q6Q8Sc4X026436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <lttng-dev@lists.lttng.org>; Thu, 26 Jul 2012 04:28:38 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.221.145]) by
	hop04-l1d11-si03.isus.emc.com (RSA Interceptor) for
	<lttng-dev@lists.lttng.org>; Thu, 26 Jul 2012 04:28:28 -0400
Received: from corpussmtp4.corp.emc.com (corpussmtp4.corp.emc.com
	[10.254.169.197])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q6Q8SRlr002765
	for <lttng-dev@lists.lttng.org>; Thu, 26 Jul 2012 04:28:28 -0400
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

Hi all,

Is that possible to launch lttng daemons as a system service? i.e. we 
can start/stop/restart it like the services under /etc/init.d.
Another concern is if here is a way to recover or continue the dataflow 
once the daemons get crashed.
I hope some vital trace info can be still kept even if daemon crashes.

BR
zheng
