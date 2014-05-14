From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-dev] compile lttng get gcc compile error
Date: Wed, 14 May 2014 19:56:29 +0000 (UTC)
Message-ID: <1169713105.17721.1400097389080.JavaMail.zimbra@efficios.com>
References: <CANudz+u_d54BtB9Fk3Vdtb8B7im_WMbK20jg_zUGeJ3wEPECMg@mail.gmail.com> <CAH6eHdSvfWjiZCLUNHaftnwjp_L56uSPwA=hTHpLAwiPhunfsA@mail.gmail.com> <CANudz+tzfc0cjBh=7Jm4TPvm7h33oyPaZdVGBjeuOrzgM8gimQ@mail.gmail.com> <53738341.4030706@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <gcc-help-return-55271-gcc-help=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-help-unsubscribe-gcc-help=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc-help/>
List-Post: <mailto:gcc-help@gcc.gnu.org>
List-Help: <mailto:gcc-help-help@gcc.gnu.org>
Sender: gcc-help-owner@gcc.gnu.org
In-Reply-To: <53738341.4030706@keymile.com>
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: loody <miloody@gmail.com>, gcc-help <gcc-help@gcc.gnu.org>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Gerlando Falauto" <gerlando.falauto@keymile.com>
> To: "loody" <miloody@gmail.com>
> Cc: "gcc-help" <gcc-help@gcc.gnu.org>, lttng-dev@lists.lttng.org
> Sent: Wednesday, May 14, 2014 10:52:49 AM
> Subject: Re: [lttng-dev] compile lttng get gcc compile error
> 
> Hi loody,
> [originally posted to gcc-help, cross-posting to lttng-dev]
> 
> On 03/27/2014 01:37 PM, loody wrote:
> > hi Jonathan:
> >
> > 2014-03-27 18:43 GMT+08:00 Jonathan Wakely <jwakely.gcc@gmail.com>:
> >> On 27 March 2014 10:32, loody wrote:
> >>> hi all
> >>> when I try to cross-compile lttng-tool for arm.
> >>> I get below message
> >>>
> >>>    CC     kernel-consumer.lo
> >>> kernel-consumer.c: In function 'lttng_kconsumer_snapshot_channel':
> >>> kernel-consumer.c:324:1: internal compiler error: in gen_movsi, at
> >>> config/arm/arm.md:5680
> >>>
> >>> my gcc version is 4.7.4
> >>
> >> I think this is http://gcc.gnu.org/PR58595 which will be fixed in GCC
> >> 4.9.0
> > is there any patch I can use to fix this issue before waiting 4.9.0
> > release?
> > or is there method I can avoid this compile happen if I rewrite the source?
> >
> > thanks a lot,
> >
> 
> Did you ever find a workaround for such an issue? Perhaps by refactoring
> the code within lttng_kconsumer_snapshot_channel()?

A similar issue was experienced due to a gcc ARM bug. It only triggered
in O2 on specific gcc versions. I updated http://bugs.lttng.org/issues/640
with a suggested work around: compile lttng-tools in O1 if you cannot get
a fixed compiler.

Thanks,

Mathieu

> 
> Thank you!
> Gerlando
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
