From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: arm gcc compile lttng-tool fail
Date: Thu, 27 Mar 2014 08:41:53 -0400
Message-ID: <53341C91.3040602__21578.5121698447$1395924159$gmane$org@mentor.com>
References: <CANudz+vJ94402GcgVbFonObcWY7HuxcPR_R6eTat54W9JmeYTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WT9dB-0002mD-Ti
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 08:42:05 -0400
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp
	id 1WT9d5-0005Ix-4S from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 27 Mar 2014 05:41:55 -0700
In-Reply-To: <CANudz+vJ94402GcgVbFonObcWY7HuxcPR_R6eTat54W9JmeYTQ@mail.gmail.com>
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

On 2014-03-27 08:26, loody wrote:
> hi all:
> I try to compile lttng-tool for arm platform but get below message
>
>   CC     kernel-consumer.lo
> kernel-consumer.c: In function 'lttng_kconsumer_snapshot_
> channel':
> kernel-consumer.c:324:1: internal compiler error: in gen_movsi, at
> config/arm/arm.md:5680
>
> after ask gcc for help, they said this will be fixed in gcc 4.9.0
> http://gcc.gnu.org/ml/gcc-help/2014-03/msg00107.html
>
> the stable release version of gcc is 4.8.2.
> Could I get the conclusion that no one can compile it for arm platform before?

We have been working around this GCC 4.8 bug by disabling optimization
on individual compilation units.

    Stefan


-- 
Stefan Seefeld
CodeSourcery / Mentor Embedded
http://www.mentor.com/embedded-software/
