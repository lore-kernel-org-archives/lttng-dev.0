From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: Processor support for user space tracer (ppc64)
Date: Sat, 20 Apr 2013 14:50:19 -0400
Message-ID: <CAGDH53=sCarskNureU=iCEG5+kdCiReaVJwF_sc7Xdr50azJ7Q__45177.5701986209$1366483850$gmane$org@mail.gmail.com>
References: <05E83BDD0E1F054FA73F00F6970F05C60608EA@CH1PRD0810MB394.namprd08.prod.outlook.com>
	<20130416151047.GA22323@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f45.google.com ([209.85.212.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UTcrh-0003hD-Gw
	for lttng-dev@lists.lttng.org; Sat, 20 Apr 2013 14:50:25 -0400
Received: by mail-vb0-f45.google.com with SMTP id w15so4763263vbf.32
	for <lttng-dev@lists.lttng.org>; Sat, 20 Apr 2013 11:50:20 -0700 (PDT)
In-Reply-To: <20130416151047.GA22323@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Hari Prasad Kalavakunta <Hari.Prasad@radisys.com>
List-Id: lttng-dev@lists.lttng.org

Website has been updated. Basically, lttng-ust should be compatible
with all the architectures supported by userspace-rcu, right?

On Tue, Apr 16, 2013 at 11:10 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> Yes, ppc64 should work fine with lttng-ust. This list is not up to date.
>
> CCing Christian so he can update it.
>
> * Hari Prasad Kalavakunta (Hari.Prasad@radisys.com) wrote:
>> Hello lttng-dev,
>>
>> Good morning and very short question.
>>
>> Is user space tracer not supported yet for ppc64?
>>
>> URL http://lttng.org/comparison-systemtap-and-dtrace   lists only x86 for User Space tracing. Could you please confirm the same.
>>
>> processor support
>>
>> Kernel tracer: x86-32, x86-64, SPARC, SPARC64, ppc, ppc64, sh, sh64, ia64, s390, MIPS 32/64, ARM, (arch-agnostic core)
>> Userspace tracer: x86-32, x86-64
>>
>>
>> Regards,
>> Hari
>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
