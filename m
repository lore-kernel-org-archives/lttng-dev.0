From: =?iso-8859-1?Q?M=E1t=E9_Ferenczy?= <mate.ferenczy@ericsson.com>
Subject: Re: efficient use of LTTng in legacy codebase
Date: Mon, 16 Dec 2013 01:11:35 +0000
Message-ID: <ECCC3645D4115E4293D3E8C0EB22F09C22CC8E__46183.7125513286$1387157648$gmane$org@ESESSMB109.ericsson.se>
References: <ECCC3645D4115E4293D3E8C0EB22F09C20D363@ESESSMB109.ericsson.se>
	<38714154.84070.1386809251111.JavaMail.zimbra@efficios.com>
	<ECCC3645D4115E4293D3E8C0EB22F09C20D3F6@ESESSMB109.ericsson.se>
	<1206710241.84238.1386851719338.JavaMail.zimbra@efficios.com>
	<ECCC3645D4115E4293D3E8C0EB22F09C20D572@ESESSMB109.ericsson.se>
	<OFA420391C.226AC243-ONC2257C42.00460223-C2257C42.00471974@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0946572832=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailgw1.ericsson.se ([193.180.251.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <mate.ferenczy@ericsson.com>) id 1VsMio-0007qz-3h
	for lttng-dev@lists.lttng.org; Sun, 15 Dec 2013 20:11:52 -0500
In-Reply-To: <OFA420391C.226AC243-ONC2257C42.00460223-C2257C42.00471974@il.ibm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0946572832==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_ECCC3645D4115E4293D3E8C0EB22F09C22CC8EESESSMB109ericsso_"

--_000_ECCC3645D4115E4293D3E8C0EB22F09C22CC8EESESSMB109ericsso_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I agree that in the long term it would be nice if the trace reader could pe=
rform the formatting.

However, I am not sure how #2 would work if the format strings and argument=
 lists are passed through a couple of function calls before calling the tra=
cepoint API (which is the case in our code).

From: Amit Margalit [mailto:AMITM@il.ibm.com]
Sent: Sunday, December 15, 2013 4:56 AM
To: M=E1t=E9 Ferenczy
Cc: lttng-dev@lists.lttng.org; Mathieu Desnoyers
Subject: Re: [lttng-dev] efficient use of LTTng in legacy codebase

The macro is elegant and solves the problem nicely.

I find that it does not make the biggest issue go away - the entire formatt=
ed string gets stored in the trace file multiple times.

The best solution would be:

  1.  To modify CTF and define a type that indicates a printf-style format =
string.

  1.  To have a LTTng macro that provides this string to the tracer, so tha=
t it can record it only once in the metadata.

  1.  To have the tracepoint store all the arguments in binary form, possib=
ly with the addition of some identifying value of the format string.

  1.  And to have babeltrace (the CTF trace reader) perform the formatting =
off-line.

I mean - consider a trace message that includes a long format string, with =
say - 5 integer arguments. Something like:
"Buffer vacancy threshold warning: curr_limit=3D%d, curr_threshold=3D%d, ch=
annel_num=3D%d, high_mark=3D%d, hit_count=3D%d"

This stores > 105 bytes with every trace line. But the real information her=
e is only 20 bytes (assuming the integers are 32-bits).

Storing the format string once in the metadata will effectively boost perfo=
rmance for a system trying to trace like this.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:        M=E1t=E9 Ferenczy <mate.ferenczy@ericsson.com<mailto:mate.fere=
nczy@ericsson.com>>
To:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com<mailto:mathieu=
.desnoyers@efficios.com>>
Cc:        "lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>" <l=
ttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>>
Date:        12/12/2013 07:39 PM
Subject:        Re: [lttng-dev] efficient use of LTTng in legacy codebase
________________________________



That's even better, as far as I see we do not even have to touch the libltt=
ng code itself.
Will get back with comments if any after testing.

Thanks so much!
mate


From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
Sent: Thursday, December 12, 2013 4:35 AM
To: M=E1t=E9 Ferenczy
Cc: lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
Subject: Re: efficient use of LTTng in legacy codebase

Just to speed things up, please have a look at the proposed UST patch. (it'=
s not in mainline yet)

This is specifically for a demo program example so far.

Comments are welcome,

Thanks,

Mathieu


________________________________

From: "M=E1t=E9 Ferenczy" <mate.ferenczy@ericsson.com<mailto:mate.ferenczy@=
ericsson.com>>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com<mailto:mathieu.desn=
oyers@efficios.com>>
Cc: lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
Sent: Wednesday, December 11, 2013 8:52:30 PM
Subject: RE: efficient use of LTTng in legacy codebase

It sounds great, I like the idea. Just to make sure I understand your sugge=
stion, are we talking about converting the variable argument list to string=
 in include/lttng/ust-tracepoint-event-write.h?

For example:
#define ctf_format_string(_item, ...)                               \
        do {                                                      \
            char _buf[BUF_MAXLEN];                               \
            snprintf(buf, sizeof(_buf), __VA_ARGS__);            \
            _ctf_string(_item, _buf, 0);                         \
       } while(0)

Or do you have some better place to put this logic?

Thanks,
Mate

From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
Sent: Wednesday, December 11, 2013 4:48 PM
To: M=E1t=E9 Ferenczy
Cc: lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
Subject: Re: efficient use of LTTng in legacy codebase

________________________________

From: "M=E1t=E9 Ferenczy" <mate.ferenczy@ericsson.com<mailto:mate.ferenczy@=
ericsson.com>>
To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com<mailto:mathieu.desn=
oyers@efficios.com>>
Cc: lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
Sent: Wednesday, December 11, 2013 6:52:22 PM
Subject: RE: efficient use of LTTng in legacy codebase

I found this email thread: https://www.mail-archive.com/lttng-dev@lists.ltt=
ng.org/msg02278.html
According to this I could just check caa_unlikely(__tracepoint_##provider##=
___##name.state). However, Dave claims that this state will stay true even =
if the tracepoint is disabled. Is there anything else I should check for?

I would recommend doing this in the UST probe provider instead. Within the =
TRACEPOINT_EVENT "TP_FIELD" section, when you declare your string field, yo=
u could parse the format string there in the last argument of a ctf_string(=
) (a statement expression). The format string would be received as paramete=
r by the tracepoint, along with a variable arg list (...). In the probe, it=
 would be turned into a va_list (see stdarg(3)), and the parameters could b=
e decoded into a string there. This has the benefit of moving the serializa=
tion call out-of-line into the probe provider rather than clobbering the tr=
acepoint call site.

Thoughts ?

Thanks,

Mathieu

Thanks,
Mate

From: M=E1t=E9 Ferenczy
Sent: Wednesday, December 11, 2013 12:17 PM
To: 'mathieu.desnoyers@efficios.com'
Cc: 'lttng-dev@lists.lttng.org'
Subject: efficient use of LTTng in legacy codebase
Hello Mathieu,
Our team was asked to support LTTng UST solution in a legacy codebase. The =
existing codebase is fairly large, and the requirement is that we provide a=
ll the existing logs and debugs in the system as LTTng traces.
The planned solution so far was just to pass everything we have as text (st=
rings) to LTTng. For that we obviously have to convert the printf-like form=
at string and parameter list to a string by calling snprintf before giving =
the string to the LTTng API. That would however mean, that these snprintfs =
are getting called every time even if there is no listener/active trace ses=
sion for the given trace. In this case, all those unnecessary snprintf call=
s may end up significantly impacting the performance of our applications.
In order to work around this, we were thinking that if there was a way to q=
uery the LTTng library from our application code whether there is an active=
 tracing session for the given trace level, we could avoid calling those sn=
printfs in case they are not needed. Do you think it would be feasible to e=
asily get this data from LTTng lib? If yes, can you provide us some pointer=
s where to look at in order to do those changes ourselves?
Any suggestions are welcome.
Thank you,
Mate Ferenczy


--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com<http://www.efficios.com/>


--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com<http://www.efficios.com/>__________________________=
_____________________
lttng-dev mailing list
lttng-dev@lists.lttng.org<mailto:lttng-dev@lists.lttng.org>
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--_000_ECCC3645D4115E4293D3E8C0EB22F09C22CC8EESESSMB109ericsso_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Helvetica;
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
tt
	{mso-style-priority:99;
	font-family:"Courier New";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1930380874;
	mso-list-template-ids:-2062149948;}
@list l0:level1 lfo3
	{mso-level-start-at:2;}
@list l0:level1 lfo4
	{mso-level-start-at:3;}
@list l0:level1 lfo5
	{mso-level-start-at:4;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">I agree that in the long =
term it would be nice if the trace reader could perform the formatting.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">However, I am not sure ho=
w #2 would work if the format strings and argument lists are passed through=
 a couple of function calls before calling the tracepoint
 API (which is the case in our code).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Amit Mar=
galit [mailto:AMITM@il.ibm.com]
<br>
<b>Sent:</b> Sunday, December 15, 2013 4:56 AM<br>
<b>To:</b> M=E1t=E9 Ferenczy<br>
<b>Cc:</b> lttng-dev@lists.lttng.org; Mathieu Desnoyers<br>
<b>Subject:</b> Re: [lttng-dev] efficient use of LTTng in legacy codebase<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,&quot;sans-serif&quot;">The macro is elegant and solves the probl=
em nicely.</span>
<br>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">I find that it does not make the biggest issue go away - the ent=
ire formatted string gets stored in the trace file multiple times.</span>
<br>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">The best solution would be:</span>
<o:p></o:p></p>
<ol start=3D"1" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-=
alt:auto;mso-list:l0 level1 lfo2">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">To modify CTF and define a type that indicates a printf-style fo=
rmat string.</span>
<o:p></o:p></li></ol>
<ol start=3D"2" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-=
alt:auto;mso-list:l0 level1 lfo3">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">To have a LTTng macro that provides this string to the tracer, s=
o that it can record it
<u>only once</u> in the metadata.</span> <o:p></o:p></li></ol>
<ol start=3D"3" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-=
alt:auto;mso-list:l0 level1 lfo4">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">To have the tracepoint store all the arguments in binary form, p=
ossibly with the addition of some identifying value of the format string.</=
span>
<o:p></o:p></li></ol>
<ol start=3D"4" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-=
alt:auto;mso-list:l0 level1 lfo5">
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">And to have babeltrace (the CTF trace reader) perform the format=
ting off-line.</span><o:p></o:p></li></ol>
<p class=3D"MsoNormal"><br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">I mean - consider a trace message that includes a long format st=
ring, with say - 5 integer arguments. Something like:</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">&quot;Buffer vacancy threshold warning: curr_limit=3D%d, curr_th=
reshold=3D%d, channel_num=3D%d, high_mark=3D%d, hit_count=3D%d&quot;</span>
<br>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">This stores &gt; 105 bytes with
<u>every</u> trace line. But the real information here is only 20 bytes (as=
suming the integers are 32-bits).</span>
<br>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">Storing the format string once in the metadata will effectively =
boost performance for a system trying to trace like this.</span>
<br>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;;color:navy">Amit Margalit</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;;color:olive">IBM XIV
</span><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;=
sans-serif&quot;">- <i>Storage Reinvented</i></span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">XIV-NAS Development Team</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">Tel. 03-689-7774</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-se=
rif&quot;">Fax. 03-689-7230</span>
<br>
<br>
<br>
<br>
<span style=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-ser=
if&quot;;color:#5F5F5F">From: &nbsp; &nbsp; &nbsp; &nbsp;</span><span style=
=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">M=
=E1t=E9 Ferenczy &lt;<a href=3D"mailto:mate.ferenczy@ericsson.com">mate.fer=
enczy@ericsson.com</a>&gt;</span>
<br>
<span style=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-ser=
if&quot;;color:#5F5F5F">To: &nbsp; &nbsp; &nbsp; &nbsp;</span><span style=
=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">M=
athieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com">math=
ieu.desnoyers@efficios.com</a>&gt;</span>
<br>
<span style=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-ser=
if&quot;;color:#5F5F5F">Cc: &nbsp; &nbsp; &nbsp; &nbsp;</span><span style=
=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">&=
quot;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a>&quot; &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists=
.lttng.org</a>&gt;</span>
<br>
<span style=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-ser=
if&quot;;color:#5F5F5F">Date: &nbsp; &nbsp; &nbsp; &nbsp;</span><span style=
=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">1=
2/12/2013 07:39 PM</span>
<br>
<span style=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-ser=
if&quot;;color:#5F5F5F">Subject: &nbsp; &nbsp; &nbsp; &nbsp;</span><span st=
yle=3D"font-size:7.5pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;=
">Re: [lttng-dev] efficient use of LTTng in legacy codebase</span>
<o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"100%" noshade=3D"" style=3D"color:#A0A0A0" align=3D=
"center">
</div>
<p class=3D"MsoNormal"><br>
<br>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">That&#8217;s even better, as far as I see we do =
not even have to touch the liblttng code itself.</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">Will get back with comments if any after testing=
.</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">&nbsp;</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">Thanks so much!
</span><br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">mate</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">&nbsp;</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">&nbsp;</span>
<br>
<b><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt;font-family:=
&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Mathieu Desnoyers [</span><a hr=
ef=3D"mailto:mathieu.desnoyers@efficios.com"><span style=3D"font-size:10.0p=
t;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">mailto:mathieu.des=
noyers@efficios.com</span></a><span style=3D"font-size:10.0pt;font-family:&=
quot;Tahoma&quot;,&quot;sans-serif&quot;">]
<b><br>
Sent:</b> Thursday, December 12, 2013 4:35 AM<b><br>
To:</b> M=E1t=E9 Ferenczy<b><br>
Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.=
org</a><b><br>
Subject:</b> Re: efficient use of LTTng in legacy codebase</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">&nbsp;</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Just to speed things up, please have a look at the proposed US=
T patch. (it's not in mainline yet)</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">&nbsp;</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">This is specifically for a demo program example so far.</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">&nbsp;</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Comments are welcome,</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">&nbsp;</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Thanks,</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">&nbsp;</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Mathieu</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">&nbsp;</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">&nbsp;</span> <o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"100%" align=3D"center">
</div>
<p class=3D"MsoNormal"><br>
<b><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot;=
sans-serif&quot;">From: </span>
</b><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot=
;sans-serif&quot;">&quot;M=E1t=E9 Ferenczy&quot; &lt;</span><a href=3D"mail=
to:mate.ferenczy@ericsson.com"><span style=3D"font-size:10.0pt;font-family:=
&quot;Helvetica&quot;,&quot;sans-serif&quot;">mate.ferenczy@ericsson.com</s=
pan></a><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&=
quot;sans-serif&quot;">&gt;<b><br>
To: </b>&quot;Mathieu Desnoyers&quot; &lt;</span><a href=3D"mailto:mathieu.=
desnoyers@efficios.com"><span style=3D"font-size:10.0pt;font-family:&quot;H=
elvetica&quot;,&quot;sans-serif&quot;">mathieu.desnoyers@efficios.com</span=
></a><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quo=
t;sans-serif&quot;">&gt;<b><br>
Cc: </b></span><a href=3D"mailto:lttng-dev@lists.lttng.org"><span style=3D"=
font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;">=
lttng-dev@lists.lttng.org</span></a><b><span style=3D"font-size:10.0pt;font=
-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;"><br>
Sent: </span></b><span style=3D"font-size:10.0pt;font-family:&quot;Helvetic=
a&quot;,&quot;sans-serif&quot;">Wednesday, December 11, 2013 8:52:30 PM<b><=
br>
Subject: </b>RE: efficient use of LTTng in legacy codebase</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot;san=
s-serif&quot;">&nbsp;</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">It sounds great, I like the idea. Just to make s=
ure I understand your suggestion, are we talking about converting the varia=
ble argument list to string in include/lttng/ust-tracepoint-event-write.h?<=
/span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">&nbsp;</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">For example:</span>
<br>
<span style=3D"font-size:10.0pt;color:#004080">#define ctf_format_string(_i=
tem, &#8230;) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</span>
<br>
<span style=3D"font-size:10.0pt;color:#004080">&nbsp; &nbsp; &nbsp; &nbsp; =
do { &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;\</span>
<br>
<span style=3D"font-size:10.0pt;color:#004080">&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; char _buf[BUF_MAXLEN]; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</span>
<br>
<span style=3D"font-size:10.0pt;color:#004080">&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; snprintf(buf, sizeof(_buf), __VA_ARGS__); &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;\</span>
<br>
<span style=3D"font-size:10.0pt;color:#004080">&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; _ctf_string(_item, _buf, 0); &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; \</span>
<br>
<span style=3D"font-size:10.0pt;color:#004080">&nbsp; &nbsp; &nbsp; &nbsp;}=
 while(0)</span> <br>
<span style=3D"font-size:10.0pt;color:#004080">&nbsp; &nbsp; &nbsp; &nbsp; =
</span><br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">Or do you have some better place to put this log=
ic?</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">&nbsp;</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">Thanks,</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">Mate</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">&nbsp;</span>
<br>
<b><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt;font-family:=
&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Mathieu Desnoyers [</span><a hr=
ef=3D"mailto:mathieu.desnoyers@efficios.com"><span style=3D"font-size:10.0p=
t;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">mailto:mathieu.des=
noyers@efficios.com</span></a><span style=3D"font-size:10.0pt;font-family:&=
quot;Tahoma&quot;,&quot;sans-serif&quot;">]
<b><br>
Sent:</b> Wednesday, December 11, 2013 4:48 PM<b><br>
To:</b> M=E1t=E9 Ferenczy<b><br>
Cc:</b> </span><a href=3D"mailto:lttng-dev@lists.lttng.org"><span style=3D"=
font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">ltt=
ng-dev@lists.lttng.org</span></a><b><span style=3D"font-size:10.0pt;font-fa=
mily:&quot;Tahoma&quot;,&quot;sans-serif&quot;"><br>
Subject:</span></b><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma=
&quot;,&quot;sans-serif&quot;"> Re: efficient use of LTTng in legacy codeba=
se</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">&nbsp;</span> <o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"100%" align=3D"center">
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
<b><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot;=
sans-serif&quot;">From: </span>
</b><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot=
;sans-serif&quot;">&quot;M=E1t=E9 Ferenczy&quot; &lt;</span><a href=3D"mail=
to:mate.ferenczy@ericsson.com" target=3D"_blank"><span style=3D"font-size:1=
0.0pt;font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;">mate.ferenc=
zy@ericsson.com</span></a><span style=3D"font-size:10.0pt;font-family:&quot=
;Helvetica&quot;,&quot;sans-serif&quot;">&gt;<b><br>
To: </b>&quot;mathieu desnoyers&quot; &lt;</span><a href=3D"mailto:mathieu.=
desnoyers@efficios.com" target=3D"_blank"><span style=3D"font-size:10.0pt;f=
ont-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;">mathieu.desnoyers@=
efficios.com</span></a><span style=3D"font-size:10.0pt;font-family:&quot;He=
lvetica&quot;,&quot;sans-serif&quot;">&gt;<b><br>
Cc: </b></span><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blan=
k"><span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot;=
sans-serif&quot;">lttng-dev@lists.lttng.org</span></a><b><span style=3D"fon=
t-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot;sans-serif&quot;"><br=
>
Sent: </span></b><span style=3D"font-size:10.0pt;font-family:&quot;Helvetic=
a&quot;,&quot;sans-serif&quot;">Wednesday, December 11, 2013 6:52:22 PM<b><=
br>
Subject: </b>RE: efficient use of LTTng in legacy codebase</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Helvetica&quot;,&quot;san=
s-serif&quot;">&nbsp;</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">I found this email thread:
</span><a href=3D"https://www.mail-archive.com/lttng-dev@lists.lttng.org/ms=
g02278.html" target=3D"_blank"><span style=3D"font-size:10.0pt;font-family:=
&quot;Calibri&quot;,&quot;sans-serif&quot;">https://www.mail-archive.com/lt=
tng-dev@lists.lttng.org/msg02278.html</span></a>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">According to this I could just check caa_unlikely(__tracepoint=
_##provider##___##name.state). However, Dave claims that this state will st=
ay true even if the tracepoint is disabled. Is there anything
 else I should check for?</span> <br>
&nbsp; <br>
I would recommend doing this in the UST probe provider instead. Within the =
TRACEPOINT_EVENT &quot;TP_FIELD&quot; section, when you declare your string=
 field, you could parse the format string there in the last argument of a c=
tf_string() (a statement expression). The
 format string would be received as parameter by the tracepoint, along with=
 a variable arg list (...). In the probe, it would be turned into a va_list=
 (see stdarg(3)), and the parameters could be decoded into a string there. =
This has the benefit of moving the
 serialization call out-of-line into the probe provider rather than clobber=
ing the tracepoint call site.
<br>
&nbsp; <br>
Thoughts ? <br>
&nbsp; <br>
Thanks, <br>
&nbsp; <br>
Mathieu <br>
&nbsp; <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Thanks,</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Mate</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;color:#004080">&nbsp;</span>
<br>
<b><span style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;san=
s-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt;font-family:=
&quot;Tahoma&quot;,&quot;sans-serif&quot;"> M=E1t=E9 Ferenczy
<b><br>
Sent:</b> Wednesday, December 11, 2013 12:17 PM<b><br>
To:</b> 'mathieu.desnoyers@efficios.com'<b><br>
Cc:</b> 'lttng-dev@lists.lttng.org'<b><br>
Subject:</b> efficient use of LTTng in legacy codebase</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Hello Mathieu,</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Our team was asked to support LTTng UST solution in a legacy c=
odebase. The existing codebase is fairly large, and the requirement is that=
 we provide all the existing logs and debugs in the system
 as LTTng traces.</span> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">The planned solution so far was just to pass everything we hav=
e as text (strings) to LTTng. For that we obviously have to convert the pri=
ntf-like format string and parameter list to a string
 by calling snprintf before giving the string to the LTTng API. That would =
however mean, that these snprintfs are getting called every time even if th=
ere is no listener/active trace session for the given trace. In this case, =
all those unnecessary snprintf calls
 may end up significantly impacting the performance of our applications.</s=
pan> <br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">In order to work around this, we were thinking that if there w=
as a way to query the LTTng library from our application code whether there=
 is an active tracing session for the given trace level,
 we could avoid calling those snprintfs in case they are not needed. Do you=
 think it would be feasible to easily get this data from LTTng lib? If yes,=
 can you provide us some pointers where to look at in order to do those cha=
nges ourselves?</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Any suggestions are welcome.</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Thank you,</span>
<br>
<span style=3D"font-size:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;">Mate Ferenczy</span>
<br>
&nbsp; <br>
&nbsp; <br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<u><span style=3D"color:blue"><br>
</span></u><a href=3D"http://www.efficios.com/" target=3D"_blank">http://ww=
w.efficios.com</a>
<br>
&nbsp; <br>
&nbsp; <br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<u><span style=3D"color:blue"><br>
</span></u><a href=3D"http://www.efficios.com/">http://www.efficios.com</a>=
<tt><span style=3D"font-size:10.0pt">______________________________________=
_________</span></tt><span style=3D"font-size:10.0pt;font-family:&quot;Cour=
ier New&quot;"><br>
<tt>lttng-dev mailing list</tt><br>
<tt><a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org<=
/a></tt><br>
</span><a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=
"><tt><span style=3D"font-size:10.0pt">http://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</span></tt></a><o:p></o:p></p>
</div>
</body>
</html>

--_000_ECCC3645D4115E4293D3E8C0EB22F09C22CC8EESESSMB109ericsso_--


--===============0946572832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0946572832==--
