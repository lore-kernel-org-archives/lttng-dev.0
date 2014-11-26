From: fmahn@technik-emden.de
Subject: instrumenting "tutorial" and RTAI
Date: Wed, 26 Nov 2014 16:59:11 +0000
Message-ID: <20141126165911.Horde.4rlxIiNzywrWTD0eXzfFsQ1__38844.2617062994$1417021203$gmane$org@secure.et-inf.fho-emden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from farad.et-inf.fho-emden.de ([139.13.80.1] ident=root)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <fmahn@technik-emden.de>) id 1Xtfvw-0001p5-O8
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 11:59:19 -0500
Received: from virt86 (virt86.et-inf.fho-emden.de [139.13.80.86])
 by farad.et-inf.fho-emden.de (8.13.8/8.13.8/Debian-3) with ESMTP id
 sAQGxA4b015611
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 17:59:10 +0100
Content-Disposition: inline
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


Hello, right now I am reading the LTTng documentation and I am at the  
point with the "tutorial" for adding a tracepoint to the  
usb_probe_device(). I updated the files as instructed, rebuilt the  
kernel and bootet it, but the "/sys/kernel/debug/tracing/events/hello"  
directory wasnt created. It exists up to the debug directory, but the  
directory itself is empty. What could have gone wrong? Is this  
directory necessary? I still followed the other instructions and I was  
able to trace the USB event but I am curios about the directory.
Furthermore, I am planning to instrument an RTAI kernel (for my  
Bachelorthesis), so I can trace it with LTTng. Is it even possible  
with these methods?

Thank you for your time!

PS:
I am using an RTAI patched 2.6.38.8 linux kernel with debian
