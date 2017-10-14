From: MMM via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Problem in finding Jar file of LTTng for adding to
 Java project
Date: Sat, 14 Oct 2017 22:18:33 +0000 (UTC)
Message-ID: <670458818.2469.1508019513394__5671.81226001612$1508020776$gmane$org@mail.yahoo.com>
References: <797428900.3787919.1507493725940.ref@mail.yahoo.com>
 <797428900.3787919.1507493725940@mail.yahoo.com>
 <CAB4xu_26Qmpzf-mccjY3HutmFBBLdEEDAxx5_WLdxdFARSzgNA@mail.gmail.com>
 <776772327.5312865.1507666332238@mail.yahoo.com>
 <37f91596-023e-f552-b07f-3b4e073399cd@voxpopuli.im>
 <850230324.98540.1507759558449@mail.yahoo.com>
 <415c1e82-6532-d4a8-c443-8263a1a3cc91@voxpopuli.im>
 <1302171483.738271.1507837087778@mail.yahoo.com>
 <5e5cbef3-794c-e4e1-8a02-bca432153031@voxpopuli.im>
Reply-To: MMM <e.morovati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5531734937214054176=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic306-22.consmr.mail.ne1.yahoo.com
 (sonic306-22.consmr.mail.ne1.yahoo.com [66.163.189.84])
 by lists.lttng.org (Postfix) with ESMTP id 3yDzzF21Xlz10n5
 for <lttng-dev@lists.lttng.org>; Sat, 14 Oct 2017 22:39:20 +0000 (UTC)
In-Reply-To: <5e5cbef3-794c-e4e1-8a02-bca432153031@voxpopuli.im>
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

--===============5531734937214054176==
Content-Type: multipart/alternative;
	boundary="----=_Part_2468_1779604036.1508019513391"

------=_Part_2468_1779604036.1508019513391
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 I installed LTTng from source at first. While after that, I also reinstall=
 it from PPA. Is it the cause of my problem?    On Friday, October 13, 2017=
, 11:57:33 PM GMT+3:30, Alexandre Montplaisir <alexmonthy@voxpopuli.im> wro=
te: =20
=20
 On 2017-10-12 03:38 PM, MMM wrote:
> Dear Alex,
>
> As I mentioned, I used sample examples. for instance, I used mentioned
> simple program that you told tracing it return some result. While, I
> can not receive any result from tracing it. Also, I use Ubuntu 16.04
> LTS and lttng 2.9.5. Besides, the output of asked command is=C2=A0
>
> //////////////////
> -rw-r--r-- 1 root root 40871 Jun 16 13:56
> /usr/share/java/lttng-ust-agent-common-2.9.1.jar
> lrwxrwxrwx 1 root root=C2=A0 =C2=A0 32 Jun 16 13:56
> /usr/share/java/lttng-ust-agent-common.jar ->
> lttng-ust-agent-common-2.9.1.jar
> -rw-r--r-- 1 root root=C2=A0 4369 Jun 16 13:56
> /usr/share/java/lttng-ust-agent-jul-2.9.1.jar
> lrwxrwxrwx 1 root root=C2=A0 =C2=A0 29 Jun 16 13:56
> /usr/share/java/lttng-ust-agent-jul.jar -> lttng-ust-agent-jul-2.9.1.jar
> -rw-r--r-- 1 root root=C2=A0 3933 Jun 16 13:56
> /usr/share/java/lttng-ust-agent-log4j-2.9.1.jar
> lrwxrwxrwx 1 root root=C2=A0 =C2=A0 31 Jun 16 13:56
> /usr/share/java/lttng-ust-agent-log4j.jar ->
> lttng-ust-agent-log4j-2.9.1.jar
> ////////////////////////////

Everything seems to be in order here.

I will try your exact same environment to see if I can reproduce the issue.
How did you install your LTTng 2.9? Was it from source, or from a PPA?
The Ubuntu 16.04 main archive only has 2.7.*

Cheers,
Alex

