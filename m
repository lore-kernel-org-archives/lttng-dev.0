From: MMM via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Problem in finding Jar file of LTTng for adding to
 Java project
Date: Tue, 17 Oct 2017 15:42:39 +0000 (UTC)
Message-ID: <1532070260.625832.1508254959043__19135.3246955716$1508255633$gmane$org@mail.yahoo.com>
References: <797428900.3787919.1507493725940.ref@mail.yahoo.com>
 <797428900.3787919.1507493725940@mail.yahoo.com>
 <CAB4xu_26Qmpzf-mccjY3HutmFBBLdEEDAxx5_WLdxdFARSzgNA@mail.gmail.com>
 <776772327.5312865.1507666332238@mail.yahoo.com>
 <37f91596-023e-f552-b07f-3b4e073399cd@voxpopuli.im>
 <850230324.98540.1507759558449@mail.yahoo.com>
 <415c1e82-6532-d4a8-c443-8263a1a3cc91@voxpopuli.im>
 <1302171483.738271.1507837087778@mail.yahoo.com>
 <5e5cbef3-794c-e4e1-8a02-bca432153031@voxpopuli.im>
 <670458818.2469.1508019513394@mail.yahoo.com>
 <34c576ec-e89f-60f2-fd8f-b3354a976bfc@voxpopuli.im>
 <CAB4xu_3=vRyUQqfZajrsw8zK09b5n-FYxS3qyAzuhhK=zVQ66w@mail.gmail.com>
Reply-To: MMM <e.morovati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6124652598690916872=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic308-11.consmr.mail.ne1.yahoo.com
 (sonic308-11.consmr.mail.ne1.yahoo.com [66.163.187.34])
 by lists.lttng.org (Postfix) with ESMTP id 3yGfqV2Cdtztqn
 for <lttng-dev@lists.lttng.org>; Tue, 17 Oct 2017 15:53:26 +0000 (UTC)
In-Reply-To: <CAB4xu_3=vRyUQqfZajrsw8zK09b5n-FYxS3qyAzuhhK=zVQ66w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>, Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6124652598690916872==
Content-Type: multipart/alternative;
	boundary="----=_Part_625829_1088333192.1508254959038"

------=_Part_625829_1088333192.1508254959038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 I checked all libraries which are listed in result of=C2=A0"ldd /usr/bin/l=
ttng"=C2=A0 command. Non of them are exit in=C2=A0/usr/local/lib. At presen=
t, I am going to reinstall my Ubuntu and check the status of my problem in =
the new Ubuntu. Could you please let me know which method for installing LT=
Tng is better? from source or from PPA?
Regards,Mehdi.
    On Monday, October 16, 2017, 7:14:48 PM GMT+3:30, Philippe Proulx <eepp=
eliteloop@gmail.com> wrote: =20
=20
 On Mon, Oct 16, 2017 at 8:13 AM, Alexandre Montplaisir
<alexmonthy@voxpopuli.im> wrote:
>
>
>
> On 2017-10-14 06:18 PM, MMM wrote:
> >=C2=A0 I installed LTTng from source at first. While after that, I also =
reinstall it from PPA. Is it the cause of my problem?
>
> Perhaps! Having a second installation in parallel is a common source of
> errors, because a binary from a given version may try to link with a
> library from another one.

I doubt that, because Automake sets explicit rpaths when installing.

The default install prefix for the PPA packages is /usr while the
default install prefix (unless you set it explicitly with --prefix at
configuration time) when you build from source is /usr/local. Unless
you're messing with LD_LIBRARY_PATH which takes precedence over the
binary's rpath, there's no conflict.

Phil

