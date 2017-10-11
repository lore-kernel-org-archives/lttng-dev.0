From: MMM via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Problem in finding Jar file of LTTng for adding to
 Java project
Date: Wed, 11 Oct 2017 22:05:58 +0000 (UTC)
Message-ID: <850230324.98540.1507759558449__33942.1778372072$1507759598$gmane$org@mail.yahoo.com>
References: <797428900.3787919.1507493725940.ref@mail.yahoo.com>
 <797428900.3787919.1507493725940@mail.yahoo.com>
 <CAB4xu_26Qmpzf-mccjY3HutmFBBLdEEDAxx5_WLdxdFARSzgNA@mail.gmail.com>
 <776772327.5312865.1507666332238@mail.yahoo.com>
 <37f91596-023e-f552-b07f-3b4e073399cd@voxpopuli.im>
Reply-To: MMM <e.morovati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0503013346334183957=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic308-11.consmr.mail.ne1.yahoo.com
 (sonic308-11.consmr.mail.ne1.yahoo.com [66.163.187.34])
 by lists.lttng.org (Postfix) with ESMTP id 3yC7Nh45HwzyWs
 for <lttng-dev@lists.lttng.org>; Wed, 11 Oct 2017 22:06:28 +0000 (UTC)
In-Reply-To: <37f91596-023e-f552-b07f-3b4e073399cd@voxpopuli.im>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0503013346334183957==
Content-Type: multipart/alternative;
	boundary="----=_Part_98539_1132719898.1507759558446"

------=_Part_98539_1132719898.1507759558446
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Dear Alex,
Thanks for your attention. I executed your commands step by step. While, ag=
ain I received previous errors which are=C2=A0
[error] Cannot open any trace for reading.[error] opening trace "[path]/ltt=
ng-traces/auto-20171011-145947" for reading.
[error] none of the specified trace paths could be opened.

I do not know the reason of this problem. Could you please help me to resol=
ve it?
Regards,Mehdi.



    On Wednesday, October 11, 2017, 6:09:41 PM GMT+3:30, Alexandre Montplai=
sir <alexmonthy@voxpopuli.im> wrote: =20
=20
 Hi,

I tried compiling and running your program, and it runs fine on my end.
Here is what I did:

saved the snippet below to "Hello.java"
$ apt install liblttng-ust-agent-java
$ javac -cp /usr/share/java/lttng-ust-agent-jul.jar Hello.java

$ lttng create
$ lttng enable-event -a -j
$ lttng start
$ java -cp /usr/share/java/lttng-ust-agent-jul.jar:. Hello
$ lttng stop
$ lttng view

and I get the following output:
Trace directory: /home/alexandre/lttng-traces/auto-20171011-102431

[10:24:49.326824061] (+?.?????????) calista lttng_jul:event: { cpu_id =3D
2 }, { msg =3D "Hello World, the answer is 42", logger_name =3D "hello",
class_name =3D "Hello", method_name =3D "main", long_millis =3D 15077318892=
99,
int_loglevel =3D 800, int_threadid =3D 1 }


Make sure you are setting the -classpath/-cp option correctly, this
could explain the "unknown package" error you were getting.

Also note that you are using the deprecated "LTTngAgent.getLTTngAgent()"
API (the "javac" command should warn about it). It should still work,
but it's highly recommended to use the new API, as described in
https://lttng.org/docs/v2.10/#doc-jul . Basically you have to
instantiate an "LttngLogHandler", and attach it to your Logger.

HTH,
Alex