>
> Thanks for your attention.
> Regards,
> Mehdi.
>
> On Thursday, October 12, 2017, 6:51:12 PM GMT+3:30, Alexandre
> Montplaisir <alexmonthy@voxpopuli.im> wrote:
>
>
>
>
> On 2017-10-11 06:05 PM, MMM wrote:
> > Dear Alex,
> >
> > Thanks for your attention. I executed your commands step by step.
> > While, again I received previous errors which are=C2=A0
> >
> > [error] Cannot open any trace for reading.
> > [error] opening trace "[path]/lttng-traces/auto-20171011-145947" for
> > reading.
> > [error] none of the specified trace paths could be opened.
> >
> > I do not know the reason of this problem. Could you please help me to
> > resolve it?
>
> As Philippe mentioned previously, this means the trace is empty, so no
> events were produced by the session.
>
> Did any of the other commands (java, javac, lttng create,...) output any
> error messages?
>
>
> Finally, it would help if you could specify:
> - What version of Ubuntu you are running
>
> - What version of LTTng you are running ("lttng --version")
>
> - The output of the following command:
> $ ls -l /usr/share/java/lttng-ust*
>
> Thanks,
> Alex
>
> >
> > Regards,
> > Mehdi.
> >
> >
> >
> >
> > On Wednesday, October 11, 2017, 6:09:41 PM GMT+3:30, Alexandre
> > Montplaisir <alexmonthy@voxpopuli.im
> <mailto:alexmonthy@voxpopuli.im>> wrote:
> >
> >
> > Hi,
> >
> > I tried compiling and running your program, and it runs fine on my end.
> > Here is what I did:
> >
> > saved the snippet below to "Hello.java"
> > $ apt install liblttng-ust-agent-java
> > $ javac -cp /usr/share/java/lttng-ust-agent-jul.jar Hello.java
> >
> > $ lttng create
> > $ lttng enable-event -a -j
> > $ lttng start
> > $ java -cp /usr/share/java/lttng-ust-agent-jul.jar:. Hello
> > $ lttng stop
> > $ lttng view
> >
> > and I get the following output:
> > Trace directory: /home/alexandre/lttng-traces/auto-20171011-102431
> >
> > [10:24:49.326824061] (+?.?????????) calista lttng_jul:event: { cpu_id =
=3D
> > 2 }, { msg =3D "Hello World, the answer is 42", logger_name =3D "hello"=
,
> > class_name =3D "Hello", method_name =3D "main", long_millis =3D 1507731=
889299,
> > int_loglevel =3D 800, int_threadid =3D 1 }
> >
> >
> > Make sure you are setting the -classpath/-cp option correctly, this
> > could explain the "unknown package" error you were getting.
> >
> > Also note that you are using the deprecated "LTTngAgent.getLTTngAgent()=
"
> > API (the "javac" command should warn about it). It should still work,
> > but it's highly recommended to use the new API, as described in
> > https://lttng.org/docs/v2.10/#doc-jul
> > <https://lttng.org/docs/v2.10/#doc-jul%20>. Basically you have to
> > instantiate an "LttngLogHandler", and attach it to your Logger.
> >
> > HTH,
> > Alex
> >
> >
> > On 2017-10-10 04:12 PM, MMM via lttng-dev wrote:
> > > Dear Philippe,
> > >
> > > Thanks a lot for your consideration. I solved former problem. While, =
I
> > > faced with a new problem. Indeed, when I create a LTTng session, star=
t
> > > it and finally stop LTTng, I could not find trace files in mentioned
> > > folder. My java code is=C2=A0
> > >
> > > ///////////////////////////////////////
> > > import java.io.IOException;
> > > import java.util.logging.Handler;
> > > import java.util.logging.Logger;
> > >
> > > import org.lttng.ust.agent.LTTngAgent;
> > > import org.lttng.ust.agent.jul.LttngLogHandler;
> > >
> > > public class Hello {
> > > private static final int answer =3D 42;
> > > private static LTTngAgent lttngAgent;
> > >
> > > public static void main(String[] args) throws InterruptedException {
> > > Logger helloLog =3D Logger.getLogger("hello");
> > > lttngAgent =3D LTTngAgent.getLTTngAgent();
> > >
> > > Thread.sleep(5000);
> > > helloLog.info("Hello World, the answer is " + answer);
> > > lttngAgent.dispose();
> > > }
> > >
> > > }
> > > ///////////////////////
> > >
> > > Also, I used following LTTng commands.=C2=A0
> > >
> > > ////////////////////////////////
> > > lttng create java-test
> > > lttng enable-event -a -l
> > > lttng start
> > > ///Start My java Application///
> > > lttng stop
> > > ////////////////////////////
> > >
> > > Besides, when I used "lttng view" after stopping LTTng, I received
> > > following error message
> > >
> > > [error] Cannot open any trace for reading.
> > > [error] opening trace
> > > "/[path]/lttng-traces/java-test10-20171010-130909" for reading.
> > > [error] none of the specified trace paths could be opened.
> > >
> > > Could you please help me to resolve it.
> > >
> > > Regards,
> > > Mehdi.
> > >
> > >
> > >
> > >
> > >
> > >
> > > On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx
> > > <eeppeliteloop@gmail.com <mailto:eeppeliteloop@gmail.com>
> <mailto:eeppeliteloop@gmail.com <mailto:eeppeliteloop@gmail.com>>> wrote:
> > >
> > >
> > > On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev
> > > <lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>
> > <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>>>
> > wrote:
> > > > Dear Users,
> > > >
> > > > I am beginner in tracing using LTTng. At present, I am going to
> > > trace a java
> > > > program in=C2=A0 Ubuntu, while I faced with a problem. When I insta=
ll
> > > LTTng on
> > > > Ubuntu, I also install
> > > >
> > > > "liblttng-ust-agent-java" by "apt-get install
> liblttng-ust-agent-java"
> > > > command in Ubuntu. But, when I want to import any libraries related
> > > to LTTng
> > > > such as
> > > "org.lttng.ust.agent.jul.LttngLogHandlerorg.lttng.ust.LTTngAgent" to
> > > > my program, it is marked as unknown package. Indeed, I could not
> > > find LTTng
> > > > Jar file for adding it to my program libraries. Furthermore, I
> > > searched in
> > > > all files and folders, while I could not find Jar file. Could you
> > please
> > > > help me to understand the cause of this problem and solve it.
> > >
> > > I'm not a Ubuntu specialist, but from
> > >
> >
> <https://packages.ubuntu.com/zesty/all/liblttng-ust-agent-java/filelist>,
> > > I would say:
> > >
> > > * /usr/share/java/lttng-ust-agent-jul.jar
> > > * /usr/share/java/lttng-ust-agent-log4j.jar
> > >
> > > On 16.04, it's:
> > >
> > > * /usr/share/java/liblttng-ust-agent.jar
> > >
> > > Add the required JAR file to your classpath.
> > >
> > > Have a look at <http://lttng.org/docs/v2.9/#doc-java-application>.
> > >
> > > Phil
> > >
> > >
> > > >
> > > >
> > > > Best regards,
> > > >
> > > > Mehdi.
> > > >
> > > >
> > > > _______________________________________________
> > > > lttng-dev mailing list
> > > > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>
> > <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>>
> >
> > > > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> > > >
> > >
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>
> > > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>