>
> Make sure you don't have any LTTng-related binaries or libraries in
> /usr/local/bin, /usr/local/lib, /usr/local/share/java, etc.
> You can also check the output of "ldd /usr/bin/lttng" and make sure only
> libraries from /usr/lib are listed, and not /usr/local/lib.
>
> Cheers,
> Alex
>
> >=C2=A0 =C2=A0 On Friday, October 13, 2017, 11:57:33 PM GMT+3:30, Alexand=
re Montplaisir <alexmonthy@voxpopuli.im> wrote:
> >
> >=C2=A0 On 2017-10-12 03:38 PM, MMM wrote:
> >> Dear Alex,
> >>
> >> As I mentioned, I used sample examples. for instance, I used mentioned
> >> simple program that you told tracing it return some result. While, I
> >> can not receive any result from tracing it. Also, I use Ubuntu 16.04
> >> LTS and lttng 2.9.5. Besides, the output of asked command is
> >>
> >> //////////////////
> >> -rw-r--r-- 1 root root 40871 Jun 16 13:56
> >> /usr/share/java/lttng-ust-agent-common-2.9.1.jar
> >> lrwxrwxrwx 1 root root=C2=A0 =C2=A0 32 Jun 16 13:56
> >> /usr/share/java/lttng-ust-agent-common.jar ->
> >> lttng-ust-agent-common-2.9.1.jar
> >> -rw-r--r-- 1 root root=C2=A0 4369 Jun 16 13:56
> >> /usr/share/java/lttng-ust-agent-jul-2.9.1.jar
> >> lrwxrwxrwx 1 root root=C2=A0 =C2=A0 29 Jun 16 13:56
> >> /usr/share/java/lttng-ust-agent-jul.jar -> lttng-ust-agent-jul-2.9.1.j=
ar
> >> -rw-r--r-- 1 root root=C2=A0 3933 Jun 16 13:56
> >> /usr/share/java/lttng-ust-agent-log4j-2.9.1.jar
> >> lrwxrwxrwx 1 root root=C2=A0 =C2=A0 31 Jun 16 13:56
> >> /usr/share/java/lttng-ust-agent-log4j.jar ->
> >> lttng-ust-agent-log4j-2.9.1.jar
> >> ////////////////////////////
> > Everything seems to be in order here.
> >
> > I will try your exact same environment to see if I can reproduce the is=
sue.
> > How did you install your LTTng 2.9? Was it from source, or from a PPA?
> > The Ubuntu 16.04 main archive only has 2.7.*
> >
> > Cheers,
> > Alex
> >
> >> Thanks for your attention.
> >> Regards,
> >> Mehdi.
> >>
> >> On Thursday, October 12, 2017, 6:51:12 PM GMT+3:30, Alexandre
> >> Montplaisir <alexmonthy@voxpopuli.im> wrote:
> >>
> >>
> >>
> >>
> >> On 2017-10-11 06:05 PM, MMM wrote:
> >>> Dear Alex,
> >>>
> >>> Thanks for your attention. I executed your commands step by step.
> >>> While, again I received previous errors which are
> >>>
> >>> [error] Cannot open any trace for reading.
> >>> [error] opening trace "[path]/lttng-traces/auto-20171011-145947" for
> >>> reading.
> >>> [error] none of the specified trace paths could be opened.
> >>>
> >>> I do not know the reason of this problem. Could you please help me to
> >>> resolve it?
> >> As Philippe mentioned previously, this means the trace is empty, so no
> >> events were produced by the session.
> >>
> >> Did any of the other commands (java, javac, lttng create,...) output a=
ny
> >> error messages?
> >>
> >>
> >> Finally, it would help if you could specify:
> >> - What version of Ubuntu you are running
> >>
> >> - What version of LTTng you are running ("lttng --version")
> >>
> >> - The output of the following command:
> >> $ ls -l /usr/share/java/lttng-ust*
> >>
> >> Thanks,
> >> Alex
> >>
> >>> Regards,
> >>> Mehdi.
> >>>
> >>>
> >>>
> >>>
> >>> On Wednesday, October 11, 2017, 6:09:41 PM GMT+3:30, Alexandre
> >>> Montplaisir <alexmonthy@voxpopuli.im
> >> <mailto:alexmonthy@voxpopuli.im>> wrote:
> >>>
> >>> Hi,
> >>>
> >>> I tried compiling and running your program, and it runs fine on my en=
d.
> >>> Here is what I did:
> >>>
> >>> saved the snippet below to "Hello.java"
> >>> $ apt install liblttng-ust-agent-java
> >>> $ javac -cp /usr/share/java/lttng-ust-agent-jul.jar Hello.java
> >>>
> >>> $ lttng create
> >>> $ lttng enable-event -a -j
> >>> $ lttng start
> >>> $ java -cp /usr/share/java/lttng-ust-agent-jul.jar:. Hello
> >>> $ lttng stop
> >>> $ lttng view
> >>>
> >>> and I get the following output:
> >>> Trace directory: /home/alexandre/lttng-traces/auto-20171011-102431
> >>>
> >>> [10:24:49.326824061] (+?.?????????) calista lttng_jul:event: { cpu_id=
 =3D
> >>> 2 }, { msg =3D "Hello World, the answer is 42", logger_name =3D "hell=
o",
> >>> class_name =3D "Hello", method_name =3D "main", long_millis =3D 15077=
31889299,
> >>> int_loglevel =3D 800, int_threadid =3D 1 }
> >>>
> >>>
> >>> Make sure you are setting the -classpath/-cp option correctly, this
> >>> could explain the "unknown package" error you were getting.
> >>>
> >>> Also note that you are using the deprecated "LTTngAgent.getLTTngAgent=
()"
> >>> API (the "javac" command should warn about it). It should still work,
> >>> but it's highly recommended to use the new API, as described in
> >>> https://lttng.org/docs/v2.10/#doc-jul
> >>> <https://lttng.org/docs/v2.10/#doc-jul%20>. Basically you have to
> >>> instantiate an "LttngLogHandler", and attach it to your Logger.
> >>>
> >>> HTH,
> >>> Alex
> >>>
> >>>
> >>> On 2017-10-10 04:12 PM, MMM via lttng-dev wrote:
> >>>> Dear Philippe,
> >>>>
> >>>> Thanks a lot for your consideration. I solved former problem. While,=
 I
