From: Zvi Vered <veredz72@gmail.com>
Subject: (no subject)
Date: Fri, 27 Nov 2015 05:20:33 +0200
Message-ID: <CABRndgzjgufnXE7_0Erp=B2P-5j3w4nZFhShn8V5oqGxd8PPaw__36925.8329192691$1448594498$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f173.google.com ([209.85.223.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <veredz72@gmail.com>) id 1a29aR-0006g4-1n
 for lttng-dev@lists.lttng.org; Thu, 26 Nov 2015 22:20:41 -0500
Received: by ioir85 with SMTP id r85so102853560ioi.1
 for <lttng-dev@lists.lttng.org>; Thu, 26 Nov 2015 19:20:33 -0800 (PST)
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

I downloaded lttng-tools-2.7.0 and tried to run ./configure.

I got the error message:

....
checking for xml2-config... /home/zvivered/GNU/libxml2/release/bin/xml2-config
checking for libxml - version >= 2.7.6... yes (version 2.7.7)
checking for uuid_generate in -luuid... no
checking for uuid_create in -lc... no
configure: error: Cannot find libuuid uuid_generate nor libc
uuid_create. Use LDFLAGS=-Ldir to specify their location.

I'm working with Centos 5.5 (32).
I downloaded libuuid-1.0.3.tar.gz from http://sourceforge.net/projects/libuuid/
It solved the .configure problem. Is this the right download place ?

Best regards,
Z.V
