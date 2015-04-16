From: =?UTF-8?B?U8OpYmFzdGllbiBMb3JyYWlu?=
 <sebastien.lorrain01@gmail.com>
Subject: Crash on 3.19.3 kernel
Date: Thu, 16 Apr 2015 14:26:44 -0400
Message-ID: <552FFEE4.9010101__30262.0993614712$1429208852$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sebastien.lorrain01@gmail.com>) id 1YioUm-00089A-He
 for lttng-dev@lists.lttng.org; Thu, 16 Apr 2015 14:26:39 -0400
Received: by igblo3 with SMTP id lo3so120657632igb.1
 for <lttng-dev@lists.lttng.org>; Thu, 16 Apr 2015 11:26:31 -0700 (PDT)
Received: from [132.207.240.180]
 (Sansfil-Securise-Etudiants-Lassonde-240-180.polymtl.ca. [132.207.240.180])
 by mx.google.com with ESMTPSA id j39sm2002549iod.41.2015.04.16.11.26.29
 for <lttng-dev@lists.lttng.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2015 11:26:29 -0700 (PDT)
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

Hello LTTng folks,

I'am using Archlinux with stock 3.19.3 kernel and I'am experiencing a 
crash with the latest and greatest lttng.
I compiled lttng-tools without UST support.

$uname -a
Linux redwind 3.19.3-3-ARCH #1 SMP PREEMPT Wed Apr 8 14:10:00 CEST 2015 
x86_64 GNU/Linux

Here's the compile log of lttng-modules :
http://paste.ubuntu.com/10834007/

I noticed I'am missing  CONFIG_KALLSYMS_ALL, but I don't know if it is 
really relevant as lttng-modules 2.6 was running fine without it.

Here's the syslog/journal after a crash (on a test VM)
http://paste.ubuntu.com/10833873/

Any help in debugging that would be greatly appreciated!

Thanks!
Lrouge/
Sebastien Lorrain.