> >>>> faced with a new problem. Indeed, when I create a LTTng session, sta=
rt
> >>>> it and finally stop LTTng, I could not find trace files in mentioned
> >>>> folder. My java code is
> >>>>
> >>>> ///////////////////////////////////////
> >>>> import java.io.IOException;
> >>>> import java.util.logging.Handler;
> >>>> import java.util.logging.Logger;
> >>>>
> >>>> import org.lttng.ust.agent.LTTngAgent;
> >>>> import org.lttng.ust.agent.jul.LttngLogHandler;
> >>>>
> >>>> public class Hello {
> >>>> private static final int answer =3D 42;
> >>>> private static LTTngAgent lttngAgent;
> >>>>
> >>>> public static void main(String[] args) throws InterruptedException {
> >>>> Logger helloLog =3D Logger.getLogger("hello");
> >>>> lttngAgent =3D LTTngAgent.getLTTngAgent();
> >>>>
> >>>> Thread.sleep(5000);
> >>>> helloLog.info("Hello World, the answer is " + answer);
> >>>> lttngAgent.dispose();
> >>>> }
> >>>>
> >>>> }
> >>>> ///////////////////////
> >>>>
> >>>> Also, I used following LTTng commands.
> >>>>
> >>>> ////////////////////////////////
> >>>> lttng create java-test
> >>>> lttng enable-event -a -l
> >>>> lttng start
> >>>> ///Start My java Application///
> >>>> lttng stop
> >>>> ////////////////////////////
> >>>>
> >>>> Besides, when I used "lttng view" after stopping LTTng, I received
> >>>> following error message
> >>>>
> >>>> [error] Cannot open any trace for reading.
> >>>> [error] opening trace
> >>>> "/[path]/lttng-traces/java-test10-20171010-130909" for reading.
> >>>> [error] none of the specified trace paths could be opened.
> >>>>
> >>>> Could you please help me to resolve it.
> >>>>
> >>>> Regards,
> >>>> Mehdi.
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> On Monday, October 9, 2017, 1:05:59 AM GMT+3:30, Philippe Proulx
> >>>> <eeppeliteloop@gmail.com <mailto:eeppeliteloop@gmail.com>
> >> <mailto:eeppeliteloop@gmail.com <mailto:eeppeliteloop@gmail.com>>> wro=
te:
> >>>>
> >>>> On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev
> >>>> <lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>
> >>> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>>=
>
> >>> wrote:
> >>>>> Dear Users,
> >>>>>
> >>>>> I am beginner in tracing using LTTng. At present, I am going to
> >>>> trace a java
> >>>>> program in=C2=A0 Ubuntu, while I faced with a problem. When I insta=
ll
> >>>> LTTng on
> >>>>> Ubuntu, I also install
> >>>>>
> >>>>> "liblttng-ust-agent-java" by "apt-get install
> >> liblttng-ust-agent-java"
> >>>>> command in Ubuntu. But, when I want to import any libraries related
> >>>> to LTTng
> >>>>> such as
> >>>> "org.lttng.ust.agent.jul.LttngLogHandlerorg.lttng.ust.LTTngAgent" to
> >>>>> my program, it is marked as unknown package. Indeed, I could not
> >>>> find LTTng
> >>>>> Jar file for adding it to my program libraries. Furthermore, I
> >>>> searched in
> >>>>> all files and folders, while I could not find Jar file. Could you
> >>> please
> >>>>> help me to understand the cause of this problem and solve it.
> >>>> I'm not a Ubuntu specialist, but from
> >>>>
> >> <https://packages.ubuntu.com/zesty/all/liblttng-ust-agent-java/filelis=
t>,
> >>>> I would say:
> >>>>
> >>>> * /usr/share/java/lttng-ust-agent-jul.jar
> >>>> * /usr/share/java/lttng-ust-agent-log4j.jar
> >>>>
> >>>> On 16.04, it's:
> >>>>
> >>>> * /usr/share/java/liblttng-ust-agent.jar
> >>>>
> >>>> Add the required JAR file to your classpath.
> >>>>
> >>>> Have a look at <http://lttng.org/docs/v2.9/#doc-java-application>.
> >>>>
> >>>> Phil
> >>>>
> >>>>
> >>>>>
> >>>>> Best regards,
> >>>>>
> >>>>> Mehdi.
> >>>>>
> >>>>>
> >>>>> _______________________________________________
> >>>>> lttng-dev mailing list
> >>>>> lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>
> >>> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>>
> >>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>>>
> >>>> _______________________________________________
> >>>> lttng-dev mailing list
> >>>> lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
> >> <mailto:lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>>
> >>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_625829_1088333192.1508254959038
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:courier new, courier, mo=
naco, monospace, sans-serif;font-size:13px;"><div></div>
            <div>I checked all libraries which are listed in result of<span=
 style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-s=
erif;">&nbsp;"ldd /usr/bin/lttng"&nbsp; command. Non of them are exit in&nb=
sp;<span style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial=
, sans-serif;">/usr/local/lib. At present, I am going to reinstall my Ubunt=
u and check the status of my problem in the new Ubuntu. Could you please le=
t me know which method for installing LTTng is better? from source or from =
PPA?</span></span></div><div><span style=3D"font-family: &quot;Helvetica Ne=
ue&quot;, Helvetica, Arial, sans-serif;"><span style=3D"font-family: &quot;=
Helvetica Neue&quot;, Helvetica, Arial, sans-serif;"><br></span></span></di=
v><div><span style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, A=
rial, sans-serif;"><span style=3D"font-family: &quot;Helvetica Neue&quot;, =
Helvetica, Arial, sans-serif;">Regards,</span></span></div><div><span style=
=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;"=
><span style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, =
sans-serif;">Mehdi.</span></span></div><div><br></div>
           =20
            <div id=3D"yahoo_quoted_8278973122" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
                   =20
                    <div>
                        On Monday, October 16, 2017, 7:14:48 PM GMT+3:30, P=