------=_Part_2468_1779604036.1508019513391
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:courier new, courier, mo=
naco, monospace, sans-serif;font-size:13px;"><div></div>
            <div>I installed LTTng from source at first. While after that, =
I also reinstall it from PPA. Is it the cause of my problem?</div>
           =20
            <div id=3D"yahoo_quoted_8221160477" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On Friday, October 13, 2017, 11:57:33 PM GMT+3:30, =
Alexandre Montplaisir &lt;alexmonthy@voxpopuli.im&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D'ltr'><html><body>On 2017-10-12 03:38 P=
M, MMM wrote:<br clear=3D"none">&gt; Dear Alex,<br clear=3D"none">&gt;<br c=
lear=3D"none">&gt; As I mentioned, I used sample examples. for instance, I =
used mentioned<br clear=3D"none">&gt; simple program that you told tracing =
it return some result. While, I<br clear=3D"none">&gt; can not receive any =
result from tracing it. Also, I use Ubuntu 16.04<br clear=3D"none">&gt; LTS=
 and lttng 2.9.5. Besides, the output of asked command is=C2=A0<br clear=3D=
"none">&gt;<br clear=3D"none">&gt; //////////////////<br clear=3D"none">&gt=
; -rw-r--r-- 1 root root 40871 Jun 16 13:56<br clear=3D"none">&gt; /usr/sha=
re/java/lttng-ust-agent-common-2.9.1.jar<br clear=3D"none">&gt; lrwxrwxrwx =
1 root root=C2=A0 =C2=A0 32 Jun 16 13:56<br clear=3D"none">&gt; /usr/share/=
java/lttng-ust-agent-common.jar -&gt;<br clear=3D"none">&gt; lttng-ust-agen=
t-common-2.9.1.jar<br clear=3D"none">&gt; -rw-r--r-- 1 root root=C2=A0 4369=
 Jun 16 13:56<br clear=3D"none">&gt; /usr/share/java/lttng-ust-agent-jul-2.=
