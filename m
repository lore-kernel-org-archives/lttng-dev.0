From: Ali Maredia <ali@cohortfs.com>
Subject: Babeltrace lttng-live API
Date: Wed, 17 Dec 2014 17:45:40 -0500 (EST)
Message-ID: <1806351258.304.1418856340823.JavaMail.root__13280.1285516054$1418856718$gmane$org@thunderbeast.private.linuxbox.com>
References: <2141428292.302.1418856273696.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from aa.linuxbox.com ([69.128.83.226])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ali@linuxbox.com>) id 1Y1NLy-0005Gl-PJ
 for lttng-dev@lists.lttng.org; Wed, 17 Dec 2014 17:46:03 -0500
Received: from thunderbeast.private.linuxbox.com
 (thunderbeast.private.linuxbox.com [10.1.1.55])
 by aa.linuxbox.com (8.13.1/8.13.1/SuSE Linux 0.7) with ESMTP id sBHMjpqq028759
 for <lttng-dev@lists.lttng.org>; Wed, 17 Dec 2014 17:45:51 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id E308F3FC8497
 for <lttng-dev@lists.lttng.org>; Wed, 17 Dec 2014 17:45:50 -0500 (EST)
Received: from thunderbeast.private.linuxbox.com ([127.0.0.1])
 by localhost (thunderbeast.private.linuxbox.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id 3culO+DWgdig for <lttng-dev@lists.lttng.org>;
 Wed, 17 Dec 2014 17:45:41 -0500 (EST)
Received: from thunderbeast.private.linuxbox.com
 (thunderbeast.private.linuxbox.com [10.1.1.55])
 by thunderbeast.private.linuxbox.com (Postfix) with ESMTP id 15C1C3FC848B
 for <lttng-dev@lists.lttng.org>; Wed, 17 Dec 2014 17:45:41 -0500 (EST)
In-Reply-To: <2141428292.302.1418856273696.JavaMail.root@thunderbeast.private.linuxbox.com>
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

Hello,

I am wondering whether I would be able to implement traces using the lttng-live format using the Babeltrace API, or whether there is development towards implementing that format in releases soon to come? 

All I see in API.txt (which hasn't changed in a few years) are methods to implement traces that are ctf-format.   

Best,

Ali