hilippe Proulx &lt;eeppeliteloop@gmail.com&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D'ltr'><html><body>On Mon, Oct 16, 2017 =
at 8:13 AM, Alexandre Montplaisir<br clear=3D"none">&lt;<a shape=3D"rect" y=
mailto=3D"mailto:alexmonthy@voxpopuli.im" href=3D"mailto:alexmonthy@voxpopu=
li.im">alexmonthy@voxpopuli.im</a>&gt; wrote:<br clear=3D"none">&gt;<br cle=
ar=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; On 2017-10-1=
4 06:18 PM, MMM wrote:<br clear=3D"none">&gt; &gt;=C2=A0 I installed LTTng =
from source at first. While after that, I also reinstall it from PPA. Is it=
 the cause of my problem?<br clear=3D"none">&gt;<br clear=3D"none">&gt; Per=
haps! Having a second installation in parallel is a common source of<br cle=
ar=3D"none">&gt; errors, because a binary from a given version may try to l=
ink with a<br clear=3D"none">&gt; library from another one.<br clear=3D"non=
e"><br clear=3D"none">I doubt that, because Automake sets explicit rpaths w=
hen installing.<br clear=3D"none"><br clear=3D"none">The default install pr=
efix for the PPA packages is /usr while the<br clear=3D"none">default insta=
ll prefix (unless you set it explicitly with --prefix at<br clear=3D"none">=
configuration time) when you build from source is /usr/local. Unless<br cle=
ar=3D"none">you&#39;re messing with LD_LIBRARY_PATH which takes precedence =
over the<br clear=3D"none">binary&#39;s rpath, there&#39;s no conflict.<br =
clear=3D"none"><br clear=3D"none">Phil<br clear=3D"none"><br clear=3D"none"=
>&gt;<br clear=3D"none">&gt; Make sure you don&#39;t have any LTTng-related=
 binaries or libraries in<br clear=3D"none">&gt; /usr/local/bin, /usr/local=
/lib, /usr/local/share/java, etc.<br clear=3D"none">&gt; You can also check=
 the output of &quot;ldd /usr/bin/lttng&quot; and make sure only<br clear=
=3D"none">&gt; libraries from /usr/lib are listed, and not /usr/local/lib.<=
br clear=3D"none">&gt;<br clear=3D"none">&gt; Cheers,<br clear=3D"none">&gt=
; Alex<br clear=3D"none">&gt;<br clear=3D"none">&gt; &gt;=C2=A0 =C2=A0 On F=
riday, October 13, 2017, 11:57:33 PM GMT+3:30, Alexandre Montplaisir &lt;<a=
 shape=3D"rect" ymailto=3D"mailto:alexmonthy@voxpopuli.im" href=3D"mailto:a=
lexmonthy@voxpopuli.im">alexmonthy@voxpopuli.im</a>&gt; wrote:<br clear=3D"=
none">&gt; &gt;<br clear=3D"none">&gt; &gt;=C2=A0 On 2017-10-12 03:38 PM, M=
MM wrote:<br clear=3D"none">&gt; &gt;&gt; Dear Alex,<br clear=3D"none">&gt;=
 &gt;&gt;<br clear=3D"none">&gt; &gt;&gt; As I mentioned, I used sample exa=
mples. for instance, I used mentioned<br clear=3D"none">&gt; &gt;&gt; simpl=
e program that you told tracing it return some result. While, I<br clear=3D=
"none">&gt; &gt;&gt; can not receive any result from tracing it. Also, I us=
e Ubuntu 16.04<br clear=3D"none">&gt; &gt;&gt; LTS and lttng 2.9.5. Besides=
, the output of asked command is<br clear=3D"none">&gt; &gt;&gt;<br clear=
=3D"none">&gt; &gt;&gt; //////////////////<br clear=3D"none">&gt; &gt;&gt; =
-rw-r--r-- 1 root root 40871 Jun 16 13:56<br clear=3D"none">&gt; &gt;&gt; /=
usr/share/java/lttng-ust-agent-common-2.9.1.jar<br clear=3D"none">&gt; &gt;=
&gt; lrwxrwxrwx 1 root root=C2=A0 =C2=A0 32 Jun 16 13:56<br clear=3D"none">=
&gt; &gt;&gt; /usr/share/java/lttng-ust-agent-common.jar -&gt;<br clear=3D"=
none">&gt; &gt;&gt; lttng-ust-agent-common-2.9.1.jar<br clear=3D"none">&gt;=
 &gt;&gt; -rw-r--r-- 1 root root=C2=A0 4369 Jun 16 13:56<br clear=3D"none">=
