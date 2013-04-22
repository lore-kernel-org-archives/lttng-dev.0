From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: supporting new processor
Date: Mon, 22 Apr 2013 11:41:24 -0400
Message-ID: <51755A24.6020905__5518.84266683391$1366645317$gmane$org@gmail.com>
References: <CANJoRMRRWiHAL=fcP717Dv9QmZVJBjpLjB0pBEioewtni8QkLw@mail.gmail.com>
	<CA+jJMxuvWRgyhzu4=QUh0+TR=9Lp1BV7PcHJHuj-LOgPDFTDUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UUIrz-0008Bm-Jd
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 11:41:31 -0400
Received: by mail-qe0-f54.google.com with SMTP id s14so4138921qeb.41
	for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 08:41:26 -0700 (PDT)
In-Reply-To: <CA+jJMxuvWRgyhzu4=QUh0+TR=9Lp1BV7PcHJHuj-LOgPDFTDUQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: Madhusudan Bhat <madhu.b77@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

For the kernel module, from what I've seen, you'll be missing the
syscall tracing, but the rest of the tracepoints should work.

Syscall tracing requires some architecture specific code in the kernel
itself.

On 2013-04-22 10:17, J=E9r=E9mie Galarneau wrote:
> Hi,
>
> Generally speaking, URCU is the most architecture-specific library of
> the project and it does support MIPS. Once it is compiled and
> installed, you should be able to build lttng-ust, lttng-tools and the
> kernel modules.
>
> I'd recommend running each project's test suite since I don't think
> that architecture has been thoroughly tested. Let us know if you
> encounter any problem on your particular architecture.
>
> Regards,
> J=E9r=E9mie
>
> On Mon, Apr 22, 2013 at 1:30 AM, Madhusudan Bhat <madhu.b77@gmail.com> wr=
ote:
>> Hi All,
>>
>> I need to support lttng tools, I have new MIPS based multi core processo=
r on
>> which 3.7 linux kernel boots up.
>>
>> To support lttng tools, does it require any drivers/kernel hook ups to n=
ew
>> processor? Or is it independent of processor architecture?
>>
>> For ex, to support Oprofile tools, we need to provide oprofile driver wh=
ich
>> is specific to particular processor. In similar ways,any thing is requir=
ed
>> to support lttng tools?
>>
>> thanks,
>> Madhu.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
>
