From: Loris Degioanni <loris@degio.org>
Subject: Re: Announcing sysdig: a new take on system
	instrumentation
Date: Thu, 03 Apr 2014 11:49:46 -0700
Message-ID: <533DAD4A.2070305__34399.6288175278$1396554171$gmane$org@gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD35992F74@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <533D9B59.4050700@gmail.com> <20140403181153.GC9339@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <loris@degio.org>) id 1WVmi4-0002iq-Fo
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 14:50:02 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so2245015pbb.26
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 11:49:49 -0700 (PDT)
In-Reply-To: <20140403181153.GC9339@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thank you David.

We did consider the lttng toolchain, but we ended up building our own =

driver for a couple of reasons:

- we do some custom work encoding events in the kernel so that they're =

ready to be consumed at user level
- we perform some additional work in the kernel (e.g. resolving network =

FD into tuples)
- our use case is currently requires a pretty small subset of the lttng =

instrumentation facilities

But we really love lttng, so I don't exclude taking a better look in the =

future, and looking into bridging the gaps as you propose. :-)

Filtering the activity of a specific process is quite easy and can be =

done with

sysdig proc.name=3DMYAPP
or
sysdig proc.pid=3DMYPID

Use
sysdig -l for a list of filtering fields that you can use.

Loris


On 4/3/2014 11:11 AM, David Goulet wrote:
> Hi Loris,
>
> I have to say that I'm quite impress with the analysis tool you guys
> have (Chisel).
>
> Quick very useful command for monitoring use cases, very nice stuff.
>
> Question time! Have you at some point consider using LTTng toolchain for
> the tracing part? Using the lttng-modules for your probes, lttng-ctl for
> tracing control, etc... ?
>
> There is one thing I can see that you do have that we don't and it's the
> ability to extract the data from the syscall payload so I guess that
> might have been a limitation with LTTng. I'm curious what are you tought
> on LTTng vis-a-vis sysdig.
>
> Do you have plans to have support for "sysdig MYAPP" like strace does
> which would filter events based on MYAPP pid/name? Because with that, we
> can retire strace :). This is something we are working towards with
> LTTng, a "lttng trace MYAPP" command that live print the trace.
>
> Your project is quite close to some LTTng features so I'm wondering here
> how can we bridge the gaps (if we can).
>
> Anyway, good job and congrats for this first release! :)
>
> Cheers!
> David
>
> On 03 Apr (10:33:13), Loris Degioanni wrote:
>> I=92d like to announce sysdig, a new open source project that I believe =
could
>> be interesting to the LTTng community. Sysdig is designed to offer a nov=
el,
>> Wireshark-like approach to system tracing.
>>
>> http://www.sysdig.org/
>> https://github.com/draios/sysdig
>>
>> Sysdig is similar to lttng from the instrumentation point of view, but is
>> like a mix between tcpdump, strace and lsof. It adds a set of layers on =
top
>> of traditional kernel-level instrumentation to reconstruct state, decode=
 and
>> filter information.
>>
>> It comes packed with a set of pretty cool features: the ability to create
>> system trace files in the wireshark-compatible pcap-ng format, an easy to
>> use filtering language, scripting in Lua, and a libpcap-like capture lib=
rary
>> that can be used to build new tools on top of the capture infrastructure.
>>
>> I=92d love to hear what you all think. And, if you do enjoy using sysdig=
, we
>> could really use your help spreading the word.
>>
>> Thanks!
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
