From: somanath sahoo <bapi_mvit2004@yahoo.com>
Subject: Re: lttng_2.0-eclipse-juno : Connection to a Remote
	Host : Unable to list kernel events
Date: Wed, 4 Jul 2012 22:45:27 -0700 (PDT)
Message-ID: <1341467127.80260.YahooMailNeo__37884.3280756429$1341467165$gmane$org@web140905.mail.bf1.yahoo.com>
References: <1341389386.5657.YahooMailNeo@web140904.mail.bf1.yahoo.com>
	<CAG5-hcMDzStCrHp0GpZNZTZfVHZ7+2xDuytSsnZnZmCgpA3Lsw@mail.gmail.com>
Reply-To: somanath sahoo <bapi_mvit2004@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1194062824=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm31-vm7.bullet.mail.bf1.yahoo.com ([72.30.239.15])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <bapi_mvit2004@yahoo.com>) id 1Smesf-0001tz-CJ
	for lttng-dev@lists.lttng.org; Thu, 05 Jul 2012 01:45:33 -0400
In-Reply-To: <CAG5-hcMDzStCrHp0GpZNZTZfVHZ7+2xDuytSsnZnZmCgpA3Lsw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bernd Hufmann <bhufmann@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1194062824==
Content-Type: multipart/alternative; boundary="661806066-272006107-1341467127=:80260"

--661806066-272006107-1341467127=:80260
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Bernd,=0A=0AThanks for your response.=0AI did follow the procedure as yo=
u mentioned.=0A=0AStill the same problem is persistent. =0A=0A=0Aafter the =
eclipse failed in "lttng list -k" ,=A0 i did=A0 "ps -ef | grep lttng " in m=
y remote host (ubuntu 12.04). Log is provided below=0A=0A=0A---=0Aroot=A0=
=A0=A0=A0=A0=A0 558=A0=A0=A0=A0 1=A0 0 10:31 ?=A0=A0=A0=A0=A0=A0=A0 00:00:0=
0 lttng-sessiond=0Asomanath=A0 2949=A0=A0=A0=A0 1=A0 4 10:49 ?=A0=A0=A0=A0=
=A0=A0=A0 00:00:30 /home/somanath/lttng_som/eclipse/eclipse=0Asomanath=A0 3=
242=A0=A0=A0=A0 1=A0 0 10:50 ?=A0=A0=A0=A0=A0=A0=A0 00:00:00 lttng-sessiond=
 --sig-parent --quiet=0Asomanath=A0 3539=A0 3251=A0 0 11:00 pts/3=A0=A0=A0 =
00:00:00 grep --color=3Dauto lttng=0A---=0A=0Abut i am able to execute all =
the lttng features in the remote host successfully. i don't know why eclips=
e is not able to do that.=0A=0AHowever i want to know how to make sure my u=
ser id present in the tracing group ? is there any command to list or inclu=
de the users into the "tracing" group ? please enlightened on this.=0A=0AKi=
ndly let me know whether i need to follow something else to resolve this ec=
lipse tracing control problem.=0A=0AThanks for your need-fullness.=0A=0A=0A=
Best Regards,=0ASomanath=0A=0A=0A=0A=0A________________________________=0A =
From: Bernd Hufmann <bhufmann@gmail.com>=0ATo: somanath sahoo <bapi_mvit200=
4@yahoo.com> =0ACc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>=
 =0ASent: Wednesday, July 4, 2012 6:18 PM=0ASubject: Re: [lttng-dev] lttng_=
2.0-eclipse-juno : Connection to a Remote Host : Unable to list kernel even=
ts=0A =0A=0A=0A=0A=0A=0AHi,=0Ato be able to trace the kernel the global ses=
sion daemon has to be running, that means it has to be running as root. To =
start the global session daemon login to your node and then execute sudo lt=
tng list -k=0AThen you are able to trace the kernel and UST using your user=
 login. However you have to make sure that your user id is part of the user=
 group tracing.=0AOnce this is setup the tracer control with Eclipse should=
 work, too.=0ABest Regards=0ABernd=0AOn 2012-07-04 4:10 AM, "somanath sahoo=
" <bapi_mvit2004@yahoo.com> wrote:=0A=0AHi,=0A>=0A>=0A>I am running eclipse=
 c/c++ juno in ubuntu 12.04 which is running inside VirtualboxVM. =0A>=0A>=
=0A>=0A>=0A>=0A>Issue : Tree node of remote host is not being created in th=
e cotrol view panel of eclipse while i am successfully connected to remote =
host (in this case my ubuntu 12.04). =0A>=0A>=0A>=0A>I am to trying use "lt=
tng tracer control" feature of eclipse juno by following this link -- http:=
//wiki.eclipse.org/index.php/Linux_Tools_Project/LTTng2/User_Guide#LTTng_Tr=
acer_Control=0A>=0A>=0A>Error description : when eclipse is successfully co=
nnected to remote host, then eclipse is trying to run "lttng list -k" to li=
sting the kernel event and its getting failed.=0A>=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 But whereas i am able to=
 run lttng commands in my remote host (in ubuntu 12.04) successfully.=0A>=
