From: Mats Liljegren <liljegren.mats2@gmail.com>
Subject: Re: Changed scheduling when using lttng
Date: Mon, 13 May 2013 09:29:49 +0200
Message-ID: <CA+xJJ19sTc7KBa+q+hVGveO3zWMTpCG5YuP-jj6HbzTnAV4A4Q__36871.6256497011$1368430231$gmane$org@mail.gmail.com>
References: <CA+xJJ19OE=nrfpEoOEib-7=GrP9hD-RV7bc=aY7nqDwB59auXQ@mail.gmail.com>
	<20130426151444.GA2260@Krystal>
	<CA+xJJ199oic8pmnKM4c674Zf_NJe3AR1YxFtBTjLryv3S67nkQ@mail.gmail.com>
	<20130426153819.GA3026@Krystal>
	<CA+xJJ18ea02rKcfJmw9B2bTOBY0Mz_Wr6c+aszb3HWPDz2zRAQ@mail.gmail.com>
	<20130426161439.GA5547@Krystal>
	<CA+xJJ181-F-36Kw18Z5R9rvhzDeNfUgNQofHrowmY5raZA2Qtw@mail.gmail.com>
	<CA+xJJ19UQ_hh-rfjhor8pHCDL0XRGyW+ZfPzQiYBfdBsj=r0xg@mail.gmail.com>
	<20130430144323.GB31980@Krystal>
	<CA+xJJ19Bg0=R0yGiu5vsDu_1nSSY1uQLK4c=oe-5=ASzxbqmOg@mail.gmail.com>
	<20130510145620.GH20313@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <liljegren.mats2@gmail.com>) id 1UbnCl-0003G4-DZ
	for lttng-dev@lists.lttng.org; Mon, 13 May 2013 03:29:55 -0400
Received: by mail-ea0-f172.google.com with SMTP id d10so240816eaj.3
	for <lttng-dev@lists.lttng.org>; Mon, 13 May 2013 00:29:49 -0700 (PDT)
In-Reply-To: <20130510145620.GH20313@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Fri, May 10, 2013 at 4:56 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Mats Liljegren (liljegren.mats2@gmail.com) wrote:
>> >>       --buffers-global     Use shared buffer for the whole system (-k only)
>> >
>> > This option would be clearer as "--buffers-per-cpu" maybe ?
>>
>> This makes me even more confused... The name "buffers-global" is very
>> clear to me. Opposites would be buffers private for a CPU, for a UID,
>> and so on. Is the option "--buffers-global" meant to be an opposite of
>> "--buffers-uid" and "--buffers-pid"? This would seems strange since
>> those two are only for user space tracing while "--buffers-global" is
>> for kernel tracing. By the way, isn't "--buffers-per-cpu" default? Oh
>> well...
>
> Currently, we have:
>
> kernel tracing: --buffers-global (those are per-cpu buffers)
>
> ust tracing: --buffers-pid, --buffers-uid (those are also per-cpu buffers)
>
> We currently don't implement "single buffer" shared across all CPUs.
>
> By the way, the fact that e.g. --buffers-global is only available for
> kernel tracing today does not mean it will never be available for ust in
> future versions.

So for data buffers, you can have them per pid & cpu, per uid and cpu
or only per cpu where the last option is the only option for kernel
tracing. This was then according to my first belief then, it was the
help text of the lttng command that made me believe otherwise.

Then I'd vote for renaming --buffers-global to --buffers-per-cpu,
which apparently is not only default but also the only available
option for kernel tracing. If I've understood things correctly, there
are plans for offering per-cpu buffers when tracing user space as
well, which then would be the reason for keeping the option.

>>
>> But the real confusion lies in the fact that I cannot see the option
>> being used for anything. It sets the file local variable
>> opt_buffers_global, and is used for a sanity check. But I can't see it
>> being used for anything else. Have I missed something here?
>
> David ?
>
> the "lttng" command passes it to liblttng-ctl, which asks lttng-sessiond
> to allocate the buffer. Then, buffer allocation is handled by either
> sessiond or consumerd (depending if kernel or ust tracing), using either
> the lttng-modules ABI or liblttng-ust-ctl. This is where the allocation
> really happens.

Thanks for the info. I'll take a deep dive into the design and see if
I can make a more intelligent modification. When thinking about it, it
might be possible to keep things per-cpu-ish, since I have no need for
inter-cpu support when writing. It is only the flushing that needs to
be done on another CPU. Not sure what that means yet since I haven't
dived into the design yet.

/Mats
