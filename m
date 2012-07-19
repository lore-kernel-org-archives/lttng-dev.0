From: changz <zheng.chang@emc.com>
Subject: Question about zero metadata
Date: Thu, 19 Jul 2012 17:33:31 +0800
Message-ID: <5007D46B.3060205__23279.1575174362$1342690458$gmane$org@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from hop-nat-141.emc.com ([168.159.213.141]
	helo=mexforward.lss.emc.com) by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Zheng.Chang@emc.com>) id 1Srn7P-0001ye-Cz
	for lttng-dev@lists.lttng.org; Thu, 19 Jul 2012 05:33:59 -0400
Received: from hop04-l1d11-si03.isus.emc.com (HOP04-L1D11-SI03.isus.emc.com
	[10.254.111.23])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q6J9XqVZ001236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <lttng-dev@lists.lttng.org>; Thu, 19 Jul 2012 05:33:52 -0400
Received: from mailhub.lss.emc.com (mailhubhoprd04.lss.emc.com
	[10.254.222.226]) by hop04-l1d11-si03.isus.emc.com (RSA
	Interceptor) for <lttng-dev@lists.lttng.org>;
	Thu, 19 Jul 2012 05:33:35 -0400
Received: from corpussmtp4.corp.emc.com (corpussmtp4.corp.emc.com
	[10.254.169.197])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
	q6J9XZQM022628
	for <lttng-dev@lists.lttng.org>; Thu, 19 Jul 2012 05:33:35 -0400
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

I tried to generate one event and view the trace at run-time. It didn't 
work because metadata was zero.
And then I found metadata couldn't be dumped to disk when sub-buffer 
were not filled(i.e. consumer daemon didn't read data from ring-buffer).
And seems no timer to flush it because I waited for very long time. Once 
I stopped lttng or the application, metadata got ready at once.

My lttng version is 2.01. Is this a known issue?

Thanks
Zheng
