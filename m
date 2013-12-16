From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: make a trace_event in a module (driver)
Date: Mon, 16 Dec 2013 15:33:21 -0500
Message-ID: <CA+jJMxsA2P0BWQJzoanK5Sp37tTyXzyCnTrMO8n+XfFgQN+AXw__19621.9148616821$1387226065$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5E6B@VAL-E-01.valcartier.drdc-rddc.gc.ca>
	<5294DB13.3010307@gmx.de>
	<CA+jJMxsvAc2Tq2M+qYBhM=L-zL7mhAD=J76T2C_KH7T5PJPgnA@mail.gmail.com>
	<52ADF368.7040007@gmx.de> <52AE330E.2070604@gmail.com>
	<52AF32EE.6090203@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Vser0-0000DW-VB
	for lttng-dev@lists.lttng.org; Mon, 16 Dec 2013 15:33:33 -0500
Received: by mail-qa0-f46.google.com with SMTP id f11so1918181qae.12
	for <lttng-dev@lists.lttng.org>; Mon, 16 Dec 2013 12:33:21 -0800 (PST)
In-Reply-To: <52AF32EE.6090203@gmx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Klaus Dannecker <klaus.dannecker@gmx.de>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Dec 16, 2013 at 12:05 PM, Klaus Dannecker
<klaus.dannecker@gmx.de> wrote:
>
> Am 15.12.2013 23:54, schrieb Francis Giraldeau:
>
>> Le 2013-12-15 13:22, Klaus Dannecker a =E9crit :
>>>
>>> Hello,
>>>
>>> now its work!
>>> i have download the new lttng-tools. (git pull)
>>>
>>> the next problem:
>>> with
>>> sudo insmod
>>> /lib/modules/3.8.0-29-generic/extra/addons/lttng-trace-events-sample.ko
>>> and
>>> lttng list -k
>>> hurray! i see the new event!
>>
>> Great!
>>
>>> now i start a lttng session and load the trace-events-sample.ko
>>> (compiling the sample in the linux source code)
>>> but i see not the event in the session. (looking in the eclipse viewer)
>>> what i am doing wrong?
>>
>> Could it be possible that the tracepoint is not called? To verify this,
>> I would recommend you to display the information in dmesg just before
>> the tracepoint:
>>
>> if (printk_ratelimit())
>>         printk("hello event!");
>>
>> Then: dmesg -c
>>
>> What does exactly the module is supposed to record?
>
> I see the message "hello event!"
> it does not matter if i start a lttng session or not. I see always the
> message!

Can you see events from the rest of the kernel in your trace?

>
> Regards,
> Klaus
>
>
> Cheers, Francis
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
