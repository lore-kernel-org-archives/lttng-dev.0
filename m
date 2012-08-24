From: Hui Zhu <teawater@gmail.com>
Subject: Re: [babeltrace] About the type read and write
Date: Fri, 24 Aug 2012 20:48:21 +0800
Message-ID: <CANFwon1JKWnodpnV+ue1XU8sGJQ+9ekO=p00j21MvRmtg2QvBg__25796.7141610154$1345812584$gmane$org@mail.gmail.com>
References: <CANFwon1jpk3PYYd-ufUSCgKf693vApFgt5UbyOFnPczYTrSZcQ@mail.gmail.com>
	<20120823122754.GA23841@Krystal>
	<CANFwon2OKKxSJj8QCkmje9jYHPLBZLdOet3qaB7huSG_96877w@mail.gmail.com>
	<20120824113852.GB12824@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <teawater@gmail.com>) id 1T4tJz-000484-KH
	for lttng-dev@lists.lttng.org; Fri, 24 Aug 2012 08:49:07 -0400
Received: by vcbfl11 with SMTP id fl11so2536613vcb.35
	for <lttng-dev@lists.lttng.org>; Fri, 24 Aug 2012 05:49:02 -0700 (PDT)
In-Reply-To: <20120824113852.GB12824@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, jdesfossez@efficios.com
List-Id: lttng-dev@lists.lttng.org

On Fri, Aug 24, 2012 at 7:38 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Hui Zhu (teawater@gmail.com) wrote:
>> On Thu, Aug 23, 2012 at 8:27 PM, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>> > * Hui Zhu (teawater@gmail.com) wrote:
>> >> Hi,
>> >>
>> >> I just tried to use libbabeltrace to read and write the CTF file.  But
>> >> I cannot find the api to read some type of CTF for example
>> >> CTF_TYPE_ENUM, CTF_TYPE_STRUCT.
>> >
>> > AFAIU, the API bt_ctf_get_field_list allows to get the list of
>> > definitions from a struct, variant, array, or sequence (any compound
>> > type). Julien, I think the header documentation of this function should
>> > really be updated, can you look into that ?
>> >
>> > Indeed, I also cannot see any API to get the enum string from the field.
>> > Julien, can we add it ?
>> >
>> >> And I cannot find the api file to write to the CTF file. (I check the
>> >> code of babeltrace-log and found that it use the function that is not
>> >> API)
>> >
>> > Currently, babeltrace only does CTF-to-text and text-log-to-CTF
>> > conversions. As you noticed, it does not expose API to write into all
>> > CTF types at this stage.
>>
>> Do you have plan to expose some API that can write CTF?
>
> Not for 1.0, as it has nearly completed its development cycle. The
> intent is to someday add CTF write capability to babeltrace, but we are
> not there yet, and we have not received any requests/contracts to do.
>

OK.  Thanks for your help, Mathieu.

Best,
Hui

> Thanks,
>
> Mathieu
>
>>
>> Thanks,
>> Hui
>>
>> >
>> > There is a prototype I am aware of that does just that (write custom CTF
>> > files): Javeltrace. See the post here
>> > http://lists.lttng.org/pipermail/lttng-dev/2012-August/018393.html for
>> > details.
>> >
>> > Thanks,
>> >
>> > Mathieu
>> >
>> >>
>> >> Could you help me with it?
>> >>
>> >> Thanks,
>> >> Hui
>> >>
>> >> _______________________________________________
>> >> lttng-dev mailing list
>> >> lttng-dev@lists.lttng.org
>> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>> > --
>> > Mathieu Desnoyers
>> > Operating System Efficiency R&D Consultant
>> > EfficiOS Inc.
>> > http://www.efficios.com
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
