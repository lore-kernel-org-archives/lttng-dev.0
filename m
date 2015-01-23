From: =?windows-1252?Q?Genevi=E8ve_Bastien?= <gbastien@versatic.net>
Subject: Re: [diamon-discuss] My experience on perf,
 CTF and TraceCompass, and some suggection.
Date: Fri, 23 Jan 2015 11:56:04 -0500
Message-ID: <54C27D24.8030100__25761.1952060417$1422032297$gmane$org@versatic.net>
References: <54C215D6.1030804@huawei.com> <54C2770F.4080305@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailout.easydns.com ([64.68.201.141])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <gbastien@versatic.net>) id 1YEhWg-0008GK-55
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 11:56:07 -0500
In-Reply-To: <54C2770F.4080305@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wang Nan <wangnan0@huawei.com>
Cc: "diamon-discuss@lists.linuxfoundation.org" <diamon-discuss@lists.linuxfoundation.org>, lttng-dev@lists.lttng.org, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

Hi Wang,

Thanks for sharing your experience. It's always useful to have some real =

live use case of using the tools.

Alex already made a quite complete answer.

I'll just add some information about your wish for Ad-Hoc visualization =

and statistics. As Alex said, data driven analysis, using XML files is =

already present in Trace Compass. Documentation on how to use it is =

available here: =

https://wiki.eclipse.org/Linux_Tools_Project/LTTng2/User_Guide#Data_driven_=
analysis

You can build your own analysis with any event type. The current support =

is rather basic, you need to write the XML by yourself, starting from a =

template and it supports only XY charts and time graph views. Current =

work by students at Polytechnique in the data-driven analysis involves =

defining data-driven custom filters for events and views, developing a =

visual UI to build an analysis from a state diagram, supporting more use =

cases of analysis from the event data. I'm cc'ing Naser Ezzati, who's =

working currently on the XML analysis. He's been working among other =

things on custom statistics, I don't know what's the status of this =

development, but he may point you to his development branch, if it's =

ready, so you can see if it fits your current need.

If you want some more details on the data-driven analysis work being =

done at Poly right now, you can look at the presentations by Naser =

Ezzati, Jean-Christian Kouam=E9 and Simon Delisle on this page: =

https://ahls.dorsal.polymtl.ca/dec2014. If you're interested in trying =

out their [still experimental] work, let us know and we'll see if there =

is an experimental working branch you could try.

Cheers,
Genevi=E8ve



On 01/23/2015 11:30 AM, Alexandre Montplaisir wrote:
> Hi Wang,
>
> First of all, thank you very much for posting this use case. This is =

> exactly the type of user feedback that will help make the toolchain =

> better and more useful for users!
>
> Some comments and questions below,
>
>
> On 01/23/2015 04:35 AM, Wang Nan wrote:
>> [...]
>>
>> Then I need to convert perf.data to ctf. It tooks 140.57s to convert
>> 2598513 samples, which are collected during only 1 second execution. My
>> working server has 64 2.0GHz Intel Xeon cores, but perf conversion
>> utilizes only 1 of them. I think this is another thing can be improved.
>
> Out of curiosity, approximately how big (in bytes) is the generated =

> CTF trace directory?
>
>>
>> The next step is visualization. Output ctf trace can be opened with
>> TraceCompass without problem. The most important views for me should be
>> resources view (I use them to check CPU usage) and control flow view (I
>> use them to check thread activities).
>>
>> The first uncomfortable thing is TraceCompass' slow response time. For
>> the trace I mentioned above, on resource view, after I click on CPU
>> idle area, I have to wait more than 10 seconds for event list updating
>> to get the previous event before the idle area.
>
> Interesting. It is expected that opening a very large trace would take =

> a long time to load the first time, as everything gets indexed. But =

> once that step is done, seeking within the trace should be relatively =

> quick ((log n) wrt to the trace size). In theory ;)
>
> The perf-to-CTF conversion brings a completely new type of CTF traces =

> that was not seen before. It is possible that the CTF parser in Trace =

> Compass has some inefficiencies that were not exposed by other trace =

> types. Are you able to share that trace publicly? Or a trace taken in =

> the same environment, with no sensible information in it? It could be =

> very helpful in finding such problem.
>
>> Then I found through resources view that perf itself tooks lots of CPU
>> time. In my case 33.5% samples are generated by perf itself. One core is
>> dedicated to perf and never idle or taken by others. I think this should
>> be another thing needs to be improved: perf should give a way to
>> blacklist itself when tracing all CPUs.
>
> I don't want to start a tracer-war here :) but have you investigated =

> using LTTng for recording syscall/sched events ? Compared to perf, =

> LTTng is only about "getting trace events", and is a bit more involved =

> to set up, but it is more focused on performance and minimizing the =

> impact on the traced applications. And it outputs in CTF format too.
>
> I remember when testing the perf-CTF patches, comparing a perf trace =

> to an LTTng one, perf would be doing system calls continuously on one =

> of the CPUs for the whole duration of the trace. Whereas in LTTng =

> traces, the session daemon would be a bit active at the beginning and =

> at then end, but otherwise completely invisible from the trace.
>
>> TraceCompass doesn't recognize syscall:* tracepoints as CPU status
>> changing point. I have to also catch raw_syscall:*, and which doubles
>> the number of samples.
>
> This is a gap in the definition of the analysis it seems. I don't =

> remember implementing two types of "syscall" events in the perf =

> analysis, so it should just be a matter of getting the exact event =

> name and adding it to the list. I will take a look and keep you posted!
>
>> Finally I found the syscall which cause idle. However I need to write a
>> script to do statistics. TraceCompass itself is lack a mean to count
>> different events in my way.
>
> Could you elaborate on this please? I agree the "Statistics" view in =

> TC is severely lacking, we could be gathering and displaying much more =

> information. The only question is what information would actually be =

> useful.
>
> What exactly would you have liked to be able to see in the tool?
>
>> [...]
>>
>>
>>   5. Ad-Hoc visualization and statistics. Currently TraceCompass only
>>      support dwaring pre-defined events and processes. When I try to
>>      capture syscalls:*, I won't get benefit from TraceCompass =

>> because it
>>      doesn't know them. I believe that during system tuning we will
>>      finally get somewhere unable to be pre-defined by TraceCompass
>>      designer. Therefore give users abilities to define their own events
>>      and model should be much helpful.
>
> As I mentioned earlier, the pre-defined "perf analysis" in Trace =

> Compass should be fixed to handle the syscall events.
>
>
> But it's interesting that you mention wanting to add your own events =

> and model. I completely agree with you, we will never be able to =

> predict every and all use cases the users will want to use the tool =

> for, so there should be a way for the user to add their own.
>
> Well good news, it *is* possible for the user to define their own =

> analysis and views! This is still undergoing a lot of development, and =

> there is no nice UI yet, which is why it is not really advertized. But =

> starting from any supported trace type, a user today can define a time =

> graph view (like the Resource View for example) or a XY chart, using a =

> data-driven XML syntax.
>
> If you are curious, you can take a look at a full example of doing =

> such a thing on this page:
> https://github.com/alexmonthy/ust-tc-example
> (the example uses an LTTng UST trace as a source, but it could work =

> with any supported trace type, even a custom text trace defined in the =

> UI).
>
>>
>> Thank you.
>
> Thanks again for taking the time to write about your experience!
>
> Cheers,
> Alexandre
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