9.1.jar<br clear=3D"none">&gt; lrwxrwxrwx 1 root root=C2=A0 =C2=A0 29 Jun 1=
6 13:56<br clear=3D"none">&gt; /usr/share/java/lttng-ust-agent-jul.jar -&gt=
; lttng-ust-agent-jul-2.9.1.jar<br clear=3D"none">&gt; -rw-r--r-- 1 root ro=
ot=C2=A0 3933 Jun 16 13:56<br clear=3D"none">&gt; /usr/share/java/lttng-ust=
-agent-log4j-2.9.1.jar<br clear=3D"none">&gt; lrwxrwxrwx 1 root root=C2=A0 =
=C2=A0 31 Jun 16 13:56<br clear=3D"none">&gt; /usr/share/java/lttng-ust-age=
nt-log4j.jar -&gt;<br clear=3D"none">&gt; lttng-ust-agent-log4j-2.9.1.jar<b=
r clear=3D"none">&gt; ////////////////////////////<br clear=3D"none"><br cl=
ear=3D"none">Everything seems to be in order here.<br clear=3D"none"><br cl=
ear=3D"none">I will try your exact same environment to see if I can reprodu=
ce the issue.<br clear=3D"none">How did you install your LTTng 2.9? Was it =
from source, or from a PPA?<br clear=3D"none">The Ubuntu 16.04 main archive=
 only has 2.7.*<br clear=3D"none"><br clear=3D"none">Cheers,<br clear=3D"no=
ne">Alex<br clear=3D"none"><br clear=3D"none">&gt;<br clear=3D"none">&gt; T=
hanks for your attention.<br clear=3D"none">&gt; Regards,<br clear=3D"none"=
>&gt; Mehdi.<br clear=3D"none">&gt;<br clear=3D"none">&gt; On Thursday, Oct=
ober 12, 2017, 6:51:12 PM GMT+3:30, Alexandre<br clear=3D"none">&gt; Montpl=
aisir &lt;<a shape=3D"rect" ymailto=3D"mailto:alexmonthy@voxpopuli.im" href=
=3D"mailto:alexmonthy@voxpopuli.im">alexmonthy@voxpopuli.im</a>&gt; wrote:<=
br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br cle=
ar=3D"none">&gt;<br clear=3D"none">&gt; On 2017-10-11 06:05 PM, MMM wrote:<=
br clear=3D"none">&gt; &gt; Dear Alex,<br clear=3D"none">&gt; &gt;<br clear=
=3D"none">&gt; &gt; Thanks for your attention. I executed your commands ste=
p by step.<br clear=3D"none">&gt; &gt; While, again I received previous err=
ors which are=C2=A0<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt;=
 [error] Cannot open any trace for reading.<br clear=3D"none">&gt; &gt; [er=
ror] opening trace &quot;[path]/lttng-traces/auto-20171011-145947&quot; for=
<br clear=3D"none">&gt; &gt; reading.<br clear=3D"none">&gt; &gt; [error] n=
one of the specified trace paths could be opened.<br clear=3D"none">&gt; &g=
t;<br clear=3D"none">&gt; &gt; I do not know the reason of this problem. Co=
uld you please help me to<br clear=3D"none">&gt; &gt; resolve it?<br clear=
=3D"none">&gt;<br clear=3D"none">&gt; As Philippe mentioned previously, thi=
s means the trace is empty, so no<br clear=3D"none">&gt; events were produc=
ed by the session.<br clear=3D"none">&gt;<br clear=3D"none">&gt; Did any of=
 the other commands (java, javac, lttng create,...) output any<br clear=3D"=
