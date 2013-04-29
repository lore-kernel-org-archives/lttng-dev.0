From: Mats Liljegren <liljegren.mats2@gmail.com>
Subject: Re: Changed scheduling when using lttng
Date: Mon, 29 Apr 2013 08:53:04 +0200
Message-ID: <CA+xJJ181-F-36Kw18Z5R9rvhzDeNfUgNQofHrowmY5raZA2Qtw__35801.8638370142$1367218414$gmane$org@mail.gmail.com>
References: <CA+xJJ18hL16P3gvowveWVfg+ZNh=cjEFOoPisznU0y28YfCdbw@mail.gmail.com>
	<20130425151213.GC7970@Krystal>
	<CA+xJJ1-U_Y0DuLNJ+xwBLPLF+5LyS=mO4f7onpquEHSrbyOUAQ@mail.gmail.com>
	<20130426132639.GA1468@Krystal>
	<CA+xJJ19OE=nrfpEoOEib-7=GrP9hD-RV7bc=aY7nqDwB59auXQ@mail.gmail.com>
	<20130426151444.GA2260@Krystal>
	<CA+xJJ199oic8pmnKM4c674Zf_NJe3AR1YxFtBTjLryv3S67nkQ@mail.gmail.com>
	<20130426153819.GA3026@Krystal>
	<CA+xJJ18ea02rKcfJmw9B2bTOBY0Mz_Wr6c+aszb3HWPDz2zRAQ@mail.gmail.com>
	<20130426161439.GA5547@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <liljegren.mats2@gmail.com>) id 1UWhxX-00080n-3n
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 02:53:11 -0400
Received: by mail-ee0-f52.google.com with SMTP id d41so2432102eek.39
	for <lttng-dev@lists.lttng.org>; Sun, 28 Apr 2013 23:53:05 -0700 (PDT)
In-Reply-To: <20130426161439.GA5547@Krystal>
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

On Fri, Apr 26, 2013 at 6:14 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>> > AFAIU, your initial question was about not preventing the CPU from going
>> > to low power mode when tracing. The deferred timers should do just that.
>> >
>> > Indeed, the timers will fire on CPUs that are active.
>> >
>> > I guess what you want there is no intrusiveness for CPU shielding.
>> > Indeed, for this kind of use-case, you may need to centralise the timer
>> > handling into lttng-consumerd.
>>
>> I realize I didn't express myself very clearly: There is a distinction
>> between "full nohz" and "nohz idle". Full nohz means that if there are
>> no competing threads there is no reason to have ticks, so turn ticks
>> off. POSIX timers complicates things, but this was the simplistic view
>> of it... This is currently implemented as an extension of nohz idle
>> although they are quite orthogonal. Full nohz has been called "full
>> dynticks" and "extended nohz", quite a lot of naming confusion here.
>>
>> I need to read up on the code to see what seems to be the best design.
>> I thought just changing lib_ring_buffer_start_switch_timer() so that
>> it used "add_timer_on(&buff->switch_timer, 0)" would do the trick,
>> perhaps by using some kind of config for this case... But things are
>> usually not as simple as they first appear to be.
>
> If you go for this approach, I would recommend having a single timer
> handler per channel (rather than per buffer). Within the handler, you
> can iterate on each buffer.

Thanks for the advice!
I'll dive into the code and see if I can make something that works.

/Mats
