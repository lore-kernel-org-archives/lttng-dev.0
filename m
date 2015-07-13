From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Lttng Soft Hang issue
Date: Mon, 13 Jul 2015 11:34:38 -0400
Message-ID: <CA+jJMxtyOqTDSh3iphDAE4qPx0+C8jJ3Txi1j+ouxHx0guuXng__35221.8531807468$1436801898$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
 <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
 <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w@mail.gmail.com>
 <CA+jJMxt2Dph0yhuE3tQ3aYKyAmX8t1DnmT6kDbnWVSgNN=rmUA@mail.gmail.com>
 <CACd+_b5v5mpfBqNRQNHiJnA51niK0BchdAgf90VRpSQQpNn_7w@mail.gmail.com>
 <CACd+_b7Gz6be-+0cc4gnQi92hSoPDDuu7fWw6t=Qn19WdNc2jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1663131062=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZEfki-0000DZ-Bs
 for lttng-dev@lists.lttng.org; Mon, 13 Jul 2015 11:34:50 -0400
Received: by pactm7 with SMTP id tm7so209196544pac.2
 for <lttng-dev@lists.lttng.org>; Mon, 13 Jul 2015 08:34:38 -0700 (PDT)
In-Reply-To: <CACd+_b7Gz6be-+0cc4gnQi92hSoPDDuu7fWw6t=Qn19WdNc2jA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Aravind HT <aravind.ht@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1663131062==
Content-Type: multipart/alternative; boundary=047d7bdc84aaad2911051ac375e5

--047d7bdc84aaad2911051ac375e5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Do you have a specific changeset in mind when you say you applied the
changes mentioned in that thread?

Do you simply revert the following commit?
https://github.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c03314=
45346b15f

Thanks,
J=C3=A9r=C3=A9mie

On Sat, Jul 11, 2015 at 3:26 AM, Aravind HT <aravind.ht@gmail.com> wrote:

