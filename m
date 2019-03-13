From: Doug Schaefer <dschaefer@blackberry.com>
Subject: Re: [tracecompass-dev] Scalability
Date: Wed, 13 Mar 2019 12:46:03 +0000
Message-ID: <2rg3fmt64soppppinbfrmk85.1552481160894__48026.2872458965$1552481190$gmane$org@blackberry.com>
References: <559e65b28a33c3a2d28bc5a32c3fdc4dfeacaf93.camel@blackberry.com>
 <DM6PR15MB3100B14E05117F439A6A08DE9E490@DM6PR15MB3100.namprd15.prod.outlook.com>
 <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>
 <20190312150314.GC13925@joraj-alpa>
 <484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com>
 <20190312153437.GA25992@joraj-alpa>
 <c2ef7a391ab1a7305d71fd0165729d130bc94f5c.camel@blackberry.com>
 <8adc08653d0246ce8b545a7c1374d8b9eb7aa6a3.camel@blackberry.com>
 <DM6PR15MB3100CFE23B0E9C736E903D759E4A0@DM6PR15MB3100.namprd15.prod.outlook.com>,
 <CAB4xu_0re+LuhMLMVfqf_GiFxMrOKFfW12ehqLzLQKkd8_9qVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8894913205638837455=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp-p01.blackberry.com (smtp-p01.blackberry.com [208.65.78.88])
 by lists.lttng.org (Postfix) with ESMTPS id 44KBR83qnzz177w
 for <lttng-dev@lists.lttng.org>; Wed, 13 Mar 2019 08:46:12 -0400 (EDT)
In-Reply-To: <CAB4xu_0re+LuhMLMVfqf_GiFxMrOKFfW12ehqLzLQKkd8_9qVA@mail.gmail.com>
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
To: Philippe Proulx <eeppeliteloop@gmail.com>, Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, tracecompass developer discussions <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

--===============8894913205638837455==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_2rg3fmt64soppppinbfrmk851552481160894blackberrycom_"

--_000_2rg3fmt64soppppinbfrmk851552481160894blackberrycom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Very cool. Would explicitly setting the byte order for each field be a shor=
t term workaround?

Sent from my BlackBerry - the most secure mobile device - via the Rogers Ne=
twork
From: eeppeliteloop@gmail.com
Sent: March 13, 2019 8:30 AM
To: matthew.khouzam@ericsson.com
Cc: jonathan.rajotte-julien@efficios.com; dschaefer@blackberry.com; traceco=
mpass-dev@eclipse.org; lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [tracecompass-dev] Scalability


On Wed, Mar 13, 2019 at 8:13 AM Matthew Khouzam
<matthew.khouzam@ericsson.com> wrote:
>
> Hi Doug & Efficios,
>
>
> I suspect the issue is with libbabeltrace-ctf. When opening the trace in =
Trace Compass, it failed saying the sequence was 2gb big. When opening in b=
abeltrace, it OOMed with 2gb allocations. When opening with a hex editor, I=
 saw 2gb allocations.

Yes, byte order issues. Here's the fix:
<https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_efficios=
_babeltrace_pull_103&d=3DDwIFaQ&c=3DyzoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp=
26wE&r=3DNrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&m=3Dmro2UhDCczUi0qeroL=
QR1acWtiyKnR0DeQlLZcufM9M&s=3D0QPaQrHAx605SVgAPeaZnF264NFCA44uOkcXdbV5dpA&e=
=3D>.

Phil

>
>
> On another subject, fixing the trace made it scale well in both babeltrac=
e and Trace Compass.
>
>
> I don't know why, data_length writes the wrong data. Hope this helps all =
parties.
>
>
> BR,
>
> Matthew
>
> ________________________________
> From: tracecompass-dev-bounces@eclipse.org <tracecompass-dev-bounces@ecli=
pse.org> on behalf of Doug Schaefer <dschaefer@blackberry.com>
> Sent: Tuesday, March 12, 2019 2:50:29 PM
> To: jonathan.rajotte-julien@efficios.com
> Cc: lttng-dev@lists.lttng.org; tracecompass-dev@eclipse.org
> Subject: Re: [tracecompass-dev] [lttng-dev] Scalability
>
> I have attached the C file for a generator that creates a trace that repr=
oduces the memory issue with babeltrace. The same issue happens with a cust=
om program in the call to add a trace to a context.
>
> I am using babeltrace that I get from my Ubuntu 18.04 distro. It has the =
version number 1.5.5.
>
> Thanks for the help!
>
> On Tue, 2019-03-12 at 15:47 +0000, Doug Schaefer wrote:
>
> In the thread on the tracecompass list, I also mentioned that the babeltr=
ace utility itself ran out of memory when reading the file. That's actually=
 my biggest worry. I got around the generator issue by flushing every 100K =
