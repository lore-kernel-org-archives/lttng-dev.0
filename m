From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: supporting new processor
Date: Tue, 11 Jun 2013 09:20:00 -0400
Message-ID: <CA+jJMxshwZh-6ysyAfFG6oFqx3KTmyDqRdmkxoHYzf0G_hqmJA__48404.2705073536$1370956885$gmane$org@mail.gmail.com>
References: <CANJoRMRRWiHAL=fcP717Dv9QmZVJBjpLjB0pBEioewtni8QkLw@mail.gmail.com>
	<CA+jJMxuvWRgyhzu4=QUh0+TR=9Lp1BV7PcHJHuj-LOgPDFTDUQ@mail.gmail.com>
	<CANJoRMS1y+rdpwkO+F2UVc72FL4WVbqrUVXH8iMBt344U3h71Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1UmOUY-00057S-WC
	for lttng-dev@lists.lttng.org; Tue, 11 Jun 2013 09:20:07 -0400
Received: by mail-wi0-f178.google.com with SMTP id k10so4119386wiv.17
	for <lttng-dev@lists.lttng.org>; Tue, 11 Jun 2013 06:20:01 -0700 (PDT)
In-Reply-To: <CANJoRMS1y+rdpwkO+F2UVc72FL4WVbqrUVXH8iMBt344U3h71Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Madhusudan Bhat <madhu.b77@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

MIPS support was added as part of the Userspace RCU 0.7.4 release.
Can't say I have tried it myself though.

Regards,
J=E9r=E9mie

On Tue, Jun 11, 2013 at 6:42 AM, Madhusudan Bhat <madhu.b77@gmail.com> wrot=
e:
> Hi J=E9r=E9mie,
>
> Thanks for the response. You have mentioned that MIPS is supported. Howev=
er
> README under U-RCU doesn't list the MIPS under the supported architecture.
> Is it possible to confirm again?
>
> Is there any order in which I need to build the different components like
> URCU, lttng-tools, kernel module and UST?
> thanks,
> Madhu.
>
>
> On Mon, Apr 22, 2013 at 7:47 PM, J=E9r=E9mie Galarneau
> <jeremie.galarneau@efficios.com> wrote:
>>
>> Hi,
>>
>> Generally speaking, URCU is the most architecture-specific library of
>> the project and it does support MIPS. Once it is compiled and
>> installed, you should be able to build lttng-ust, lttng-tools and the
>> kernel modules.
>>
>> I'd recommend running each project's test suite since I don't think
>> that architecture has been thoroughly tested. Let us know if you
>> encounter any problem on your particular architecture.
>>
>> Regards,
>> J=E9r=E9mie
>>
>> On Mon, Apr 22, 2013 at 1:30 AM, Madhusudan Bhat <madhu.b77@gmail.com>
>> wrote:
>> > Hi All,
>> >
>> > I need to support lttng tools, I have new MIPS based multi core
>> > processor on
>> > which 3.7 linux kernel boots up.
>> >
>> > To support lttng tools, does it require any drivers/kernel hook ups to
>> > new
>> > processor? Or is it independent of processor architecture?
>> >
>> > For ex, to support Oprofile tools, we need to provide oprofile driver
>> > which
>> > is specific to particular processor. In similar ways,any thing is
>> > required
>> > to support lttng tools?
>> >
>> > thanks,
>> > Madhu.
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>>
>>
>>
>> --
>> J=E9r=E9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
