From: loody <miloody@gmail.com>
Subject: lttng-tool cross configure for libxml2 error
Date: Thu, 27 Mar 2014 17:04:39 +0800
Message-ID: <CANudz+u1N5kr9tZRJasw28iJU0tD-k6mGqX1t1Gnm2eHaZQR7w__27259.8856282004$1395911126$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <miloody@gmail.com>) id 1WT6Ev-0000n2-Cm
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 05:04:46 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so3161005iec.2
	for <lttng-dev@lists.lttng.org>; Thu, 27 Mar 2014 02:04:39 -0700 (PDT)
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

hi all
i use below configure command to cross-compile lttng-tool
./configure --disable-static --host=arm-v7a8v4r3-linux-gnueabi
CPPFLAGS=-I/media/sdb2/toolchain/arm/arm-v7a8v4r3-20131011/arm-v7a8v4r3-linux-gnueabi/sys-root/include
--prefix=/media/sdb2/toolchain/arm/arm-v7a8v4r3-20131011/arm-v7a8v4r3-linux-gnueabi/sys-root/

But get below message:
checking for libxml - version >= 2.7.6... no
*** The xml2-config script installed by LIBXML could not be found
*** If libxml was installed in PREFIX, make sure PREFIX/bin is in
*** your path, or set the XML2_CONFIG environment variable to the
*** full path to xml2-config.
configure: error: No supported version of libxml2 found.

I use below git commit version to cross-compile:
   commit 83b7c3bf7a5c28883396af5dadd6ee469f20aa59
   Author: David Goulet <dgoulet@efficios.com>
   Date:   Wed Mar 26 11:31:36 2014 -0400
      Fix: update test to use correct lttng load option
      Signed-off-by: David Goulet <dgoulet@efficios.com>

My questions are
1. is that necessary for lttng run on arm platform with xml support?
2. Is it possible to disable xml support with configure command?
3. I use "--disable-xmltest" option, but configure still said it need libxmll

Thanks for your help in advance,
