From: Paul Chavent <paul.chavent@fnac.net>
Subject: Re: Viewing userspace apps traces
Date: Thu, 04 Oct 2012 22:39:11 +0200
Message-ID: <506DF3EF.9070201__712.492134380405$1349388860$gmane$org@fnac.net>
References: <506B4A21.6080309@fnac.net> <506B4EA4.8050407@voxpopuli.im>
	<506BD225.3030906@fnac.net> <506D0581.3030400@polymtl.ca>
	<506D91B0.2070708@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp5-g21.free.fr ([212.27.42.5])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paul.chavent@fnac.net>) id 1TJsC8-0004I9-Sq
	for lttng-dev@lists.lttng.org; Thu, 04 Oct 2012 16:38:57 -0400
In-Reply-To: <506D91B0.2070708@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: eamcs/eedbhu <Bernd.Hufmann@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Linux Tools developer discussions <linuxtools-dev@eclipse.org>, Alexandre Montplaisir <alexandre.montplaisir@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

Hi,

I've follow this link (http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/juno/SR1/eclipse-cpp-juno-SR1-linux-gtk-x86_64.tar.gz) to download the Eclipse env.

Here is the version notes i can give you :
**************
Eclipse
Version: Juno Release
Build id: 20120614-1722

Eclipse Linux Tools LTTng ... 1.0.0.201206130106
**************

Then i've got my traces with :

lttng create
lttng enable-event -u -a
lttng add-context -u -t vpid -t vtid
lttng start
...
lttng stop
lttng destroy

Here is a sample of the traces :
http://paul.chavent.free.fr/tmp/sample_traces.tar.bz2


I can open the traces in eclipse (i see the "Events" panel), but i can't see the events ordered by pid/tid in the "Time Chart" panel, neither "Control Flow", nor "Ressources" ...)

Is it possible to have the traces displayed sorted by tid for instance ?

Thanks.

Paul.


On 10/04/2012 03:40 PM, eamcs/eedbhu wrote:
> Hi Paul
>
> The Eclipse Linux Tools release v1.1.1 (which is also included in the CDT EPP Juno SR1 release) contains an update that displays CTF context information in the events table.
> So you should be able to see the context information.
>
> Best Regards
> Bernd
>
>
> On 10/03/2012 11:41 PM, Alexandre Montplaisir wrote:
>> Sorry for the late reply, I had to update/rebase some of the stuff first...
>>
>> (Cross-posting linuxtools-dev, as it might interest some people who
>> follow that list too. This is about extending TMF to implement a
>> graphical view for a specific UST trace type.)
>>
>>
>> On 12-10-03 01:50 AM, Paul Chavent wrote:
>>> [...]
>>>
>>> On 10/02/2012 10:29 PM, Alexandre Montplaisir wrote:
>>>> [...]
>>>>
>>>> What would you like see in your "timeline representation" exactly? Maybe
>>>> we could give you some pointers as to how to implement such a view.
>>>> (We're currently working on making it easy to extend the framework to
>>>> implement new views, so this could be a good exercise!)
>>> I would like to see, eg, one line per tid, and on each line, the value
>>> of one context or argument value.
>>>
>>> I'm ready to follow an exercise for extending the framework !
>> Ok good! We don't have a nice tutorial ready yet, as most parts are
>> still working their way upstream. But if you want to dig into it and try
>> it out now, you can:
>>
>> 1 - Set up the development environment for TMF:
>> http://wiki.eclipse.org/Linux_Tools_Project/LTTng_Eclipse_Plug-in_Development_Environement_Setup
>>
>> 2 - Checkout the "lttng-kepler" branch in the git. This is where the
>> latest development happens.
>>
>> 3 - Apply those two patches, in that order:
>> https://git.eclipse.org/r/#/c/7747/
>> https://git.eclipse.org/r/#/c/7748/
>> (you can copy-paste the "cherry-pick" command shown on the page)
>>
>> 4 - Download the example program and view from:
>> git://git.dorsal.polymtl.ca/~alexmont/ust-example.git
>>
>> Now at this point you should be able to import and build the example
>> plugins (ust.example.core and ust.example.ui) and the TMF/LTTng ones in
>> the same workspace.
>>
>> You can try it to make sure it works correctly : take a UST trace of the
>> "myprog" program, and then load it into TMF, and show the "Example ->
>> Connections" view. It should display the yellow and green rectangles
>> corresponding to the states that were defined.
>>
>>
>> After that, it shouldn't be too hard (famous last words...) to rework
>> the ust.example.* code to fit your application. The points of interest
>> will be (before renames):
>>
>> MyUstTraceInput, line 85+: This is where you assign your trace events to
>> states
>> ConnectionsPresentationProvider, line 31-34: This is where you assign
>> the colors to each state in the view
>> and same file, lines 64-68 and 81-85 : This is where you assign the
>> trace's states to the ones in the view.
>> (one place is for the actual colored rectangle, the other is for the
>> tooltips, iirc).
>>
>>
>> If you have any question or problem, please let me know!
>>
>> Good luck ;)
>>
>
