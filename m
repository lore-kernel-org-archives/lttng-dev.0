From: MMM via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Problem in finding Jar file of LTTng for adding to
 Java project
Date: Thu, 12 Oct 2017 19:38:07 +0000 (UTC)
Message-ID: <1302171483.738271.1507837087778__35949.0562965677$1507842666$gmane$org@mail.yahoo.com>
References: <797428900.3787919.1507493725940.ref@mail.yahoo.com>
 <797428900.3787919.1507493725940@mail.yahoo.com>
 <CAB4xu_26Qmpzf-mccjY3HutmFBBLdEEDAxx5_WLdxdFARSzgNA@mail.gmail.com>
 <776772327.5312865.1507666332238@mail.yahoo.com>
 <37f91596-023e-f552-b07f-3b4e073399cd@voxpopuli.im>
 <850230324.98540.1507759558449@mail.yahoo.com>
 <415c1e82-6532-d4a8-c443-8263a1a3cc91@voxpopuli.im>
Reply-To: MMM <e.morovati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7043170631730578752=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic308-3.consmr.mail.bf2.yahoo.com
 (sonic308-3.consmr.mail.bf2.yahoo.com [74.6.130.42])
 by lists.lttng.org (Postfix) with ESMTP id 3yCk655stRzybw
 for <lttng-dev@lists.lttng.org>; Thu, 12 Oct 2017 21:10:53 +0000 (UTC)
In-Reply-To: <415c1e82-6532-d4a8-c443-8263a1a3cc91@voxpopuli.im>
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

--===============7043170631730578752==
Content-Type: multipart/alternative;
	boundary="----=_Part_738270_1062443064.1507837087774"

------=_Part_738270_1062443064.1507837087774
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Dear Alex,
As I mentioned, I used sample examples. for instance, I used mentioned simp=
le program that you told tracing it return some result. While, I can not re=
ceive any result from tracing it. Also, I use Ubuntu 16.04 LTS and lttng 2.=
9.5. Besides, the output of asked command is=C2=A0
//////////////////-rw-r--r-- 1 root root 40871 Jun 16 13:56 /usr/share/java=
/lttng-ust-agent-common-2.9.1.jarlrwxrwxrwx 1 root root=C2=A0 =C2=A0 32 Jun=
 16 13:56 /usr/share/java/lttng-ust-agent-common.jar -> lttng-ust-agent-com=
mon-2.9.1.jar-rw-r--r-- 1 root root=C2=A0 4369 Jun 16 13:56 /usr/share/java=
/lttng-ust-agent-jul-2.9.1.jarlrwxrwxrwx 1 root root=C2=A0 =C2=A0 29 Jun 16=
 13:56 /usr/share/java/lttng-ust-agent-jul.jar -> lttng-ust-agent-jul-2.9.1=
.jar-rw-r--r-- 1 root root=C2=A0 3933 Jun 16 13:56 /usr/share/java/lttng-us=
t-agent-log4j-2.9.1.jarlrwxrwxrwx 1 root root=C2=A0 =C2=A0 31 Jun 16 13:56 =
/usr/share/java/lttng-ust-agent-log4j.jar -> lttng-ust-agent-log4j-2.9.1.ja=
r////////////////////////////
Thanks for your attention.Regards,Mehdi.
    On Thursday, October 12, 2017, 6:51:12 PM GMT+3:30, Alexandre Montplais=
ir <alexmonthy@voxpopuli.im> wrote: =20
=20
=20

On 2017-10-11 06:05 PM, MMM wrote:
> Dear Alex,
>
> Thanks for your attention. I executed your commands step by step.
> While, again I received previous errors which are=C2=A0
>
> [error] Cannot open any trace for reading.
> [error] opening trace "[path]/lttng-traces/auto-20171011-145947" for
> reading.
> [error] none of the specified trace paths could be opened.
>
> I do not know the reason of this problem. Could you please help me to
> resolve it?

