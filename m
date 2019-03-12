From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [tracecompass-dev] Scalability
Date: Tue, 12 Mar 2019 15:10:21 +0000
Message-ID: <DM6PR15MB310066EB15FFCE5AD1CC207D9E490__9351.96310035593$1552403488$gmane$org@DM6PR15MB3100.namprd15.prod.outlook.com>
References: <559e65b28a33c3a2d28bc5a32c3fdc4dfeacaf93.camel@blackberry.com>
 <DM6PR15MB3100B14E05117F439A6A08DE9E490@DM6PR15MB3100.namprd15.prod.outlook.com>
 <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>,
 <20190312150314.GC13925@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3219916082334219730=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sesbmg23.ericsson.net (sesbmg23.ericsson.net [193.180.251.37])
 by lists.lttng.org (Postfix) with ESMTPS id 44Jdh35QL7z15vV
 for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2019 11:10:27 -0400 (EDT)
In-Reply-To: <20190312150314.GC13925@joraj-alpa>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>, Doug
 Schaefer <dschaefer@blackberry.com>, tracecompass developer discussions <tracecompass-dev@eclipse.org>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3219916082334219730==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR15MB310066EB15FFCE5AD1CC207D9E490DM6PR15MB3100namp_"

--_000_DM6PR15MB310066EB15FFCE5AD1CC207D9E490DM6PR15MB3100namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Welcome Jonathan,


Also, for people seeking great babeltrace support, I feel I should plug the=
 lttng-dev mailinglist.


I hope the URL is not censored. https://lists.lttng.org/cgi-bin/mailman/lis=
tinfo/lttng-dev if it is, just search for "lttng-dev -- LTTng development l=
ist"

lttng-dev Info Page<https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-=
dev>
lists.lttng.org
To see the collection of prior postings to the list, visit the lttng-dev Ar=
chives.. Using lttng-dev: To post a message to all the list members, send e=
mail to lttng-dev@lists.lttng.org. You can subscribe to the list, or change=
 your existing subscription, in the sections below.



________________________________
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Sent: Tuesday, March 12, 2019 11:03:14 AM
To: Doug Schaefer; tracecompass developer discussions
Cc: Matthew Khouzam; lttng-dev
Subject: Re: [tracecompass-dev] Scalability

Hi Doug,

On Tue, Mar 12, 2019 at 02:56:26PM +0000, Doug Schaefer wrote:
> Thanks, Matthew, I ended up flushing every 100K events and that seemed OK=
.
>
> My biggest worry is on the read side. Babeltrace blew up on that file. It=
's a pretty simple trace (for now) with a single event class with 4 ints an=
d a sequence of 32-bit unsigned ints which is usually only 2 elements long.

This is not I expect. Still eithet jgalar or eep might have a more insight =
on
this. CCing the lttng-dev mailing list.

Is there any way to share us a similar trace? Either with a generator or we=
 can
provide a link for you to upload it. The current limit on bugs.lttng.org is=
 a
bit too small for such trace.

>
> Aside from that, am very pleased with the how easy CTF is to work with. L=
ooking forward to doing more.
>
> Doug.
>
> On Tue, 2019-03-12 at 14:41 +0000, Matthew Khouzam wrote:
>
> Hi Doug,
>
>
> Great to hear you're coming to a standard! I don't know if trace compass =
will scale properly as I don't know what the trace configuration is.
>
>
> > I have one of our trace which has 16 million events, the size of each e=
vent is around 32 bytes giving me a 540MB file. My first attempt at simply =
writing out the CTF events without a flush ran out of virtual memory. I the=
n flushed after every event which made each event take 32K. So I found a mi=
ddle ground and the resulting stream file is close to the same size.
>
>
>
> My suggestion is to have 1 MB packets. This makes seeking very efficient.=
 If each event is 32 bytes, basically flush every 25k events or so.