On 2017-10-10 04:12 PM, MMM via lttng-dev wrote:
> Dear Philippe,
>
> Thanks a lot for your consideration. I solved former problem. While, I
> faced with a new problem. Indeed, when I create a LTTng session, start
> it and finally stop LTTng, I could not find trace files in mentioned
> folder. My java code is=C2=A0
>
> ///////////////////////////////////////
> import java.io.IOException;
> import java.util.logging.Handler;
> import java.util.logging.Logger;
>
> import org.lttng.ust.agent.LTTngAgent;
> import org.lttng.ust.agent.jul.LttngLogHandler;
>
> public class Hello {
> private static final int answer =3D 42;
> private static LTTngAgent lttngAgent;
>
> public static void main(String[] args) throws InterruptedException {
> Logger helloLog =3D Logger.getLogger("hello");
> lttngAgent =3D LTTngAgent.getLTTngAgent();
>
> Thread.sleep(5000);
> helloLog.info("Hello World, the answer is " + answer);
> lttngAgent.dispose();
> }
>
> }
> ///////////////////////
>
> Also, I used following LTTng commands.=C2=A0
>
> ////////////////////////////////
> lttng create java-test
> lttng enable-event -a -l
> lttng start
> ///Start My java Application///
> lttng stop
> ////////////////////////////
>
> Besides, when I used "lttng view" after stopping LTTng, I received
> following error message
>
> [error] Cannot open any trace for reading.
> [error] opening trace
> "/[path]/lttng-traces/java-test10-20171010-130909" for reading.
> [error] none of the specified trace paths could be opened.
>
> Could you please help me to resolve it.
>
> Regards,
> Mehdi.
>
>
>
>
>
>
> On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx
> <eeppeliteloop@gmail.com> wrote:
>
>
> On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev
> <lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>> wrote:
> > Dear Users,
> >
> > I am beginner in tracing using LTTng. At present, I am going to
> trace a java
> > program in=C2=A0 Ubuntu, while I faced with a problem. When I install
> LTTng on
> > Ubuntu, I also install
> >
> > "liblttng-ust-agent-java" by "apt-get install liblttng-ust-agent-java"
> > command in Ubuntu. But, when I want to import any libraries related
> to LTTng
> > such as
> "org.lttng.ust.agent.jul.LttngLogHandlerorg.lttng.ust.LTTngAgent" to
> > my program, it is marked as unknown package. Indeed, I could not
> find LTTng
> > Jar file for adding it to my program libraries. Furthermore, I
> searched in
> > all files and folders, while I could not find Jar file. Could you pleas=
e
> > help me to understand the cause of this problem and solve it.
>
> I'm not a Ubuntu specialist, but from
> <https://packages.ubuntu.com/zesty/all/liblttng-ust-agent-java/filelist>,
> I would say:
>
> * /usr/share/java/lttng-ust-agent-jul.jar
> * /usr/share/java/lttng-ust-agent-log4j.jar
>
> On 16.04, it's:
>
> * /usr/share/java/liblttng-ust-agent.jar
>
> Add the required JAR file to your classpath.
>
> Have a look at <http://lttng.org/docs/v2.9/#doc-java-application>.
>
> Phil
>
>
> >
> >
> > Best regards,
> >
> > Mehdi.
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


------=_Part_98539_1132719898.1507759558446
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:courier new, courier, mo=
naco, monospace, sans-serif;font-size:13px;"><div></div>
            <div>Dear Alex,</div><div><br></div><div>Thanks for your attent=
ion. I executed your commands step by step. While, again I received previou=
s errors which are&nbsp;</div><div><br></div><div><div>[error] Cannot open =
any trace for reading.</div><div>[error] opening trace "[path]/lttng-traces=
/auto-20171011-145947" for reading.<br></div><div>[error] none of the speci=
fied trace paths could be opened.<br></div><div><br></div><div>I do not kno=
w the reason of this problem. Could you please help me to resolve it?</div>=
<div><br></div><div>Regards,</div><div>Mehdi.</div><div><br></div><div><br>=
</div><br></div><div><br></div>
           =20
            <div id=3D"yahoo_quoted_8456331675" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On Wednesday, October 11, 2017, 6:09:41 PM GMT+3:30=
, Alexandre Montplaisir &lt;alexmonthy@voxpopuli.im&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D'ltr'><html><body>Hi,<br clear=3D"none"=
><br clear=3D"none">I tried compiling and running your program, and it runs=
 fine on my end.<br clear=3D"none">Here is what I did:<br clear=3D"none"><b=
r clear=3D"none">saved the snippet below to &quot;Hello.java&quot;<br clear=
=3D"none">$ apt install liblttng-ust-agent-java<br clear=3D"none">$ javac -=
cp /usr/share/java/lttng-ust-agent-jul.jar Hello.java<br clear=3D"none"><br=
 clear=3D"none">$ lttng create<br clear=3D"none">$ lttng enable-event -a -j=