> To try this fix, I also needed the changes talked about in
> http://lists.lttng.org/pipermail/lttng-dev/2015-July/024689.html ,
> otherwise, I would see relayd coring.
> Once I took them I could see that the soft hang issue was no longer
> reproducible.
>
> Thanks for helping.
>
> On Wed, Jul 8, 2015 at 9:49 AM, Aravind HT <aravind.ht@gmail.com> wrote:
>
>> Sure, I will try the fix and update.
>>
>> On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <
>> jeremie.galarneau@efficios.com> wrote:
>>
>>> Would you mind testing Mathieu's patch?
>>>
>>> I have rebased it on stable-2.6:
>>> git clone https://github.com/jgalar/lttng-tools.git -b hang-fix
>>>
>>> Thanks,
>>> J=C3=A9r=C3=A9mie=EF=BF=BC
>>>
>>>
>>> On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <
>>> jeremie.galarneau@efficios.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> What do you observe when this happens? Does the session daemon become
>>>> unresponsive?
>>>>
>>>> J=C3=A9r=C3=A9mie
>>>>
>>>> On Wed, May 27, 2015 at 6:19 AM, Aravind HT <aravind.ht@gmail.com>
>>>> wrote:
>>>>
>>>>> Request someone to kindly help with this. Blocked at this point,
>>>>> unable to continue as any application crash leads to lttng not workin=
g.
>>>>>
>>>>> Thanks,
>>>>> Aravind.
>>>>>
>>>>> On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com>
>>>>> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>>
>>>>>>
>>>>>> I have recently started trying lttng 2.6 for a few applications on m=
y
>>>>>> Ubuntu 12.04 and I noticed that the health check on sessiond and con=
sumerd
>>>>>> failed soon after starting the session.
>>>>>>
>>>>>>
>>>>>> On investigating, I found that thread_manage_consumer() had exited
>>>>>> causing an overall health check failure.
>>>>>>
>>>>>>
>>>>>> Here are the sequence of steps that I found contributed to
>>>>>> *thread_manage_consumer()* exiting.
>>>>>>
>>>>>>
>>>>>> 1.       In *thread_manage_apps() : 1558 ,
>>>>>> ust_app_unregister(pollfd)* is being called. This happens when there
>>>>>> is an error detected by *revents =3D LTTNG_POLL_GETEV(&events, i)*
>>>>>>
>>>>>> My initial guess here is that as one of my apps has crashed,
>>>>>> producing a *LPOLLERR | LPOLLHUP | LPOLLRDHUP *to be generated for
>>>>>> *epoll()* causing *ust_app_unregister()* to be called for that app.
>>>>>>
>>>>>>
>>>>>>
>>>>>> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
>>>>>> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is s=
et
>>>>>> *.*
>>>>>>
>>>>>>
>>>>>>
>>>>>> (2.a) Note:* close_metadata() *also calls
>>>>>> * consumer_close_metadata() *which sends
>>>>>> * LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the consumerd
>>>>>> to stop it from further dealing with the concerned app. Somehow this
>>>>>> doesn=E2=80=99t seem to help*.*
>>>>>>
>>>>>>
>>>>>>
>>>>>> 3.       Next, I see that the *thread_manage_consumer():1353* for
>>>>>> some reason has ignored the above 2.a and gets to do request/reply f=
or that
>>>>>> app by calling*ust_consumer_metadata_request():491 ->
>>>>>> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks
>>>>>> for *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>>>>>>
>>>>>>
>>>>>>
>>>>>> 4.       This *=E2=80=93EPIPE* error cascades all the way back up to
>>>>>> *thread_manage_consumer():1353* at which point
>>>>>> *thread_manage_consumer()* decides to exit causing health_check() to
>>>>>> fail.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> So it looks like under some scenario, an application crash could
>>>>>> cause the lttng some problems.
>>>>>>
>>>>>>
>>>>>>
>>>>>> I think a possible fix for this scenario, is to instead of 4, send a=
n
>>>>>> *ERROR* message back to *consumerd()* . This could be done from
>>>>>> *ust_consumer_metadata_request()* call. Can someone please let me
>>>>>> know if this is correct and shed more light on the issue ?
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Please forgive if there are any guideline omissions for posting here
>>>>>> from my part. This is my first post.
>>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Aravind.
>>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> lttng-dev mailing list
>>>>> lttng-dev@lists.lttng.org
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> J=C3=A9r=C3=A9mie Galarneau
>>>> EfficiOS Inc.
>>>> http://www.efficios.com
>>>>
>>>
>>>
>>>
>>> --
>>> J=C3=A9r=C3=A9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>>
>>
>>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7bdc84aaad2911051ac375e5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Do you have a specific changeset in mind when you say you =
applied the changes mentioned in that thread?<div><br></div><div>Do you sim=
ply revert the following commit?</div><div><a href=3D"https://github.com/lt=
tng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f">https://gi=
thub.com/lttng/lttng-tools/commit/1dc0526df43f2b5f86ef451e4c0331445346b15f<=
/a></div><div><br></div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie<br><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, Jul 11, 2015 at =
3:26 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmai=
l.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex"><div dir=3D"ltr">To try this fix, I also needed the changes ta=
lked about in=C2=A0<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/20=
15-July/024689.html" target=3D"_blank">http://lists.lttng.org/pipermail/ltt=
ng-dev/2015-July/024689.html</a> , otherwise, I would see relayd coring.<di=
v>Once I took them I could see that the soft hang issue was no longer repro=
ducible.=C2=A0</div><div><br></div><div>Thanks for helping.</div></div><div=
><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Jul=
 8, 2015 at 9:49 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:ara=
vind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-style=
:solid;padding-left:1ex"><div dir=3D"ltr">Sure, I will try the fix and upda=
te.</div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <span dir=3D=
"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_blan=
k">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
><div dir=3D"ltr">Would you mind testing Mathieu&#39;s patch?<div><br></div=
><div>I have rebased it on stable-2.6:</div><div><div>git clone <a href=3D"=
https://github.com/jgalar/lttng-tools.git" target=3D"_blank">https://github=
.com/jgalar/lttng-tools.git</a> -b hang-fix<br></div></div><div><br></div><=
div><div>Thanks,</div><div>J=C3=A9r=C3=A9mie=EF=BF=BC</div></div><div><br><=
/div></div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <span dir=
=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" target=3D"_b=
lank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1=
ex"><div dir=3D"ltr">Hi,<div><br></div><div>What do you observe when this h=
appens? Does the session daemon become unresponsive?</div><div><br></div><d=
iv>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote"><div><div>On Wed, May 27, 2015 at 6:19 AM, Aravind HT <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank"=
>aravind.ht@gmail.com</a>&gt;</span> wrote:<br></div></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
><div><div><div dir=3D"ltr">Request someone to kindly help with this. Block=
ed at this point, unable to continue as any application crash leads to lttn=
g not working.<div><br></div><div>Thanks,</div><div>Aravind.</div></div><di=
v><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Ma=
y 21, 2015 at 12:18 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:=
aravind.ht@gmail.com" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-st=
yle:solid;padding-left:1ex"><div dir=3D"ltr"><p class=3D"MsoNormal" style=
=3D"font-size:12.8000001907349px">Hi,</p><p class=3D"MsoNormal" style=3D"fo=
nt-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-=
size:12.8000001907349px">I have recently started trying lttng 2.6 for a few=
 applications on my Ubuntu 12.04 and I noticed that the health check on ses=