&gt; &gt;&gt; /usr/share/java/lttng-ust-agent-jul-2.9.1.jar<br clear=3D"non=
e">&gt; &gt;&gt; lrwxrwxrwx 1 root root=C2=A0 =C2=A0 29 Jun 16 13:56<br cle=
ar=3D"none">&gt; &gt;&gt; /usr/share/java/lttng-ust-agent-jul.jar -&gt; ltt=
ng-ust-agent-jul-2.9.1.jar<br clear=3D"none">&gt; &gt;&gt; -rw-r--r-- 1 roo=
t root=C2=A0 3933 Jun 16 13:56<br clear=3D"none">&gt; &gt;&gt; /usr/share/j=
ava/lttng-ust-agent-log4j-2.9.1.jar<br clear=3D"none">&gt; &gt;&gt; lrwxrwx=
rwx 1 root root=C2=A0 =C2=A0 31 Jun 16 13:56<br clear=3D"none">&gt; &gt;&gt=
; /usr/share/java/lttng-ust-agent-log4j.jar -&gt;<br clear=3D"none">&gt; &g=
t;&gt; lttng-ust-agent-log4j-2.9.1.jar<br clear=3D"none">&gt; &gt;&gt; ////=
////////////////////////<br clear=3D"none">&gt; &gt; Everything seems to be=
 in order here.<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt; I w=
ill try your exact same environment to see if I can reproduce the issue.<br=
 clear=3D"none">&gt; &gt; How did you install your LTTng 2.9? Was it from s=
ource, or from a PPA?<br clear=3D"none">&gt; &gt; The Ubuntu 16.04 main arc=
hive only has 2.7.*<br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt; &gt;=
 Cheers,<br clear=3D"none">&gt; &gt; Alex<br clear=3D"none">&gt; &gt;<br cl=
ear=3D"none">&gt; &gt;&gt; Thanks for your attention.<br clear=3D"none">&gt=
; &gt;&gt; Regards,<br clear=3D"none">&gt; &gt;&gt; Mehdi.<br clear=3D"none=
">&gt; &gt;&gt;<br clear=3D"none">&gt; &gt;&gt; On Thursday, October 12, 20=
17, 6:51:12 PM GMT+3:30, Alexandre<br clear=3D"none">&gt; &gt;&gt; Montplai=
sir &lt;<a shape=3D"rect" ymailto=3D"mailto:alexmonthy@voxpopuli.im" href=
=3D"mailto:alexmonthy@voxpopuli.im">alexmonthy@voxpopuli.im</a>&gt; wrote:<=
br clear=3D"none">&gt; &gt;&gt;<br clear=3D"none">&gt; &gt;&gt;<br clear=3D=
"none">&gt; &gt;&gt;<br clear=3D"none">&gt; &gt;&gt;<br clear=3D"none">&gt;=
 &gt;&gt; On 2017-10-11 06:05 PM, MMM wrote:<br clear=3D"none">&gt; &gt;&gt=
;&gt; Dear Alex,<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt;=
 &gt;&gt;&gt; Thanks for your attention. I executed your commands step by s=
tep.<br clear=3D"none">&gt; &gt;&gt;&gt; While, again I received previous e=
rrors which are<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt; =
&gt;&gt;&gt; [error] Cannot open any trace for reading.<br clear=3D"none">&=
gt; &gt;&gt;&gt; [error] opening trace &quot;[path]/lttng-traces/auto-20171=
011-145947&quot; for<br clear=3D"none">&gt; &gt;&gt;&gt; reading.<br clear=
=3D"none">&gt; &gt;&gt;&gt; [error] none of the specified trace paths could=
 be opened.<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt; &gt;=
&gt;&gt; I do not know the reason of this problem. Could you please help me=
 to<br clear=3D"none">&gt; &gt;&gt;&gt; resolve it?<br clear=3D"none">&gt; =
&gt;&gt; As Philippe mentioned previously, this means the trace is empty, s=
o no<br clear=3D"none">&gt; &gt;&gt; events were produced by the session.<b=
r clear=3D"none">&gt; &gt;&gt;<br clear=3D"none">&gt; &gt;&gt; Did any of t=
he other commands (java, javac, lttng create,...) output any<br clear=3D"no=
ne">&gt; &gt;&gt; error messages?<br clear=3D"none">&gt; &gt;&gt;<br clear=
=3D"none">&gt; &gt;&gt;<br clear=3D"none">&gt; &gt;&gt; Finally, it would h=
elp if you could specify:<br clear=3D"none">&gt; &gt;&gt; - What version of=
 Ubuntu you are running<br clear=3D"none">&gt; &gt;&gt;<br clear=3D"none">&=
gt; &gt;&gt; - What version of LTTng you are running (&quot;lttng --version=
&quot;)<br clear=3D"none">&gt; &gt;&gt;<br clear=3D"none">&gt; &gt;&gt; - T=
he output of the following command:<br clear=3D"none">&gt; &gt;&gt; $ ls -l=
 /usr/share/java/lttng-ust*<br clear=3D"none">&gt; &gt;&gt;<br clear=3D"non=