events.
>
> I'll create a quick generator that shows the same issue and post it in a =
bit.
>
> Doug.
>
> On Tue, 2019-03-12 at 11:34 -0400, Jonathan Rajotte-Julien wrote:
>
> On Tue, Mar 12, 2019 at 03:23:23PM +0000, Doug Schaefer wrote:
>
> It should be easy to generate a random one with the class I mentioned bel=
ow
>
> and fill it with 16 million events.
>
>
> Not if the problem is in the generator code ;).
>
>
> BTW, two of the int fields are 5 and 10
>
> bits respectively, but I'm not sure that matters (or at least it shouldn'=
t).
>
>
> Make sure to check the endian-ness of those fields.
>
>
> What class? Not sure I see any reference to any.
>
>
> Since you are generating CTF the error can be in the generator code. Plea=
se
>
> provide either a trace reproducing the issue or a base reproducer. It wil=
l be
>
> much easier overall than us trying to reproduce it blindly.
>
>
> Cheers.
>
>
> _______________________________________________
>
> lttng-dev mailing list
>
> lttng-dev@lists.lttng.org
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org_cg=
i-2Dbin_mailman_listinfo_lttng-2Ddev&d=3DDwICAg&c=3DyzoHOc_ZK-sxl-kfGNSEvlJ=
YanssXN3q-lhj0sp26wE&r=3DNrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&m=3DDW=
wlFfl5FD5R8-HPY3GfbG6l6m7y_o2gXPER8IkQstk&s=3DbPK6X3vufUtEAemGpslNIlIL4UslB=
sgK-SWnraL-e9g&e=3D
>
>
> ---------------------------------------------------------------------
> This transmission (including any attachments) may contain confidential in=
formation, privileged material (including material protected by the solicit=
or-client or other applicable privileges), or constitute non-public informa=
tion. Any use of this information by anyone other than the intended recipie=
nt is prohibited. If you have received this transmission in error, please i=
mmediately reply to the sender and delete this information from your system=
. Use, dissemination, distribution, or reproduction of this transmission by=
 unintended recipients is not authorized and may be unlawful.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org_cg=
i-2Dbin_mailman_listinfo_lttng-2Ddev&d=3DDwIFaQ&c=3DyzoHOc_ZK-sxl-kfGNSEvlJ=
YanssXN3q-lhj0sp26wE&r=3DNrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&m=3Dmr=
o2UhDCczUi0qeroLQR1acWtiyKnR0DeQlLZcufM9M&s=3D0dykfQKNunY0J3PjBwLhAqvF-WUIJ=
-gk74D-duicVKI&e=3D

--_000_2rg3fmt64soppppinbfrmk851552481160894blackberrycom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<style id=3D"x_outgoing-font-settings">
<!--
#x_response_container_BBPPID
	{font-family:initial;
	font-size:initial;
	color:initial}
