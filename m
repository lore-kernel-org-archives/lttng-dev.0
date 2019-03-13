From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: [tracecompass-dev]   Scalability
Date: Wed, 13 Mar 2019 12:12:55 +0000
Message-ID: <DM6PR15MB3100CFE23B0E9C736E903D759E4A0__43363.4167931572$1552479210$gmane$org@DM6PR15MB3100.namprd15.prod.outlook.com>
References: <559e65b28a33c3a2d28bc5a32c3fdc4dfeacaf93.camel@blackberry.com>
 <DM6PR15MB3100B14E05117F439A6A08DE9E490@DM6PR15MB3100.namprd15.prod.outlook.com>
 <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>
 <20190312150314.GC13925@joraj-alpa>
 <484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com>
 <20190312153437.GA25992@joraj-alpa>
 <c2ef7a391ab1a7305d71fd0165729d130bc94f5c.camel@blackberry.com>,
 <8adc08653d0246ce8b545a7c1374d8b9eb7aa6a3.camel@blackberry.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3389052207075083051=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sesbmg23.ericsson.net (sesbmg23.ericsson.net [193.180.251.37])
 by lists.lttng.org (Postfix) with ESMTPS id 44K9hy3TXHz174J
 for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2019 08:13:06 -0400 (EDT)
In-Reply-To: <8adc08653d0246ce8b545a7c1374d8b9eb7aa6a3.camel@blackberry.com>
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
To: "jonathan.rajotte-julien@efficios.com" <jonathan.rajotte-julien@efficios.com>, Doug Schaefer <dschaefer@blackberry.com>, tracecompass developer discussions <tracecompass-dev@eclipse.org>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3389052207075083051==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR15MB3100CFE23B0E9C736E903D759E4A0DM6PR15MB3100namp_"

--_000_DM6PR15MB3100CFE23B0E9C736E903D759E4A0DM6PR15MB3100namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Doug & Efficios,


I suspect the issue is with libbabeltrace-ctf. When opening the trace in Tr=
ace Compass, it failed saying the sequence was 2gb big. When opening in bab=
eltrace, it OOMed with 2gb allocations. When opening with a hex editor, I s=
aw 2gb allocations.


On another subject, fixing the trace made it scale well in both babeltrace =
and Trace Compass.


I don't know why, data_length writes the wrong data. Hope this helps all pa=
rties.


BR,

Matthew

________________________________
From: tracecompass-dev-bounces@eclipse.org <tracecompass-dev-bounces@eclips=
e.org> on behalf of Doug Schaefer <dschaefer@blackberry.com>
Sent: Tuesday, March 12, 2019 2:50:29 PM
To: jonathan.rajotte-julien@efficios.com
Cc: lttng-dev@lists.lttng.org; tracecompass-dev@eclipse.org
Subject: Re: [tracecompass-dev] [lttng-dev] Scalability

I have attached the C file for a generator that creates a trace that reprod=
uces the memory issue with babeltrace. The same issue happens with a custom=
 program in the call to add a trace to a context.

I am using babeltrace that I get from my Ubuntu 18.04 distro. It has the ve=
rsion number 1.5.5.

Thanks for the help!

On Tue, 2019-03-12 at 15:47 +0000, Doug Schaefer wrote:
In the thread on the tracecompass list, I also mentioned that the babeltrac=
e utility itself ran out of memory when reading the file. That's actually m=
y biggest worry. I got around the generator issue by flushing every 100K ev=
ents.

I'll create a quick generator that shows the same issue and post it in a bi=
t.

Doug.

On Tue, 2019-03-12 at 11:34 -0400, Jonathan Rajotte-Julien wrote:

On Tue, Mar 12, 2019 at 03:23:23PM +0000, Doug Schaefer wrote:

It should be easy to generate a random one with the class I mentioned below

and fill it with 16 million events.


Not if the problem is in the generator code ;).


BTW, two of the int fields are 5 and 10

bits respectively, but I'm not sure that matters (or at least it shouldn't)=
.


Make sure to check the endian-ness of those fields.


What class? Not sure I see any reference to any.


Since you are generating CTF the error can be in the generator code. Please

provide either a trace reproducing the issue or a base reproducer. It will =
be

much easier overall than us trying to reproduce it blindly.


Cheers.


_______________________________________________

lttng-dev mailing list

lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>

https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org_cgi-=
2Dbin_mailman_listinfo_lttng-2Ddev&d=3DDwICAg&c=3DyzoHOc_ZK-sxl-kfGNSEvlJYa=
nssXN3q-lhj0sp26wE&r=3DNrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&m=3DDWwl=
Ffl5FD5R8-HPY3GfbG6l6m7y_o2gXPER8IkQstk&s=3DbPK6X3vufUtEAemGpslNIlIL4UslBsg=
K-SWnraL-e9g&e=3D


---------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_DM6PR15MB3100CFE23B0E9C736E903D759E4A0DM6PR15MB3100namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Doug &amp; Efficios,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I suspect the issue is with libba=
beltrace-ctf. When opening the trace in Trace Compass, it failed saying the=
 sequence was 2gb big. When opening in babeltrace, it OOMed with 2gb alloca=
