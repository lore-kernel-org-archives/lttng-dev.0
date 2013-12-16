From: Klaus Dannecker <klaus.dannecker@gmx.de>
Subject: Re: make a trace_event in a module (driver)
Date: Mon, 16 Dec 2013 18:05:50 +0100
Message-ID: <52AF32EE.6090203__48783.399075228$1387213617$gmane$org@gmx.de>
References: <48CF5AC71E61DB46B70D0F388054EFFD267A5E6B@VAL-E-01.valcartier.drdc-rddc.gc.ca>	<5294DB13.3010307@gmx.de>	<CA+jJMxsvAc2Tq2M+qYBhM=L-zL7mhAD=J76T2C_KH7T5PJPgnA@mail.gmail.com>
	<52ADF368.7040007@gmx.de> <52AE330E.2070604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.15.19])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <klaus.dannecker@gmx.de>) id 1VsbcA-00075y-2O
	for lttng-dev@lists.lttng.org; Mon, 16 Dec 2013 12:05:59 -0500
Received: from [192.168.178.23] ([94.217.80.40]) by mail.gmx.com (mrgmx003)
	with ESMTPSA (Nemesis) id 0MYP57-1W5Y1V1EY5-00V7BB for
	<lttng-dev@lists.lttng.org>; Mon, 16 Dec 2013 18:05:48 +0100
In-Reply-To: <52AE330E.2070604@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Am 15.12.2013 23:54, schrieb Francis Giraldeau:
> Le 2013-12-15 13:22, Klaus Dannecker a =E9crit :
>> Hello,
>>
>> now its work!
>> i have download the new lttng-tools. (git pull)
>>
>> the next problem:
>> with
>> sudo insmod
>> /lib/modules/3.8.0-29-generic/extra/addons/lttng-trace-events-sample.ko
>> and
>> lttng list -k
>> hurray! i see the new event!
> Great!
>
>> now i start a lttng session and load the trace-events-sample.ko
>> (compiling the sample in the linux source code)
>> but i see not the event in the session. (looking in the eclipse viewer)
>> what i am doing wrong?
> Could it be possible that the tracepoint is not called? To verify this,
> I would recommend you to display the information in dmesg just before
> the tracepoint:
>
> if (printk_ratelimit())
> 	printk("hello event!");
>
> Then: dmesg -c
>
> What does exactly the module is supposed to record?
I see the message "hello event!"
it does not matter if i start a lttng session or not. I see always the =

message!

Regards,
Klaus

Cheers, Francis