As Philippe mentioned previously, this means the trace is empty, so no
events were produced by the session.

Did any of the other commands (java, javac, lttng create,...) output any
error messages?


Finally, it would help if you could specify:
- What version of Ubuntu you are running

- What version of LTTng you are running ("lttng --version")

- The output of the following command:
$ ls -l /usr/share/java/lttng-ust*

Thanks,
Alex

>
> Regards,
> Mehdi.
>
>
>
>
> On Wednesday, October 11, 2017, 6:09:41 PM GMT+3:30, Alexandre
> Montplaisir <alexmonthy@voxpopuli.im> wrote:
>
>
> Hi,
>
> I tried compiling and running your program, and it runs fine on my end.
> Here is what I did:
>
> saved the snippet below to "Hello.java"
> $ apt install liblttng-ust-agent-java
> $ javac -cp /usr/share/java/lttng-ust-agent-jul.jar Hello.java
>
> $ lttng create
> $ lttng enable-event -a -j
> $ lttng start
> $ java -cp /usr/share/java/lttng-ust-agent-jul.jar:. Hello
> $ lttng stop
> $ lttng view
>
> and I get the following output:
> Trace directory: /home/alexandre/lttng-traces/auto-20171011-102431
>
> [10:24:49.326824061] (+?.?????????) calista lttng_jul:event: { cpu_id =3D
> 2 }, { msg =3D "Hello World, the answer is 42", logger_name =3D "hello",
> class_name =3D "Hello", method_name =3D "main", long_millis =3D 150773188=
9299,
> int_loglevel =3D 800, int_threadid =3D 1 }
>
>
> Make sure you are setting the -classpath/-cp option correctly, this
> could explain the "unknown package" error you were getting.
>
> Also note that you are using the deprecated "LTTngAgent.getLTTngAgent()"
> API (the "javac" command should warn about it). It should still work,
> but it's highly recommended to use the new API, as described in
> https://lttng.org/docs/v2.10/#doc-jul
> <https://lttng.org/docs/v2.10/#doc-jul%20>. Basically you have to
> instantiate an "LttngLogHandler", and attach it to your Logger.
>
> HTH,
> Alex
>
>
> On 2017-10-10 04:12 PM, MMM via lttng-dev wrote:
> > Dear Philippe,
> >
> > Thanks a lot for your consideration. I solved former problem. While, I
> > faced with a new problem. Indeed, when I create a LTTng session, start
> > it and finally stop LTTng, I could not find trace files in mentioned
> > folder. My java code is=C2=A0
> >
> > ///////////////////////////////////////
> > import java.io.IOException;
> > import java.util.logging.Handler;
> > import java.util.logging.Logger;
> >
> > import org.lttng.ust.agent.LTTngAgent;
> > import org.lttng.ust.agent.jul.LttngLogHandler;
> >
> > public class Hello {
> > private static final int answer =3D 42;
> > private static LTTngAgent lttngAgent;
> >
> > public static void main(String[] args) throws InterruptedException {
> > Logger helloLog =3D Logger.getLogger("hello");
> > lttngAgent =3D LTTngAgent.getLTTngAgent();
> >
> > Thread.sleep(5000);
> > helloLog.info("Hello World, the answer is " + answer);
> > lttngAgent.dispose();
> > }
> >
> > }
> > ///////////////////////
> >
> > Also, I used following LTTng commands.=C2=A0
> >
> > ////////////////////////////////
> > lttng create java-test
> > lttng enable-event -a -l
> > lttng start
> > ///Start My java Application///
> > lttng stop
> > ////////////////////////////
> >
> > Besides, when I used "lttng view" after stopping LTTng, I received
> > following error message
> >
> > [error] Cannot open any trace for reading.
> > [error] opening trace
> > "/[path]/lttng-traces/java-test10-20171010-130909" for reading.
> > [error] none of the specified trace paths could be opened.
> >
> > Could you please help me to resolve it.
> >
> > Regards,
> > Mehdi.
> >
> >
> >
> >
> >
> >
> > On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx
> > <eeppeliteloop@gmail.com <mailto:eeppeliteloop@gmail.com>> wrote:
> >
> >
> > On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev
> > <lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>>
> wrote:
> > > Dear Users,
> > >
> > > I am beginner in tracing using LTTng. At present, I am going to
> > trace a java
> > > program in=C2=A0 Ubuntu, while I faced with a problem. When I install
> > LTTng on
> > > Ubuntu, I also install
> > >
> > > "liblttng-ust-agent-java" by "apt-get install liblttng-ust-agent-java=
"
> > > command in Ubuntu. But, when I want to import any libraries related
> > to LTTng
> > > such as
> > "org.lttng.ust.agent.jul.LttngLogHandlerorg.lttng.ust.LTTngAgent" to
> > > my program, it is marked as unknown package. Indeed, I could not
> > find LTTng
> > > Jar file for adding it to my program libraries. Furthermore, I
> > searched in
> > > all files and folders, while I could not find Jar file. Could you
> please
> > > help me to understand the cause of this problem and solve it.
> >
> > I'm not a Ubuntu specialist, but from
> >
> <https://packages.ubuntu.com/zesty/all/liblttng-ust-agent-java/filelist>,
> > I would say:
> >
> > * /usr/share/java/lttng-ust-agent-jul.jar
> > * /usr/share/java/lttng-ust-agent-log4j.jar
> >
> > On 16.04, it's:
> >
> > * /usr/share/java/liblttng-ust-agent.jar
> >
> > Add the required JAR file to your classpath.
> >
> > Have a look at <http://lttng.org/docs/v2.9/#doc-java-application>.
> >
> > Phil
> >
> >
> > >
> > >
> > > Best regards,
> > >
> > > Mehdi.
> > >
> > >
> > > _______________________________________________
> > > lttng-dev mailing list
> > > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>
>
> > > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>


