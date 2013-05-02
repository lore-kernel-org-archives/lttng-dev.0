From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng enable-channel option for blocking
Date: Thu, 2 May 2013 10:58:27 -0400
Message-ID: <20130502145827.GA8853__36177.1470089026$1367506752$gmane$org@Krystal>
References: <4F992213.2090103@mentor.com> <20120426211627.GB1646@Krystal>
	<4F9A4A91.7090102@mentor.com> <20120427113321.GA6987@Krystal>
	<4F9A87F3.5090504@mentor.com> <20120427124344.GB21048@Krystal>
	<4F9AC627.2090203@mentor.com> <20120430142026.GA31622@Krystal>
	<4FA114B3.1040108@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UXuxp-0003pE-Av
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 10:58:29 -0400
Content-Disposition: inline
In-Reply-To: <4FA114B3.1040108@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
> On 04/30/2012 04:20 PM, Mathieu Desnoyers wrote:
>> * Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
>>> On 04/27/2012 02:43 PM, Mathieu Desnoyers wrote:
>>>> * Woegerer, Paul (Paul_Woegerer@mentor.com) wrote:
>>>>> On 04/27/2012 01:33 PM, Mathieu Desnoyers wrote:
>>>>>> A core difference between ulimit and user-space tracing is that ulim=
it
>>>>>> can only be set within the environment (and access right) of the user
>>>>>> running the application. System-wide tracing sessions can be initiat=
ed
>>>>>> by users member of the "tracing" group -- giving them the ability to
>>>>>> potentially DoS an application does not appear to me to be a good
>>>>>> security practice. Thoughts ?
>>>>> Hmm, how would that look in practice ? Lets assume there is the web
>>>>> server which was started by an init-script in runlevel 3. How does a
>>>>> user that belongs to group tracing hava a chance to DoS the already
>>>>> running running web server. As far as I understand the trace session
>>>>> concept every tracing user can only see (and affect) the tracing sess=
ion
>>>>> that he initiated. Even if the web server itself runs in a tracing
>>>>> session (of user wwwrun) other tracing users wouldn't see it when they
>>>>> do a "lttng list", right ?
>>>> Let me clarify the concept of tracing session in lttng 2.0.
>>>>
>>>> We support launching per-user sessiond, which only interact with the
>>>> user's applications. That's all fine with security.
>>>>
>>>> Now, we also support a root system-wide sessiond, which allows kernel
>>>> and user-space tracing. The "tracing" group has every right to create a
>>>> tracing session and trace the kernel and _all_ applications that were
>>>> already or will be running on the system.
>>> Ah, I see. I was not aware of the "... and _all_ applications that were
>>> already or will be running on the system" aspect of the concept. In that
>>> case I would rather invert the semantic in the API and instead of having
>>> a tracepoint() function that potentially blocks I would declare
>>> tracepoint() to never ever block and additionally provide tracepointb()
>>> that does potentially block.
>> So keeping this in mind, one way to allow this kind of "blocking" mode
>> might be to add a special option to the lttng-sessiond, e.g. a
>> "--developer" mode, which could enable this feature, and possibly other
>> features that are not "safe" to deploy on production machines.
>
> Sounds good. Our need for blocking channels is only during development  =

> phase.
>
> In case of blocking it would be useful to emit a meta-event to indicate  =

> that blocking happened. This allows to (optionally) factor out blocking  =

> periods from event data visualizations.

We already have start-end timestamps in packet headers. We can already
compute blocking time by looking at the delta between consecutive
packet's end time and start time.

>
> Thanks,
> Paul
>
> PS: A more general question: In the light of the upcoming event  =

> streaming support for LTTng, is it intended to use lttng for "regular"  =

> event based real-time communication (non-tracing/debugging related) as  =

> well. From that perspective, support for blocking (reliably emitted  =

> events) would become mandatory (there might be events of kind  =

> cooling_system_deactivated, containment_leakage_detected, ...).

Well, currently lttng-tools is designed so that even if the consumerd is
killed, the application traced with UST will continue running without
any issue. Adding the option to "block" the application would require us
to enhance the lttng-tools design in ways that would allow applications
to continue behaving correctly in case of a sessiond/consumerd failure.
That's the tricky part.

Thanks,

Mathieu

>
>>
>> Thoughts ?
>>
>> Thanks,
>>
>> Mathieu
>>
>
>
> -- =

> Paul Woegerer | SW Development Engineer
> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> P 43.1.535991320
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
>
> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.
>

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
