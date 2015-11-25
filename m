From: Jay Aurabind <jay.aurabind@gmail.com>
Subject: Best practices to trace built in drivers
Date: Wed, 25 Nov 2015 11:11:20 +0530
Message-ID: <CAOsEZoixwjGbV0qCY_LUMh=9GywiSx8c7zFtneU8Pr6Yevap0A__12644.8629460812$1448430166$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jay.aurabind@gmail.com>) id 1a1Spt-0001DG-Ua
 for lttng-dev@lists.lttng.org; Wed, 25 Nov 2015 00:41:46 -0500
Received: by igvg19 with SMTP id g19so110801076igv.1
 for <lttng-dev@lists.lttng.org>; Tue, 24 Nov 2015 21:41:40 -0800 (PST)
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

Hello everyone!

I am learning how to use lttng and I would like to get some
suggestions or best practices that you experienced hackers use to
trace kernel components.

Specifically I would like to know how I can easily trace built in
drivers which does its job well before the userspace has come up. For
example, I would like to trace the i915 driver, when configured to be
a built in module rather than  a module.

Please provide some suggestions on how to deal with this situation.

-- 

Thanks and Regards,
Aurabindo J
