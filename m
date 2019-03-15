From: =?UTF-8?Q?Genevi=c3=a8ve_Bastien?= <gbastien@versatic.net>
Subject: Re: [tracecompass-dev] Scalability
Date: Fri, 15 Mar 2019 09:40:53 -0400
Message-ID: <dfd2c677-b134-8675-e5a7-5307ac4b5ca9__34699.5209971041$1552660777$gmane$org@versatic.net>
References: <559e65b28a33c3a2d28bc5a32c3fdc4dfeacaf93.camel@blackberry.com>
 <DM6PR15MB3100B14E05117F439A6A08DE9E490@DM6PR15MB3100.namprd15.prod.outlook.com>
 <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>
 <20190312150314.GC13925@joraj-alpa>
 <484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1651298915143808997=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from s056.panelboxmanager.com (s056.panelboxmanager.com
 [174.142.230.146])
 by lists.lttng.org (Postfix) with ESMTPS id 44LSrl4Drxz16GP
 for <lttng-dev@lists.lttng.org>; Fri, 15 Mar 2019 10:39:19 -0400 (EDT)
Received: from mailnull by s056.panelboxmanager.com with sa-checked (Exim 4.91)
 (envelope-from <gbastien@versatic.net>) id 1h4n4w-009OZP-8W
 for lttng-dev@lists.lttng.org; Fri, 15 Mar 2019 09:40:54 -0400
In-Reply-To: <484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com>
Content-Language: en-US-large
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Doug Schaefer <dschaefer@blackberry.com>, tracecompass developer discussions <tracecompass-dev@eclipse.org>, "jonathan.rajotte-julien@efficios.com" <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1651298915143808997==
Content-Type: multipart/alternative;
 boundary="------------411D8559A835C6850182A9B5"
Content-Language: en-US-large

This is a multi-part message in MIME format.
--------------411D8559A835C6850182A9B5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Doug,

Welcome to the CTF ecosystem!

FYI, one thing I am working now on TraceCompass is to add support for scripting using the Eclipse EASE framework.

In short, one could use python, javascript, ruby or groovy to interact with POJOs. We'll provide a simple API to get the trace events (the parsers are already available in TraceCompass, so all supported trace types will work), fill backend (state systems, segment stores) and create time graph / XY views.

In a few weeks, I should be able to share a prototype for the community to try. I hope you can benefit from it.

Regards,

Geneviève