=0A>=0A>The error message from eclipse is provided below - =0A>=0A>=0A>=0A>=
----=0A>=0A>List sessions failed=0A>Command failed! Command:=A0 lttng list =
-k=0A>Return Value: 79=0A>Error: Unable to list kernel events=0A>=0A>=0A>--=
----=0A>=0A>I have attached screenshot of this error. please find the attac=
hment.=0A>=0A>=0A>Please guide me to resolve this problem.=0A>=0A>=0A>=0A>=
=0A>Thanks & Regards,=0A>Somanath=0A>=0A>__________________________________=
_____________=0A>lttng-dev mailing list=0A>lttng-dev@lists.lttng.org=0A>htt=
p://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev=0A>=0A>
--661806066-272006107-1341467127=:80260
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span>Hi Bernd,<=
/span></div><div><br><span></span></div><div><span>Thanks for your <span id=
=3D"misspell-1" class=3D""><span>response</span></span>.</span></div><div><=
span>I did <span id=3D"misspell-2" class=3D""><span>follow</span></span> th=
e <span id=3D"misspell-3" class=3D"">procedure</span> as you mentioned.</sp=
an></div><div><br><span></span></div><div>Still the same problem is <span s=
tyle=3D"font-weight: bold;">persistent. </span><br></div><div><br></div><di=
v>after the eclipse failed in "lttng list -k" ,&nbsp; i did&nbsp; "ps -ef |=
 grep lttng " in my <span id=3D"misspell-4" class=3D"">remote</span> host (=
<span id=3D"misspell-4" class=3D"mark">ubuntu</span> 12.04). Log is provide=
d below<br></div><div><br></div><div>---</div><div>root&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 558&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0 10:31
 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:00:00 lttng-<span id=3D"mis=
spell-6" class=3D"mark">sessiond</span><br>somanath&nbsp; 2949&nbsp;&nbsp;&=
nbsp;&nbsp; 1&nbsp; 4 10:49 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:=
00:30 /home/somanath/lttng_<span id=3D"misspell-10" class=3D"mark">som</spa=
n>/eclipse/eclipse<br>somanath&nbsp; 3242&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; 0=
 10:50 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:00:00 lttng-<span id=
=3D"misspell-13" class=3D"mark">sessiond</span> --<span id=3D"misspell-14" =
class=3D"mark">sig</span>-parent --quiet<br>somanath&nbsp; 3539&nbsp; 3251&=
nbsp; 0 11:00 <span id=3D"misspell-16" class=3D"mark">pts</span>/3&nbsp;&nb=
sp;&nbsp; 00:00:00 grep --color=3Dauto lttng<br>---<br><span></span></div><=
div>but i am able to execute all the lttng features in the remote host succ=
essfully. i <span id=3D"misspell-20" class=3D""><span>don't</span></span> k=
now why eclipse is not able to do that.</div><div><br></div><div>However i =
want to know how to
 make sure my user id present in the tracing group ? is there any command t=
o list or include the users into the "tracing" group ? please <span id=3D"m=
isspell-19" class=3D""><span>enlightened</span></span> on this.</div><div><=
br></div><div>Kindly let me know whether i need to follow something else to=
 resolve this eclipse tracing control problem.</div><div><br></div><div>Tha=
nks for your <span id=3D"misspell-19" class=3D""><span>need-fullness</span>=
</span>.<br></div><div><br></div><div>Best Regards,<br>Somanath<br><span></=
span></div><div><span><br></span></div><div><br></div>  <div style=3D"font-=
family: times new roman, new york, times, serif; font-size: 12pt;"> <div st=
yle=3D"font-family: times new roman, new york, times, serif; font-size: 12p=
t;"> <div dir=3D"ltr"> <font face=3D"Arial" size=3D"2"> <hr size=3D"1">  <b=
><span style=3D"font-weight:bold;">From:</span></b> Bernd Hufmann &lt;bhufm=
ann@gmail.com&gt;<br> <b><span style=3D"font-weight: bold;">To:</span></b> =
somanath sahoo
 &lt;bapi_mvit2004@yahoo.com&gt; <br><b><span style=3D"font-weight: bold;">=
