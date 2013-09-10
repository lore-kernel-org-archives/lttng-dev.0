From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Getting function names with	lttng-ust-cyg-profile.so
Date: Tue, 10 Sep 2013 11:26:12 -0400
Message-ID: <522F3A14.7050406__31043.7990505763$1378826842$gmane$org@ericsson.com>
References: <522E4FCE.7070000@voxpopuli.im> <20130909234409.GA11082@Krystal>
	<522F379A.9010308@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1VJPpe-00017s-Em
	for lttng-dev@lists.lttng.org; Tue, 10 Sep 2013 11:26:28 -0400
In-Reply-To: <522F379A.9010308@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Alex brought up an excellent point,
these locations should be events since there can be address collisions.

A default event for location with a payload of address and name would be
sufficient I think. DlOpen will create many events then.


On 13-09-10 11:15 AM, Matthew Khouzam wrote:
> Hi Alex and Mathieu,
>
> A year ago we discussed this and said iirc: "the addresses are a good
> first step, we'll do more later." and "It would be nice to dump the
> stabs into the metadata of the ctf trace"
>
> I would still maintain that this seems to be the way to go.
>
> A technical hurdle that is probably trivial to our high level tracing
> vanguards would be to handle dlopens and libs that replace other libs.
>
> I would suggest something like this in TSDL:
>
> location {
>     address = 0xdeadbeef;
>     name = "get_actual_lost_events";
> }
>
> location {
>     address = 0xf00ff00f;
>     name = "get_pretend_lost_events";
>     // optional
>     timestart = 123456;
>     timeend = 123457;
> }
>
>
> The metadata will get big and dynamic though.
>
> On 13-09-09 07:44 PM, Mathieu Desnoyers wrote:
>> We might want to investigate doing a side-program that gathers the
>> executables on the system, and lookup the symbols from the ELF. We could
>> save those in a bin/ subdirectory of a CTF trace. All we need is
>> instrumentation of the dynamic linker, and to know the executable names
>> associated with PIDs. There is a UST feature request for dynamic linker
>> instrumentation.
>>
>> Thanks,
>>
>> Mathieu
>>
>> * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
>>> Hi all,
>>>
>>> I've recently started playing with liblttng-ust-cyg-profile.so (aka,
>>> getting UST events from -finstrument-functions), and I have to say it's
>>> pretty nifty! I haven't done any benchmarks, but it's certainly faster
>>> than the typical printf() that people use with it...
>>>
>>> However, in the resulting trace, one only gets the addresses of the
>>> functions. I understand how it's relatively "easy" for the seasoned user
>>> to use nm or addr2line to get the actual function names, but would it
>>> possible - and how hard would it be - to have this information (function
>>> names) directly in the trace?
>>>
>>>
>>> I'm trying to leverage this feature in Eclipse TMF to display a call
>>> stack for such UST traces. And to be honest, displaying a call stack
>>> with only the function addresses is completely useless, we need the
>>> function names.
>>>
>>> We could have the user import a text file (which he can generate with
>>> "nm appname > file.txt" for example). But then he needs the original
>>> binary, which he might not have. And that binary needs to be compiled
>>> with debugging symbols. If the function name information was already in
>>> the trace, it would make the user experience much better, and our job
>>> much easier! ;)
>>>
>>>
>>> Thoughts?
>>>
>>> Thanks,
>>> Alex
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
