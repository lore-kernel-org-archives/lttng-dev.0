From: Mats Liljegren <liljegren.mats2@gmail.com>
Subject: Re: Changed scheduling when using lttng
Date: Fri, 26 Apr 2013 18:11:23 +0200
Message-ID: <CA+xJJ18ea02rKcfJmw9B2bTOBY0Mz_Wr6c+aszb3HWPDz2zRAQ__47437.9031373703$1366992718$gmane$org@mail.gmail.com>
References: <CA+xJJ18hL16P3gvowveWVfg+ZNh=cjEFOoPisznU0y28YfCdbw@mail.gmail.com>
	<20130425151213.GC7970@Krystal>
	<CA+xJJ1-U_Y0DuLNJ+xwBLPLF+5LyS=mO4f7onpquEHSrbyOUAQ@mail.gmail.com>
	<20130426132639.GA1468@Krystal>
	<CA+xJJ19OE=nrfpEoOEib-7=GrP9hD-RV7bc=aY7nqDwB59auXQ@mail.gmail.com>
	<20130426151444.GA2260@Krystal>
	<CA+xJJ199oic8pmnKM4c674Zf_NJe3AR1YxFtBTjLryv3S67nkQ@mail.gmail.com>
	<20130426153819.GA3026@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <liljegren.mats2@gmail.com>) id 1UVlFB-0004QM-Jf
	for lttng-dev@lists.lttng.org; Fri, 26 Apr 2013 12:11:29 -0400
Received: by mail-ea0-f174.google.com with SMTP id g14so349800eak.19
	for <lttng-dev@lists.lttng.org>; Fri, 26 Apr 2013 09:11:23 -0700 (PDT)
In-Reply-To: <20130426153819.GA3026@Krystal>
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

On Fri, Apr 26, 2013 at 5:38 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Mats Liljegren (liljegren.mats2@gmail.com) wrote:
>> >> >> I tried number 1 using --read-timer 0, but "lttng stop" hanged at
>> >> >> "Waiting for data availability", producing lots of dots...
>> >> >
>> >> > As I said, we'd need to implement RING_BUFFER_WAKEUP_BY_WRITER when
>> >> > read-timer is set to 0. It's not implemented currently.
>> >> >
>> >> >>
>> >> >> Would it be possible to let some other (not using nohz mode) CPU to
>> >> >> flush the buffers?
>> >> >
>> >> > I guess that would be option 3) :
>> >> >
>> >> > Another option would be to let a single thread in the consumer handle
>> >> > the read-timer for all streams of the channel, like we do for UST.
>> >>
>> >> Ehm, well, you did say something about implement... Sorry for missing that.
>> >>
>> >> I guess now the question is which option that gives best
>> >> characteristics for least amount of work... Without knowing the design
>> >> of lttng-module, I'd believe that simply having the timer on another
>> >> CPU should be a good candidate. Is there anything to watch out for
>> >> with this solution?
>> >>
>> >> Are there any documents describing lttng-module design, or is it "join
>> >> the force, use the source"? I've seen some high-level description
>> >> showing how tools/libs/modules fit together, but I haven't found
>> >> anything that describes how lttng-modules is designed.
>> >
>> > Papers on the ring buffer design exist, but not on lttng-modules per se.
>> >
>> > I think the best solution in the shortest amount of time would be (2):
>> > using deferrable timers. It's just flags to pass to timer creation.
>>
>> Doesn't that require that the system is idle from time to time? My
>> application will occupy 100% CPU until finished, and expects there are
>> no ticks during that time.
>
> AFAIU, your initial question was about not preventing the CPU from going
> to low power mode when tracing. The deferred timers should do just that.
>
> Indeed, the timers will fire on CPUs that are active.
>
> I guess what you want there is no intrusiveness for CPU shielding.
> Indeed, for this kind of use-case, you may need to centralise the timer
> handling into lttng-consumerd.

I realize I didn't express myself very clearly: There is a distinction
between "full nohz" and "nohz idle". Full nohz means that if there are
no competing threads there is no reason to have ticks, so turn ticks
off. POSIX timers complicates things, but this was the simplistic view
of it... This is currently implemented as an extension of nohz idle
although they are quite orthogonal. Full nohz has been called "full
dynticks" and "extended nohz", quite a lot of naming confusion here.

I need to read up on the code to see what seems to be the best design.
I thought just changing lib_ring_buffer_start_switch_timer() so that
it used "add_timer_on(&buff->switch_timer, 0)" would do the trick,
perhaps by using some kind of config for this case... But things are
usually not as simple as they first appear to be.

/Mats