<br clear=3D"none">$ lttng start<br clear=3D"none">$ java -cp /usr/share/ja=
va/lttng-ust-agent-jul.jar:. Hello<br clear=3D"none">$ lttng stop<br clear=
=3D"none">$ lttng view<br clear=3D"none"><br clear=3D"none">and I get the f=
ollowing output:<br clear=3D"none">Trace directory: /home/alexandre/lttng-t=
races/auto-20171011-102431<br clear=3D"none"><br clear=3D"none">[10:24:49.3=
26824061] (+?.?????????) calista lttng_jul:event: { cpu_id =3D<br clear=3D"=
none">2 }, { msg =3D &quot;Hello World, the answer is 42&quot;, logger_name=
 =3D &quot;hello&quot;,<br clear=3D"none">class_name =3D &quot;Hello&quot;,=
 method_name =3D &quot;main&quot;, long_millis =3D 1507731889299,<br clear=
=3D"none">int_loglevel =3D 800, int_threadid =3D 1 }<br clear=3D"none"><br =
clear=3D"none"><br clear=3D"none">Make sure you are setting the -classpath/=
-cp option correctly, this<br clear=3D"none">could explain the &quot;unknow=
n package&quot; error you were getting.<br clear=3D"none"><br clear=3D"none=
">Also note that you are using the deprecated &quot;LTTngAgent.getLTTngAgen=
t()&quot;<br clear=3D"none">API (the &quot;javac&quot; command should warn =
about it). It should still work,<br clear=3D"none">but it&#39;s highly reco=
mmended to use the new API, as described in<br clear=3D"none"><a shape=3D"r=
ect" href=3D"https://lttng.org/docs/v2.10/#doc-jul " target=3D"_blank">http=
s://lttng.org/docs/v2.10/#doc-jul </a>. Basically you have to<br clear=3D"n=
one">instantiate an &quot;LttngLogHandler&quot;, and attach it to your Logg=
er.<br clear=3D"none"><br clear=3D"none">HTH,<br clear=3D"none">Alex<br cle=
ar=3D"none"><br clear=3D"none"><br clear=3D"none">On 2017-10-10 04:12 PM, M=
MM via lttng-dev wrote:<br clear=3D"none">&gt; Dear Philippe,<br clear=3D"n=
one">&gt;<br clear=3D"none">&gt; Thanks a lot for your consideration. I sol=
ved former problem. While, I<br clear=3D"none">&gt; faced with a new proble=
m. Indeed, when I create a LTTng session, start<br clear=3D"none">&gt; it a=
nd finally stop LTTng, I could not find trace files in mentioned<br clear=
=3D"none">&gt; folder. My java code is=C2=A0<br clear=3D"none">&gt;<br clea=
r=3D"none">&gt; ///////////////////////////////////////<br clear=3D"none">&=
gt; import java.io.IOException;<br clear=3D"none">&gt; import java.util.log=
ging.Handler;<br clear=3D"none">&gt; import java.util.logging.Logger;<br cl=
ear=3D"none">&gt;<br clear=3D"none">&gt; import org.lttng.ust.agent.LTTngAg=
ent;<br clear=3D"none">&gt; import org.lttng.ust.agent.jul.LttngLogHandler;=
<br clear=3D"none">&gt;<br clear=3D"none">&gt; public class Hello {<br clea=
r=3D"none">&gt; private static final int answer =3D 42;<br clear=3D"none">&=
gt; private static LTTngAgent lttngAgent;<br clear=3D"none">&gt;<br clear=
=3D"none">&gt; public static void main(String[] args) throws InterruptedExc=
eption {<br clear=3D"none">&gt; Logger helloLog =3D Logger.getLogger(&quot;=
hello&quot;);<br clear=3D"none">&gt; lttngAgent =3D LTTngAgent.getLTTngAgen=
t();<br clear=3D"none">&gt;<br clear=3D"none">&gt; Thread.sleep(5000);<br c=
lear=3D"none">&gt; helloLog.info(&quot;Hello World, the answer is &quot; + =
answer);<br clear=3D"none">&gt; lttngAgent.dispose();<br clear=3D"none">&gt=
; }<br clear=3D"none">&gt;<br clear=3D"none">&gt; }<br clear=3D"none">&gt; =
///////////////////////<br clear=3D"none">&gt;<br clear=3D"none">&gt; Also,=
 I used following LTTng commands.=C2=A0<br clear=3D"none">&gt;<br clear=3D"=
none">&gt; ////////////////////////////////<br clear=3D"none">&gt; lttng cr=
eate java-test<br clear=3D"none">&gt; lttng enable-event -a -l<br clear=3D"=
none">&gt; lttng start<br clear=3D"none">&gt; ///Start My java Application/=
//<br clear=3D"none">&gt; lttng stop<br clear=3D"none">&gt; ///////////////=
/////////////<br clear=3D"none">&gt;<br clear=3D"none">&gt; Besides, when I=
 used &quot;lttng view&quot; after stopping LTTng, I received<br clear=3D"n=
one">&gt; following error message<br clear=3D"none">&gt;<br clear=3D"none">=
&gt; [error] Cannot open any trace for reading.<br clear=3D"none">&gt; [err=
or] opening trace<br clear=3D"none">&gt; &quot;/[path]/lttng-traces/java-te=
st10-20171010-130909&quot; for reading.<br clear=3D"none">&gt; [error] none=
 of the specified trace paths could be opened.<br clear=3D"none">&gt;<br cl=