On 2019-03-12 11:23 a.m., Doug Schaefer wrote:
> It should be easy to generate a random one with the class I mentioned below and fill it with 16 million events. BTW, two of the int fields are 5 and 10 bits respectively, but I'm not sure that matters (or at least it shouldn't).
>
> I'll also take a look at the babeltrace code and see what I can see.
>
> BTW, my focus on libbabeltrace is to allow for a full range of tooling for our users using the language of their choice. The python binding is particularly interesting. As we move forward into the new world of IDEs, I can see a node.js binding being interesting as well. And it may even make sense to use it in Java tooling like TraceCompass using JNA. That's the vision at least, but first, baby steps ☺.
>
> Doug.
>
> On Tue, 2019-03-12 at 11:03 -0400, Jonathan Rajotte-Julien wrote:
>> Hi Doug,
>> On Tue, Mar 12, 2019 at 02:56:26PM +0000, Doug Schaefer wrote:
>> Thanks, Matthew, I ended up flushing every 100K events and that seemed OK.
>> My biggest worry is on the read side. Babeltrace blew up on that file. It's a pretty simple trace (for now) with a single event class with 4 ints and a sequence of 32-bit unsigned ints which is usually only 2 elements long.
>> This is not I expect. Still eithet jgalar or eep might have a more insight on
>> this. CCing the lttng-dev mailing list.
>> Is there any way to share us a similar trace? Either with a generator or we can
>> provide a link for you to upload it. The current limit on bugs.lttng.org is a
>> bit too small for such trace.
>> Aside from that, am very pleased with the how easy CTF is to work with. Looking forward to doing more.
>> Doug.
>> On Tue, 2019-03-12 at 14:41 +0000, Matthew Khouzam wrote:
>> Hi Doug,
>> Great to hear you're coming to a standard! I don't know if trace compass will scale properly as I don't know what the trace configuration is.
>> I have one of our trace which has 16 million events, the size of each event is around 32 bytes giving me a 540MB file. My first attempt at simply writing out the CTF events without a flush ran out of virtual memory. I then flushed after every event which made each event take 32K. So I found a middle ground and the resulting stream file is close to the same size.
>> My suggestion is to have 1 MB packets. This makes seeking very efficient. If each event is 32 bytes, basically flush every 25k events or so.
>> Please keep us posted!
>> Matthew.
>> ________________________________
>> From: tracecompass-dev-bounces@eclipse.org <mailto:tracecompass-dev-bounces@eclipse.org> <tracecompass-dev-bounces@eclipse.org <mailto:tracecompass-dev-bounces@eclipse.org>> on behalf of Doug Schaefer <dschaefer@blackberry.com <mailto:dschaefer@blackberry.com>>
>> Sent: Tuesday, March 12, 2019 10:30:15 AM
>> To: tracecompass-dev@eclipse.org <mailto:tracecompass-dev@eclipse.org>
>> Subject: [tracecompass-dev] Scalability
>> Hey gang,
>> We're finally starting to look at converting our custom traces into CTF so we can leverage tools like TraceCompass and, of course, contribute to it. One thing I quickly ran into is a scalability issue I'm seeing with libbabeltrace.
>> I have one of our trace which has 16 million events, the size of each event is around 32 bytes giving me a 540MB file. My first attempt at simply writing out the CTF events without a flush ran out of virtual memory. I then flushed after every event which made each event take 32K. So I found a middle ground and the resulting stream file is close to the same size.
>> But when I use babeltrace to print it out, I ran out of virtual memory. I then hand coded a reader and simply adding the trace to the context caused the memory issue. It really looks like libbabeltrace (version 1.5 from the Ubuntu 18.04 distro), tries to inflate the events into it's internal representation for the entire trace. I need to do more investigation to confirm that.
>> So my question for this list, would TraceCompass do better? Does it have it's own parsing libraries?
>> Thanks,
>> Doug
>> _______________________________________________
>> tracecompass-dev mailing list
>> tracecompass-dev@eclipse.org <mailto:tracecompass-dev@eclipse.org>
>> To change your delivery options, retrieve your password, or unsubscribe from this list, visit
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.eclipse.org_mailman_listinfo_tracecompass-2Ddev&d=DwIBAg&c=yzoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp26wE&r=NrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&m=ZoCx61VE_sHGa6j3DXehbqjX5P1NGEuDtEFaGORCh9k&s=qi9q1zvDaC9cJCci0y123O-j66M643YwxRJccJCzg_c&e=
>
> _______________________________________________
> tracecompass-dev mailing list
> tracecompass-dev@eclipse.org
> To change your delivery options, retrieve your password, or unsubscribe from this list, visit
> https://www.eclipse.org/mailman/listinfo/tracecompass-dev

