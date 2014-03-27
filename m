From: loody <miloody@gmail.com>
Subject: Re: arm gcc compile lttng-tool fail
Date: Thu, 27 Mar 2014 20:53:01 +0800
Message-ID: <CANudz+voc=OGJXU4NViC38q2K7z1LwMnC5ZeAEAF=L+831AK2w__34523.1623192832$1395924825$gmane$org@mail.gmail.com>
References: <CANudz+vJ94402GcgVbFonObcWY7HuxcPR_R6eTat54W9JmeYTQ@mail.gmail.com>
	<53341C91.3040602@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <miloody@gmail.com>) id 1WT9nv-0002sw-Hs
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 08:53:10 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so3172343ieb.26
	for <lttng-dev@lists.lttng.org>; Thu, 27 Mar 2014 05:53:02 -0700 (PDT)
In-Reply-To: <53341C91.3040602@mentor.com>
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

hi stefan:

2014-03-27 20:41 GMT+08:00 Stefan Seefeld <stefan_seefeld@mentor.com>:
> On 2014-03-27 08:26, loody wrote:
>> hi all:
>> I try to compile lttng-tool for arm platform but get below message
>>
>>   CC     kernel-consumer.lo
>> kernel-consumer.c: In function 'lttng_kconsumer_snapshot_
>> channel':
>> kernel-consumer.c:324:1: internal compiler error: in gen_movsi, at
>> config/arm/arm.md:5680
>>
>> after ask gcc for help, they said this will be fixed in gcc 4.9.0
>> http://gcc.gnu.org/ml/gcc-help/2014-03/msg00107.html
>>
>> the stable release version of gcc is 4.8.2.
>> Could I get the conclusion that no one can compile it for arm platform before?
>
> We have been working around this GCC 4.8 bug by disabling optimization
> on individual compilation units.

Would you please give us a hand about how to "disabling optimization
on individual compilation units."
any configure option we can use?
or pass "-O1" instead of default "-O2" in CFLAGS?

appreciate your help,
