From: Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [lttng-dev]  Bogus openembedded gcc patch
Date: Wed, 27 Jan 2016 12:26:00 -0500
Message-ID: <CAMKF1sqEb-G3ENVWkhesEoMkgMJdvKf8wcbvOJ3hDf6EVQb=XQ@mail.gmail.com>
References: <1037243108.4336.1453770172960.JavaMail.zimbra@efficios.com>
	<51287CFC-6F3C-43B1-9190-84F3B20C192E@gmail.com>
	<433937130.5072.1453838389504.JavaMail.zimbra@efficios.com>
	<CAMKF1sofnyADcNkAc+YrXjPED=ALxf60oPEsuQiJTAY87oB31Q@mail.gmail.com>
	<CAJTo0LZazTzkp94ASdACaBOuC4JpNWCpnf46kAucjY5B+wX2vQ@mail.gmail.com>
	<883932458.5623.1453895978760.JavaMail.zimbra@efficios.com>
	<809092932.5736.1453901457659.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1542137901=="
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <809092932.5736.1453901457659.JavaMail.zimbra-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Cc: lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Patches and discussions about the oe-core layer <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

--===============1542137901==
Content-Type: multipart/alternative; boundary=001a113ebd7c905e82052a541817

--001a113ebd7c905e82052a541817
Content-Type: text/plain; charset=UTF-8

On Jan 27, 2016 8:30 AM, "Mathieu Desnoyers" <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
wrote:
>
> ----- On Jan 27, 2016, at 6:59 AM, Mathieu Desnoyers <
mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org> wrote:
>>
>> ----- On Jan 27, 2016, at 6:31 AM, Burton, Ross <ross.burton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
wrote:
>>>
>>>
>>> On 26 January 2016 at 23:14, Khem Raj <raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>
>>>> > Yes, we have narrowed down our problem to this specific patch by
>>>> > removing the patch from the OE gcc patches, rebuilding gcc, and
>>>> > then building our test program with that gcc. The problem goes
>>>> > away when we do so, which points directly to that patch as a
>>>> > culprit.
>>>> >
>>>> > Test program is attached.
>>>>
>>>> Ok I think we can remove this from master and jethro release
>>>
>>>
>>> Mathieu, as you found this do you want the glory by submitting a the
removal patch?
>>
>>
>> Thanks for asking, but for me a
>>
>> Reported-by: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
>>
>> in the patch commit messge is good enough.
>> You'll probably want to have a link to this discussion thread
>> also in the commit message.
>
>
> I have a few minutes in front of me, I'll prepare a patch.

Ok. I think for jethro and master its ok, for other branches. This needs
testing
>
> Thanks,
>
> Mathieu
>
>>
>>
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> Cheerss,
>>> Ross
>>>
>>
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--001a113ebd7c905e82052a541817
Content-Type: text/html; charset=UTF-8

<p dir="ltr"><br>
On Jan 27, 2016 8:30 AM, &quot;Mathieu Desnoyers&quot; &lt;<a href="mailto:mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org">mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; ----- On Jan 27, 2016, at 6:59 AM, Mathieu Desnoyers &lt;<a href="mailto:mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org">mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; ----- On Jan 27, 2016, at 6:31 AM, Burton, Ross &lt;<a href="mailto:ross.burton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org">ross.burton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 26 January 2016 at 23:14, Khem Raj &lt;<a href="mailto:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt; Yes, we have narrowed down our problem to this specific patch by<br>
&gt;&gt;&gt;&gt; &gt; removing the patch from the OE gcc patches, rebuilding gcc, and<br>
&gt;&gt;&gt;&gt; &gt; then building our test program with that gcc. The problem goes<br>
&gt;&gt;&gt;&gt; &gt; away when we do so, which points directly to that patch as a<br>
&gt;&gt;&gt;&gt; &gt; culprit.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Test program is attached.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Ok I think we can remove this from master and jethro release<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Mathieu, as you found this do you want the glory by submitting a the removal patch?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks for asking, but for me a<br>
&gt;&gt;<br>
&gt;&gt; Reported-by: Mathieu Desnoyers &lt;<a href="mailto:mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org">mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; in the patch commit messge is good enough.<br>
&gt;&gt; You&#39;ll probably want to have a link to this discussion thread<br>
&gt;&gt; also in the commit message.<br>
&gt;<br>
&gt;<br>
&gt; I have a few minutes in front of me, I&#39;ll prepare a patch.</p>
<p dir="ltr">Ok. I think for jethro and master its ok, for other branches. This needs testing<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Mathieu<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt;<br>
&gt;&gt; Mathieu<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Cheerss,<br>
&gt;&gt;&gt; Ross<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; -- <br>
&gt;&gt; Mathieu Desnoyers<br>
&gt;&gt; EfficiOS Inc.<br>
&gt;&gt; <a href="http://www.efficios.com">http://www.efficios.com</a><br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; lttng-dev mailing list<br>
&gt;&gt; <a href="mailto:lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org">lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org</a><br>
&gt;&gt; <a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
&gt;<br>
&gt;<br>
&gt; -- <br>
&gt; Mathieu Desnoyers<br>
&gt; EfficiOS Inc.<br>
&gt; <a href="http://www.efficios.com">http://www.efficios.com</a></p>

--001a113ebd7c905e82052a541817--

--===============1542137901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
_______________________________________________
Openembedded-core mailing list
Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
http://lists.openembedded.org/mailman/listinfo/openembedded-core

--===============1542137901==--
