From: Martin Townsend <martin.townsend@xsilon.com>
Subject: lttng-modules how to automatically load my
	lttng_probe_xxx module
Date: Wed, 09 Jul 2014 11:55:48 +0100
Message-ID: <53BD1FB4.8020001__4379.63017398051$1404903407$gmane$org@xsilon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.kundenserver.de ([212.227.126.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <martin.townsend@xsilon.com>) id 1X4pXX-0006Ky-R7
 for lttng-dev@lists.lttng.org; Wed, 09 Jul 2014 06:55:58 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

Using the instructions from
http://lists.lttng.org/pipermail/lttng-dev/2013-October/021540.html
I have added my own kernel module to lttng-modules and can successfully 
trace my own custom events.  I have to manually modprobe lttng_probe_xxx 
to get it to work though.  Is there a way of doing this automatically?

Best Regards,
Martin.
