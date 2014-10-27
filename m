From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: [PATCH lttng-tools] Fix: mi test: possible race
 between listing UST events and testapp start
Date: Mon, 27 Oct 2014 18:50:40 -0400
Message-ID: <CAF4oYfH46xdc1cYg6Q_5ETypEoduO1t9Hre5f6Ey_wycdxQ6Zg__39052.9479984709$1414450294$gmane$org@mail.gmail.com>
References: <1414372906-22433-1-git-send-email-jonathan.r.julien@gmail.com>
 <544EAF8F.7070904@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0710596870=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jonathan.r.julien@gmail.com>) id 1Xit7e-0000iH-HG
 for lttng-dev@lists.lttng.org; Mon, 27 Oct 2014 18:50:48 -0400
Received: by mail-yh0-f50.google.com with SMTP id b6so851636yha.9
 for <lttng-dev@lists.lttng.org>; Mon, 27 Oct 2014 15:50:40 -0700 (PDT)
In-Reply-To: <544EAF8F.7070904@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Nathan Lynch <Nathan_Lynch@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0710596870==
Content-Type: multipart/alternative; boundary=089e013a0bc627ba7b05066f5cdd

--089e013a0bc627ba7b05066f5cdd
Content-Type: text/plain; charset=UTF-8

Hey

On Mon, Oct 27, 2014 at 4:48 PM, Nathan Lynch <Nathan_Lynch@mentor.com>
wrote:

> On 10/26/2014 08:21 PM, Jonathan Rajotte wrote:
> > Signed-off-by: Jonathan Rajotte <jonathan.r.julien@gmail.com>
>
> More description of the change is needed IMO.
>
> > ---
> >  tests/regression/tools/mi/test_mi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tests/regression/tools/mi/test_mi
> b/tests/regression/tools/mi/test_mi
> > index fa46b51..7acec18 100755
> > --- a/tests/regression/tools/mi/test_mi
> > +++ b/tests/regression/tools/mi/test_mi
> > @@ -507,6 +507,11 @@ function test_list_ust_event ()
> >
> >       #Begin testing
> >       $TESTAPP_BIN $NR_USEC_WAIT & 2>/dev/null
> > +     pid=$!
> > +
> > +     #Wait for TESTAPP to run
> > +     while ! kill -0 $pid 2> /dev/null; do :; done
> > +
> >       list_lttng_with_opts "-u -f"
>
> Is this an attempt to give the test program enough time to register
> tracepoints?
>

A poor one... if one at all.... for which I needed feedback (missing rfc
tag here) because I could not simply find any simple way. See [1]


> If so, I agree there is a race, but I don't think this is the right way
> to address it.

   I would not expect the while ! kill loop to repeat at

> all;


The presence of ":" assure the execution of the while loop.
A simple test on a process that does not exist yield a lot of printing:

while ! kill -0 500; do :; done

Anyway it does not solve the problem. ;) and I'm not sure you were talking
about that.

if you remove the stderr redirection do you see any output, ever?

The exit status from kill $! is not a reliable indication that the shell
> has execve'd the program in the background, and even if it were, it
> would not be a reliable indication of how far the program has progressed


+1

(e.g. whether it has got far enough along to register tracepoints).
>
>

> If a test program needs to run in the background, yet needs to reach a
> certain state before the rest of the test should proceed, then it should
> have a way to indicate to the test harness that it has reached the
> desired state.  The shell's rudimentary facilities for managing
> concurrency are not sufficient.
>

I'm pushing limits here regarding simplicity: how about a trap and signal
exchange between the testapp... might give it a shot. Or a simple sleep...

Thanks, I'll think about it a little more.

[1]:http://meta.wikimedia.org/wiki/Cunningham%27s_Law
Bonus xkcd: http://xkcd.com/386/