tions. When opening with a hex editor,
 I saw 2gb allocations.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">On another subject, fixing the tr=
ace made it scale well in both babeltrace and Trace Compass.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I don't know why, data_length wri=
tes the wrong data. Hope this helps all parties.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">BR,</p>
<p style=3D"margin-top:0;margin-bottom:0">Matthew<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> tracecompass-dev-boun=
ces@eclipse.org &lt;tracecompass-dev-bounces@eclipse.org&gt; on behalf of D=
oug Schaefer &lt;dschaefer@blackberry.com&gt;<br>
<b>Sent:</b> Tuesday, March 12, 2019 2:50:29 PM<br>
<b>To:</b> jonathan.rajotte-julien@efficios.com<br>
<b>Cc:</b> lttng-dev@lists.lttng.org; tracecompass-dev@eclipse.org<br>
<b>Subject:</b> Re: [tracecompass-dev] [lttng-dev] Scalability</font>
<div>&nbsp;</div>
</div>
<div style=3D"text-align:left; direction:ltr">
<div>
<div>I have attached the C file for a generator that creates a trace that r=
eproduces the memory issue with babeltrace. The same issue happens with a c=
ustom program in the call to add a trace to a context.</div>
<div><br>
</div>
<div>I am using babeltrace that I get from my Ubuntu 18.04 distro. It has t=
he version number 1.5.5.</div>
<div><br>
</div>
<div>Thanks for the help!</div>
<div><br>
</div>
</div>
<div>On Tue, 2019-03-12 at 15:47 &#43;0000, Doug Schaefer wrote:</div>
<blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729f=
cf solid; padding-left:1ex">
<div>In the thread on the tracecompass list, I also mentioned that the babe=
ltrace utility itself ran out of memory when reading the file. That's actua=
lly my biggest worry. I got around the generator issue by flushing every 10=
0K events.</div>
<div><br>
</div>
<div>I'll create a quick generator that shows the same issue and post it in=
 a bit.</div>
<div><br>
</div>
<div>Doug.</div>
<div><br>
</div>
<div>On Tue, 2019-03-12 at 11:34 -0400, Jonathan Rajotte-Julien wrote:</div=
>
<blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2px #729f=
cf solid; padding-left:1ex">
<pre>On Tue, Mar 12, 2019 at 03:23:23PM &#43;0000, Doug Schaefer wrote:</pr=
e>
<pre></pre>
<pre>It should be easy to generate a random one with the class I mentioned =
below</pre>
<pre>and fill it with 16 million events.</pre>
<pre><br></pre>
<pre>Not if the problem is in the generator code ;).</pre>
<pre><br></pre>
<pre></pre>
<pre>BTW, two of the int fields are 5 and 10</pre>
<pre>bits respectively, but I'm not sure that matters (or at least it shoul=
dn't).</pre>
<pre><br></pre>
<pre>Make sure to check the endian-ness of those fields.</pre>
<pre><br></pre>
<pre>What class? Not sure I see any reference to any.</pre>
<pre><br></pre>
<pre>Since you are generating CTF the error can be in the generator code. P=
lease</pre>
<pre>provide either a trace reproducing the issue or a base reproducer. It =
will be</pre>
<pre>much easier overall than us trying to reproduce it blindly.</pre>
<pre><br></pre>
<pre>Cheers.</pre>
<pre><br></pre>
</blockquote>
<pre>_______________________________________________</pre>
<pre>lttng-dev mailing list</pre>
<pre><a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a></pre>
<pre><a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__list=
s.lttng.org_cgi-2Dbin_mailman_listinfo_lttng-2Ddev&amp;d=3DDwICAg&amp;c=3Dy=
zoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp26wE&amp;r=3DNrrbvTHWa2Nbp_kAN0Hl1o3l=
M1WAwSes64uBjxjNhMc&amp;m=3DDWwlFfl5FD5R8-HPY3GfbG6l6m7y_o2gXPER8IkQstk&amp=
;s=3DbPK6X3vufUtEAemGpslNIlIL4UslBsgK-SWnraL-e9g&amp;e=3D">https://urldefen=
se.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org_cgi-2Dbin_mailman_li=
stinfo_lttng-2Ddev&amp;d=3DDwICAg&amp;c=3DyzoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-=
lhj0sp26wE&amp;r=3DNrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&amp;m=3DDWwl=
Ffl5FD5R8-HPY3GfbG6l6m7y_o2gXPER8IkQstk&amp;s=3DbPK6X3vufUtEAemGpslNIlIL4Us=
lBsgK-SWnraL-e9g&amp;e=3D</a></pre>
<pre><br></pre>
</blockquote>
---------------------------------------------------------------------<br>
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information
 by anyone other than the intended recipient is prohibited. If you have rec=
eived this transmission in error, please immediately reply to the sender an=
d delete this information from your system. Use, dissemination, distributio=
n, or reproduction of this transmission
 by unintended recipients is not authorized and may be unlawful.<br>
</div>
</body>
</html>

--_000_DM6PR15MB3100CFE23B0E9C736E903D759E4A0DM6PR15MB3100namp_--

--===============3389052207075083051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3389052207075083051==--
