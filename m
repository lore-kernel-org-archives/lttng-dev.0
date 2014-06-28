From: Dmitri Shubin <sbn@tbricks.com>
Subject: Re: How to check is tracepoint is currently enabled
	(UST)
Date: Sat, 28 Jun 2014 13:15:07 +0400
Message-ID: <CADmgc-s6LV3WWa50pgBvdUn7RLU+ZxefHZfYtsSd-7Ra650eVw__8974.9475512237$1403946959$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359C62DE@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <53AAE15C.3040100@ericsson.com>
 <CAFXXi0=XEwjPfLwxsGim6_FwRqGD-YM9o1zTVFRWbmyigGDPcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1970643680=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sbn@tbricks.com>) id 1X0oj3-0005VB-HV
 for lttng-dev@lists.lttng.org; Sat, 28 Jun 2014 05:15:17 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so5326663ieb.20
 for <lttng-dev@lists.lttng.org>; Sat, 28 Jun 2014 02:15:08 -0700 (PDT)
In-Reply-To: <CAFXXi0=XEwjPfLwxsGim6_FwRqGD-YM9o1zTVFRWbmyigGDPcw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1970643680==
Content-Type: multipart/alternative; boundary=089e013c67ccbb4eea04fce1dcca

--089e013c67ccbb4eea04fce1dcca
Content-Type: text/plain; charset=UTF-8

Hi Simon,

Thank you for reply!

On Wed, Jun 25, 2014 at 7:36 PM, Simon Marchi <simon.marchi@polymtl.ca>
wrote:

> I am pretty sure that Dmitri is talking about a check that you can use
> in your application, to see if a specific tracepoint is enabled. If
> some data that you pass to the tracepoint is expensive to compute, yo
> might want to avoid computing it when tracing is disabled.
>

Yes, exactly.
Here is nice explanation from dtrace author --
http://dtrace.org/blogs/ahl/2006/05/08/user-land-tracing-gets-better-and-better/
(see Is-Enabled probes)



> > #define tracepoint_enabled(provider, name)
> caa_unlikely(__tracepoint_##provider##___##name.state)
>
> Dmitri, that macro that you posted, does it work for you?
>

Yes, looks working AFAIKT.
I.e. if (tracepoint_enabled()) { printf(); } gives correct enabled/disabled
state.


Otherwise, you can simply embed the code in the call to tracepoint:
>

Thanks for suggestions!
Moving argument evaluation to function is a bit tedious.
Statement expressions looks nicer, but their portability is questionable
(although clang that we use seems to support them).

So from my point of view having tracepoint_enabled() macro is the best
possible solution.

Thanks!

--089e013c67ccbb4eea04fce1dcca
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Simon,<div><br></div><div>Thank you for reply!<br><div =
class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jun 25, 2014 a=
t 7:36 PM, Simon Marchi <span dir=3D"ltr">&lt;<a href=3D"mailto:simon.march=
i@polymtl.ca" target=3D"_blank">simon.marchi@polymtl.ca</a>&gt;</span> wrot=
e:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">I am pretty sure that Dmitri is talking about a check that=
 you can use<br>

in your application, to see if a specific tracepoint is enabled. If<br>
some data that you pass to the tracepoint is expensive to compute, yo<br>
might want to avoid computing it when tracing is disabled.<br></blockquote>=
<div><br></div><div>Yes, exactly.</div><div>Here is nice explanation from d=
trace author --=C2=A0<a href=3D"http://dtrace.org/blogs/ahl/2006/05/08/user=
-land-tracing-gets-better-and-better/">http://dtrace.org/blogs/ahl/2006/05/=
08/user-land-tracing-gets-better-and-better/</a> (see Is-Enabled probes)</d=
iv>
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex">&gt; #define tracepoint_en=
abled(provider, name) caa_unlikely(__tracepoint_##provider##___##name.state=
)<br>

<br>
Dmitri, that macro that you posted, does it work for you?<br></blockquote><=
div><br></div><div>Yes, looks working AFAIKT.</div><div>I.e. if (tracepoint=
_enabled()) { printf(); } gives correct enabled/disabled state.</div><div>
=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex">Otherwise, you can simply embed=
 the code in the call to tracepoint:<br>
</blockquote><div><br></div><div>Thanks for suggestions!</div><div>Moving a=
rgument evaluation to function is a bit tedious.</div><div>Statement expres=
sions looks nicer, but their portability is questionable (although clang th=
at we use seems to support them).</div>
<div><br></div><div>So from my point of view having tracepoint_enabled() ma=
cro is the best possible solution.</div><div><br></div><div>Thanks!</div></=
div></div></div></div>

--089e013c67ccbb4eea04fce1dcca--


--===============1970643680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1970643680==--