ear=3D"none">&gt; Could you please help me to resolve it.<br clear=3D"none"=
>&gt;<br clear=3D"none">&gt; Regards,<br clear=3D"none">&gt; Mehdi.<br clea=
r=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"n=
one">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&=
gt; On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx<br cle=
ar=3D"none">&gt; &lt;<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmai=
l.com" href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&=
gt; wrote:<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">=
&gt; On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev<br clear=3D"none">&g=
t; &lt;<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=
=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mai=
lto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"=
mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt;&gt; wro=
te:<br clear=3D"none">&gt; &gt; Dear Users,<br clear=3D"none">&gt; &gt;<br =
clear=3D"none">&gt; &gt; I am beginner in tracing using LTTng. At present, =
I am going to<br clear=3D"none">&gt; trace a java<br clear=3D"none">&gt; &g=
t; program in=C2=A0 Ubuntu, while I faced with a problem. When I install<br=
 clear=3D"none">&gt; LTTng on<br clear=3D"none">&gt; &gt; Ubuntu, I also in=
stall<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; &quot;liblttn=
g-ust-agent-java&quot; by &quot;apt-get install liblttng-ust-agent-java&quo=
t;<br clear=3D"none">&gt; &gt; command in Ubuntu. But, when I want to impor=
t any libraries related<br clear=3D"none">&gt; to LTTng<br clear=3D"none">&=
gt; &gt; such as<br clear=3D"none">&gt; &quot;org.lttng.ust.agent.jul.Lttng=
LogHandlerorg.lttng.ust.LTTngAgent&quot; to<br clear=3D"none">&gt; &gt; my =
program, it is marked as unknown package. Indeed, I could not<br clear=3D"n=
one">&gt; find LTTng<br clear=3D"none">&gt; &gt; Jar file for adding it to =
my program libraries. Furthermore, I<br clear=3D"none">&gt; searched in<br =
clear=3D"none">&gt; &gt; all files and folders, while I could not find Jar =
file. Could you please<br clear=3D"none">&gt; &gt; help me to understand th=
e cause of this problem and solve it.<br clear=3D"none">&gt;<br clear=3D"no=
ne">&gt; I&#39;m not a Ubuntu specialist, but from<br clear=3D"none">&gt; &=
lt;<a shape=3D"rect" href=3D"https://packages.ubuntu.com/zesty/all/liblttng=
-ust-agent-java/filelist" target=3D"_blank">https://packages.ubuntu.com/zes=
ty/all/liblttng-ust-agent-java/filelist</a>&gt;,<br clear=3D"none">&gt; I w=
ould say:<br clear=3D"none">&gt;<br clear=3D"none">&gt; * /usr/share/java/l=
ttng-ust-agent-jul.jar<br clear=3D"none">&gt; * /usr/share/java/lttng-ust-a=
gent-log4j.jar<br clear=3D"none">&gt;<br clear=3D"none">&gt; On 16.04, it&#=
39;s:<br clear=3D"none">&gt;<br clear=3D"none">&gt; * /usr/share/java/liblt=
tng-ust-agent.jar<br clear=3D"none">&gt;<br clear=3D"none">&gt; Add the req=
uired JAR file to your classpath.<br clear=3D"none">&gt;<br clear=3D"none">=
&gt; Have a look at &lt;<a shape=3D"rect" href=3D"http://lttng.org/docs/v2.=
9/#doc-java-application" target=3D"_blank">http://lttng.org/docs/v2.9/#doc-=
java-application</a>&gt;.<br clear=3D"none">&gt;<br clear=3D"none">&gt; Phi=
l<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; &gt;=
<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; Best regards,<br c=
lear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; Mehdi.<br clear=3D"none=
">&gt; &gt;<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; _______=
________________________________________<br clear=3D"none">&gt; &gt; lttng-=
dev mailing list<br clear=3D"none">&gt; &gt; <a shape=3D"rect" ymailto=3D"m=
ailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">=
lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailt=
o:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttn=
g-dev@lists.lttng.org</a>&gt;<div class=3D"yqt1528194731" id=3D"yqtfd47239"=
><br clear=3D"none">&gt; &gt; <a shape=3D"rect" href=3D"https://lists.lttng=
.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br clear=3D"none">&gt; &gt;<=
br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; ______=
_________________________________________<br clear=3D"none">&gt; lttng-dev =
mailing list<br clear=3D"none">&gt; <a shape=3D"rect" ymailto=3D"mailto:ltt=
ng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev=
@lists.lttng.org</a><br clear=3D"none">&gt; <a shape=3D"rect" href=3D"https=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">ht=
tps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br clear=3D"no=
ne"><br clear=3D"none"></div></body></html></div></div>
                </div>
            </div></div></body></html>
------=_Part_98539_1132719898.1507759558446--

--===============0503013346334183957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0503013346334183957==--