>
>
> Please keep us posted!
>
>
> Matthew.
>
> ________________________________
> From: tracecompass-dev-bounces@eclipse.org <tracecompass-dev-bounces@ecli=
pse.org> on behalf of Doug Schaefer <dschaefer@blackberry.com>
> Sent: Tuesday, March 12, 2019 10:30:15 AM
> To: tracecompass-dev@eclipse.org
> Subject: [tracecompass-dev] Scalability
>
> Hey gang,
>
> We're finally starting to look at converting our custom traces into CTF s=
o we can leverage tools like TraceCompass and, of course, contribute to it.=
 One thing I quickly ran into is a scalability issue I'm seeing with libbab=
eltrace.
>
> I have one of our trace which has 16 million events, the size of each eve=
nt is around 32 bytes giving me a 540MB file. My first attempt at simply wr=
iting out the CTF events without a flush ran out of virtual memory. I then =
flushed after every event which made each event take 32K. So I found a midd=
le ground and the resulting stream file is close to the same size.
>
> But when I use babeltrace to print it out, I ran out of virtual memory. I=
 then hand coded a reader and simply adding the trace to the context caused=
 the memory issue. It really looks like libbabeltrace (version 1.5 from the=
 Ubuntu 18.04 distro), tries to inflate the events into it's internal repre=
sentation for the entire trace. I need to do more investigation to confirm =
that.
>
> So my question for this list, would TraceCompass do better? Does it have =
it's own parsing libraries?
>
> Thanks,
> Doug

> _______________________________________________
> tracecompass-dev mailing list
> tracecompass-dev@eclipse.org
> To change your delivery options, retrieve your password, or unsubscribe f=
rom this list, visit
> https://www.eclipse.org/mailman/listinfo/tracecompass-dev


--
Jonathan Rajotte-Julien
EfficiOS

--_000_DM6PR15MB310066EB15FFCE5AD1CC207D9E490DM6PR15MB3100namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Welcome Jonathan,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Also, for people seeking great ba=
beltrace support, I feel I should plug the lttng-dev mailinglist.
<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I hope the URL is not censored. <=
a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" class=
=3D"OWAAutoLink" id=3D"LPlnk853878" previewremoved=3D"true">
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a> if it is, ju=
st search for &quot;<b><font size=3D"&#43;1" color=3D"#000000">lttng-dev --=
 LTTng development list</font></b>&quot;<br>
</p>
<div id=3D"LPBorder_GT_15524033734260.13838571933289845" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15524033734220.025667838474824234" style=3D"width:=
 90%; background-color: rgb(255, 255, 255); position: relative; overflow: a=
uto; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top:=
 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200=
);" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15524033734240.05101294807418255" style=3D"vertical-alig=
n: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"=
2">
<div id=3D"LPRemovePreviewContainer_15524033734240.45704162409583526"></div=
>
<div id=3D"LPTitle_15524033734240.768426324418359" style=3D"top: 0px; color=
: rgb(0, 75, 139); font-weight: 400; font-size: 21px; font-family: &quot;wf=
_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quo=
t;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; =
line-height: 21px;">
<a id=3D"LPUrlAnchor_15524033734240.08400261288183442" style=3D"text-decora=
tion: none;" href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev" target=3D"_blank">lttng-dev Info Page</a></div>
<div id=3D"LPMetadata_15524033734250.5254476983267053" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.lttng.org</div>
<div id=3D"LPDescription_15524033734250.43499263846109015" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma,=
 Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; =
overflow: hidden;">
To see the collection of prior postings to the list, visit the lttng-dev Ar=
chives.. Using lttng-dev: To post a message to all the list members, send e=
mail to lttng-dev@lists.lttng.org. You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<p></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jonathan Rajotte-Juli=
en &lt;jonathan.rajotte-julien@efficios.com&gt;<br>
<b>Sent:</b> Tuesday, March 12, 2019 11:03:14 AM<br>
<b>To:</b> Doug Schaefer; tracecompass developer discussions<br>
<b>Cc:</b> Matthew Khouzam; lttng-dev<br>
<b>Subject:</b> Re: [tracecompass-dev] Scalability</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Doug,<br>
<br>
On Tue, Mar 12, 2019 at 02:56:26PM &#43;0000, Doug Schaefer wrote:<br>
&gt; Thanks, Matthew, I ended up flushing every 100K events and that seemed=
 OK.<br>
