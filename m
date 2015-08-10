From: Sergei Dyshel <qyron.private@gmail.com>
Subject: Re: Using LLTNG within shared library (not dlopen-ed).
Date: Mon, 10 Aug 2015 23:18:44 +0300
Message-ID: <CAAeL1MHVMgmYoOHFjhSumP=hdFuMofXSPpvN6j7fAeUvXVa2xA__1040.24011311612$1439238122$gmane$org@mail.gmail.com>
References: <CAAeL1MGw9i1yHyxpAfJOq++zsNYM7+-_aJDAh2yN1B9k9K3U0w@mail.gmail.com>
 <CAB4xu_0p4cHO4Wtnn4DNNM_8iwVk7U_nNfu=PpNtsLDy-Ob03A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0641863366=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <qyron.private@gmail.com>) id 1ZOtXJ-000266-Tk
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 16:19:11 -0400
Received: by wijp15 with SMTP id p15so149897094wij.0
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 13:19:04 -0700 (PDT)
In-Reply-To: <CAB4xu_0p4cHO4Wtnn4DNNM_8iwVk7U_nNfu=PpNtsLDy-Ob03A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0641863366==
Content-Type: multipart/alternative; boundary=001a11c3fa76698b7b051cfab24a

--001a11c3fa76698b7b051cfab24a
Content-Type: text/plain; charset=UTF-8

Hi Phillipe,

Thank you for quick answer! I studied that thread but I see that it refers
to well-known "dlclose" problem: trace provider as part of dlclose-ed .so
is unloaded before lttng-ust is unloaded which leads to segfault.

But in my case both .so containing tracepoints (and trace provider) and
lttng-ust are linked to application at link-time. So both are supposed load
before application starts and unload after it ends.

Also, it would be very inconvenient for me to put trace provider into
separate ".so" for some reasons.


-- 
Regards,
Sergei Dyshel

On Mon, Aug 10, 2015 at 10:52 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Mon, Aug 10, 2015 at 1:27 PM, Sergei Dyshel <qyron.private@gmail.com>
> wrote:
> > Hi all,
> >
> > I have some code using traces compiled as shared object (together with
> trace
> > provider).
> > This ".so" is linked to main code during compile-time.
> > When I run main application and try to read traces after that I get
> errors
> > about corrupted trace file.
> >
> > I've read docs about dynamical linking of trace provider which recommends
> > compiling trace provider into separate .so and using LD_PRELOAD to
> preload
> > it. But that is only needed for shared objects loaded with "dlopen". In
> my
> > case "dlclose" isn't called and shared object is unloaded on the exit
> (i.e.
> > after all traces produced).
> >
> > So this shouldn't be a problem... Am I right?
>
> Hello there,
>
> See if this thread helps:
> <http://lists.lttng.org/pipermail/lttng-dev/2014-December/023953.html>.
>
> I'm not the author of LTTng-UST and I do not have a comprehensive
> understanding
> of its inner mechanics, but I believe that it's good practice to always use
> LD_PRELOAD with a tracepoint provider that is not statically linked with
> the
> application.
>
> Phil
>
> > --
> > Regards,
> > Sergei Dyshel
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--001a11c3fa76698b7b051cfab24a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Phillipe,<div><br></div><div>Thank you for quick answer=
! I studied that thread but I see that it refers to well-known &quot;dlclos=
e&quot; problem: trace provider as part of dlclose-ed .so is unloaded befor=
e lttng-ust is unloaded which leads to segfault.=C2=A0</div><div><br></div>=
<div>But in my case both .so containing tracepoints (and trace provider) an=
d lttng-ust are linked to application at link-time. So both are supposed lo=
ad before application starts and unload after it ends.=C2=A0</div><div><br>=
</div><div>Also, it would be very inconvenient for me to put trace provider=
 into separate &quot;.so&quot; for some reasons.</div><div><br></div></div>=
<div class=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_signa=
ture"><div dir=3D"ltr">-- <br>Regards,<br>Sergei Dyshel</div></div></div>
<br><div class=3D"gmail_quote">On Mon, Aug 10, 2015 at 10:52 PM, Philippe P=
roulx <span dir=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gmail.com" targ=
et=3D"_blank">eeppeliteloop@gmail.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><span class=3D"">On Mon, Aug 10, 2015 at 1:27 PM, Sergei=
 Dyshel &lt;<a href=3D"mailto:qyron.private@gmail.com">qyron.private@gmail.=
com</a>&gt; wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I have some code using traces compiled as shared object (together with=
 trace<br>
&gt; provider).<br>
&gt; This &quot;.so&quot; is linked to main code during compile-time.<br>
&gt; When I run main application and try to read traces after that I get er=
rors<br>
&gt; about corrupted trace file.<br>
&gt;<br>
&gt; I&#39;ve read docs about dynamical linking of trace provider which rec=
ommends<br>
&gt; compiling trace provider into separate .so and using LD_PRELOAD to pre=
load<br>
&gt; it. But that is only needed for shared objects loaded with &quot;dlope=
n&quot;. In my<br>
&gt; case &quot;dlclose&quot; isn&#39;t called and shared object is unloade=
d on the exit (i.e.<br>
&gt; after all traces produced).<br>
&gt;<br>
&gt; So this shouldn&#39;t be a problem... Am I right?<br>
<br>
</span>Hello there,<br>
<br>
See if this thread helps:<br>
&lt;<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2014-December/023=
953.html" rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/piper=
mail/lttng-dev/2014-December/023953.html</a>&gt;.<br>
<br>
I&#39;m not the author of LTTng-UST and I do not have a comprehensive under=
standing<br>
of its inner mechanics, but I believe that it&#39;s good practice to always=
 use<br>
LD_PRELOAD with a tracepoint provider that is not statically linked with th=
e<br>
application.<br>
<br>
Phil<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
&gt; --<br>
&gt; Regards,<br>
&gt; Sergei Dyshel<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" =
rel=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev</a><br>
&gt;<br>
</font></span></blockquote></div><br></div>

--001a11c3fa76698b7b051cfab24a--


--===============0641863366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0641863366==--
