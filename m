From: Bernd Hufmann <bhufmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [lttng-dev] Viewing userspace apps traces
Date: Fri, 5 Oct 2012 08:15:10 -0400
Message-ID: <CAG5-hcNmq06bR7b2n0yOziuUYQinHnUa7RaZDXhaL5c_QQOX-w@mail.gmail.com>
References: <506B4A21.6080309@fnac.net> <506B4EA4.8050407@voxpopuli.im>
	<506BD225.3030906@fnac.net> <506D0581.3030400@polymtl.ca>
	<506D91B0.2070708@ericsson.com> <506DF3EF.9070201@fnac.net>
Reply-To: Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
In-Reply-To: <506DF3EF.9070201-oNGEd6G4ga4@public.gmane.org>
List-Unsubscribe: <https://dev.eclipse.org/mailman/options/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://dev.eclipse.org/mailman/private/linuxtools-dev>
List-Post: <mailto:linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <https://dev.eclipse.org/mailman/listinfo/linuxtools-dev>,
	<mailto:linuxtools-dev-request-j9T/66MeVpFAfugRpC6u6w@public.gmane.org?subject=subscribe>
Errors-To: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
Sender: linuxtools-dev-bounces-j9T/66MeVpFAfugRpC6u6w@public.gmane.org
To: Paul Chavent <paul.chavent-oNGEd6G4ga4@public.gmane.org>
Cc: "lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org" <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, Linux Tools developer discussions <linuxtools-dev-j9T/66MeVpFAfugRpC6u6w@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

Hi Paul

I was trying your trace with the Eclipse Juno SR1 CDT EPP and you're
right the context information is not displayed in the Events Table
(I'm not talking about the Time Graph and its table).
I was verifying the commits and the commit that added the support for
displaying of context information in the Events Table is in the
release. As well as the example trace with context
information I generated and tested with works. However, it was a
Kernel trace with context information and not a UST trace.

So, that needs to be investigated on our side (Eclipse developer) why
the context information is not shown for the UST trace. We'll let you
know.

Best Regard
Bernd

On Thu, Oct 4, 2012 at 4:39 PM, Paul Chavent <paul.chavent-oNGEd6G4ga4@public.gmane.org> wrote:
> Hi,
>
> I've follow this link
> (http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/juno/SR1/eclipse-cpp-juno-SR1-linux-gtk-x86_64.tar.gz)
> to download the Eclipse env.
>
> Here is the version notes i can give you :
> **************
> Eclipse
> Version: Juno Release
> Build id: 20120614-1722
>
> Eclipse Linux Tools LTTng ... 1.0.0.201206130106
> **************
>
> Then i've got my traces with :
>
> lttng create
> lttng enable-event -u -a
> lttng add-context -u -t vpid -t vtid
> lttng start
> ...
> lttng stop
> lttng destroy
>
> Here is a sample of the traces :
> http://paul.chavent.free.fr/tmp/sample_traces.tar.bz2
>
>
> I can open the traces in eclipse (i see the "Events" panel), but i can't see
> the events ordered by pid/tid in the "Time Chart" panel, neither "Control
> Flow", nor "Ressources" ...)
>
> Is it possible to have the traces displayed sorted by tid for instance ?
>
> Thanks.
>
> Paul.
>
>
>
> On 10/04/2012 03:40 PM, eamcs/eedbhu wrote:
>>
>> Hi Paul
>>
>> The Eclipse Linux Tools release v1.1.1 (which is also included in the CDT
>> EPP Juno SR1 release) contains an update that displays CTF context
>> information in the events table.
>> So you should be able to see the context information.
>>
>> Best Regards
>> Bernd
>>
>>
>> On 10/03/2012 11:41 PM, Alexandre Montplaisir wrote:
>>>
>>> Sorry for the late reply, I had to update/rebase some of the stuff
>>> first...
>>>
>>> (Cross-posting linuxtools-dev, as it might interest some people who
>>> follow that list too. This is about extending TMF to implement a
>>> graphical view for a specific UST trace type.)
>>>
>>>
>>> On 12-10-03 01:50 AM, Paul Chavent wrote:
>>>>
>>>> [...]
>>>>
>>>> On 10/02/2012 10:29 PM, Alexandre Montplaisir wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>> What would you like see in your "timeline representation" exactly?
>>>>> Maybe
>>>>> we could give you some pointers as to how to implement such a view.
>>>>> (We're currently working on making it easy to extend the framework to
>>>>> implement new views, so this could be a good exercise!)
>>>>
>>>> I would like to see, eg, one line per tid, and on each line, the value
>>>> of one context or argument value.
>>>>
>>>> I'm ready to follow an exercise for extending the framework !
>>>
>>> Ok good! We don't have a nice tutorial ready yet, as most parts are
>>> still working their way upstream. But if you want to dig into it and try
>>> it out now, you can:
>>>
>>> 1 - Set up the development environment for TMF:
>>>
>>> http://wiki.eclipse.org/Linux_Tools_Project/LTTng_Eclipse_Plug-in_Development_Environement_Setup
>>>
>>> 2 - Checkout the "lttng-kepler" branch in the git. This is where the
>>> latest development happens.
>>>
>>> 3 - Apply those two patches, in that order:
>>> https://git.eclipse.org/r/#/c/7747/
>>> https://git.eclipse.org/r/#/c/7748/
>>> (you can copy-paste the "cherry-pick" command shown on the page)
>>>
>>> 4 - Download the example program and view from:
>>> git://git.dorsal.polymtl.ca/~alexmont/ust-example.git
>>>
>>> Now at this point you should be able to import and build the example
>>> plugins (ust.example.core and ust.example.ui) and the TMF/LTTng ones in
>>> the same workspace.
>>>
>>> You can try it to make sure it works correctly : take a UST trace of the
>>> "myprog" program, and then load it into TMF, and show the "Example ->
>>> Connections" view. It should display the yellow and green rectangles
>>> corresponding to the states that were defined.
>>>
>>>
>>> After that, it shouldn't be too hard (famous last words...) to rework
>>> the ust.example.* code to fit your application. The points of interest
>>> will be (before renames):
>>>
>>> MyUstTraceInput, line 85+: This is where you assign your trace events to
>>> states
>>> ConnectionsPresentationProvider, line 31-34: This is where you assign
>>> the colors to each state in the view
>>> and same file, lines 64-68 and 81-85 : This is where you assign the
>>> trace's states to the ones in the view.
>>> (one place is for the actual colored rectangle, the other is for the
>>> tooltips, iirc).
>>>
>>>
>>> If you have any question or problem, please let me know!
>>>
>>> Good luck ;)
>>>
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