------=_Part_738270_1062443064.1507837087774
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:courier new, courier, mo=
naco, monospace, sans-serif;font-size:13px;"><div></div>
            <div>Dear Alex,</div><div><br></div><div>As I mentioned, I used=
 sample examples. for instance, I used mentioned simple program that you to=
ld tracing it return some result. While, I can not receive any result from =
tracing it. Also, I use Ubuntu 16.04 LTS and lttng 2.9.5. Besides, the outp=
ut of asked command is&nbsp;</div><div><br></div><div>//////////////////</d=
iv><div><div><font color=3D"#5b8828">-rw-r--r-- 1 root root 40871 Jun 16 13=
:56 /usr/share/java/lttng-ust-agent-common-2.9.1.jar</font></div><div><font=
 color=3D"#5b8828">lrwxrwxrwx 1 root root&nbsp; &nbsp; 32 Jun 16 13:56 /usr=
/share/java/lttng-ust-agent-common.jar -&gt; lttng-ust-agent-common-2.9.1.j=
ar</font></div><div><font color=3D"#5b8828">-rw-r--r-- 1 root root&nbsp; 43=
69 Jun 16 13:56 /usr/share/java/lttng-ust-agent-jul-2.9.1.jar</font></div><=
div><font color=3D"#5b8828">lrwxrwxrwx 1 root root&nbsp; &nbsp; 29 Jun 16 1=
3:56 /usr/share/java/lttng-ust-agent-jul.jar -&gt; lttng-ust-agent-jul-2.9.=
1.jar</font></div><div><font color=3D"#5b8828">-rw-r--r-- 1 root root&nbsp;=
 3933 Jun 16 13:56 /usr/share/java/lttng-ust-agent-log4j-2.9.1.jar</font></=
div><div><font color=3D"#5b8828">lrwxrwxrwx 1 root root&nbsp; &nbsp; 31 Jun=
 16 13:56 /usr/share/java/lttng-ust-agent-log4j.jar -&gt; lttng-ust-agent-l=