siond and consumerd failed soon after starting the session.</p><p class=3D"=
MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px">On investigating, I found that=
 thread_manage_consumer() had exited causing an overall health check failur=
e.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p=
><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Here are the=
 sequence of steps that I found contributed to=C2=A0<b>thread_manage_consum=
er()</b>=C2=A0exiting.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000=
001907349px"></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349=
px"><br></p><p style=3D"font-size:12.8000001907349px">1.<span style=3D"font=
-stretch:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>thread_manage_apps() =
: 1558 , ust_app_unregister(pollfd)</b>=C2=A0is being called. This happens =
when there is an error detected by=C2=A0<b>revents =3D LTTNG_POLL_GETEV(&am=
p;events, i)</b></p><p style=3D"font-size:12.8000001907349px">My initial gu=
ess here is that as one of my apps has crashed, producing a=C2=A0<b>LPOLLER=
R | LPOLLHUP | LPOLLRDHUP=C2=A0</b>to be generated for=C2=A0<b>epoll()</b>=
=C2=A0causing=C2=A0<b>ust_app_unregister()</b>=C2=A0to be called for that a=
pp.</p><p style=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font=
-size:12.8000001907349px">2.<span style=3D"font-stretch:normal;font-size:7p=
t;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0</span>In=C2=A0<b>ust_app_unregister():3154 , close_metadata(regis=
try, ua_sess-&gt;consumer)=C2=A0=C2=A0</b>in which<b>=C2=A0registry-&gt;met=
adata_closed =3D 1=C2=A0</b>is set<b>.</b></p><p style=3D"font-size:12.8000=
001907349px;text-indent:0.5in">=C2=A0</p><p style=3D"font-size:12.800000190=
7349px;text-indent:0.5in">(2.a) Note:<b>=C2=A0close_metadata()=C2=A0</b>als=
o calls<b>=C2=A0consumer_close_metadata()=C2=A0</b>which sends<b>=C2=A0LTTN=
G_CONSUMER_CLOSE_METADATA=C2=A0</b>and<b>=C2=A0metadata_key=C2=A0</b>to the=
 consumerd to stop it from further dealing with the concerned app. Somehow =
this doesn=E2=80=99t seem to help<b>.</b></p><p style=3D"font-size:12.80000=
01907349px"><b>=C2=A0</b></p><p style=3D"font-size:12.8000001907349px">3.<s=
pan style=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times New R=
oman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>Next, I see tha=
t the=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0for some reason has ig=
nored the above 2.a and gets to do request/reply for that app by calling<b>=
ust_consumer_metadata_request():491 -&gt; ust_app_push_metadat(ust_reg, soc=
ket,1)=C2=A0</b>which at line 460 checks for=C2=A0<b>registry-&gt;metadata_=
closed</b>=C2=A0and returns an=C2=A0<b>=E2=80=93EPIPE</b></p><p class=3D"Ms=
oNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font-=
size:12.8000001907349px">4.<span style=3D"font-stretch:normal;font-size:7pt=
;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0</span>This=C2=A0<b>=E2=80=93EPIPE</b>=C2=A0error cascades all the=
 way back up to=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0at which poi=
nt=C2=A0<b>thread_manage_consumer()</b>=C2=A0decides to exit causing health=
_check() to fail.</p><p style=3D"font-size:12.8000001907349px">=C2=A0</p><p=
 class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p cl=
ass=3D"MsoNormal" style=3D"font-size:12.8000001907349px">So it looks like u=
nder some scenario, an application crash could cause the lttng some problem=
s.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0<=
/p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">I think a =
possible fix for this scenario, is to instead of 4, send an=C2=A0<b>ERROR</=
b>=C2=A0message back to=C2=A0<b>consumerd()</b>=C2=A0. This could be done f=
rom=C2=A0<b>ust_consumer_metadata_request()</b>=C2=A0call. Can someone plea=
se let me know if this is correct and shed more light on the issue ?</p><p =
class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p cla=
ss=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Please forgive if the=
re are any guideline omissions for posting here from my part. This is my fi=
rst post.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=
<br></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Regar=
ds,</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Aravin=
d.</p></div>
</blockquote></div><br></div>
</div></div><br></div></div>_______________________________________________=
<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/li=
stinfo/lttng-dev</a><br>
<br></blockquote></div><span><font color=3D"#888888"><br><br clear=3D"all">=
<div><br></div>-- <br><div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br>=
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div>J=C3=A9=
r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com=
" target=3D"_blank">http://www.efficios.com</a></div>
</div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div>J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"http://www.=
efficios.com" target=3D"_blank">http://www.efficios.com</a></div>
</div></div></div>

--047d7bdc84aaad2911051ac375e5--


--===============1663131062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1663131062==--