-->
</style>
<div style=3D"background-color:rgb(255,255,255); line-height:initial">
<div id=3D"x_response_container_BBPPID" dir=3D"auto" style=3D"outline:none"=
>
<div name=3D"x_BB10" id=3D"x_BB10_response_div_BBPPID" dir=3D"auto" style=
=3D"width:100%">
Very cool. Would explicitly setting the byte order for each field be a shor=
t term workaround?&nbsp;</div>
<div name=3D"x_BB10" id=3D"x_response_div_spacer_BBPPID" dir=3D"auto" style=
=3D"width:100%">
<br style=3D"display:initial">
</div>
<div id=3D"x_blackberry_signature_BBPPID" name=3D"x_BB10" dir=3D"auto">
<div id=3D"x__signaturePlaceholder_BBPPID" name=3D"x_BB10" dir=3D"auto">Sen=
t from my BlackBerry - the most secure mobile device - via the Rogers Netwo=
rk</div>
</div>
</div>
<div id=3D"x__original_msg_header_BBPPID" dir=3D"auto">
<table width=3D"100%" style=3D"background-color:white; border-spacing:0px; =
display:table; outline:none">
<tbody>
<tr>
<td colspan=3D"2" style=3D"padding:initial; font-size:initial; text-align:i=
nitial; background-color:rgb(255,255,255)">
<div style=3D"border-right:none; border-bottom:none; border-left:none; bord=
er-top:1pt solid rgb(181,196,223); padding:3pt 0in 0in; font-family:Tahoma,=
&quot;BB Alpha Sans&quot;,&quot;Slate Pro&quot;; font-size:10pt">
<div id=3D"x_from"><b>From:</b> eeppeliteloop@gmail.com</div>
<div id=3D"x_sent"><b>Sent:</b> March 13, 2019 8:30 AM</div>
<div id=3D"x_to"><b>To:</b> matthew.khouzam@ericsson.com</div>
<div id=3D"x_cc"><b>Cc:</b> jonathan.rajotte-julien@efficios.com; dschaefer=
@blackberry.com; tracecompass-dev@eclipse.org; lttng-dev@lists.lttng.org</d=
iv>
<div id=3D"x_subject"><b>Subject:</b> Re: [lttng-dev] [tracecompass-dev] Sc=
alability</div>
</div>
</td>
</tr>
</tbody>
</table>
<br>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Wed, Mar 13, 2019 at 8:13 AM Matthew Khouzam<br=
>
&lt;matthew.khouzam@ericsson.com&gt; wrote:<br>
&gt;<br>
&gt; Hi Doug &amp; Efficios,<br>
&gt;<br>
&gt;<br>
&gt; I suspect the issue is with libbabeltrace-ctf. When opening the trace =
in Trace Compass, it failed saying the sequence was 2gb big. When opening i=
n babeltrace, it OOMed with 2gb allocations. When opening with a hex editor=
, I saw 2gb allocations.<br>
<br>
Yes, byte order issues. Here's the fix:<br>
&lt;<a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__githu=
b.com_efficios_babeltrace_pull_103&amp;d=3DDwIFaQ&amp;c=3DyzoHOc_ZK-sxl-kfG=
NSEvlJYanssXN3q-lhj0sp26wE&amp;r=3DNrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjN=
hMc&amp;m=3Dmro2UhDCczUi0qeroLQR1acWtiyKnR0DeQlLZcufM9M&amp;s=3D0QPaQrHAx60=
5SVgAPeaZnF264NFCA44uOkcXdbV5dpA&amp;e=3D">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__github.com_efficios_babeltrace_pull_103&amp;d=3DDwIF=
aQ&amp;c=3DyzoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp26wE&amp;r=3DNrrbvTHWa2Nb=
p_kAN0Hl1o3lM1WAwSes64uBjxjNhMc&amp;m=3Dmro2UhDCczUi0qeroLQR1acWtiyKnR0DeQl=
LZcufM9M&amp;s=3D0QPaQrHAx605SVgAPeaZnF264NFCA44uOkcXdbV5dpA&amp;e=3D</a>&g=
t;.<br>
<br>
Phil<br>
<br>
&gt;<br>
&gt;<br>
&gt; On another subject, fixing the trace made it scale well in both babelt=
race and Trace Compass.<br>
&gt;<br>
&gt;<br>
&gt; I don't know why, data_length writes the wrong data. Hope this helps a=
ll parties.<br>
&gt;<br>
&gt;<br>
&gt; BR,<br>
&gt;<br>
&gt; Matthew<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: tracecompass-dev-bounces@eclipse.org &lt;tracecompass-dev-bounce=
s@eclipse.org&gt; on behalf of Doug Schaefer &lt;dschaefer@blackberry.com&g=
t;<br>
&gt; Sent: Tuesday, March 12, 2019 2:50:29 PM<br>
&gt; To: jonathan.rajotte-julien@efficios.com<br>
&gt; Cc: lttng-dev@lists.lttng.org; tracecompass-dev@eclipse.org<br>
&gt; Subject: Re: [tracecompass-dev] [lttng-dev] Scalability<br>
&gt;<br>
&gt; I have attached the C file for a generator that creates a trace that r=
eproduces the memory issue with babeltrace. The same issue happens with a c=
ustom program in the call to add a trace to a context.<br>
&gt;<br>
&gt; I am using babeltrace that I get from my Ubuntu 18.04 distro. It has t=
he version number 1.5.5.<br>
&gt;<br>
&gt; Thanks for the help!<br>
&gt;<br>
&gt; On Tue, 2019-03-12 at 15:47 &#43;0000, Doug Schaefer wrote:<br>
&gt;<br>
&gt; In the thread on the tracecompass list, I also mentioned that the babe=
ltrace utility itself ran out of memory when reading the file. That's actua=
lly my biggest worry. I got around the generator issue by flushing every 10=
0K events.<br>
&gt;<br>
&gt; I'll create a quick generator that shows the same issue and post it in=
 a bit.<br>