e">&gt; &gt;&gt; Thanks,<br clear=3D"none">&gt; &gt;&gt; Alex<br clear=3D"n=
one">&gt; &gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt; Regards,<br clear=3D=
"none">&gt; &gt;&gt;&gt; Mehdi.<br clear=3D"none">&gt; &gt;&gt;&gt;<br clea=
r=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=
=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt; On Wednesda=
y, October 11, 2017, 6:09:41 PM GMT+3:30, Alexandre<br clear=3D"none">&gt; =
&gt;&gt;&gt; Montplaisir &lt;<a shape=3D"rect" ymailto=3D"mailto:alexmonthy=
@voxpopuli.im" href=3D"mailto:alexmonthy@voxpopuli.im">alexmonthy@voxpopuli=
.im</a><br clear=3D"none">&gt; &gt;&gt; &lt;mailto:<a shape=3D"rect" ymailt=
o=3D"mailto:alexmonthy@voxpopuli.im" href=3D"mailto:alexmonthy@voxpopuli.im=
">alexmonthy@voxpopuli.im</a>&gt;&gt; wrote:<br clear=3D"none">&gt; &gt;&gt=
;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt; Hi,<br clear=3D"none">&gt; &gt;&g=
t;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt; I tried compiling and running yo=
ur program, and it runs fine on my end.<br clear=3D"none">&gt; &gt;&gt;&gt;=
 Here is what I did:<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">=
&gt; &gt;&gt;&gt; saved the snippet below to &quot;Hello.java&quot;<br clea=
r=3D"none">&gt; &gt;&gt;&gt; $ apt install liblttng-ust-agent-java<br clear=
=3D"none">&gt; &gt;&gt;&gt; $ javac -cp /usr/share/java/lttng-ust-agent-jul=
.jar Hello.java<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt; =
&gt;&gt;&gt; $ lttng create<br clear=3D"none">&gt; &gt;&gt;&gt; $ lttng ena=
ble-event -a -j<br clear=3D"none">&gt; &gt;&gt;&gt; $ lttng start<br clear=
=3D"none">&gt; &gt;&gt;&gt; $ java -cp /usr/share/java/lttng-ust-agent-jul.=
jar:. Hello<br clear=3D"none">&gt; &gt;&gt;&gt; $ lttng stop<br clear=3D"no=
ne">&gt; &gt;&gt;&gt; $ lttng view<br clear=3D"none">&gt; &gt;&gt;&gt;<br c=
lear=3D"none">&gt; &gt;&gt;&gt; and I get the following output:<br clear=3D=
"none">&gt; &gt;&gt;&gt; Trace directory: /home/alexandre/lttng-traces/auto=
-20171011-102431<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt;=
 &gt;&gt;&gt; [10:24:49.326824061] (+?.?????????) calista lttng_jul:event: =
{ cpu_id =3D<br clear=3D"none">&gt; &gt;&gt;&gt; 2 }, { msg =3D &quot;Hello=
 World, the answer is 42&quot;, logger_name =3D &quot;hello&quot;,<br clear=
=3D"none">&gt; &gt;&gt;&gt; class_name =3D &quot;Hello&quot;, method_name =
=3D &quot;main&quot;, long_millis =3D 1507731889299,<br clear=3D"none">&gt;=
 &gt;&gt;&gt; int_loglevel =3D 800, int_threadid =3D 1 }<br clear=3D"none">=
&gt; &gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt=
; &gt;&gt;&gt; Make sure you are setting the -classpath/-cp option correctl=
y, this<br clear=3D"none">&gt; &gt;&gt;&gt; could explain the &quot;unknown=
 package&quot; error you were getting.<br clear=3D"none">&gt; &gt;&gt;&gt;<=
br clear=3D"none">&gt; &gt;&gt;&gt; Also note that you are using the deprec=
ated &quot;LTTngAgent.getLTTngAgent()&quot;<br clear=3D"none">&gt; &gt;&gt;=
&gt; API (the &quot;javac&quot; command should warn about it). It should st=
ill work,<br clear=3D"none">&gt; &gt;&gt;&gt; but it&#39;s highly recommend=
ed to use the new API, as described in<br clear=3D"none">&gt; &gt;&gt;&gt; =
<a shape=3D"rect" href=3D"https://lttng.org/docs/v2.10/#doc-jul" target=3D"=
_blank">https://lttng.org/docs/v2.10/#doc-jul</a><br clear=3D"none">&gt; &g=
t;&gt;&gt; &lt;<a shape=3D"rect" href=3D"https://lttng.org/docs/v2.10/#doc-=
jul%20" target=3D"_blank">https://lttng.org/docs/v2.10/#doc-jul%20</a>&gt;.=
 Basically you have to<br clear=3D"none">&gt; &gt;&gt;&gt; instantiate an &=
quot;LttngLogHandler&quot;, and attach it to your Logger.<br clear=3D"none"=
>&gt; &gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt; HTH,<br clear=3D"non=
e">&gt; &gt;&gt;&gt; Alex<br clear=3D"none">&gt; &gt;&gt;&gt;<br clear=3D"n=
one">&gt; &gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt; On 2017-10-10 04=
:12 PM, MMM via lttng-dev wrote:<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; De=
ar Philippe,<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt;=
 &gt;&gt;&gt;&gt; Thanks a lot for your consideration. I solved former prob=
lem. While, I<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; faced with a new prob=
lem. Indeed, when I create a LTTng session, start<br clear=3D"none">&gt; &g=
t;&gt;&gt;&gt; it and finally stop LTTng, I could not find trace files in m=
entioned<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; folder. My java code is<br=
 clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&g=
t; ///////////////////////////////////////<br clear=3D"none">&gt; &gt;&gt;&=
gt;&gt; import java.io.IOException;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;=
 import java.util.logging.Handler;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; =
import java.util.logging.Logger;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br=
 clear=3D"none">&gt; &gt;&gt;&gt;&gt; import org.lttng.ust.agent.LTTngAgent=