&gt; <br>
&gt; My biggest worry is on the read side. Babeltrace blew up on that file.=
 It's a pretty simple trace (for now) with a single event class with 4 ints=
 and a sequence of 32-bit unsigned ints which is usually only 2 elements lo=
ng.<br>
<br>
This is not I expect. Still eithet jgalar or eep might have a more insight =
on<br>
this. CCing the lttng-dev mailing list.<br>
<br>
Is there any way to share us a similar trace? Either with a generator or we=
 can<br>
provide a link for you to upload it. The current limit on bugs.lttng.org is=
 a<br>
bit too small for such trace.<br>
<br>
&gt; <br>
&gt; Aside from that, am very pleased with the how easy CTF is to work with=
. Looking forward to doing more.<br>
&gt; <br>
&gt; Doug.<br>
&gt; <br>
&gt; On Tue, 2019-03-12 at 14:41 &#43;0000, Matthew Khouzam wrote:<br>
&gt; <br>
&gt; Hi Doug,<br>
&gt; <br>
&gt; <br>
&gt; Great to hear you're coming to a standard! I don't know if trace compa=
ss will scale properly as I don't know what the trace configuration is.<br>
&gt; <br>
&gt; <br>
&gt; &gt; I have one of our trace which has 16 million events, the size of =
each event is around 32 bytes giving me a 540MB file. My first attempt at s=
imply writing out the CTF events without a flush ran out of virtual memory.=
 I then flushed after every event which
 made each event take 32K. So I found a middle ground and the resulting str=
eam file is close to the same size.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; My suggestion is to have 1 MB packets. This makes seeking very efficie=
nt. If each event is 32 bytes, basically flush every 25k events or so.<br>
&gt; <br>
&gt; <br>
&gt; Please keep us posted!<br>
&gt; <br>
&gt; <br>
&gt; Matthew.<br>
&gt; <br>
&gt; ________________________________<br>
&gt; From: tracecompass-dev-bounces@eclipse.org &lt;tracecompass-dev-bounce=
s@eclipse.org&gt; on behalf of Doug Schaefer &lt;dschaefer@blackberry.com&g=
t;<br>
&gt; Sent: Tuesday, March 12, 2019 10:30:15 AM<br>
&gt; To: tracecompass-dev@eclipse.org<br>
&gt; Subject: [tracecompass-dev] Scalability<br>
&gt; <br>
&gt; Hey gang,<br>
&gt; <br>
&gt; We're finally starting to look at converting our custom traces into CT=
F so we can leverage tools like TraceCompass and, of course, contribute to =
it. One thing I quickly ran into is a scalability issue I'm seeing with lib=
babeltrace.<br>
&gt; <br>
&gt; I have one of our trace which has 16 million events, the size of each =
event is around 32 bytes giving me a 540MB file. My first attempt at simply=
 writing out the CTF events without a flush ran out of virtual memory. I th=
en flushed after every event which
 made each event take 32K. So I found a middle ground and the resulting str=
eam file is close to the same size.<br>
&gt; <br>
&gt; But when I use babeltrace to print it out, I ran out of virtual memory=
. I then hand coded a reader and simply adding the trace to the context cau=
sed the memory issue. It really looks like libbabeltrace (version 1.5 from =
the Ubuntu 18.04 distro), tries to
 inflate the events into it's internal representation for the entire trace.=
 I need to do more investigation to confirm that.<br>
&gt; <br>
&gt; So my question for this list, would TraceCompass do better? Does it ha=
ve it's own parsing libraries?<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Doug<br>
<br>
&gt; _______________________________________________<br>
&gt; tracecompass-dev mailing list<br>
&gt; tracecompass-dev@eclipse.org<br>
&gt; To change your delivery options, retrieve your password, or unsubscrib=
e from this list, visit<br>
&gt; <a href=3D"https://www.eclipse.org/mailman/listinfo/tracecompass-dev">=
https://www.eclipse.org/mailman/listinfo/tracecompass-dev</a><br>
<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR15MB310066EB15FFCE5AD1CC207D9E490DM6PR15MB3100namp_--

--===============3219916082334219730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3219916082334219730==--
