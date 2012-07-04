From: Bernd Hufmann <bhufmann@gmail.com>
Subject: Re: lttng_2.0-eclipse-juno : Connection to a Remote
 Host : Unable to list kernel events
Date: Wed, 4 Jul 2012 08:48:01 -0400
Message-ID: <CAG5-hcMDzStCrHp0GpZNZTZfVHZ7+2xDuytSsnZnZmCgpA3Lsw__23998.3947053135$1341406115$gmane$org@mail.gmail.com>
References: <1341389386.5657.YahooMailNeo@web140904.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0380344475=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yx0-f176.google.com ([209.85.213.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bhufmann@gmail.com>) id 1SmP03-0002p8-QL
	for lttng-dev@lists.lttng.org; Wed, 04 Jul 2012 08:48:08 -0400
Received: by yenl5 with SMTP id l5so7321900yen.35
	for <lttng-dev@lists.lttng.org>; Wed, 04 Jul 2012 05:48:02 -0700 (PDT)
In-Reply-To: <1341389386.5657.YahooMailNeo@web140904.mail.bf1.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: somanath sahoo <bapi_mvit2004@yahoo.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0380344475==
Content-Type: multipart/alternative; boundary=14dae934044505357a04c4007189

--14dae934044505357a04c4007189
Content-Type: text/plain; charset=ISO-8859-1

Hi,
to be able to trace the kernel the global session daemon has to be running,
that means it has to be running as root. To start the global session daemon
login to your node and then execute sudo lttng list -k
Then you are able to trace the kernel and UST using your user login.
However you have to make sure that your user id is part of the user group
tracing.
Once this is setup the tracer control with Eclipse should work, too.

Best Regards
Bernd
On 2012-07-04 4:10 AM, "somanath sahoo" <bapi_mvit2004@yahoo.com> wrote:

> Hi,
>
> I am running eclipse c/c++ juno in ubuntu 12.04 which is running inside
> Virtualbox VM.
>
>
> Issue : Tree node of remote host is not being created in the cotrol view
> panel of eclipse while i am successfully connected to remote host (in this
> case my ubuntu 12.04).
>
> I am to trying use "lttng tracer control" feature of eclipse juno by
> following this link --
> http://wiki.eclipse.org/index.php/Linux_Tools_Project/LTTng2/User_Guide#LTTng_Tracer_Control
>
> Error description : when eclipse is successfully connected to remote host,
> then eclipse is trying to run "lttng list -k" to listing the kernel event
> and its getting failed.
>                               But whereas i am able to run lttng commands
> in my remote host (in ubuntu 12.04) successfully.
>
> The error message from eclipse is provided below -
>
> ----
> List sessions failed
> Command failed! Command:  lttng list -k
> Return Value: 79
> Error: Unable to list kernel events
>
> ------
> I have attached screenshot of this error. please find the attachment.
>
> Please guide me to resolve this problem.
>
>
> Thanks & Regards,
> Somanath
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--14dae934044505357a04c4007189
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi,<br>
to be able to trace the kernel the global session daemon has to be running,=
 that means it has to be running as root. To start the global session daemo=
n login to your node and then execute sudo lttng list -k<br>
Then you are able to trace the kernel and UST using your user login. Howeve=
r you have to make sure that your user id is part of the user group tracing=
.<br>
Once this is setup the tracer control with Eclipse should work, too.</p>
<p>Best Regards<br>
Bernd</p>
<div class=3D"gmail_quote">On 2012-07-04 4:10 AM, &quot;somanath sahoo&quot=
; &lt;<a href=3D"mailto:bapi_mvit2004@yahoo.com">bapi_mvit2004@yahoo.com</a=
>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div><div style=3D"font-size:12pt;font-family:times new roman,new york,time=
s,serif"><div>Hi,</div><div><br></div><div>I am running eclipse c/c++ juno =
in ubuntu 12.04 which is running inside Virtualbox VM. <br></div><div><br>
</div><div><br></div><div>Issue : Tree node of remote host is not being cre=
ated in the cotrol view panel of eclipse while i am successfully connected =
to remote host (in this case my ubuntu 12.04). <br></div><div><br></div>
<div>I am to trying use &quot;<span style=3D"font-weight:bold">lttng tracer=
 control&quot; </span><span>feature of eclipse juno by following this link =
-- <span style=3D"font-weight:bold"><a href=3D"http://wiki.eclipse.org/inde=
x.php/Linux_Tools_Project/LTTng2/User_Guide#LTTng_Tracer_Control" target=3D=
"_blank">http://wiki.eclipse.org/index.php/Linux_Tools_Project/LTTng2/User_=
Guide#LTTng_Tracer_Control</a></span></span></div>
<div><span><br> </span></div><div>Error description : when eclipse is succe=
ssfully connected to remote host, then eclipse is trying to run &quot;lttng=
 list -k&quot; to listing the kernel event and its
 getting failed.</div><div><span>=A0=A0=A0 </span><span>=A0=A0=A0 </span><s=
pan>=A0=A0=A0 </span><span>=A0=A0=A0 </span><span>=A0=A0=A0 </span><span>=
=A0=A0=A0 </span><span>=A0=A0=A0 </span><span>=A0 </span>But whereas i am a=
ble to run lttng commands in my remote host (in ubuntu 12.04) successfully.=
</div>
<div><br></div><div>The error message from eclipse is provided below - <br>=
</div><div><br></div><div>----<br></div><div>List sessions failed<br>Comman=
d failed! Command:=A0 lttng list -k<br>Return Value: 79<br>Error: Unable to=
 list kernel events</div>
<div><br></div><div>------<br></div><div>I have attached <span style=3D"fon=
t-weight:bold">screenshot of this error</span>. please find the attachment.=
</div><div><br></div><div>Please guide me to resolve this
 problem.</div><div><br></div><div><br></div><div>Thanks &amp; Regards,<br>=
Somanath<br></div></div></div><br>_________________________________________=
______<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div>

--14dae934044505357a04c4007189--


--===============0380344475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0380344475==--
