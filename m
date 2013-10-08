From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: Use lttng for my own module which already has trace
 events
Date: Tue, 08 Oct 2013 09:10:26 -0400
Message-ID: <52540442.2070808__38772.8144335144$1381237906$gmane$org@gmail.com>
References: <6B3AC2788014DD49B43AF9611365BBAA21CACCA460@mary.at.omicron.at>
	<5253EBA8.2050205@mentor.com>
	<6B3AC2788014DD49B43AF9611365BBAA21CACCA461@mary.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VTX48-0003JE-Tp
	for lttng-dev@lists.lttng.org; Tue, 08 Oct 2013 09:11:11 -0400
Received: by mail-yh0-f48.google.com with SMTP id f11so2072668yha.21
	for <lttng-dev@lists.lttng.org>; Tue, 08 Oct 2013 06:11:03 -0700 (PDT)
In-Reply-To: <6B3AC2788014DD49B43AF9611365BBAA21CACCA461@mary.at.omicron.at>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Le 2013-10-08 08:42, Michael Lausch a =E9crit :
> On Tue, 2013-10-08 at 13:25 +0200, Woegerer, Paul wrote:
>> On 10/08/2013 01:03 PM, Michael Lausch wrote:
>>> Hi,
>>>
>>> I've developed a kernel module which defines TRACE_EVENTS. These events
>>> are shown in /sys/kernel/debug/tracing/events and i can read them
>>> from /sys/kernel/debug/tracing/trace if they are enabled.
>>>
>>> But i want to use these events in lttng. =

>>> # lttng list -k =

>>> does not show them. =

>>
>> You need to add an lttng probe in lttng-modules to expose your ftrace
>> events as lttng kernel events.
> =

> I did this, but this has some maintenance problems. I'd like not to
> change or add something to the lttng-module source. I'd like to compile
> the lttng tracepoints, depending on some config variable int he same
> step as the kernel module.
> =

> If that's not possible, maintenannce of the module get's a little bit
> harder. =


I do maintain an "addons" module branch for experimental purposes. When
the utility of the tracepoints are demonstrated, then it becomes easier
to push them upstream. Your contributions are welcome.

https://github.com/giraldeau/lttng-modules

BTW, if the kernel has CONFIG_MODULE_SIG=3Dy (from Ubuntu with kernel
3.8), then it won't load tracepoints defined in modules. The addons
branch has the necessary steps to create a x509 certificate and load the
key, such that the tracepoints are visible. It doesn't seems you are
affected by this, but still good to know ;-)

Cheers,

Francis