;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; import org.lttng.ust.agent.jul.Lt=
tngLogHandler;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&g=
t; &gt;&gt;&gt;&gt; public class Hello {<br clear=3D"none">&gt; &gt;&gt;&gt=
;&gt; private static final int answer =3D 42;<br clear=3D"none">&gt; &gt;&g=
t;&gt;&gt; private static LTTngAgent lttngAgent;<br clear=3D"none">&gt; &gt=
;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; public static void ma=
in(String[] args) throws InterruptedException {<br clear=3D"none">&gt; &gt;=
&gt;&gt;&gt; Logger helloLog =3D Logger.getLogger(&quot;hello&quot;);<br cl=
ear=3D"none">&gt; &gt;&gt;&gt;&gt; lttngAgent =3D LTTngAgent.getLTTngAgent(=
);<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&=
gt;&gt; Thread.sleep(5000);<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; helloLo=
g.info(&quot;Hello World, the answer is &quot; + answer);<br clear=3D"none"=
>&gt; &gt;&gt;&gt;&gt; lttngAgent.dispose();<br clear=3D"none">&gt; &gt;&gt=
;&gt;&gt; }<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; =
&gt;&gt;&gt;&gt; }<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; ////////////////=
///////<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;=
&gt;&gt;&gt; Also, I used following LTTng commands.<br clear=3D"none">&gt; =
&gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; //////////////////=
//////////////<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; lttng create java-te=
st<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; lttng enable-event -a -l<br clea=
r=3D"none">&gt; &gt;&gt;&gt;&gt; lttng start<br clear=3D"none">&gt; &gt;&gt=
;&gt;&gt; ///Start My java Application///<br clear=3D"none">&gt; &gt;&gt;&g=
t;&gt; lttng stop<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; /////////////////=
///////////<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; =
&gt;&gt;&gt;&gt; Besides, when I used &quot;lttng view&quot; after stopping=
 LTTng, I received<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; following error =
message<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;=
&gt;&gt;&gt; [error] Cannot open any trace for reading.<br clear=3D"none">&=
gt; &gt;&gt;&gt;&gt; [error] opening trace<br clear=3D"none">&gt; &gt;&gt;&=
gt;&gt; &quot;/[path]/lttng-traces/java-test10-20171010-130909&quot; for re=
ading.<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; [error] none of the specifie=
d trace paths could be opened.<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br c=
lear=3D"none">&gt; &gt;&gt;&gt;&gt; Could you please help me to resolve it.=
<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt=
;&gt; Regards,<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; Mehdi.<br clear=3D"n=
one">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=
=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br =
clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt=
;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; On Monday, October 9, 2017, 1:05:=
59 AM GMT+3:30, Philippe Proulx<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; &lt=
;<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmail.com" href=3D"mailt=
o:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a> &lt;mailto:<a shape=
=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmail.com" href=3D"mailto:eeppeli=
teloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;<br clear=3D"none">&gt; &g=
t;&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmail.c=
om" href=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a> &lt=
;mailto:<a shape=3D"rect" ymailto=3D"mailto:eeppeliteloop@gmail.com" href=
=3D"mailto:eeppeliteloop@gmail.com">eeppeliteloop@gmail.com</a>&gt;&gt;&gt;=
 wrote:<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;=
&gt;&gt;&gt; On Sun, Oct 8, 2017 at 4:15 PM, MMM via lttng-dev<br clear=3D"=
none">&gt; &gt;&gt;&gt;&gt; &lt;<a shape=3D"rect" ymailto=3D"mailto:lttng-d=
ev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lis=
ts.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@l=
ists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.l=
ttng.org</a>&gt;<br clear=3D"none">&gt; &gt;&gt; &lt;mailto:<a shape=3D"rec=
t" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@li=
sts.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" y=
mailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.=
lttng.org">lttng-dev@lists.lttng.org</a>&gt;&gt;<br clear=3D"none">&gt; &gt=
;&gt;&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lt=
tng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.or=
g</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.=
org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a=
>&gt;<br clear=3D"none">&gt; &gt;&gt; &lt;mailto:<a shape=3D"rect" ymailto=
=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.=
org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"=
mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org"=
>lttng-dev@lists.lttng.org</a>&gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&=
gt;&gt; wrote:<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; Dear Users,<br c=
lear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;=
&gt;&gt; I am beginner in tracing using LTTng. At present, I am going to<br=
 clear=3D"none">&gt; &gt;&gt;&gt;&gt; trace a java<br clear=3D"none">&gt; &=
gt;&gt;&gt;&gt;&gt; program in=C2=A0 Ubuntu, while I faced with a problem. =
When I install<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; LTTng on<br clear=3D=
"none">&gt; &gt;&gt;&gt;&gt;&gt; Ubuntu, I also install<br clear=3D"none">&=
gt; &gt;&gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; &quot;=
liblttng-ust-agent-java&quot; by &quot;apt-get install<br clear=3D"none">&g=
t; &gt;&gt; liblttng-ust-agent-java&quot;<br clear=3D"none">&gt; &gt;&gt;&g=
t;&gt;&gt; command in Ubuntu. But, when I want to import any libraries rela=
ted<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; to LTTng<br clear=3D"none">&gt;=
 &gt;&gt;&gt;&gt;&gt; such as<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; &quot=
