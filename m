From: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Subject: Re: Trace loss in Lttng
Date: Mon, 29 Dec 2014 12:19:42 +0000 (UTC)
Message-ID: <1917307066.1594933.1419855582576.JavaMail.yahoo__37326.8617237501$1419855644$gmane$org@jws10968.mail.sg3.yahoo.com>
References: <CA+jJMxvtm+jBbn1-hqQoBcG0+P9sLz+J1uZYD5jFigUpBDa=Zw@mail.gmail.com>
Reply-To: Ranganadh Kanitmahanti <ranganadh1991@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0583868898=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm14-vm1.bullet.mail.sg3.yahoo.com ([106.10.149.32])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ranganadh1991@yahoo.com>) id 1Y5ZId-0003so-7q
 for lttng-dev@lists.lttng.org; Mon, 29 Dec 2014 07:19:54 -0500
In-Reply-To: <CA+jJMxvtm+jBbn1-hqQoBcG0+P9sLz+J1uZYD5jFigUpBDa=Zw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0583868898==
Content-Type: multipart/alternative;
	boundary="----=_Part_1594932_638351885.1419855582569"
Content-Length: 6015

------=_Part_1594932_638351885.1419855582569
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeremie,
Thank you, events_discarded may be of some help for us.=C2=A0 Our main requ=
irement is to find the number of discarded events per session
Ex: We use lttng_create_session() to create an session and then enabled cer=
tain events using lttng_enable_event(). The events=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 come=C2=A0 from different processes.=20
Now, as a whole, can we get the number of discarded events for the whole se=
ssion??=20

Thanks &Regards,K.V.Ranganadh.

     On Tuesday, 9 December 2014 10:10 PM, J=C3=A9r=C3=A9mie Galarneau <jer=
emie.galarneau@efficios.com> wrote:
  =20

 On Tue, Dec 9, 2014 at 12:20 AM, Ranganadh Kanitmahanti
<ranganadh1991@yahoo.com> wrote:
> Hi,
>
> I am using Lttng in an application. I have enabled heavy traces and I hav=
e
> found that there is a loss in traces.=C2=A0 Is there any way of knowing i=
f there
> is any trace loss or any information regarding about it . Are there any A=
PI
> calls to know about them.

There is no way to know from the application while the trace is being
captured. I wonder what form such a mechanism would take to,
basically, query the tracer/ring buffer for the events_discarded
counter... This would arguably be of little use in per-uid mode (since
a user's apps share the same buffer), but I could see this being
useful in per-pid mode.
Any ideas?

J=C3=A9r=C3=A9mie

>
> Thanks & Regards.,
> K.V.Ranganadh.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

   
------=_Part_1594932_638351885.1419855582569
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, Sans-Serif;fo=
nt-size:12px"><div dir=3D"ltr" id=3D"yui_3_16_0_1_1419855527555_3355"><span=
>Hi Jeremie,</span></div><div id=3D"yui_3_16_0_1_1419855527555_3358" dir=3D=
"ltr"><br><span></span><span id=3D"yui_3_16_0_1_1419855527555_3357">Thank y=
ou, events_discarded may be of some help for us.&nbsp; Our main requirement=
 is to find the number of discarded events per session<br style=3D"" class=
=3D"">Ex: We use lttng_create_session() to create an session and then enabl=
ed certain events using lttng_enable_event(). The events&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; come&nbsp; from different processes. <br style=3D"" class=3D"">=
Now, as a whole, can we get the number of discarded events for the whole se=
ssion?? <br style=3D"" class=3D""></span></div><div id=3D"yui_3_16_0_1_1419=
855527555_3377" dir=3D"ltr"><span id=3D"yui_3_16_0_1_1419855527555_3357"><b=
r></span></div><div id=3D"yui_3_16_0_1_1419855527555_3380" dir=3D"ltr"><spa=
n id=3D"yui_3_16_0_1_1419855527555_3357">Thanks &amp;Regards,</span></div><=
div id=3D"yui_3_16_0_1_1419855527555_3378" dir=3D"ltr">K.V.Ranganadh.</div>=
<div class=3D"qtdSeparateBR"><br><br></div><div style=3D"display: block;" c=
lass=3D"yahoo_quoted"> <div style=3D"font-family: HelveticaNeue, Helvetica =
Neue, Helvetica, Arial, Lucida Grande, Sans-Serif; font-size: 12px;"> <div =
style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica, Arial, Luci=
da Grande, Sans-Serif; font-size: 12px;"> <div dir=3D"ltr"> <font size=3D"2=
" face=3D"Arial"> On Tuesday, 9 December 2014 10:10 PM, J=C3=A9r=C3=A9mie G=
alarneau &lt;jeremie.galarneau@efficios.com&gt; wrote:<br> </font> </div>  =
<br><br> <div class=3D"y_msg_container">On Tue, Dec 9, 2014 at 12:20 AM, Ra=
nganadh Kanitmahanti<br clear=3D"none">&lt;<a shape=3D"rect" ymailto=3D"mai=
lto:ranganadh1991@yahoo.com" href=3D"mailto:ranganadh1991@yahoo.com">rangan=
adh1991@yahoo.com</a>&gt; wrote:<br clear=3D"none">&gt; Hi,<br clear=3D"non=
e">&gt;<br clear=3D"none">&gt; I am using Lttng in an application. I have e=
nabled heavy traces and I have<br clear=3D"none">&gt; found that there is a=
 loss in traces.&nbsp; Is there any way of knowing if there<br clear=3D"non=
e">&gt; is any trace loss or any information regarding about it . Are there=
 any API<br clear=3D"none">&gt; calls to know about them.<br clear=3D"none"=
><br clear=3D"none">There is no way to know from the application while the =
trace is being<br clear=3D"none">captured. I wonder what form such a mechan=
ism would take to,<br clear=3D"none">basically, query the tracer/ring buffe=
r for the events_discarded<br clear=3D"none">counter... This would arguably=
 be of little use in per-uid mode (since<br clear=3D"none">a user's apps sh=
are the same buffer), but I could see this being<br clear=3D"none">useful i=
n per-pid mode.<br clear=3D"none">Any ideas?<br clear=3D"none"><br clear=3D=
"none">J=C3=A9r=C3=A9mie<div class=3D"yqt1967503046" id=3D"yqtfd90429"><br =
clear=3D"none"><br clear=3D"none">&gt;<br clear=3D"none">&gt; Thanks &amp; =
Regards.,<br clear=3D"none">&gt; K.V.Ranganadh.</div><br clear=3D"none">&gt=
;<br clear=3D"none">&gt; _______________________________________________<br=
 clear=3D"none">&gt; lttng-dev mailing list<br clear=3D"none">&gt; <a shape=
=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng=
-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br clear=3D"none">&gt; =
<a shape=3D"rect" href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev</a><br clear=3D"none">&gt;<br clear=3D"none"><br clear=3D"none">=
<br clear=3D"none"><br clear=3D"none">-- <br clear=3D"none">J=C3=A9r=C3=A9m=
ie Galarneau<br clear=3D"none">EfficiOS Inc.<br clear=3D"none"><a shape=3D"=
rect" href=3D"http://www.efficios.com/" target=3D"_blank">http://www.effici=
os.com</a><br><br></div>  </div> </div>  </div> </div></body></html>
------=_Part_1594932_638351885.1419855582569--


--===============0583868898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0583868898==--
