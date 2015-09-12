From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Instrumenting a Shared Object
Date: Sat, 12 Sep 2015 16:58:47 +0000 (UTC)
Message-ID: <1024547344.5503.1442077127546.JavaMail.zimbra__25701.3828414076$1442077201$gmane$org@efficios.com>
References: <SN1PR0301MB159862AA83F63780E73A8CFAC87D0@SN1PR0301MB1598.namprd03.prod.outlook.com>
 <CA+jJMxvp+rZCAEtjhv+DAWRf8fFqOf4-8E5fbXp3URJKBc9AVg@mail.gmail.com>
 <SN1PR0301MB15987789379EC11BADBF1544C8670@SN1PR0301MB1598.namprd03.prod.outlook.com>
 <SN1PR0301MB15985C439B4DC8D52AC0A0D9C8520@SN1PR0301MB1598.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1998940656=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Zao8l-0003eZ-Ls
 for lttng-dev@lists.lttng.org; Sat, 12 Sep 2015 12:59:08 -0400
In-Reply-To: <SN1PR0301MB15985C439B4DC8D52AC0A0D9C8520@SN1PR0301MB1598.namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Brian Robbins <brianrob@microsoft.com>
Cc: Rama Krishnan Raghupathy <ramarag@microsoft.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1998940656==
Content-Type: multipart/alternative;
	boundary="----=_Part_5502_355275191.1442077127544"

------=_Part_5502_355275191.1442077127544
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Sep 9, 2015, at 4:49 PM, Brian Robbins <brianrob@microsoft.com> wr=
ote:=20

> One additional question on this. It appears that the tracepoint initializ=
ation
> code will dlopen liblttng-ust-tracepoint.so.0 and essentially no-op if it=
 can=E2=80=99t
> find it. However, I=E2=80=99ve noticed that the executable still has a st=
atic
> dependency on liblttng-ust.so.0 and liblttng-ust-tracepoint.so.0, I belie=
ve for
> registration. Is there any way to make these static dependencies dynamic =
as
> well so that if liblttng-ust is not installed on an arbitrary machine, th=
en the
> application still works but no tracing is possible?

Hi Brian,=20

Yes, lttng-ust can be used either with a probe provider as a static depende=
ncy=20
of the application, or entirely dynamically, in a use-case where you don't =
want=20
requiring to deploy lttng-ust on all systems, but keep building the applica=
tion with=20
tracepoints.=20

Both ways of doing things are documented in the lttng-ust(3) man page. I th=
ink the=20
use-case you are describing fits in section=20

"BUILDING/LINKING THE TRACEPOINT PROVIDER=20
[...]=20
2) Compile the Tracepoint Provider separately from the application,=20
using dynamic linking:"=20

The key thing here is to split your tracepoint probe provider from your app=
lication=20
by building it into its own .so. Then, you can package the tracepoint probe=
 provider=20
into an optional package, an "add-on" to your application. The static depen=
dency=20
on lttng-ust is from the tracepoint probe provider, not the application tra=
cepoints=20
per se.=20

Does it help ?=20

Thanks,=20

Mathieu=20

> Thanks.

> -Brian

> From: Brian Robbins [mailto:brianrob@microsoft.com]
> Sent: Wednesday, August 19, 2015 1:15 PM
> To: J=C3=A9r=C3=A9mie Galarneau <jeremie.galarneau@efficios.com>
> Cc: Rama Krishnan Raghupathy <ramarag@microsoft.com>; lttng-dev@lists.ltt=
ng.org
> Subject: Re: [lttng-dev] Instrumenting a Shared Object

> Hi J=C3=A9r=C3=A9mie,

> Thank you very much. That helps a bunch. I think in general, we can make =
some
> guarantees around when tracepoints are no-longer called, so we should jus=
t be
> able to dlclose liblttng-ust after that point.

> Mathieu =E2=80=93 if you have any additional advice, that would be great.

> Thank you much.

> -Brian

> From: jeremie.galarneau@gmail.com [ mailto:jeremie.galarneau@gmail.com ] =
On
> Behalf Of J=C3=A9r=C3=A9mie Galarneau
> Sent: Monday, August 17, 2015 3:22 PM
> To: Brian Robbins < brianrob@microsoft.com >
> Cc: lttng-dev@lists.lttng.org ; Rama Krishnan Raghupathy < ramarag@micros=
oft.com
> >; Mathieu Desnoyers < mathieu.desnoyers@efficios.com >
> Subject: Re: [lttng-dev] Instrumenting a Shared Object

> Hi Brian,

> Mathieu will probably weigh in on this shortly. In the meantime, here's m=
y
> understanding of the problem.