&gt;<br>
&gt; Doug.<br>
&gt;<br>
&gt; On Tue, 2019-03-12 at 11:34 -0400, Jonathan Rajotte-Julien wrote:<br>
&gt;<br>
&gt; On Tue, Mar 12, 2019 at 03:23:23PM &#43;0000, Doug Schaefer wrote:<br>
&gt;<br>
&gt; It should be easy to generate a random one with the class I mentioned =
below<br>
&gt;<br>
&gt; and fill it with 16 million events.<br>
&gt;<br>
&gt;<br>
&gt; Not if the problem is in the generator code ;).<br>
&gt;<br>
&gt;<br>
&gt; BTW, two of the int fields are 5 and 10<br>
&gt;<br>
&gt; bits respectively, but I'm not sure that matters (or at least it shoul=
dn't).<br>
&gt;<br>
&gt;<br>
&gt; Make sure to check the endian-ness of those fields.<br>
&gt;<br>
&gt;<br>
&gt; What class? Not sure I see any reference to any.<br>
&gt;<br>
&gt;<br>
&gt; Since you are generating CTF the error can be in the generator code. P=
lease<br>
&gt;<br>
&gt; provide either a trace reproducing the issue or a base reproducer. It =
will be<br>
&gt;<br>
&gt; much easier overall than us trying to reproduce it blindly.<br>
&gt;<br>
&gt;<br>
&gt; Cheers.<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt;<br>
&gt; lttng-dev mailing list<br>
&gt;<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt;<br>
&gt; <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__list=
s.lttng.org_cgi-2Dbin_mailman_listinfo_lttng-2Ddev&amp;d=3DDwICAg&amp;c=3Dy=
zoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp26wE&amp;r=3DNrrbvTHWa2Nbp_kAN0Hl1o3l=
M1WAwSes64uBjxjNhMc&amp;m=3DDWwlFfl5FD5R8-HPY3GfbG6l6m7y_o2gXPER8IkQstk&amp=
;s=3DbPK6X3vufUtEAemGpslNIlIL4UslBsgK-SWnraL-e9g&amp;e=3D">
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org_cgi-=
2Dbin_mailman_listinfo_lttng-2Ddev&amp;d=3DDwICAg&amp;c=3DyzoHOc_ZK-sxl-kfG=
NSEvlJYanssXN3q-lhj0sp26wE&amp;r=3DNrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjN=
hMc&amp;m=3DDWwlFfl5FD5R8-HPY3GfbG6l6m7y_o2gXPER8IkQstk&amp;s=3DbPK6X3vufUt=
EAemGpslNIlIL4UslBsgK-SWnraL-e9g&amp;e=3D</a><br>
&gt;<br>
&gt;<br>
&gt; ---------------------------------------------------------------------<=
br>
&gt; This transmission (including any attachments) may contain confidential=
 information, privileged material (including material protected by the soli=
citor-client or other applicable privileges), or constitute non-public info=
rmation. Any use of this information
 by anyone other than the intended recipient is prohibited. If you have rec=
eived this transmission in error, please immediately reply to the sender an=
d delete this information from your system. Use, dissemination, distributio=
n, or reproduction of this transmission
 by unintended recipients is not authorized and may be unlawful.<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; lttng-dev@lists.lttng.org<br>
&gt; <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__list=
s.lttng.org_cgi-2Dbin_mailman_listinfo_lttng-2Ddev&amp;d=3DDwIFaQ&amp;c=3Dy=
zoHOc_ZK-sxl-kfGNSEvlJYanssXN3q-lhj0sp26wE&amp;r=3DNrrbvTHWa2Nbp_kAN0Hl1o3l=
M1WAwSes64uBjxjNhMc&amp;m=3Dmro2UhDCczUi0qeroLQR1acWtiyKnR0DeQlLZcufM9M&amp=
;s=3D0dykfQKNunY0J3PjBwLhAqvF-WUIJ-gk74D-duicVKI&amp;e=3D">
https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.lttng.org_cgi-=
2Dbin_mailman_listinfo_lttng-2Ddev&amp;d=3DDwIFaQ&amp;c=3DyzoHOc_ZK-sxl-kfG=
NSEvlJYanssXN3q-lhj0sp26wE&amp;r=3DNrrbvTHWa2Nbp_kAN0Hl1o3lM1WAwSes64uBjxjN=
hMc&amp;m=3Dmro2UhDCczUi0qeroLQR1acWtiyKnR0DeQlLZcufM9M&amp;s=3D0dykfQKNunY=
0J3PjBwLhAqvF-WUIJ-gk74D-duicVKI&amp;e=3D</a><br>
</div>
</span></font>
</body>
</html>

--_000_2rg3fmt64soppppinbfrmk851552481160894blackberrycom_--

--===============8894913205638837455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============8894913205638837455==--