none">&gt; error messages?<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br=
 clear=3D"none">&gt; Finally, it would help if you could specify:<br clear=
=3D"none">&gt; - What version of Ubuntu you are running<br clear=3D"none">&=
gt;<br clear=3D"none">&gt; - What version of LTTng you are running (&quot;l=
ttng --version&quot;)<br clear=3D"none">&gt;<br clear=3D"none">&gt; - The o=
utput of the following command:<br clear=3D"none">&gt; $ ls -l /usr/share/j=
ava/lttng-ust*<br clear=3D"none">&gt;<br clear=3D"none">&gt; Thanks,<br cle=
ar=3D"none">&gt; Alex<br clear=3D"none">&gt;<br clear=3D"none">&gt; &gt;<br=
 clear=3D"none">&gt; &gt; Regards,<br clear=3D"none">&gt; &gt; Mehdi.<br cl=
ear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &=
gt;<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; On Wednesday, O=
ctober 11, 2017, 6:09:41 PM GMT+3:30, Alexandre<br clear=3D"none">&gt; &gt;=
 Montplaisir &lt;<a shape=3D"rect" ymailto=3D"mailto:alexmonthy@voxpopuli.i=
m" href=3D"mailto:alexmonthy@voxpopuli.im">alexmonthy@voxpopuli.im</a><br c=
lear=3D"none">&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:alexmonth=
y@voxpopuli.im" href=3D"mailto:alexmonthy@voxpopuli.im">alexmonthy@voxpopul=
i.im</a>&gt;&gt; wrote:<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; =
&gt;<br clear=3D"none">&gt; &gt; Hi,<br clear=3D"none">&gt; &gt;<br clear=
=3D"none">&gt; &gt; I tried compiling and running your program, and it runs=
 fine on my end.<br clear=3D"none">&gt; &gt; Here is what I did:<br clear=
=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; saved the snippet below to =
&quot;Hello.java&quot;<br clear=3D"none">&gt; &gt; $ apt install liblttng-u=
st-agent-java<br clear=3D"none">&gt; &gt; $ javac -cp /usr/share/java/lttng=
-ust-agent-jul.jar Hello.java<br clear=3D"none">&gt; &gt;<br clear=3D"none"=
>&gt; &gt; $ lttng create<br clear=3D"none">&gt; &gt; $ lttng enable-event =
-a -j<br clear=3D"none">&gt; &gt; $ lttng start<br clear=3D"none">&gt; &gt;=
 $ java -cp /usr/share/java/lttng-ust-agent-jul.jar:. Hello<br clear=3D"non=
e">&gt; &gt; $ lttng stop<br clear=3D"none">&gt; &gt; $ lttng view<br clear=
=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; and I get the following out=
put:<br clear=3D"none">&gt; &gt; Trace directory: /home/alexandre/lttng-tra=
ces/auto-20171011-102431<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt;=
 &gt; [10:24:49.326824061] (+?.?????????) calista lttng_jul:event: { cpu_id=
 =3D<br clear=3D"none">&gt; &gt; 2 }, { msg =3D &quot;Hello World, the answ=
er is 42&quot;, logger_name =3D &quot;hello&quot;,<br clear=3D"none">&gt; &=
gt; class_name =3D &quot;Hello&quot;, method_name =3D &quot;main&quot;, lon=
g_millis =3D 1507731889299,<br clear=3D"none">&gt; &gt; int_loglevel =3D 80=
0, int_threadid =3D 1 }<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; =
&gt;<br clear=3D"none">&gt; &gt; Make sure you are setting the -classpath/-=
cp option correctly, this<br clear=3D"none">&gt; &gt; could explain the &qu=
ot;unknown package&quot; error you were getting.<br clear=3D"none">&gt; &gt=
;<br clear=3D"none">&gt; &gt; Also note that you are using the deprecated &=
quot;LTTngAgent.getLTTngAgent()&quot;<br clear=3D"none">&gt; &gt; API (the =
&quot;javac&quot; command should warn about it). It should still work,<br c=
lear=3D"none">&gt; &gt; but it&#39;s highly recommended to use the new API,=
 as described in<br clear=3D"none">&gt; &gt; <a shape=3D"rect" href=3D"http=