> In order to produce a trace, you have to ensure both liblttng-ust and you=
r
> provider(s) are linked into the application. That can be done either by
> LD_PRELOAD-ing, dynamically linking, or dlopen-ing() both. Not linking ag=
ainst
> liblttng-ust will simply result in your application not producing a trace
> (since the application will never register to the session daemon), but wi=
ll
> have no adverse effect.

> The real concern with dlclose-ing the providers is that you have to be en=
tirely
> sure that no tracepoints will be triggered after the provider is
> unloaded/dlclose. There is no reference counting to ensure the provider r=
emains
> loaded as long as any probes remain reachable or any other mechanism of t=
he
> sort. Therefore, triggering a tracepoint after the provider has been unlo=
aded
> will result in a crash. Keep in mind that triggering tracepoints remains
> entirely safe if the providers are never loaded. Only triggering after a
> dlopen/dlclose of providers may cause problems.

> If you can guarantee this doesn't happen, you should be pretty much good =
to go.

> Regards,

> J=C3=A9r=C3=A9mie

> On Thu, Aug 13, 2015 at 7:40 PM, Brian Robbins < brianrob@microsoft.com >=
 wrote:
>> Hello,

>> I=E2=80=99m looking to instrument a shared object using LTTng-UST tracep=
oints. The
>> expectation is that users of the library will use dlopen to open it at t=
he
>> beginning of their application and dlclose right before process exit. Fr=
om what
>> I=E2=80=99ve read at
>> http://lttng.org/docs/#doc-building-tracepoint-providers-and-user-applic=
ation ,
>> it sounds like there is some complexity with this as the tracepoint defi=
nition
>> must remain in memory, but I want to make sure I fully understand.

>> If I want to instrument a shared object, is my only option to dynamicall=
y link
>> and use LD_PRELOAD? Also, do my options change if I know that the proces=
s will
>> exit right after it calls dlclose on the library?

>> Thank you very much.

>> -Brian

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --

> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_5502_355275191.1442077127544
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Sep 9, 2015, at 4:49 PM, Brian Robbins &lt;brianrob@microsoft.=
com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockq=
uote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt;"><style><!--

