From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: arm gcc compile lttng-tool fail
Date: Wed, 28 May 2014 17:31:59 +0200
Message-ID: <5386016F.2020205__7532.8932879076$1401291203$gmane$org@keymile.com>
References: <CANudz+vJ94402GcgVbFonObcWY7HuxcPR_R6eTat54W9JmeYTQ@mail.gmail.com>	<53341C91.3040602@mentor.com>	<CANudz+voc=OGJXU4NViC38q2K7z1LwMnC5ZeAEAF=L+831AK2w@mail.gmail.com>	<5334207E.1030007@mentor.com>	<CANudz+soZbO-GGZyXrNZdEQRp3Nz6xUO_p-mnTEeRiGA4MJLew@mail.gmail.com>
 <5334258F.80706@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=02251e696b=gerlando.falauto@keymile.com>)
 id 1Wpfpw-0002Um-BF
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 11:32:21 -0400
In-Reply-To: <5334258F.80706@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>, loody <miloody@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

 >> I use CFLAGS="-O1" while executing configure
>> But I get below message
>>    CCLD   lttng-consumerd
>> /media/sdb2/toolchain/arm/arm-v7a8v4r3-20131011/bin/../lib/gcc/arm-v7a8v4r3-linux-gnueabi/4.7.4/../../../../arm-v7a8v4r3-linux-gnueabi/bin/ld:
>> health_state: TLS reference in
>> ../../../src/common/.libs/libconsumer.a(consumer.o) mismatches non-TLS
>> reference in ../../../src/common/.libs/libconsumer.a(consumer-timer.o)
>> ../../../src/common/.libs/libconsumer.a: could not read symbols: Bad value
>> collect2: error: ld returned 1 exit status
>> make[3]: *** [lttng-consumerd] Error 1
>>
>> is that related to optimization?
>
> I haven't seen that error before. Did you run 'make clean' before ?
> Perhaps your link command is now picking up object files compiled before
> and after your reconfiguration, and there are other changes introduced
> that are incompatible. The optimization flag alone shouldn't cause any
> incompatibility.

I ran into the same problem with -O1 (tested from a fresh checkout).
Did you ever find any way out?
Looks like -O0 does the trick for me.

Weirdly enough, I'm 99% sure I had tested this with -O1 and it was 
working fine. But maybe I was then starting with a *NOT* clean 
environment (first compiled something with -O2 and then switched 
afterwards).
Whatever.

Thanks,
Gerlando