s://lttng.org/docs/v2.10/#doc-jul" target=3D"_blank">https://lttng.org/docs=
/v2.10/#doc-jul</a><br clear=3D"none">&gt; &gt; &lt;<a shape=3D"rect" href=
=3D"https://lttng.org/docs/v2.10/#doc-jul%20" target=3D"_blank">https://ltt=
ng.org/docs/v2.10/#doc-jul%20</a>&gt;. Basically you have to<br clear=3D"no=
ne">&gt; &gt; instantiate an &quot;LttngLogHandler&quot;, and attach it to =
your Logger.<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; HTH,<b=
r clear=3D"none">&gt; &gt; Alex<br clear=3D"none">&gt; &gt;<br clear=3D"non=
e">&gt; &gt;<br clear=3D"none">&gt; &gt; On 2017-10-10 04:12 PM, MMM via lt=
tng-dev wrote:<br clear=3D"none">&gt; &gt; &gt; Dear Philippe,<br clear=3D"=
none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; Thanks a lot for your=
 consideration. I solved former problem. While, I<br clear=3D"none">&gt; &g=
t; &gt; faced with a new problem. Indeed, when I create a LTTng session, st=
art<br clear=3D"none">&gt; &gt; &gt; it and finally stop LTTng, I could not=
 find trace files in mentioned<br clear=3D"none">&gt; &gt; &gt; folder. My =
java code is=C2=A0<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; =
&gt; &gt; ///////////////////////////////////////<br clear=3D"none">&gt; &g=
t; &gt; import java.io.IOException;<br clear=3D"none">&gt; &gt; &gt; import=
 java.util.logging.Handler;<br clear=3D"none">&gt; &gt; &gt; import java.ut=
il.logging.Logger;<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; =
&gt; &gt; import org.lttng.ust.agent.LTTngAgent;<br clear=3D"none">&gt; &gt=
; &gt; import org.lttng.ust.agent.jul.LttngLogHandler;<br clear=3D"none">&g=
t; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; public class Hello {<br clear=
=3D"none">&gt; &gt; &gt; private static final int answer =3D 42;<br clear=
=3D"none">&gt; &gt; &gt; private static LTTngAgent lttngAgent;<br clear=3D"=
none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; public static void ma=
in(String[] args) throws InterruptedException {<br clear=3D"none">&gt; &gt;=
 &gt; Logger helloLog =3D Logger.getLogger(&quot;hello&quot;);<br clear=3D"=
none">&gt; &gt; &gt; lttngAgent =3D LTTngAgent.getLTTngAgent();<br clear=3D=
"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; Thread.sleep(5000);<=
br clear=3D"none">&gt; &gt; &gt; helloLog.info(&quot;Hello World, the answe=
r is &quot; + answer);<br clear=3D"none">&gt; &gt; &gt; lttngAgent.dispose(=
);<br clear=3D"none">&gt; &gt; &gt; }<br clear=3D"none">&gt; &gt; &gt;<br c=
lear=3D"none">&gt; &gt; &gt; }<br clear=3D"none">&gt; &gt; &gt; ///////////=
////////////<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &=
gt; Also, I used following LTTng commands.=C2=A0<br clear=3D"none">&gt; &gt=
; &gt;<br clear=3D"none">&gt; &gt; &gt; ////////////////////////////////<br=
 clear=3D"none">&gt; &gt; &gt; lttng create java-test<br clear=3D"none">&gt=
