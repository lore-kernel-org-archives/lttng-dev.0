From: loody <miloody@gmail.com>
Subject: Re: arm gcc compile lttng-tool fail
Date: Thu, 27 Mar 2014 21:09:22 +0800
Message-ID: <CANudz+soZbO-GGZyXrNZdEQRp3Nz6xUO_p-mnTEeRiGA4MJLew__24745.0239178308$1395925805$gmane$org@mail.gmail.com>
References: <CANudz+vJ94402GcgVbFonObcWY7HuxcPR_R6eTat54W9JmeYTQ@mail.gmail.com>
	<53341C91.3040602@mentor.com>
	<CANudz+voc=OGJXU4NViC38q2K7z1LwMnC5ZeAEAF=L+831AK2w@mail.gmail.com>
	<5334207E.1030007@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <miloody@gmail.com>) id 1WTA3j-00035s-JW
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 09:09:28 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so3400385iec.19
	for <lttng-dev@lists.lttng.org>; Thu, 27 Mar 2014 06:09:22 -0700 (PDT)
In-Reply-To: <5334207E.1030007@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

hi Stefan:


>
> Exactly. Compiling src/common/consumer.c,
> src/common/kernel-consumer/kernel-consumer.c, and
> src/common/ust-consumer/ust-consumer.c with -O1 instead of -O2 worked
> for us. And if you are afraid to mess with the build system, you can
> also inject
>
>   #pragma GCC optimize ("O1")
>
> on top of those files to override the command-line optimization option.
>
I use CFLAGS="-O1" while executing configure
But I get below message
  CCLD   lttng-consumerd
/media/sdb2/toolchain/arm/arm-v7a8v4r3-20131011/bin/../lib/gcc/arm-v7a8v4r3-linux-gnueabi/4.7.4/../../../../arm-v7a8v4r3-linux-gnueabi/bin/ld:
health_state: TLS reference in
../../../src/common/.libs/libconsumer.a(consumer.o) mismatches non-TLS
reference in ../../../src/common/.libs/libconsumer.a(consumer-timer.o)
../../../src/common/.libs/libconsumer.a: could not read symbols: Bad value
collect2: error: ld returned 1 exit status
make[3]: *** [lttng-consumerd] Error 1

is that related to optimization?

appreciate your help,