Cc:</span></b> "lttng-dev@lists.lttng.org" &lt;lttng-dev@lists.lttng.org&gt=
; <br> <b><span style=3D"font-weight: bold;">Sent:</span></b> Wednesday, Ju=
ly 4, 2012 6:18 PM<br> <b><span style=3D"font-weight: bold;">Subject:</span=
></b> Re: [lttng-dev] lttng_2.0-eclipse-<span id=3D"misspell-28" class=3D"m=
ark">juno</span> : Connection to a Remote Host : Unable to list kernel even=
ts<br> </font> <span></span><span></span><span></span><span></span></div> <=
br>=0A<div id=3D"yiv884360242"><div>Hi,<br>=0Ato be able to trace the kerne=
l the global session daemon has to be running, that means it has to be runn=
ing as root. To start the global session daemon <span id=3D"misspell-29" cl=
ass=3D"mark">login</span> to your node and then execute <span id=3D"misspel=
l-30" class=3D"mark">sudo</span> lttng list -k<br>=0AThen you are able to t=
race the kernel and <span id=3D"misspell-32" class=3D"mark">UST</span> usin=
g your user <span id=3D"misspell-33" class=3D"mark">login</span>. However y=
ou have to make sure that your user id is part of the user group tracing.<b=
r>=0AOnce this is setup the tracer control with Eclipse should work, too.</=
div>=0A<div>Best Regards<br>=0ABernd</div>=0A<div class=3D"yiv884360242gmai=
l_quote">On 2012-07-04 4:10 AM, "somanath sahoo" &lt;<a rel=3D"nofollow" ym=
ailto=3D"mailto:bapi_mvit2004@yahoo.com" target=3D"_blank" href=3D"mailto:b=
api_mvit2004@yahoo.com">bapi_mvit2004@yahoo.com</a>&gt; wrote:<br><blockquo=
te class=3D"yiv884360242gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex;">=0A<div><div style=3D"font-size:12pt;fon=
t-family:times new roman, new york, times, serif;"><div>Hi,</div><div><br><=
/div><div>I am running eclipse c/c++ <span id=3D"misspell-37" class=3D"mark=
">juno</span> in <span id=3D"misspell-38" class=3D"mark">ubuntu</span> 12.0=
4 which is running inside <span id=3D"misspell-39" class=3D"mark">Virtualbo=
x</span> <span id=3D"misspell-40" class=3D"mark">VM</span>. <br></div><div>=
<br>=0A</div><div><br></div><div>Issue : Tree node of remote host is not be=
ing created in the <span id=3D"misspell-41" class=3D"mark">cotrol</span> vi=
ew panel of eclipse while i am successfully connected to remote host (in th=
is case my <span id=3D"misspell-42" class=3D"mark">ubuntu</span> 12.04). <b=
r></div><div><br></div>=0A<div>I am to trying use "<span style=3D"font-weig=
ht:bold;">lttng tracer control" </span><span>feature of eclipse <span id=3D=
"misspell-44" class=3D"mark">juno</span> by following this link -- <span st=
yle=3D"font-weight:bold;">http://wiki.eclipse.org/index.php/Linux_Tools_Pro=
ject/LTTng2/User_Guide#LTTng_Tracer_Control</span></span></div>=0A<div><spa=
n><br> </span></div><div>Error description : when eclipse is successfully c=
onnected to remote host, then eclipse is trying to run "lttng list -k" to l=
isting the kernel event and its=0A getting failed.</div><div><span>&nbsp;&n=
bsp;&nbsp; </span><span>&nbsp;&nbsp;&nbsp; </span><span>&nbsp;&nbsp;&nbsp; =
</span><span>&nbsp;&nbsp;&nbsp; </span><span>&nbsp;&nbsp;&nbsp; </span><spa=
n>&nbsp;&nbsp;&nbsp; </span><span>&nbsp;&nbsp;&nbsp; </span><span>&nbsp; </=
span>But whereas i am able to run lttng commands in my remote host (in <spa=
n id=3D"misspell-47" class=3D"mark">ubuntu</span> 12.04) successfully.</div=
>=0A<div><br></div><div>The error message from eclipse is provided below - =
<br></div><div><br></div><div>----<br></div><div>List sessions failed<br>Co=
mmand failed! Command:&nbsp; lttng list -k<br>Return Value: 79<br>Error: Un=
able to list kernel events</div>=0A<div><br></div><div>------<br></div><div=
>I have attached <span style=3D"font-weight:bold;"><span id=3D"misspell-49"=
 class=3D"mark">screenshot</span> of this error</span>. please find the att=
achment.</div><div><br></div><div>Please guide me to resolve this=0A proble=
m.</div><div><br></div><div><br></div><div>Thanks &amp; Regards,<br>Somanat=
h<br></div></div></div><br>_______________________________________________<=
br>=0Alttng-dev mailing list<br>=0A<a rel=3D"nofollow" ymailto=3D"mailto:lt=
tng-dev@lists.lttng.org" target=3D"_blank" href=3D"mailto:lttng-dev@lists.l=
ttng.org">lttng-dev@lists.lttng.org</a><br>=0Ahttp://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev<br>=0A<br></blockquote></div>=0A</div><br><br>=
 </div> </div>  </div></body></html>
--661806066-272006107-1341467127=:80260--


--===============1194062824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1194062824==--