; &gt; &gt; lttng enable-event -a -l<br clear=3D"none">&gt; &gt; &gt; lttng=
 start<br clear=3D"none">&gt; &gt; &gt; ///Start My java Application///<br =
clear=3D"none">&gt; &gt; &gt; lttng stop<br clear=3D"none">&gt; &gt; &gt; /=
///////////////////////////<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"no=
ne">&gt; &gt; &gt; Besides, when I used &quot;lttng view&quot; after stoppi=
ng LTTng, I received<br clear=3D"none">&gt; &gt; &gt; following error messa=
ge<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; [error=
] Cannot open any trace for reading.<br clear=3D"none">&gt; &gt; &gt; [erro=
r] opening trace<br clear=3D"none">&gt; &gt; &gt; &quot;/[path]/lttng-trace=
s/java-test10-20171010-130909&quot; for reading.<br clear=3D"none">&gt; &gt=
; &gt; [error] none of the specified trace paths could be opened.<br clear=
=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; Could you please =
help me to resolve it.<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&=
gt; &gt; &gt; Regards,<br clear=3D"none">&gt; &gt; &gt; Mehdi.<br clear=3D"=
none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt=
; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &g=
t;<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; On Mon=
day, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx<br clear=3D"none=
">&gt; &gt; &gt; &lt;<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmai=
l.com" href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a> =
&lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmail.com" hre=
f=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;<br cle=
ar=3D"none">&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:eeppelitelo=
op@gmail.com" href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.c=
om</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmail.c=
om" href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;=
&gt;&gt; wrote:<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt=
; &gt;<br clear=3D"none">&gt; &gt; &gt; On Sun, Oct 8, 2017 at 4:15 PM, MMM=
 via lttng-dev<br clear=3D"none">&gt; &gt; &gt; &lt;<a shape=3D"rect" ymail=
to=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttn=
g.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=
=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.=
org">lttng-dev@lists.lttng.org</a>&gt;<br clear=3D"none">&gt; &lt;mailto:<a=
 shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto=
:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a sha=
pe=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:ltt=
ng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt;&gt;<br clear=3D"n=
one">&gt; &gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lis=
ts.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.ltt=
ng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.l=
ttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.o=
rg</a>&gt;<br clear=3D"none">&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"m=
ailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">=
lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailt=
o:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttn=
g-dev@lists.lttng.org</a>&gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt; wrote=
:<br clear=3D"none">&gt; &gt; &gt; &gt; Dear Users,<br clear=3D"none">&gt; =
&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; &gt; I am beginner in traci=
ng using LTTng. At present, I am going to<br clear=3D"none">&gt; &gt; &gt; =
trace a java<br clear=3D"none">&gt; &gt; &gt; &gt; program in=C2=A0 Ubuntu,=
 while I faced with a problem. When I install<br clear=3D"none">&gt; &gt; &=
gt; LTTng on<br clear=3D"none">&gt; &gt; &gt; &gt; Ubuntu, I also install<b=
r clear=3D"none">&gt; &gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; &gt; =
&quot;liblttng-ust-agent-java&quot; by &quot;apt-get install<br clear=3D"no=
ne">&gt; liblttng-ust-agent-java&quot;<br clear=3D"none">&gt; &gt; &gt; &gt=
; command in Ubuntu. But, when I want to import any libraries related<br cl=
ear=3D"none">&gt; &gt; &gt; to LTTng<br clear=3D"none">&gt; &gt; &gt; &gt; =
such as<br clear=3D"none">&gt; &gt; &gt; &quot;org.lttng.ust.agent.jul.Lttn=
gLogHandlerorg.lttng.ust.LTTngAgent&quot; to<br clear=3D"none">&gt; &gt; &g=
t; &gt; my program, it is marked as unknown package. Indeed, I could not<br=
 clear=3D"none">&gt; &gt; &gt; find LTTng<br clear=3D"none">&gt; &gt; &gt; =
