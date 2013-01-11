From: "Ostermueller, Erik" <Erik.Ostermueller@fisglobal.com>
Subject: Re: tracing of non-JNI java in IBM jvm
Date: Fri, 11 Jan 2013 16:26:51 +0000
Message-ID: <A94B468263DDE2448A14367F590EB97301D10B85__6944.24185571751$1357921685$gmane$org@ltcfiswmsgmb15>
References: <A94B468263DDE2448A14367F590EB97301D10803@ltcfiswmsgmb15>
	<50F03512.4080100@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx1.fisglobal.com ([199.200.24.190])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Erik.Ostermueller@fisglobal.com>) id 1TthRv-0000VH-60
	for lttng-dev@lists.lttng.org; Fri, 11 Jan 2013 11:27:19 -0500
In-Reply-To: <50F03512.4080100@voxpopuli.im>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks Alex for the quick reply....now I get it.
I'll jump in on that other thread you mentioned.

There is a tool called InTrace that does some of this work.
Perhaps some design ideas or even code could be stolen from here:  http://mchr3k.github.com/org.intrace/
This project:
* implements the java.lang.instrumentation api, which can be used to plug a tracing tool into an already-running JVM.
* allows you to instrument/de-instrument various classes without restarting the JVM.
* Uses http://asm.ow2.org/ to inject byte code for entry/exit tracing methods.
* stores thread id (good) but does nothing to sort/organize activity by thread id into a session(bad)
* no graphing/aggregating of performance metrics...just displays entry/exit times, method parameters, etc...

--Erik




-----Original Message-----
From: Alexandre Montplaisir [mailto:alexmonthy@voxpopuli.im] 
Sent: Friday, January 11, 2013 9:52 AM
To: Ostermueller, Erik
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] tracing of non-JNI java in IBM jvm

Hi Erik,

I'm not sure what you mean by "non-JNI java calls". LTTng-UST is a tracer implemented in C. There are Java bindings available (if you configure UST with --with-jni-interface), but if you want to use it to trace Java applications, it will have to go through JNI.

If this is what you want to do, I have an example at http://git.dorsal.polymtl.ca/~alexmont?p=ust-jni-tests.git;a=summary .
It's a small Java application instrumented with UST JNI tracepoints.

Finally, there is an ongoing project about hooking UST into a JUL
(java.util.logging) handler, and moving more logic like session control to the Java side of things. It's still at the design stage afaik, but you might want to monitor this thread:
http://lists.lttng.org/pipermail/lttng-dev/2013-January/019371.html

One more comment below,

On 13-01-10 05:52 PM, Ostermueller, Erik wrote:
> Hi all,
>
> Would like to use LTTng to trace some pure, non-JNI java method calls.
> Seems like I need to
>
> *         install 2.1.0-rc2
>
> *         install the TMF/Eclipse LTTng plugin

The Eclipse plugin does no tracing by itself. It's mainly only a viewer for LTTng/UST traces. It also has a control feature that allows controlling a LTTng session daemon from within Eclipse, but it still requires the lttng tools to be installed on the traced machine.


Cheers,
Alex

>
> *         how do I indicate which classes/methods to be traced?
>
> I started with the "User-space" tracing section this doc:  
> https://bugs.lttng.org/projects/lttng-tools/wiki
> ...but then I stop understanding things when I read "So, after instrumenting you applications with LTTng-ust 2.0".
> That was followed by a link to http://lttng.org/lttng2.0, but that didn't help.
>
> Would love to be an alpha/beta tester if this isn't ready yet.
>
> Thanks a lot,
> --Erik
>
> ###   some info about my environment:  ####################################
>
>
> =>uname -a
> Linux vlxesngperf01.atldev.com 2.6.18-238.5.1.el5 #1 SMP Mon Feb 21 
> 05:52:39 EST 2011 x86_64 x86_64 x86_64 GNU/Linux
>
> =>cat /etc/issue
> Red Hat Enterprise Linux Server release 5.6 (Tikanga) Kernel \r on an 
> \m
>
>
> tp@vlxesngperf01 /usr/tp/app/tp/nmon/bin$=>java -version java version 
> "1.6.0"
> Java(TM) SE Runtime Environment (build 
> pxa6460sr9fp2ifix-20111111_05(SR9 
> FP2+IV03622+IV02378+IZ99243+IZ97310+IV00707))
> IBM J9 VM (build 2.4, JRE 1.6.0 IBM J9 2.4 Linux amd64-64 
> jvmxa6460sr9-20111111_94827 (JIT enabled, AOT enabled) J9VM - 
> 20111111_094827 JIT  - r9_20101028_17488ifx45
> GC   - 20101027_AA)
> JCL  - 20110727_04
>
>
> ________________________________
> Erik Ostermueller
> Xpress Architecture
>
> T: 501.220.7753
> C:501.213.8309
> erik.ostermueller@fisglobal.com<mailto:erik.ostermueller@fisglobal.com
> >
> [Description: Description: Description: Description: 
> cid:image001.png@01CD8AB3.84921E40]
> [Description: Description: Description: Description: 
> cid:image003.png@01CD8AB3.84921E40]
>
> _____________
> The information contained in this message is proprietary and/or confidential. If you are not the intended recipient, please: (i) delete the message and all copies; (ii) do not disclose, distribute or use the message in any manner; and (iii) notify the sender immediately. In addition, please be aware that any message addressed to our domain is subject to archiving and review by persons other than the intended recipient. Thank you.
>
>
>

_____________
The information contained in this message is proprietary and/or confidential. If you are not the intended recipient, please: (i) delete the message and all copies; (ii) do not disclose, distribute or use the message in any manner; and (iii) notify the sender immediately. In addition, please be aware that any message addressed to our domain is subject to archiving and review by persons other than the intended recipient. Thank you.
