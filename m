From: MMM via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Problem in finding Jar file of LTTng for adding to
 Java project
Date: Tue, 10 Oct 2017 20:12:12 +0000 (UTC)
Message-ID: <776772327.5312865.1507666332238__35492.8051973276$1507666357$gmane$org@mail.yahoo.com>
References: <797428900.3787919.1507493725940.ref@mail.yahoo.com>
 <797428900.3787919.1507493725940@mail.yahoo.com>
 <CAB4xu_26Qmpzf-mccjY3HutmFBBLdEEDAxx5_WLdxdFARSzgNA@mail.gmail.com>
Reply-To: MMM <e.morovati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4283237090631100539=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic309-21.consmr.mail.ne1.yahoo.com
 (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
 by lists.lttng.org (Postfix) with ESMTP id 3yBSvZ3srhzskm
 for <lttng-dev@lists.lttng.org>; Tue, 10 Oct 2017 20:12:25 +0000 (UTC)
In-Reply-To: <CAB4xu_26Qmpzf-mccjY3HutmFBBLdEEDAxx5_WLdxdFARSzgNA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4283237090631100539==
Content-Type: multipart/alternative;
	boundary="----=_Part_5312864_714234025.1507666332233"

------=_Part_5312864_714234025.1507666332233
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Dear Philippe,
Thanks a lot for your consideration. I solved former problem. While, I face=
d with a new problem. Indeed, when I create a LTTng session, start it and f=
inally stop LTTng, I could not find trace files in mentioned folder. My jav=
a code is=C2=A0
///////////////////////////////////////import java.io.IOException;import ja=
va.util.logging.Handler;import java.util.logging.Logger;
import org.lttng.ust.agent.LTTngAgent;import org.lttng.ust.agent.jul.LttngL=
ogHandler;
public class Hello {  private static final int answer =3D 42; private stati=
c LTTngAgent lttngAgent;
 public static void main(String[] args) throws InterruptedException { Logge=
r helloLog =3D Logger.getLogger("hello"); lttngAgent =3D LTTngAgent.getLTTn=
gAgent();
 Thread.sleep(5000); helloLog.info("Hello World, the answer is " + answer);=
 lttngAgent.dispose(); }
}///////////////////////
Also, I used following LTTng commands.=C2=A0
////////////////////////////////lttng create java-testlttng enable-event -a=
 -llttng start
///Start My java Application///
lttng stop////////////////////////////
Besides, when I used "lttng view" after stopping LTTng, I received followin=
g error message
[error] Cannot open any trace for reading.[error] opening trace "/[path]/lt=
tng-traces/java-test10-20171010-130909" for reading.[error] none of the spe=
cified trace paths could be opened.
Could you please help me to resolve it.
Regards,Mehdi.








    On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx <eeppe=
liteloop@gmail.com> wrote: =20
=20
 On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev
<lttng-dev@lists.lttng.org> wrote:
> Dear Users,
>
> I am beginner in tracing using LTTng. At present, I am going to trace a j=
ava
> program in=C2=A0 Ubuntu, while I faced with a problem. When I install LTT=
ng on
> Ubuntu, I also install
>
> "liblttng-ust-agent-java" by "apt-get install liblttng-ust-agent-java"
> command in Ubuntu. But, when I want to import any libraries related to LT=
Tng
> such as "org.lttng.ust.agent.jul.LttngLogHandlerorg.lttng.ust.LTTngAgent"=
 to
> my program, it is marked as unknown package. Indeed, I could not find LTT=
ng
> Jar file for adding it to my program libraries. Furthermore, I searched i=
n
> all files and folders, while I could not find Jar file. Could you please
> help me to understand the cause of this problem and solve it.

I'm not a Ubuntu specialist, but from
<https://packages.ubuntu.com/zesty/all/liblttng-ust-agent-java/filelist>,
I would say:

* /usr/share/java/lttng-ust-agent-jul.jar
* /usr/share/java/lttng-ust-agent-log4j.jar

On 16.04, it's:

* /usr/share/java/liblttng-ust-agent.jar

Add the required JAR file to your classpath.

Have a look at <http://lttng.org/docs/v2.9/#doc-java-application>.

Phil

>
>
> Best regards,
>
> Mehdi.
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

------=_Part_5312864_714234025.1507666332233
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:courier new, courier, mo=
naco, monospace, sans-serif;font-size:13px;"><div></div>
            <div>Dear Philippe,</div><div><br></div><div>Thanks a lot for y=
our consideration. I solved former problem. While, I faced with a new probl=
em. Indeed, when I create a LTTng session, start it and finally stop LTTng,=
 I could not find trace files in mentioned folder. My java code is&nbsp;</d=
iv><div><br></div><div><div>///////////////////////////////////////</div><d=
iv><font color=3D"#5b8828">import java.io.IOException;</font></div><div><fo=
nt color=3D"#5b8828">import java.util.logging.Handler;</font></div><div><fo=
nt color=3D"#5b8828">import java.util.logging.Logger;</font></div><div><fon=
t color=3D"#5b8828"><br></font></div><div><font color=3D"#5b8828">import or=
g.lttng.ust.agent.LTTngAgent;</font></div><div><font color=3D"#5b8828">impo=
rt org.lttng.ust.agent.jul.LttngLogHandler;</font></div><div><br></div><div=
><font color=3D"#5b8828">public class Hello {</font></div><div><span style=
=3D"white-space: pre-wrap;"><font color=3D"#5b8828">=09</font></span></div>=
<div><font color=3D"#5b8828"><span style=3D"white-space: pre-wrap;">=09</sp=
an>private static final int answer =3D 42;</font></div><div><font color=3D"=
#5b8828"><span style=3D"white-space: pre-wrap;">=09</span>private static LT=
TngAgent lttngAgent;</font></div><div><font color=3D"#5b8828"><br></font></=
div><div><font color=3D"#5b8828"><span style=3D"white-space: pre-wrap;">=09=
</span>public static void main(String[] args) throws InterruptedException {=
</font></div><div><font color=3D"#5b8828"><span style=3D"white-space: pre-w=
rap;">=09=09</span>Logger helloLog =3D Logger.getLogger("hello");</font></d=
iv><div><font color=3D"#5b8828"><span style=3D"white-space: pre-wrap;">=09=
=09</span>lttngAgent =3D LTTngAgent.getLTTngAgent();</font></div><div><font=
 color=3D"#5b8828"><br></font></div><div><font color=3D"#5b8828"><span styl=
e=3D"white-space: pre-wrap;">=09=09</span>Thread.sleep(5000);</font></div><=
div><font color=3D"#5b8828"><span style=3D"white-space: pre-wrap;">=09=09</=
span>helloLog.info("Hello World, the answer is " + answer);</font></div><di=
v><font color=3D"#5b8828"><span style=3D"white-space: pre-wrap;">=09=09</sp=
an>lttngAgent.dispose();</font></div><div><font color=3D"#5b8828"><span sty=
le=3D"white-space: pre-wrap;">=09</span>}</font></div><div><font color=3D"#=
5b8828"><br></font></div><div><font color=3D"#5b8828">}</font></div><div>//=
/////////////////////</div><div><br></div><div>Also, I used following LTTng=
 commands.&nbsp;</div><div><br></div><div><span style=3D"font-family: &quot=
;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Bitstream Vera Sans M=
ono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, &quot;Ub=
untu Mono&quot;, Monaco, Consolas, &quot;Lucida Console&quot;, &quot;Lucida=
 Sans Typewriter&quot;, &quot;Courier New&quot;, Courier, monospace; font-s=
ize: 12px; white-space: pre-wrap;">////////////////////////////////</span><=
/div><div><span style=3D"font-family: &quot;Andale Mono WT&quot;, &quot;And=
ale Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono=
&quot;, &quot;Nimbus Mono L&quot;, &quot;Ubuntu Mono&quot;, Monaco, Consola=
s, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;Co=
urier New&quot;, Courier, monospace; font-size: 12px; white-space: pre-wrap=
;">lttng create java-test</span></div><div><span style=3D"font-family: &quo=
t;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Bitstream Vera Sans =
Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, &quot;U=
buntu Mono&quot;, Monaco, Consolas, &quot;Lucida Console&quot;, &quot;Lucid=
a Sans Typewriter&quot;, &quot;Courier New&quot;, Courier, monospace; font-=
size: 12px; white-space: pre-wrap;">lttng enable-event -a -l</span></div><d=
iv><span style=3D"font-family: &quot;Andale Mono WT&quot;, &quot;Andale Mon=
o&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;,=
 &quot;Nimbus Mono L&quot;, &quot;Ubuntu Mono&quot;, Monaco, Consolas, &quo=
t;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;Courier N=
ew&quot;, Courier, monospace; font-size: 12px; white-space: pre-wrap;">lttn=
g start</span></div><div><span style=3D"font-family: &quot;Andale Mono WT&q=
uot;, &quot;Andale Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;=
Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, &quot;Ubuntu Mono&quot;, =
Monaco, Consolas, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&=
quot;, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; white-=
space: pre-wrap;"><br></span></div><div><span style=3D"font-family: &quot;A=
ndale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Bitstream Vera Sans Mon=
o&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, &quot;Ubun=
tu Mono&quot;, Monaco, Consolas, &quot;Lucida Console&quot;, &quot;Lucida S=
ans Typewriter&quot;, &quot;Courier New&quot;, Courier, monospace; font-siz=
e: 12px; white-space: pre-wrap;">///Start My java Application///</span></di=
v><div><span style=3D"font-family: &quot;Andale Mono WT&quot;, &quot;Andale=
 Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&qu=
ot;, &quot;Nimbus Mono L&quot;, &quot;Ubuntu Mono&quot;, Monaco, Consolas, =
&quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;Couri=
er New&quot;, Courier, monospace; font-size: 12px; white-space: pre-wrap;">=
<br></span></div><div><span style=3D"font-family: &quot;Andale Mono WT&quot=
;, &quot;Andale Mono&quot;, &quot;Bitstream Vera Sans Mono&quot;, &quot;Lib=
eration Mono&quot;, &quot;Nimbus Mono L&quot;, &quot;Ubuntu Mono&quot;, Mon=
aco, Consolas, &quot;Lucida Console&quot;, &quot;Lucida Sans Typewriter&quo=
t;, &quot;Courier New&quot;, Courier, monospace; font-size: 12px; white-spa=
ce: pre-wrap;">lttng stop</span></div><div>////////////////////////////</di=
v><div><br></div><div>Besides, when I used "lttng view" after stopping LTTn=
g, I received following error message</div><div><br></div><div><div>[error]=
 Cannot open any trace for reading.</div><div>[error] opening trace "/[path=
]/lttng-traces/java-test10-20171010-130909" for reading.</div><div>[error] =
none of the specified trace paths could be opened.</div><div><br></div><div=
>Could you please help me to resolve it.</div><div><br></div><div>Regards,<=
/div><div>Mehdi.</div><br></div><div><span style=3D"font-family: &quot;Anda=
le Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Bitstream Vera Sans Mono&q=
uot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;, &quot;Ubuntu =
Mono&quot;, Monaco, Consolas, &quot;Lucida Console&quot;, &quot;Lucida Sans=
 Typewriter&quot;, &quot;Courier New&quot;, Courier, monospace; font-size: =
12px; white-space: pre-wrap;"><br></span></div><div><span style=3D"font-fam=
ily: &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &quot;Bitstream V=
era Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimbus Mono L&quot;=
, &quot;Ubuntu Mono&quot;, Monaco, Consolas, &quot;Lucida Console&quot;, &q=
uot;Lucida Sans Typewriter&quot;, &quot;Courier New&quot;, Courier, monospa=
ce; font-size: 12px; white-space: pre-wrap;"><br></span></div><div><span st=
yle=3D"font-family: &quot;Andale Mono WT&quot;, &quot;Andale Mono&quot;, &q=
uot;Bitstream Vera Sans Mono&quot;, &quot;Liberation Mono&quot;, &quot;Nimb=
us Mono L&quot;, &quot;Ubuntu Mono&quot;, Monaco, Consolas, &quot;Lucida Co=
nsole&quot;, &quot;Lucida Sans Typewriter&quot;, &quot;Courier New&quot;, C=
ourier, monospace; font-size: 12px; white-space: pre-wrap;"><br></span></di=
v><div><br></div><div><br></div><div><br></div><br></div><div><br></div>
           =20
            <div id=3D"yahoo_quoted_8362436092" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Ph=
ilippe Proulx &lt;eeppeliteloop@gmail.com&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D'ltr'><html><body>On Sun, Oct 8, 2017 a=
t 4:15 PM, MMM via lttng-dev<br clear=3D"none">&lt;<a shape=3D"rect" ymailt=
o=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng=
.org">lttng-dev@lists.lttng.org</a>&gt; wrote:<br clear=3D"none">&gt; Dear =
Users,<br clear=3D"none">&gt;<br clear=3D"none">&gt; I am beginner in traci=
ng using LTTng. At present, I am going to trace a java<br clear=3D"none">&g=
t; program in=C2=A0 Ubuntu, while I faced with a problem. When I install LT=
Tng on<br clear=3D"none">&gt; Ubuntu, I also install<br clear=3D"none">&gt;=
<br clear=3D"none">&gt; &quot;liblttng-ust-agent-java&quot; by &quot;apt-ge=
t install liblttng-ust-agent-java&quot;<br clear=3D"none">&gt; command in U=
buntu. But, when I want to import any libraries related to LTTng<br clear=
=3D"none">&gt; such as &quot;org.lttng.ust.agent.jul.LttngLogHandlerorg.ltt=
ng.ust.LTTngAgent&quot; to<br clear=3D"none">&gt; my program, it is marked =
as unknown package. Indeed, I could not find LTTng<br clear=3D"none">&gt; J=
ar file for adding it to my program libraries. Furthermore, I searched in<b=
r clear=3D"none">&gt; all files and folders, while I could not find Jar fil=
e. Could you please<br clear=3D"none">&gt; help me to understand the cause =
of this problem and solve it.<br clear=3D"none"><br clear=3D"none">I&#39;m =
not a Ubuntu specialist, but from<br clear=3D"none">&lt;<a shape=3D"rect" h=
ref=3D"https://packages.ubuntu.com/zesty/all/liblttng-ust-agent-java/fileli=
st" target=3D"_blank">https://packages.ubuntu.com/zesty/all/liblttng-ust-ag=
ent-java/filelist</a>&gt;,<br clear=3D"none">I would say:<br clear=3D"none"=
><br clear=3D"none">* /usr/share/java/lttng-ust-agent-jul.jar<br clear=3D"n=
one">* /usr/share/java/lttng-ust-agent-log4j.jar<br clear=3D"none"><br clea=
r=3D"none">On 16.04, it&#39;s:<br clear=3D"none"><br clear=3D"none">* /usr/=
share/java/liblttng-ust-agent.jar<br clear=3D"none"><br clear=3D"none">Add =
the required JAR file to your classpath.<br clear=3D"none"><br clear=3D"non=
e">Have a look at &lt;<a shape=3D"rect" href=3D"http://lttng.org/docs/v2.9/=
#doc-java-application" target=3D"_blank">http://lttng.org/docs/v2.9/#doc-ja=
va-application</a>&gt;.<br clear=3D"none"><br clear=3D"none">Phil<div class=
=3D"yqt0451103275" id=3D"yqtfd62043"><br clear=3D"none"><br clear=3D"none">=
&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; Best regards,<br clear=
=3D"none">&gt;<br clear=3D"none">&gt; Mehdi.<br clear=3D"none">&gt;<br clea=
r=3D"none">&gt;<br clear=3D"none">&gt; ____________________________________=
___________<br clear=3D"none">&gt; lttng-dev mailing list<br clear=3D"none"=
>&gt; <a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=
=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br clea=
r=3D"none">&gt; <a shape=3D"rect" href=3D"https://lists.lttng.org/cgi-bin/m=
ailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev</a><br clear=3D"none">&gt;<br clear=3D"none"><=
/div></body></html></div></div>
                </div>
            </div></div></body></html>
------=_Part_5312864_714234025.1507666332233--

--===============4283237090631100539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4283237090631100539==--