--------------411D8559A835C6850182A9B5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Doug,</p>
    <p>Welcome to the CTF ecosystem! <br>
    </p>
    <p>FYI, one thing I am working now on TraceCompass is to add support
      for scripting using the Eclipse EASE framework. <br>
    </p>
    <p>In short, one could use python, javascript, ruby or groovy to
      interact with POJOs. We'll provide a simple API to get the trace
      events (the parsers are already available in TraceCompass, so all
      supported trace types will work), fill backend (state systems,
      segment stores) and create time graph / XY views.</p>
    <p>In a few weeks, I should be able to share a prototype for the
      community to try. I hope you can benefit from it.</p>
    <p>Regards,</p>
    <p>Geneviève<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2019-03-12 11:23 a.m., Doug Schaefer
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div>It should be easy to generate a random one with the class I
        mentioned below and fill it with 16 million events. BTW, two of
        the int fields are 5 and 10 bits respectively, but I'm not sure
        that matters (or at least it shouldn't).</div>
      <div><br>
      </div>
      <div>I'll also take a look at the babeltrace code and see what I
        can see.</div>
      <div><br>
      </div>
      <div>BTW, my focus on libbabeltrace is to allow for a full range
        of tooling for our users using the language of their choice. The
        python binding is particularly interesting. As we move forward
        into the new world of IDEs, I can see a node.js binding being
        interesting as well. And it may even make sense to use it in
        Java tooling like TraceCompass using JNA. That's the vision at
        least, but first, baby steps ☺.</div>
      <div><br>
      </div>
      <div>Doug.</div>
      <div><br>
      </div>
      <div>On Tue, 2019-03-12 at 11:03 -0400, Jonathan Rajotte-Julien
        wrote:</div>
      <blockquote type="cite" style="margin:0 0 0 .8ex; border-left:2px
        #729fcf solid;padding-left:1ex">
        <pre>Hi Doug,</pre>
        <pre>
</pre>
        <pre>On Tue, Mar 12, 2019 at 02:56:26PM +0000, Doug Schaefer wrote:</pre>
        <pre>Thanks, Matthew, I ended up flushing every 100K events and that seemed OK.</pre>
        <pre>
</pre>
        <pre>My biggest worry is on the read side. Babeltrace blew up on that file. It's a pretty simple trace (for now) with a single event class with 4 ints and a sequence of 32-bit unsigned ints which is usually only 2 elements long.</pre>
        <pre>
</pre>
        <pre>This is not I expect. Still eithet jgalar or eep might have a more insight on</pre>
        <pre>this. CCing the lttng-dev mailing list.</pre>
        <pre>
</pre>
        <pre>Is there any way to share us a similar trace? Either with a generator or we can</pre>
        <pre>provide a link for you to upload it. The current limit on bugs.lttng.org is a</pre>
        <pre>bit too small for such trace.</pre>
        <pre>
</pre>
        <pre>
</pre>
        <pre>Aside from that, am very pleased with the how easy CTF is to work with. Looking forward to doing more.</pre>
        <pre>
</pre>
        <pre>Doug.</pre>
        <pre>
</pre>
        <pre>On Tue, 2019-03-12 at 14:41 +0000, Matthew Khouzam wrote:</pre>
        <pre>
</pre>
        <pre>Hi Doug,</pre>
        <pre>
</pre>
        <pre>
</pre>
        <pre>Great to hear you're coming to a standard! I don't know if trace compass will scale properly as I don't know what the trace configuration is.</pre>
        <pre>
</pre>
        <pre>
</pre>
        <pre>I have one of our trace which has 16 million events, the size of each event is around 32 bytes giving me a 540MB file. My first attempt at simply writing out the CTF events without a flush ran out of virtual memory. I then flushed after every event which made each event take 32K. So I found a middle ground and the resulting stream file is close to the same size.</pre>
        <pre>
</pre>
        <pre>
</pre>
        <pre>
</pre>
        <pre>My suggestion is to have 1 MB packets. This makes seeking very efficient. If each event is 32 bytes, basically flush every 25k events or so.</pre>
        <pre>
</pre>
        <pre>
</pre>
        <pre>Please keep us posted!</pre>
        <pre>
</pre>
        <pre>
</pre>
        <pre>Matthew.</pre>
        <pre>
</pre>
        <pre>________________________________</pre>
        <pre>From: <a href="mailto:tracecompass-dev-bounces@eclipse.org" moz-do-not-send="true">tracecompass-dev-bounces@eclipse.org</a> &lt;<a href="mailto:tracecompass-dev-bounces@eclipse.org" moz-do-not-send="true">tracecompass-dev-bounces@eclipse.org</a>&gt; on behalf of Doug Schaefer &lt;<a href="mailto:dschaefer@blackberry.com" moz-do-not-send="true">dschaefer@blackberry.com</a>&gt;</pre>
        <pre>Sent: Tuesday, March 12, 2019 10:30:15 AM</pre>
        <pre>To: <a href="mailto:tracecompass-dev@eclipse.org" moz-do-not-send="true">tracecompass-dev@eclipse.org</a></pre>
        <pre>Subject: [tracecompass-dev] Scalability</pre>
        <pre>
</pre>
        <pre>Hey gang,</pre>
        <pre>
</pre>
        <pre>We're finally starting to look at converting our custom traces into CTF so we can leverage tools like TraceCompass and, of course, contribute to it. One thing I quickly ran into is a scalability issue I'm seeing with libbabeltrace.</pre>
        <pre>
</pre>
        <pre>I have one of our trace which has 16 million events, the size of each event is around 32 bytes giving me a 540MB file. My first attempt at simply writing out the CTF events without a flush ran out of virtual memory. I then flushed after every event which made each event take 32K. So I found a middle ground and the resulting stream file is close to the same size.</pre>
        <pre>
</pre>
        <pre>But when I use babeltrace to print it out, I ran out of virtual memory. I then hand coded a reader and simply adding the trace to the context caused the memory issue. It really looks like libbabeltrace (version 1.5 from the Ubuntu 18.04 distro), tries to inflate the events into it's internal representation for the entire trace. I need to do more investigation to confirm that.</pre>
        <pre>
</pre>
        <pre>So my question for this list, would TraceCompass do better? Does it have it's own parsing libraries?</pre>
        <pre>
</pre>
        <pre>Thanks,</pre>
        <pre>Doug</pre>
        <pre>
</pre>
        <pre>_______________________________________________</pre>
        <pre>tracecompass-dev mailing list</pre>
        <pre><a href="mailto:tracecompass-dev@eclipse.org" moz-do-not-send="true">tracecompass-dev@eclipse.org</a></pre>
        <pre>To change your delivery options, retrieve your password, or unsubscribe from this list, visit</pre>
        <pre><a href="https://urldefense.proofpoint.com/v2/url?u=https-3A__www.eclipse.org_mailman_listinfo_tracecompass-2Ddev&amp;d=DwIBAg&amp;c=yzoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp26wE&amp;r=NrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&amp;m=ZoCx61VE_sHGa6j3DXehbqjX5P1NGEuDtEFaGORCh9k&amp;s=qi9q1zvDaC9cJCci0y123O-j66M643YwxRJccJCzg_c&amp;e=" moz-do-not-send="true">https://urldefense.proofpoint.com/v2/url?u=https-3A__www.eclipse.org_mailman_listinfo_tracecompass-2Ddev&amp;d=DwIBAg&amp;c=yzoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp26wE&amp;r=NrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&amp;m=ZoCx61VE_sHGa6j3DXehbqjX5P1NGEuDtEFaGORCh9k&amp;s=qi9q1zvDaC9cJCci0y123O-j66M643YwxRJccJCzg_c&amp;e=</a></pre>
        <pre>
</pre>
        <pre>
</pre>
        <pre>
</pre>
      </blockquote>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
tracecompass-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:tracecompass-dev@eclipse.org">tracecompass-dev@eclipse.org</a>
To change your delivery options, retrieve your password, or unsubscribe from this list, visit
<a class="moz-txt-link-freetext" href="https://www.eclipse.org/mailman/listinfo/tracecompass-dev">https://www.eclipse.org/mailman/listinfo/tracecompass-dev</a>
</pre>
    </blockquote>
  </body>
</html>

--------------411D8559A835C6850182A9B5--

--===============1651298915143808997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1651298915143808997==--
