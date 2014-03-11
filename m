From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Can tracepoint be listed before app registered?
Date: Tue, 11 Mar 2014 15:23:33 -0400
Message-ID: <CA+jJMxu_BWt-LO-zfH4V3HA+ONo0-cO0f1TrV26bGOwcq3zHuA__39423.9638270394$1394565880$gmane$org@mail.gmail.com>
References: <tencent_6D2083A7444C8D7C02D4AD53@qq.com>
	<CA+jJMxtsE91pFis=SQbce0eHWS-vVfAiJg6deyvFSfp=B2WvYQ@mail.gmail.com>
	<1167278944.300.1394565372926.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WNSH5-0006ij-D4
	for lttng-dev@lists.lttng.org; Tue, 11 Mar 2014 15:23:44 -0400
Received: by mail-qg0-f44.google.com with SMTP id a108so26187262qge.3
	for <lttng-dev@lists.lttng.org>; Tue, 11 Mar 2014 12:23:33 -0700 (PDT)
In-Reply-To: <1167278944.300.1394565372926.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Mar 11, 2014 at 3:16 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>
> ----- Original Message -----
>> From: "J=E9r=E9mie Galarneau" <jeremie.galarneau@efficios.com>
>> To: "zlynus" <302590304@qq.com>
>> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
>> Sent: Friday, March 7, 2014 1:23:01 PM
>> Subject: Re: [lttng-dev] Can tracepoint be listed before app registered?
>>
>> On Fri, Mar 7, 2014 at 12:26 PM, zlynus <302590304@qq.com> wrote:
>> > Hi,
>> > Sorry to bother you guys. The lttng-tool man page dosen't make it clear
>> > that
>> > when the tracepoints of user-space application can be listed. So I did=
 a
>> > little test. As far as I can tell ,the tracepoint information is only
>> > available during the application is running.
>> >
>>
>> Correct.
>>
>> > So is it possible that the tracepoint can be available *before* app get
>> > running, specifically, before enable-event subcommand? I think it can =
be
>> > quite convenient to output the list when specify which events to trace=
. If
>> > it is not for now,
>> > maybe it's a feature worth working on. My idea is lttng-tool could read
>> > tracer provider library and get the info,and  add a option after 'list'
>> > subcommand which let user specify the provider library to read. Just a
>> > personal opion from a new comer :-)
>> >
>>
>> You can enable an event before the app is started. However, as you
>> pointed out, the session daemon has no knowledge of application events
>> before they are launched.
>>
>> My understanding of your suggestion is that we should define a public
>> provider API on which the lttng client could hook itself to list
>> events. It would be of limited use in the case of statically linked
>> providers, but It's an interesting problem... Do you have a specific
>> use-case in mind?
>
> Another option that would take care of statically linked providers
> would be to let a lttng library look at all the executables on the system
> (or from a certain path in the system), as well as .so, and list a specif=
ic
> "tracepoint provider" section that we could specify. We'd need to parse
> ELF for this.
>
> Thoughts ?
>

I like the idea. Lingyu, would that be something you'd like to propose
as a GSoC project?

Regards,
J=E9r=E9mie

> Thanks,
>
> Mathieu
>
>>
>> Regards,
>> J=E9r=E9mie
>>
>> > Best regards,
>> > Lingyu Zhu
>> >
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
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
