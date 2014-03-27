From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: arm gcc compile lttng-tool fail
Date: Thu, 27 Mar 2014 09:20:15 -0400
Message-ID: <5334258F.80706__37189.2138537534$1395926471$gmane$org@mentor.com>
References: <CANudz+vJ94402GcgVbFonObcWY7HuxcPR_R6eTat54W9JmeYTQ@mail.gmail.com>	<53341C91.3040602@mentor.com>	<CANudz+voc=OGJXU4NViC38q2K7z1LwMnC5ZeAEAF=L+831AK2w@mail.gmail.com>	<5334207E.1030007@mentor.com>
	<CANudz+soZbO-GGZyXrNZdEQRp3Nz6xUO_p-mnTEeRiGA4MJLew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WTAEN-0003De-17
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 09:20:31 -0400
In-Reply-To: <CANudz+soZbO-GGZyXrNZdEQRp3Nz6xUO_p-mnTEeRiGA4MJLew@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: loody <miloody@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2014-03-27 09:09, loody wrote:
> hi Stefan:
> 
> 
>>
>> Exactly. Compiling src/common/consumer.c,
>> src/common/kernel-consumer/kernel-consumer.c, and
>> src/common/ust-consumer/ust-consumer.c with -O1 instead of -O2 worked
>> for us. And if you are afraid to mess with the build system, you can
>> also inject
>>
>>   #pragma GCC optimize ("O1")
>>
>> on top of those files to override the command-line optimization option.
>>
> I use CFLAGS="-O1" while executing configure
> But I get below message
>   CCLD   lttng-consumerd
> /media/sdb2/toolchain/arm/arm-v7a8v4r3-20131011/bin/../lib/gcc/arm-v7a8v4r3-linux-gnueabi/4.7.4/../../../../arm-v7a8v4r3-linux-gnueabi/bin/ld:
> health_state: TLS reference in
> ../../../src/common/.libs/libconsumer.a(consumer.o) mismatches non-TLS
> reference in ../../../src/common/.libs/libconsumer.a(consumer-timer.o)
> ../../../src/common/.libs/libconsumer.a: could not read symbols: Bad value
> collect2: error: ld returned 1 exit status
> make[3]: *** [lttng-consumerd] Error 1
> 
> is that related to optimization?

I haven't seen that error before. Did you run 'make clean' before ?
Perhaps your link command is now picking up object files compiled before
and after your reconfiguration, and there are other changes introduced
that are incompatible. The optimization flag alone shouldn't cause any
incompatibility.

	Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Embedded
http://www.mentor.com/embedded-software/