&gt; Jar file for adding it to my program libraries. Furthermore, I<br clea=
r=3D"none">&gt; &gt; &gt; searched in<br clear=3D"none">&gt; &gt; &gt; &gt;=
 all files and folders, while I could not find Jar file. Could you<br clear=
=3D"none">&gt; &gt; please<br clear=3D"none">&gt; &gt; &gt; &gt; help me to=
 understand the cause of this problem and solve it.<br clear=3D"none">&gt; =
&gt; &gt;<br clear=3D"none">&gt; &gt; &gt; I&#39;m not a Ubuntu specialist,=
 but from<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt;<br c=
lear=3D"none">&gt; &lt;<a shape=3D"rect" href=3D"https://packages.ubuntu.co=
m/zesty/all/liblttng-ust-agent-java/filelist" target=3D"_blank">https://pac=
kages.ubuntu.com/zesty/all/liblttng-ust-agent-java/filelist</a>&gt;,<br cle=
ar=3D"none">&gt; &gt; &gt; I would say:<br clear=3D"none">&gt; &gt; &gt;<br=
 clear=3D"none">&gt; &gt; &gt; * /usr/share/java/lttng-ust-agent-jul.jar<br=
 clear=3D"none">&gt; &gt; &gt; * /usr/share/java/lttng-ust-agent-log4j.jar<=
br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; On 16.04,=
 it&#39;s:<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt=
; * /usr/share/java/liblttng-ust-agent.jar<br clear=3D"none">&gt; &gt; &gt;=
<br clear=3D"none">&gt; &gt; &gt; Add the required JAR file to your classpa=
th.<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; Have =
a look at &lt;<a shape=3D"rect" href=3D"http://lttng.org/docs/v2.9/#doc-jav=
a-application" target=3D"_blank">http://lttng.org/docs/v2.9/#doc-java-appli=
cation</a>&gt;.<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt=
; &gt; Phil<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &g=
t;<br clear=3D"none">&gt; &gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; &=
gt;<br clear=3D"none">&gt; &gt; &gt; &gt; Best regards,<br clear=3D"none">&=
gt; &gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; &gt; Mehdi.<br clear=3D=
"none">&gt; &gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; &gt;<br clear=
=3D"none">&gt; &gt; &gt; &gt; _____________________________________________=
__<br clear=3D"none">&gt; &gt; &gt; &gt; lttng-dev mailing list<br clear=3D=
"none">&gt; &gt; &gt; &gt; <a shape=3D"rect" ymailto=3D"mailto:lttng-dev@li=
sts.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lt=
tng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.=
lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.=
org</a>&gt;<br clear=3D"none">&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"=
mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org"=
>lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mail=
to:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">ltt=
ng-dev@lists.lttng.org</a>&gt;&gt;<br clear=3D"none">&gt; &gt; &lt;mailto:<=
a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailt=
o:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a sh=
ape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lt=
tng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt;<br clear=3D"none=
">&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng=
.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</=
a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org=
" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&g=
t;&gt;&gt;<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; &gt; &gt=
; <a shape=3D"rect" href=3D"https://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev</a><div class=3D"yqt0280732580" id=3D"yqtfd34946"><br clear=
=3D"none">&gt;<br clear=3D"none">&gt; &gt; &gt; &gt;<br clear=3D"none">&gt;=
 &gt; &gt;<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt=
; _______________________________________________<br clear=3D"none">&gt; &g=
t; &gt; lttng-dev mailing list<br clear=3D"none">&gt; &gt; &gt; <a shape=3D=
"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-de=
v@lists.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rec=
t" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@li=
sts.lttng.org">lttng-dev@lists.lttng.org</a>&gt;<br clear=3D"none">&gt; &lt=
;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=
=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mai=
lto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"=
mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt;&gt;<br =
clear=3D"none">&gt; &gt; &gt; <a shape=3D"rect" href=3D"https://lists.lttng=
.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br clear=3D"none">&gt; &gt;<=
br clear=3D"none">&gt;<br clear=3D"none"><br clear=3D"none"></div></body></=
html></div></div>
                </div>
            </div></div></body></html>
------=_Part_2468_1779604036.1508019513391--

--===============5531734937214054176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5531734937214054176==--