--089e013a0bc627ba7b05066f5cdd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Mon, Oct 27, 2014 at 4:48 PM, Nathan Lynch <span dir=3D"ltr">&lt;=
<a href=3D"mailto:Nathan_Lynch@mentor.com" target=3D"_blank">Nathan_Lynch@m=
entor.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">On 10/26/2014 08:21 PM=
, Jonathan Rajotte wrote:<br>
&gt; Signed-off-by: Jonathan Rajotte &lt;<a href=3D"mailto:jonathan.r.julie=
n@gmail.com" target=3D"_blank">jonathan.r.julien@gmail.com</a>&gt;<br>
<br>
More description of the change is needed IMO.<br>
<span><br>
&gt; ---<br>
&gt;=C2=A0 tests/regression/tools/mi/test_mi | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt;<br>
&gt; diff --git a/tests/regression/tools/mi/test_mi b/tests/regression/tool=
s/mi/test_mi<br>
&gt; index fa46b51..7acec18 100755<br>
&gt; --- a/tests/regression/tools/mi/test_mi<br>
&gt; +++ b/tests/regression/tools/mi/test_mi<br>
&gt; @@ -507,6 +507,11 @@ function test_list_ust_event ()<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#Begin testing<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN $NR_USEC_WAIT &amp; 2&gt;/dev/n=
ull<br>
&gt; +=C2=A0 =C2=A0 =C2=A0pid=3D$!<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#Wait for TESTAPP to run<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while ! kill -0 $pid 2&gt; /dev/null; do :; done<=
br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0list_lttng_with_opts &quot;-u -f&quot;<br>
<br>
</span>Is this an attempt to give the test program enough time to register<=
br>
tracepoints?<br></blockquote><div><br></div><div>A poor one... if one at al=
l.... for which I needed feedback (missing rfc tag here) because I could no=
t simply find any simple way. See [1]</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<br>
If so, I agree there is a race, but I don&#39;t think this is the right way=
<br>
to address it.</blockquote><div>=C2=A0 =C2=A0I would not expect the while !=
 kill loop to repeat at</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,2=
04);border-left-style:solid;padding-left:1ex">
all;</blockquote><div><br></div><div>The presence of &quot;:&quot; assure t=
he execution of the while loop.</div><div>A simple test on a process that d=
oes not exist yield a lot of printing:</div><div><br></div><div>while ! kil=
l -0 500; do :; done</div><div>=C2=A0</div><div>Anyway it does not solve th=
e problem. ;) and I&#39;m not sure you were talking about that.</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"> if you remove the stderr redirection do you see =
any output, ever?</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,=
204);border-left-style:solid;padding-left:1ex">
The exit status from kill $! is not a reliable indication that the shell<br=
>
has execve&#39;d the program in the background, and even if it were, it<br>
would not be a reliable indication of how far the program has progressed</b=
lockquote><div>=C2=A0</div><div>+1=C2=A0</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1e=
x">
(e.g. whether it has got far enough along to register tracepoints).<br>
<br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">
If a test program needs to run in the background, yet needs to reach a<br>
certain state before the rest of the test should proceed, then it should<br=
>
have a way to indicate to the test harness that it has reached the<br>
desired state.=C2=A0 The shell&#39;s rudimentary facilities for managing<br=
>
concurrency are not sufficient.<br></blockquote><div><br></div><div>I&#39;m=
 pushing limits here regarding simplicity: how about a trap and signal exch=
ange between the testapp... might give it a shot. Or a simple sleep...</div=
><div><br></div></div><div dir=3D"ltr"><div>Thanks, I&#39;ll think about it=
 a little more.</div><div><br></div><div>[1]:<a href=3D"http://meta.wikimed=
ia.org/wiki/Cunningham%27s_Law">http://meta.wikimedia.org/wiki/Cunningham%2=
7s_Law</a>=C2=A0</div><div>Bonus xkcd:=C2=A0<a href=3D"http://xkcd.com/386/=
">http://xkcd.com/386/</a></div></div>
</div></div>

--089e013a0bc627ba7b05066f5cdd--


--===============0710596870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0710596870==--