@font-face
=09{font-family:"Cambria Math";
=09panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:"Segoe UI";
=09panose-1:2 11 5 2 4 2 4 2 2 3;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
=09{mso-style-name:msonormal;
=09mso-margin-top-alt:auto;
=09margin-right:0in;
=09mso-margin-bottom-alt:auto;
=09margin-left:0in;
=09font-size:12.0pt;
=09font-family:"Times New Roman",serif;}
span.hoenzb
=09{mso-style-name:hoenzb;}
span.EmailStyle19
=09{mso-style-type:personal;
=09font-family:"Calibri",sans-serif;
=09color:#1F497D;}
span.EmailStyle20
=09{mso-style-type:personal-reply;
=09font-family:"Calibri",sans-serif;
=09color:#1F497D;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><div class=3D"WordSection1"><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F49=
7D">One additional question on this.&nbsp; It appears that the tracepoint i=
nitialization code will dlopen liblttng-ust-tracepoint.so.0 and essentially=
 no-op if it can=E2=80=99t
 find it.&nbsp; However, I=E2=80=99ve noticed that the executable still has=
 a static dependency on liblttng-ust.so.0 and liblttng-ust-tracepoint.so.0,=
 I believe for registration.&nbsp; Is there any way to make these static de=
pendencies dynamic as well so that if liblttng-ust
 is not installed on an arbitrary machine, then the application still works=
 but no tracing is possible?</span></p></div></blockquote><div><br></div><d=
iv><div>Hi Brian,<br></div><div><br></div><div>Yes, lttng-ust can be used e=
ither with a probe provider as a static dependency</div><div>of the applica=
tion, or entirely dynamically, in a use-case where you don't want</div><div=
>requiring to deploy lttng-ust on all systems, but keep building the applic=
ation with</div><div>tracepoints.</div><div><br></div><div>Both ways of doi=
ng things are documented in the lttng-ust(3) man page. I think the</div><di=
v>use-case you are describing fits in section</div><div><br data-mce-bogus=
=3D"1"></div><div>"BUILDING/LINKING THE TRACEPOINT PROVIDER</div><div>[...]=
</div><div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2) Compile the =
Tracepoint Provider separately from the application,<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; using dynamic linking:"<br>=
</div><div><br></div><div>The key thing here is to split your tracepoint pr=
obe provider from your application</div><div>by building it into its own .s=
o. Then, you can package the tracepoint probe provider</div><div>into an op=
tional package, an "add-on" to your application. The static dependency</div=
><div>on lttng-ust is from the tracepoint probe provider, not the applicati=
on tracepoints</div><div>per se.</div><div><br></div><div>Does it help ?</d=
iv><div><br></div><div>Thanks,</div><div><br></div><div>Mathieu</div><div><=
br></div><div><br></div><span id=3D"zwchr" data-marker=3D"__DIVIDER__"></sp=
an></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class=
=3D"WordSection1"><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;</span></p><p=
 class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Cali=
bri&quot;,sans-serif;color:#1F497D">Thanks.</span></p><p class=3D"MsoNormal=
"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-seri=
f;color:#1F497D">-Brian</span></p><p class=3D"MsoNormal"><a name=3D"_MailEn=
dCompose"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#1F497D">&nbsp;</span></a><br data-mce-bogus=3D"1"></p><div=
><div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in=
 0in 0in"><p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-fa=
mily:&quot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-si=
ze:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> Brian Robbins [mailt=
o:brianrob@microsoft.com]
<br>
<b>Sent:</b> Wednesday, August 19, 2015 1:15 PM<br>
<b>To:</b> J=C3=A9r=C3=A9mie Galarneau &lt;jeremie.galarneau@efficios.com&g=
t;<br>
<b>Cc:</b> Rama Krishnan Raghupathy &lt;ramarag@microsoft.com&gt;; lttng-de=
v@lists.lttng.org<br>
<b>Subject:</b> Re: [lttng-dev] Instrumenting a Shared Object</span></p></d=
iv></div><p class=3D"MsoNormal">Hi J=C3=A9r=C3=A9mie,</p><p class=3D"MsoNor=
mal">Thank you very much.&nbsp; That helps a bunch.&nbsp; I think in genera=
l, we can make some guarantees around when tracepoints are no-longer called=
, so we should just be able to dlclose liblttng-ust after that point.</p><p=
 class=3D"MsoNormal">Mathieu =E2=80=93 if you have any additional advice, t=
hat would be great.</p><p class=3D"MsoNormal">Thank you much.</p><p class=
=3D"MsoNormal">-Brian</p><p class=3D"MsoNormal"><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;</span=
></p><p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,sans-serif;color:#1F497D">&nbsp;</span></p><p class=3D"Mso=
Normal"><b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,=
sans-serif">From:</span></b><span style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,sans-serif">
<a href=3D"mailto:jeremie.galarneau@gmail.com" target=3D"_blank">jeremie.ga=
larneau@gmail.com</a> [<a href=3D"mailto:jeremie.galarneau@gmail.com" targe=
t=3D"_blank">mailto:jeremie.galarneau@gmail.com</a>]
<b>On Behalf Of </b>J=C3=A9r=C3=A9mie Galarneau<br>
<b>Sent:</b> Monday, August 17, 2015 3:22 PM<br>
<b>To:</b> Brian Robbins &lt;<a href=3D"mailto:brianrob@microsoft.com" targ=
et=3D"_blank">brianrob@microsoft.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">l=
ttng-dev@lists.lttng.org</a>; Rama Krishnan Raghupathy &lt;<a href=3D"mailt=
o:ramarag@microsoft.com" target=3D"_blank">ramarag@microsoft.com</a>&gt;; M=
athieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" targ=
et=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
<b>Subject:</b> Re: [lttng-dev] Instrumenting a Shared Object</span></p><di=
v><p class=3D"MsoNormal">Hi Brian,</p><div><p class=3D"MsoNormal">Mathieu w=
ill probably weigh in on this shortly. In the meantime, here's my understan=
ding of the problem.</p></div><div><p class=3D"MsoNormal">In order to produ=
ce a trace, you have to ensure both liblttng-ust and your provider(s) are l=
inked into the application. That can be done either by LD_PRELOAD-ing, dyna=
mically linking, or dlopen-ing() both. Not linking against liblttng-ust
 will simply result in your application not producing a trace (since the ap=
plication will never register to the session daemon), but will have no adve=
rse effect.</p></div><div><p class=3D"MsoNormal">The real concern with dlcl=
ose-ing the providers is that you have to be entirely sure that no tracepoi=
nts will be triggered after the provider is unloaded/dlclose. There is no r=
eference counting to ensure the provider remains loaded as long
 as any probes remain reachable or any other mechanism of the sort. Therefo=
re, triggering a tracepoint after the provider has been unloaded will resul=
t in a crash. Keep in mind that triggering tracepoints remains entirely saf=
e if the providers are never loaded.
 Only triggering after a dlopen/dlclose of providers may cause problems.</p=
></div><div><p class=3D"MsoNormal">If you can guarantee this doesn't happen=
, you should be pretty much good to go.</p></div><div><p class=3D"MsoNormal=
">Regards,</p></div><div><p class=3D"MsoNormal">J=C3=A9r=C3=A9mie</p></div>=
</div><div><div><p class=3D"MsoNormal">On Thu, Aug 13, 2015 at 7:40 PM, Bri=
an Robbins &lt;<a href=3D"mailto:brianrob@microsoft.com" target=3D"_blank">=
brianrob@microsoft.com</a>&gt; wrote:</p><blockquote style=3D"border:none;b=
order-left:solid #CCCCCC 1.0pt;padding:0in 0in 0in 6.0pt;margin-left:4.8pt;=
margin-top:5.0pt;margin-right:0in;margin-bottom:5.0pt"><div><div><p class=
=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"=
>Hello,</p><p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-marg=
in-bottom-alt:auto">I=E2=80=99m looking to instrument a shared object using=
 LTTng-UST tracepoints.&nbsp; The expectation is that users of the library =
will use dlopen to open it at the beginning of their application
 and dlclose right before process exit.&nbsp; From what I=E2=80=99ve read a=
t <span style=3D"font-size:10.0pt;font-family:&quot;Segoe UI&quot;,sans-ser=
if;color:black">
<a href=3D"https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3a%2f%=
2flttng.org%2fdocs%2f%23doc-building-tracepoint-providers-and-user-applicat=
ion&amp;data=3D01%7c01%7cbrianrob%40microsoft.com%7c3ae11714ef9b4072f3ee08d=
2a75249b9%7c72f988bf86f141af91ab2d7cd011db47%7c1&amp;sdata=3DYO4WlsmA6UBLU%=
2fvAmnn6JL4S5JnsXWguw%2bXgkC2M9aI%3d" target=3D"_blank">http://lttng.org/do=
cs/#doc-building-tracepoint-providers-and-user-application</a></span>,
 it sounds like there is some complexity with this as the tracepoint defini=
tion must remain in memory, but I want to make sure I fully understand.</p>=
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto">If I want to instrument a shared object, is my only option to dyna=
mically link and use LD_PRELOAD?&nbsp; Also, do my options change if I know=
 that the process will exit right after it
 calls dlclose on the library?</p><p class=3D"MsoNormal" style=3D"mso-margi=
n-top-alt:auto;mso-margin-bottom-alt:auto">Thank you very much.</p><p class=
=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"=
><span style=3D"color:#888888">-Brian</span></p><p class=3D"MsoNormal" styl=
e=3D"mso-margin-top-alt:auto;mso-margin-bottom-alt:auto"><span style=3D"col=
or:#888888">&nbsp;</span></p><p class=3D"MsoNormal" style=3D"mso-margin-top=
-alt:auto;mso-margin-bottom-alt:auto"><span style=3D"color:#888888">&nbsp;<=
/span></p></div></div><p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"=
><br>
_______________________________________________<br>
lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://na01.safe=
links.protection.outlook.com/?url=3Dhttp%3a%2f%2flists.lttng.org%2fcgi-bin%=
2fmailman%2flistinfo%2flttng-dev&amp;data=3D01%7c01%7cbrianrob%40microsoft.=
com%7c3ae11714ef9b4072f3ee08d2a75249b9%7c72f988bf86f141af91ab2d7cd011db47%7=
c1&amp;sdata=3DkvzDR%2b%2bP1EKVMNduwrayFrWR2zqBlH8OF71zm0sA8eQ%3d" target=
=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><b=
r data-mce-bogus=3D"1"></p></blockquote></div><p class=3D"MsoNormal"><br><b=
r clear=3D"all"></p><p class=3D"MsoNormal">-- </p><div><p class=3D"MsoNorma=
l">J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br><a href=3D"https://na01.safelinks.protection.outlook.com/?=
url=3Dhttp%3a%2f%2fwww.efficios.com&amp;data=3D01%7c01%7cbrianrob%40microso=
ft.com%7c3ae11714ef9b4072f3ee08d2a75249b9%7c72f988bf86f141af91ab2d7cd011db4=
7%7c1&amp;sdata=3D3a%2bQApyhm%2bk4UaN%2fn1a0f8SS%2bn6e0Nq4B2YJGqgkpzs%3d" t=
arget=3D"_blank">http://www.efficios.com</a><br data-mce-bogus=3D"1"></p></=
div></div></div><br>_______________________________________________<br>lttn=
g-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div=
 data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>Effici=
OS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_5502_355275191.1442077127544--


--===============1998940656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1998940656==--