og4j-2.9.1.jar</font></div><div>////////////////////////////</div></div><di=
v><br></div><div>Thanks for your attention.</div><div>Regards,</div><div>Me=
hdi.</div><div><br></div>
           =20
            <div id=3D"yahoo_quoted_8706768885" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On Thursday, October 12, 2017, 6:51:12 PM GMT+3:30,=
 Alexandre Montplaisir &lt;alexmonthy@voxpopuli.im&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D'ltr'><html><body><br clear=3D"none"><b=
r clear=3D"none">On 2017-10-11 06:05 PM, MMM wrote:<br clear=3D"none">&gt; =
Dear Alex,<br clear=3D"none">&gt;<br clear=3D"none">&gt; Thanks for your at=
tention. I executed your commands step by step.<br clear=3D"none">&gt; Whil=
e, again I received previous errors which are=C2=A0<br clear=3D"none">&gt;<=
br clear=3D"none">&gt; [error] Cannot open any trace for reading.<br clear=
=3D"none">&gt; [error] opening trace &quot;[path]/lttng-traces/auto-2017101=
1-145947&quot; for<br clear=3D"none">&gt; reading.<br clear=3D"none">&gt; [=
error] none of the specified trace paths could be opened.<br clear=3D"none"=
>&gt;<br clear=3D"none">&gt; I do not know the reason of this problem. Coul=
d you please help me to<br clear=3D"none">&gt; resolve it?<br clear=3D"none=
"><br clear=3D"none">As Philippe mentioned previously, this means the trace=
 is empty, so no<br clear=3D"none">events were produced by the session.<br =
clear=3D"none"><br clear=3D"none">Did any of the other commands (java, java=
c, lttng create,...) output any<br clear=3D"none">error messages?<br clear=
=3D"none"><br clear=3D"none"><br clear=3D"none">Finally, it would help if y=
ou could specify:<br clear=3D"none">- What version of Ubuntu you are runnin=
g<br clear=3D"none"><br clear=3D"none">- What version of LTTng you are runn=
ing (&quot;lttng --version&quot;)<br clear=3D"none"><br clear=3D"none">- Th=
e output of the following command:<br clear=3D"none">$ ls -l /usr/share/jav=
a/lttng-ust*<br clear=3D"none"><br clear=3D"none">Thanks,<br clear=3D"none"=
>Alex<br clear=3D"none"><br clear=3D"none">&gt;<br clear=3D"none">&gt; Rega=
rds,<br clear=3D"none">&gt; Mehdi.<br clear=3D"none">&gt;<br clear=3D"none"=
>&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; =
On Wednesday, October 11, 2017, 6:09:41 PM GMT+3:30, Alexandre<br clear=3D"=
none">&gt; Montplaisir &lt;<a shape=3D"rect" ymailto=3D"mailto:alexmonthy@v=
oxpopuli.im" href=3D"mailto:alexmonthy@voxpopuli.im">alexmonthy@voxpopuli.i=
m</a>&gt; wrote:<br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"=
none">&gt; Hi,<br clear=3D"none">&gt;<br clear=3D"none">&gt; I tried compil=
ing and running your program, and it runs fine on my end.<br clear=3D"none"=
>&gt; Here is what I did:<br clear=3D"none">&gt;<br clear=3D"none">&gt; sav=
ed the snippet below to &quot;Hello.java&quot;<br clear=3D"none">&gt; $ apt=
 install liblttng-ust-agent-java<br clear=3D"none">&gt; $ javac -cp /usr/sh=
are/java/lttng-ust-agent-jul.jar Hello.java<br clear=3D"none">&gt;<br clear=
=3D"none">&gt; $ lttng create<br clear=3D"none">&gt; $ lttng enable-event -=
a -j<br clear=3D"none">&gt; $ lttng start<br clear=3D"none">&gt; $ java -cp=
 /usr/share/java/lttng-ust-agent-jul.jar:. Hello<br clear=3D"none">&gt; $ l=
