From: Jeffrey Chen <cpthk@hotmail.com>
Subject: Re: LTTng event loglevel
Date: Mon, 22 Jun 2015 15:03:44 -0700
Message-ID: <BLU169-W116D220BC28F5EEAB7D0DF8ABA10__40908.9155532003$1435010705$gmane$org@phx.gbl>
References: <BLU169-W114739E6F78BF869CAD7B8ABA10@phx.gbl>,
 <55887C23.8010306@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0513298592=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc1s5.hotmail.com ([65.55.116.16])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1Z79ok-00013N-KM
 for lttng-dev@lists.lttng.org; Mon, 22 Jun 2015 18:03:59 -0400
In-Reply-To: <55887C23.8010306@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0513298592==
Content-Type: multipart/alternative;
	boundary="_b3b506ed-dfa6-47f1-80f0-a2b620057025_"

--_b3b506ed-dfa6-47f1-80f0-a2b620057025_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for your answer.

I tried to use the TRACEPOINT_LOGLEVEL macro=2C but I was not able to make =
it working. I have my macro immediately follow my TRACE_EVENT macro "TRACEP=
OINT_LOGLEVEL(hello_world=2Cmy_first_tracepoint=2CTRACE_WARNING)"

I enabled the event with the --loglevel TRACE_WARNING parameter. When I run=
 my code=2C and I do `lttng list --userspace`=2C I still get "hello_world:m=
y_first_tracepoint (loglevel: TRACE_DEBUG_LINE (13)) (type: tracepoint)"

It looks like my code does not set the loglevel correctly=2C so it is still=
 using the default loglevel. Am I doing anything wrong? Thanks.

> Date: Mon=2C 22 Jun 2015 17:20:35 -0400
> From: alexmonthy@voxpopuli.im
> To: cpthk@hotmail.com
> CC: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] LTTng event loglevel
>=20
> Hi=2C
>=20
> On 2015-06-22 05:06 PM=2C Jeffrey Chen wrote:
> > Hi:
> >
> > I am reading the LTTng and I am confused about the loglevel in the docu=
ment. The document talked about it could assign a loglevel to each event. (=
http://lttng.org/docs/#doc-assigning-log-levels)
>=20
> This part refers to when you define your own tracepoints in your pogram=
=2C=20
> using the TRACEPOINT_EVENT macro.
>=20
> >   But=2C later in the document=2C it says all events from LTTng are tra=
ced as loglevel TRACE_DEBUG_FUNCTION. (http://lttng.org/docs/#doc-liblttng%=
E2%80%91ust%E2%80%91cyg%E2%80%91profile)
>=20
> That part however=2C refers to using the liblttng-ust-cyg-profile library=
=2C=20
> to automatically instrument function entries and exits. This library=20
> implements the callbacks expected by cyg-profile=2C and puts the=20
> information into UST tracepoints. Since it's this=20
> liblttng-ust-cyg-profile library that "defines" the tracepoints here=2C=20
> they are stuck at the log level specified in their definition=2C which is=
=20
> TRACE_DEBUG_FUNCTION in this case.
>=20
>=20
> Hope this helps=2C
> Alexandre
>=20
 		 	   		  =

--_b3b506ed-dfa6-47f1-80f0-a2b620057025_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Thanks for your answer.<br><br>I=
 tried to use the TRACEPOINT_LOGLEVEL macro=2C but I was not able to make i=
t working. I have my macro immediately follow my TRACE_EVENT macro "TRACEPO=
INT_LOGLEVEL(hello_world=2Cmy_first_tracepoin<span style=3D"background-colo=
r: rgb(255=2C 255=2C 255)=3B">t=2C<span style=3D"background-color: rgb(255=
=2C 255=2C 0)=3B">TRACE_WARNING</span></span>)"<br><br>I enabled the event =
with the --loglevel <span style=3D"background-color: rgb(255=2C 255=2C 255)=
=3B"><span style=3D"background-color: rgb(255=2C 255=2C 0)=3B">TRACE_WARNIN=
G</span></span> parameter. When I run my code=2C and I do `lttng list --use=
rspace`=2C I still get "hello_world:my_first_tracepoint (loglevel: <span st=
yle=3D"background-color: rgb(255=2C 255=2C 0)=3B">TRACE_DEBUG_LINE</span> (=
13)) (type: tracepoint)"<br><br>It looks like my code does not set the logl=
evel correctly=2C so it is still using the default loglevel. Am I doing any=
thing wrong? Thanks.<br><br><div>&gt=3B Date: Mon=2C 22 Jun 2015 17:20:35 -=
0400<br>&gt=3B From: alexmonthy@voxpopuli.im<br>&gt=3B To: cpthk@hotmail.co=
m<br>&gt=3B CC: lttng-dev@lists.lttng.org<br>&gt=3B Subject: Re: [lttng-dev=
] LTTng event loglevel<br>&gt=3B <br>&gt=3B Hi=2C<br>&gt=3B <br>&gt=3B On 2=
015-06-22 05:06 PM=2C Jeffrey Chen wrote:<br>&gt=3B &gt=3B Hi:<br>&gt=3B &g=
t=3B<br>&gt=3B &gt=3B I am reading the LTTng and I am confused about the lo=
glevel in the document. The document talked about it could assign a logleve=
l to each event. (http://lttng.org/docs/#doc-assigning-log-levels)<br>&gt=
=3B <br>&gt=3B This part refers to when you define your own tracepoints in =
your pogram=2C <br>&gt=3B using the TRACEPOINT_EVENT macro.<br>&gt=3B <br>&=
gt=3B &gt=3B   But=2C later in the document=2C it says all events from LTTn=
g are traced as loglevel TRACE_DEBUG_FUNCTION. (http://lttng.org/docs/#doc-=
liblttng%E2%80%91ust%E2%80%91cyg%E2%80%91profile)<br>&gt=3B <br>&gt=3B That=
 part however=2C refers to using the liblttng-ust-cyg-profile library=2C <b=
r>&gt=3B to automatically instrument function entries and exits. This libra=
ry <br>&gt=3B implements the callbacks expected by cyg-profile=2C and puts =
the <br>&gt=3B information into UST tracepoints. Since it's this <br>&gt=3B=
 liblttng-ust-cyg-profile library that "defines" the tracepoints here=2C <b=
r>&gt=3B they are stuck at the log level specified in their definition=2C w=
hich is <br>&gt=3B TRACE_DEBUG_FUNCTION in this case.<br>&gt=3B <br>&gt=3B =
<br>&gt=3B Hope this helps=2C<br>&gt=3B Alexandre<br>&gt=3B <br></div> 		 	=
   		  </div></body>
</html>=

--_b3b506ed-dfa6-47f1-80f0-a2b620057025_--


--===============0513298592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0513298592==--
