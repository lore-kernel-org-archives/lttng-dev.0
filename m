From: Daniel Griscom <griscom@suitable.com>
Subject: Version of LTTng for kernel 2.6.25?
Date: Tue, 26 Jun 2012 10:06:17 -0400
Message-ID: <p06240851cc0f70d951ac__20442.5654294484$1340719612$gmane$org@[192.168.1.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from gateway11.websitewelcome.com ([67.18.7.10])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <griscom@suitable.com>) id 1SjWPO-0001bY-D8
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 10:06:22 -0400
Received: from gator683.hostgator.com (gator683.hostgator.com
	[174.132.158.226])
	by gateway11.websitewelcome.com (Postfix) with ESMTP id D141B9416BB77
	for <lttng-dev@lists.lttng.org>; Tue, 26 Jun 2012 09:06:20 -0500 (CDT)
Received: from [66.87.7.231] (port=50220 helo=[192.168.1.12])
	by gator683.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <griscom@suitable.com>)
	id 1SjWPL-0001wo-Jr
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 09:06:20 -0500
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

I'd like to use LTTng, but I'm using an old kernel (and can't upgrade):

>$ cat /proc/version
>Linux version 2.6.25.10-prof (root@atmdev) (gcc version 3.4.6 
>(Gentoo Hardened 3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #5 PREEMPT Sat 
>Mar 3 16:51:19 EST 2012

I understand that the latest kernel modules require kernel 2.6.38 or 
later. What is the latest version of the kernel tools that I could 
run? Are the user-space tools kernel-independent (and 
LTTng-modules-independent)?


Thanks,
Dan

-- 
Daniel T. Griscom             griscom@suitable.com
Suitable Systems              http://www.suitable.com/
1 Centre Street, Suite 204    (781) 665-0053
Wakefield, MA  01880-2400
