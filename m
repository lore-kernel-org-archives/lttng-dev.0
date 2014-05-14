From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: compile lttng get gcc compile error
Date: Wed, 14 May 2014 16:52:49 +0200
Message-ID: <53738341.4030706@keymile.com>
References: <CANudz+u_d54BtB9Fk3Vdtb8B7im_WMbK20jg_zUGeJ3wEPECMg@mail.gmail.com>	<CAH6eHdSvfWjiZCLUNHaftnwjp_L56uSPwA=hTHpLAwiPhunfsA@mail.gmail.com> <CANudz+tzfc0cjBh=7Jm4TPvm7h33oyPaZdVGBjeuOrzgM8gimQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <gcc-help-return-55266-gcc-help=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-help-unsubscribe-gcc-help=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc-help/>
List-Post: <mailto:gcc-help@gcc.gnu.org>
List-Help: <mailto:gcc-help-help@gcc.gnu.org>
Sender: gcc-help-owner@gcc.gnu.org
In-Reply-To: <CANudz+tzfc0cjBh=7Jm4TPvm7h33oyPaZdVGBjeuOrzgM8gimQ@mail.gmail.com>
To: loody <miloody@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, gcc-help <gcc-help@gcc.gnu.org>
List-Id: lttng-dev@lists.lttng.org

Hi loody,
[originally posted to gcc-help, cross-posting to lttng-dev]

On 03/27/2014 01:37 PM, loody wrote:
> hi Jonathan:
>
> 2014-03-27 18:43 GMT+08:00 Jonathan Wakely <jwakely.gcc@gmail.com>:
>> On 27 March 2014 10:32, loody wrote:
>>> hi all
>>> when I try to cross-compile lttng-tool for arm.
>>> I get below message
>>>
>>>    CC     kernel-consumer.lo
>>> kernel-consumer.c: In function 'lttng_kconsumer_snapshot_channel':
>>> kernel-consumer.c:324:1: internal compiler error: in gen_movsi, at
>>> config/arm/arm.md:5680
>>>
>>> my gcc version is 4.7.4
>>
>> I think this is http://gcc.gnu.org/PR58595 which will be fixed in GCC 4.9.0
> is there any patch I can use to fix this issue before waiting 4.9.0 release?
> or is there method I can avoid this compile happen if I rewrite the source?
>
> thanks a lot,
>

Did you ever find a workaround for such an issue? Perhaps by refactoring 
the code within lttng_kconsumer_snapshot_channel()?

Thank you!
Gerlando