ttng stop<br clear=3D"none">&gt; $ lttng view<br clear=3D"none">&gt;<br cle=
ar=3D"none">&gt; and I get the following output:<br clear=3D"none">&gt; Tra=
ce directory: /home/alexandre/lttng-traces/auto-20171011-102431<br clear=3D=
"none">&gt;<br clear=3D"none">&gt; [10:24:49.326824061] (+?.?????????) cali=
sta lttng_jul:event: { cpu_id =3D<br clear=3D"none">&gt; 2 }, { msg =3D &qu=
ot;Hello World, the answer is 42&quot;, logger_name =3D &quot;hello&quot;,<=
br clear=3D"none">&gt; class_name =3D &quot;Hello&quot;, method_name =3D &q=
uot;main&quot;, long_millis =3D 1507731889299,<br clear=3D"none">&gt; int_l=
oglevel =3D 800, int_threadid =3D 1 }<br clear=3D"none">&gt;<br clear=3D"no=
ne">&gt;<br clear=3D"none">&gt; Make sure you are setting the -classpath/-c=
p option correctly, this<br clear=3D"none">&gt; could explain the &quot;unk=
nown package&quot; error you were getting.<br clear=3D"none">&gt;<br clear=
=3D"none">&gt; Also note that you are using the deprecated &quot;LTTngAgent=
.getLTTngAgent()&quot;<br clear=3D"none">&gt; API (the &quot;javac&quot; co=
mmand should warn about it). It should still work,<br clear=3D"none">&gt; b=
ut it&#39;s highly recommended to use the new API, as described in<br clear=
=3D"none">&gt; <a shape=3D"rect" href=3D"https://lttng.org/docs/v2.10/#doc-=
jul" target=3D"_blank">https://lttng.org/docs/v2.10/#doc-jul</a><br clear=
=3D"none">&gt; &lt;<a shape=3D"rect" href=3D"https://lttng.org/docs/v2.10/#=
doc-jul%20" target=3D"_blank">https://lttng.org/docs/v2.10/#doc-jul%20</a>&=
gt;. Basically you have to<br clear=3D"none">&gt; instantiate an &quot;Lttn=
gLogHandler&quot;, and attach it to your Logger.<br clear=3D"none">&gt;<br =
clear=3D"none">&gt; HTH,<br clear=3D"none">&gt; Alex<br clear=3D"none">&gt;=
<br clear=3D"none">&gt;<br clear=3D"none">&gt; On 2017-10-10 04:12 PM, MMM =
via lttng-dev wrote:<br clear=3D"none">&gt; &gt; Dear Philippe,<br clear=3D=
"none">&gt; &gt;<br clear=3D"none">&gt; &gt; Thanks a lot for your consider=
ation. I solved former problem. While, I<br clear=3D"none">&gt; &gt; faced =
with a new problem. Indeed, when I create a LTTng session, start<br clear=
=3D"none">&gt; &gt; it and finally stop LTTng, I could not find trace files=
 in mentioned<br clear=3D"none">&gt; &gt; folder. My java code is=C2=A0<br =
clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; //////////////////////=
/////////////////<br clear=3D"none">&gt; &gt; import java.io.IOException;<b=
r clear=3D"none">&gt; &gt; import java.util.logging.Handler;<br clear=3D"no=
ne">&gt; &gt; import java.util.logging.Logger;<br clear=3D"none">&gt; &gt;<=
br clear=3D"none">&gt; &gt; import org.lttng.ust.agent.LTTngAgent;<br clear=
=3D"none">&gt; &gt; import org.lttng.ust.agent.jul.LttngLogHandler;<br clea=
r=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; public class Hello {<br cl=
ear=3D"none">&gt; &gt; private static final int answer =3D 42;<br clear=3D"=
none">&gt; &gt; private static LTTngAgent lttngAgent;<br clear=3D"none">&gt=
; &gt;<br clear=3D"none">&gt; &gt; public static void main(String[] args) t=
hrows InterruptedException {<br clear=3D"none">&gt; &gt; Logger helloLog =
=3D Logger.getLogger(&quot;hello&quot;);<br clear=3D"none">&gt; &gt; lttngA=
gent =3D LTTngAgent.getLTTngAgent();<br clear=3D"none">&gt; &gt;<br clear=
=3D"none">&gt; &gt; Thread.sleep(5000);<br clear=3D"none">&gt; &gt; helloLo=
g.info(&quot;Hello World, the answer is &quot; + answer);<br clear=3D"none"=
>&gt; &gt; lttngAgent.dispose();<br clear=3D"none">&gt; &gt; }<br clear=3D"=
none">&gt; &gt;<br clear=3D"none">&gt; &gt; }<br clear=3D"none">&gt; &gt; /=
//////////////////////<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &=
gt; Also, I used following LTTng commands.=C2=A0<br clear=3D"none">&gt; &gt=
;<br clear=3D"none">&gt; &gt; ////////////////////////////////<br clear=3D"=
none">&gt; &gt; lttng create java-test<br clear=3D"none">&gt; &gt; lttng en=
able-event -a -l<br clear=3D"none">&gt; &gt; lttng start<br clear=3D"none">=
&gt; &gt; ///Start My java Application///<br clear=3D"none">&gt; &gt; lttng=
 stop<br clear=3D"none">&gt; &gt; ////////////////////////////<br clear=3D"=
none">&gt; &gt;<br clear=3D"none">&gt; &gt; Besides, when I used &quot;lttn=
g view&quot; after stopping LTTng, I received<br clear=3D"none">&gt; &gt; f=
ollowing error message<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &=
gt; [error] Cannot open any trace for reading.<br clear=3D"none">&gt; &gt; =
[error] opening trace<br clear=3D"none">&gt; &gt; &quot;/[path]/lttng-trace=
s/java-test10-20171010-130909&quot; for reading.<br clear=3D"none">&gt; &gt=
; [error] none of the specified trace paths could be opened.<br clear=3D"no=
ne">&gt; &gt;<br clear=3D"none">&gt; &gt; Could you please help me to resol=
ve it.<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; Regards,<br =
clear=3D"none">&gt; &gt; Mehdi.<br clear=3D"none">&gt; &gt;<br clear=3D"non=
e">&gt; &gt;<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt;<br cle=
ar=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &g=
t; On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx<br clea=
r=3D"none">&gt; &gt; &lt;<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@=
gmail.com" href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com<=
/a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmail.com"=
 href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;&gt=
; wrote:<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt;<br clear=
=3D"none">&gt; &gt; On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev<br cl=
ear=3D"none">&gt; &gt; &lt;<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@li=
sts.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lt=
tng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.=
lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.=
org</a>&gt;<br clear=3D"none">&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"=
mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org"=
>lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mail=
to:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">ltt=
ng-dev@lists.lttng.org</a>&gt;&gt;&gt;<br clear=3D"none">&gt; wrote:<br cle=
ar=3D"none">&gt; &gt; &gt; Dear Users,<br clear=3D"none">&gt; &gt; &gt;<br =
clear=3D"none">&gt; &gt; &gt; I am beginner in tracing using LTTng. At pres=
ent, I am going to<br clear=3D"none">&gt; &gt; trace a java<br clear=3D"non=
e">&gt; &gt; &gt; program in=C2=A0 Ubuntu, while I faced with a problem. Wh=
en I install<br clear=3D"none">&gt; &gt; LTTng on<br clear=3D"none">&gt; &g=
t; &gt; Ubuntu, I also install<br clear=3D"none">&gt; &gt; &gt;<br clear=3D=
"none">&gt; &gt; &gt; &quot;liblttng-ust-agent-java&quot; by &quot;apt-get =
install liblttng-ust-agent-java&quot;<br clear=3D"none">&gt; &gt; &gt; comm=
and in Ubuntu. But, when I want to import any libraries related<br clear=3D=
"none">&gt; &gt; to LTTng<br clear=3D"none">&gt; &gt; &gt; such as<br clear=
=3D"none">&gt; &gt; &quot;org.lttng.ust.agent.jul.LttngLogHandlerorg.lttng.=
ust.LTTngAgent&quot; to<br clear=3D"none">&gt; &gt; &gt; my program, it is =
marked as unknown package. Indeed, I could not<br clear=3D"none">&gt; &gt; =
find LTTng<br clear=3D"none">&gt; &gt; &gt; Jar file for adding it to my pr=
ogram libraries. Furthermore, I<br clear=3D"none">&gt; &gt; searched in<br =
clear=3D"none">&gt; &gt; &gt; all files and folders, while I could not find=
 Jar file. Could you<br clear=3D"none">&gt; please<br clear=3D"none">&gt; &=
gt; &gt; help me to understand the cause of this problem and solve it.<br c=
lear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; I&#39;m not a Ubuntu sp=
ecialist, but from<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &lt;<=
a shape=3D"rect" href=3D"https://packages.ubuntu.com/zesty/all/liblttng-ust=
-agent-java/filelist" target=3D"_blank">https://packages.ubuntu.com/zesty/a=
ll/liblttng-ust-agent-java/filelist</a>&gt;,<br clear=3D"none">&gt; &gt; I =
would say:<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; * /usr/s=
hare/java/lttng-ust-agent-jul.jar<br clear=3D"none">&gt; &gt; * /usr/share/=
java/lttng-ust-agent-log4j.jar<br clear=3D"none">&gt; &gt;<br clear=3D"none=
">&gt; &gt; On 16.04, it&#39;s:<br clear=3D"none">&gt; &gt;<br clear=3D"non=
e">&gt; &gt; * /usr/share/java/liblttng-ust-agent.jar<br clear=3D"none">&gt=
; &gt;<br clear=3D"none">&gt; &gt; Add the required JAR file to your classp=
ath.<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; Have a look at=
 &lt;<a shape=3D"rect" href=3D"http://lttng.org/docs/v2.9/#doc-java-applica=
tion" target=3D"_blank">http://lttng.org/docs/v2.9/#doc-java-application</a=
>&gt;.<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; Phil<br clea=
r=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt=
; &gt;<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt; Be=
st regards,<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &g=
t; Mehdi.<br clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt; &gt;=
<br clear=3D"none">&gt; &gt; &gt; _________________________________________=
______<br clear=3D"none">&gt; &gt; &gt; lttng-dev mailing list<br clear=3D"=
none">&gt; &gt; &gt; <a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lt=
tng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.or=
g</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.=
org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a=
>&gt;<br clear=3D"none">&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto=
:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng=
-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:ltt=
ng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev=
@lists.lttng.org</a>&gt;&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; =
&gt; &gt; <a shape=3D"rect" href=3D"https://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev</a><div class=3D"yqt2954931476" id=3D"yqtfd99178"><b=
r clear=3D"none">&gt; &gt; &gt;<br clear=3D"none">&gt; &gt;<br clear=3D"non=
e">&gt; &gt;<br clear=3D"none">&gt; &gt; __________________________________=
_____________<br clear=3D"none">&gt; &gt; lttng-dev mailing list<br clear=
=3D"none">&gt; &gt; <a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.ltt=
ng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.o=
rg" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>=
&gt;<br clear=3D"none">&gt; &gt; <a shape=3D"rect" href=3D"https://lists.lt=
tng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists=
.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br clear=3D"none">&gt;<br=
 clear=3D"none"><br clear=3D"none"></div></body></html></div></div>
                </div>
            </div></div></body></html>
------=_Part_738270_1062443064.1507837087774--

--===============7043170631730578752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7043170631730578752==--