;org.lttng.ust.agent.jul.LttngLogHandlerorg.lttng.ust.LTTngAgent&quot; to<b=
r clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; my program, it is marked as unkn=
own package. Indeed, I could not<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; fi=
nd LTTng<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; Jar file for adding it=
 to my program libraries. Furthermore, I<br clear=3D"none">&gt; &gt;&gt;&gt=
;&gt; searched in<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; all files and=
 folders, while I could not find Jar file. Could you<br clear=3D"none">&gt;=
 &gt;&gt;&gt; please<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; help me to=
 understand the cause of this problem and solve it.<br clear=3D"none">&gt; =
&gt;&gt;&gt;&gt; I&#39;m not a Ubuntu specialist, but from<br clear=3D"none=
">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt; &lt;<a shape=3D"rec=
t" href=3D"https://packages.ubuntu.com/zesty/all/liblttng-ust-agent-java/fi=
lelist" target=3D"_blank">https://packages.ubuntu.com/zesty/all/liblttng-us=
t-agent-java/filelist</a>&gt;,<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; I wo=
uld say:<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt=
;&gt;&gt;&gt; * /usr/share/java/lttng-ust-agent-jul.jar<br clear=3D"none">&=
gt; &gt;&gt;&gt;&gt; * /usr/share/java/lttng-ust-agent-log4j.jar<br clear=
=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; On =
16.04, it&#39;s:<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">=
&gt; &gt;&gt;&gt;&gt; * /usr/share/java/liblttng-ust-agent.jar<br clear=3D"=
none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; Add the=
 required JAR file to your classpath.<br clear=3D"none">&gt; &gt;&gt;&gt;&g=
t;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; Have a look at &lt;<a shape=3D"r=
ect" href=3D"http://lttng.org/docs/v2.9/#doc-java-application" target=3D"_b=
lank">http://lttng.org/docs/v2.9/#doc-java-application</a>&gt;.<br clear=3D=
"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; Phil<b=
r clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&=
gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;=
&gt;&gt;&gt;&gt; Best regards,<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt;<=
br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; Mehdi.<br clear=3D"none">&gt; &=
gt;&gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt;<br clear=3D=
"none">&gt; &gt;&gt;&gt;&gt;&gt; __________________________________________=
_____<br clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; lttng-dev mailing list<br=
 clear=3D"none">&gt; &gt;&gt;&gt;&gt;&gt; <a shape=3D"rect" ymailto=3D"mail=
to:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">ltt=
ng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:l=
ttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-d=
ev@lists.lttng.org</a>&gt;<br clear=3D"none">&gt; &gt;&gt; &lt;mailto:<a sh=
ape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lt=
tng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=
=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng=
-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt;&gt;<br clear=3D"non=
e">&gt; &gt;&gt;&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-d=
ev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lis=
ts.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@l=
ists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.l=
ttng.org</a>&gt;<br clear=3D"none">&gt; &gt;&gt; &lt;mailto:<a shape=3D"rec=
t" ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@li=
sts.lttng.org">lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" y=
mailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.=
lttng.org">lttng-dev@lists.lttng.org</a>&gt;&gt;&gt;<br clear=3D"none">&gt;=
 &gt;&gt;&gt;&gt;&gt; <a shape=3D"rect" href=3D"https://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev" target=3D"_blank">https://lists.lttng.org/=
cgi-bin/mailman/listinfo/lttng-dev</a><div class=3D"yqt4174658560" id=3D"yq=
tfd18322"><br clear=3D"none">&gt; &gt;&gt;&gt;&gt;<br clear=3D"none">&gt; &=
gt;&gt;&gt;&gt; _______________________________________________<br clear=3D=
"none">&gt; &gt;&gt;&gt;&gt; lttng-dev mailing list<br clear=3D"none">&gt; =
&gt;&gt;&gt;&gt; <a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.=
org" href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a=
> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailto:lttng-dev@lists.lttng.org"=
 href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt=
;<br clear=3D"none">&gt; &gt;&gt; &lt;mailto:<a shape=3D"rect" ymailto=3D"m=
ailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">=
lttng-dev@lists.lttng.org</a> &lt;mailto:<a shape=3D"rect" ymailto=3D"mailt=
o:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists.lttng.org">lttn=
g-dev@lists.lttng.org</a>&gt;&gt;<br clear=3D"none">&gt; &gt;&gt;&gt;&gt; <=
a shape=3D"rect" href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev</a><br clear=3D"none">&gt; &gt;<br clear=3D"none">&gt;<br clear=
=3D"none">&gt; _______________________________________________<br clear=3D"=
none">&gt; lttng-dev mailing list<br clear=3D"none">&gt; <a shape=3D"rect" =
ymailto=3D"mailto:lttng-dev@lists.lttng.org" href=3D"mailto:lttng-dev@lists=
.lttng.org">lttng-dev@lists.lttng.org</a><br clear=3D"none">&gt; <a shape=
=3D"rect" href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev</a><br clear=3D"none"></div></body></html></div></div>
                </div>
            </div></div></body></html>
------=_Part_625829_1088333192.1508254959038--

--===============6124652598690916872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6124652598690916872==--
