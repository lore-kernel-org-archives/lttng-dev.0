From: Stanislav Vovk <stanislav.vovk@ericsson.com>
Subject: Running 32bit sessiond on 64bit host
Date: Thu, 26 Sep 2013 13:44:07 +0000
Message-ID: <6DB83340B9D38C4A9C0ECD8B6FBABDFB1A251458__10580.0582365648$1380203187$gmane$org@ESESSMB105.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailgw1.ericsson.se ([193.180.251.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stanislav.vovk@ericsson.com>) id 1VPBsh-00047m-FW
	for lttng-dev@lists.lttng.org; Thu, 26 Sep 2013 09:45:28 -0400
Content-Language: en-US
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

Running a 32bit session deamon on a 64 bit host fails when creating a channel. The following  error message is given,

Default snapshot output set to: /tmp/ltt
Snapshot mode set. Every channel enabled for that session will be set in overwrite mode and mmap output.
Error: Channel ch_tri: 32-bit UST consumer start failed (session tri)
Warning: Some command(s) went wrong

Running on,
uname -a
Linux esekilxxen3020 3.0.13-0.27-xen #1 SMP Wed Feb 15 13:33:49 UTC 2012 (d73692b) x86_64 x86_64 x86_64 GNU/Linux

Is this intended to work or are there some limitations for this scenario?

Thanks,
Stanislav
