From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Lttng Soft Hang issue
Date: Wed, 8 Jul 2015 09:49:15 +0530
Message-ID: <CACd+_b5v5mpfBqNRQNHiJnA51niK0BchdAgf90VRpSQQpNn_7w__3621.1745035418$1436329221$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
 <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w@mail.gmail.com>
 <CA+jJMxuHWhy1n9Ty1Q6=eGd7bRe-brh3Mqog1uzw5EXbKDPJ0w@mail.gmail.com>
 <CA+jJMxt2Dph0yhuE3tQ3aYKyAmX8t1DnmT6kDbnWVSgNN=rmUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1742676736=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1ZCgpN-0002S6-Ay
 for lttng-dev@lists.lttng.org; Wed, 08 Jul 2015 00:19:26 -0400
Received: by lbzd8 with SMTP id d8so3289842lbz.0
 for <lttng-dev@lists.lttng.org>; Tue, 07 Jul 2015 21:19:15 -0700 (PDT)
In-Reply-To: <CA+jJMxt2Dph0yhuE3tQ3aYKyAmX8t1DnmT6kDbnWVSgNN=rmUA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1742676736==
Content-Type: multipart/alternative; boundary=089e0160bdaa170215051a5571fa

--089e0160bdaa170215051a5571fa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sure, I will try the fix and update.

On Mon, Jul 6, 2015 at 10:12 PM, J=C3=A9r=C3=A9mie Galarneau <
jeremie.galarneau@efficios.com> wrote:

> Would you mind testing Mathieu's patch?
>
> I have rebased it on stable-2.6:
> git clone https://github.com/jgalar/lttng-tools.git -b hang-fix
>
> Thanks,
> J=C3=A9r=C3=A9mie=EF=BF=BC
>
>
> On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <
> jeremie.galarneau@efficios.com> wrote:
>
>> Hi,
>>
>> What do you observe when this happens? Does the session daemon become
>> unresponsive?
>>
>> J=C3=A9r=C3=A9mie
>>
>> On Wed, May 27, 2015 at 6:19 AM, Aravind HT <aravind.ht@gmail.com> wrote=
:
>>
>>> Request someone to kindly help with this. Blocked at this point, unable
>>> to continue as any application crash leads to lttng not working.
>>>
>>> Thanks,
>>> Aravind.
>>>
>>> On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com>
>>> wrote:
>>>
>>>> Hi,
>>>>
>>>>
>>>>
>>>> I have recently started trying lttng 2.6 for a few applications on my
>>>> Ubuntu 12.04 and I noticed that the health check on sessiond and consu=
merd
>>>> failed soon after starting the session.
>>>>
>>>>
>>>> On investigating, I found that thread_manage_consumer() had exited
>>>> causing an overall health check failure.
>>>>
>>>>
>>>> Here are the sequence of steps that I found contributed to
>>>> *thread_manage_consumer()* exiting.
>>>>
>>>>
>>>> 1.       In *thread_manage_apps() : 1558 , ust_app_unregister(pollfd)*=
 is
>>>> being called. This happens when there is an error detected by *revents
>>>> =3D LTTNG_POLL_GETEV(&events, i)*
>>>>
>>>> My initial guess here is that as one of my apps has crashed, producing
>>>> a *LPOLLERR | LPOLLHUP | LPOLLRDHUP *to be generated for *epoll()*
>>>>  causing *ust_app_unregister()* to be called for that app.
>>>>
>>>>
>>>>
>>>> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
>>>> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is set=
*.*
>>>>
>>>>
>>>>
>>>> (2.a) Note:* close_metadata() *also calls* consumer_close_metadata() *=
which
>>>> sends* LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the
>>>> consumerd to stop it from further dealing with the concerned app. Some=
how
>>>> this doesn=E2=80=99t seem to help*.*
>>>>
>>>>
>>>>
>>>> 3.       Next, I see that the *thread_manage_consumer():1353* for some
>>>> reason has ignored the above 2.a and gets to do request/reply for that=
 app
>>>> by calling*ust_consumer_metadata_request():491 ->
>>>> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks for
>>>> *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>>>>
>>>>
>>>>
>>>> 4.       This *=E2=80=93EPIPE* error cascades all the way back up to
>>>> *thread_manage_consumer():1353* at which point
>>>> *thread_manage_consumer()* decides to exit causing health_check() to
>>>> fail.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> So it looks like under some scenario, an application crash could cause
>>>> the lttng some problems.
>>>>
>>>>
>>>>
>>>> I think a possible fix for this scenario, is to instead of 4, send an
>>>> *ERROR* message back to *consumerd()* . This could be done from
>>>> *ust_consumer_metadata_request()* call. Can someone please let me know
>>>> if this is correct and shed more light on the issue ?
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> Please forgive if there are any guideline omissions for posting here
>>>> from my part. This is my first post.
>>>>
>>>>
>>>> Regards,
>>>>
>>>> Aravind.
>>>>
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>>
>> --
>> J=C3=A9r=C3=A9mie Galarneau
>> EfficiOS Inc.
>> http://www.efficios.com
>>
>
>
>
> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
>

--089e0160bdaa170215051a5571fa
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sure, I will try the fix and update.</div><div class=3D"gm=
ail_extra"><br><div class=3D"gmail_quote">On Mon, Jul 6, 2015 at 10:12 PM, =
J=C3=A9r=C3=A9mie Galarneau <span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie=
.galarneau@efficios.com" target=3D"_blank">jeremie.galarneau@efficios.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Wou=
ld you mind testing Mathieu&#39;s patch?<div><br></div><div>I have rebased =
it on stable-2.6:</div><div><div>git clone <a href=3D"https://github.com/jg=
alar/lttng-tools.git" target=3D"_blank">https://github.com/jgalar/lttng-too=
ls.git</a> -b hang-fix<br></div></div><div><br></div><div><div>Thanks,</div=
><div>J=C3=A9r=C3=A9mie=EF=BF=BC</div></div><div><br></div></div><div class=
=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On Mon, Jul 6, 2015 at 11:23 AM, J=C3=A9r=C3=A9mie Galarneau <=
span dir=3D"ltr">&lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" targ=
et=3D"_blank">jeremie.galarneau@efficios.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div dir=3D"ltr">Hi,<div><br></div><div>What do y=
ou observe when this happens? Does the session daemon become unresponsive?<=
/div><div><br></div><div>J=C3=A9r=C3=A9mie</div></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote"><div><div>On Wed, May 27, 2015 at 6:19=
 AM, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.co=
m" target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br></div></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div><div><div dir=3D"ltr">Request someo=
ne to kindly help with this. Blocked at this point, unable to continue as a=
ny application crash leads to lttng not working.<div><br></div><div>Thanks,=
</div><div>Aravind.</div></div><div><div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Thu, May 21, 2015 at 12:18 AM, Aravind HT <span =
dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com" target=3D"_blank">a=
ravind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div dir=3D"ltr"><p class=3D"MsoNormal" style=3D"font-size:12.800000190734=
9px">Hi,</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=
=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">I h=
ave recently started trying lttng 2.6 for a few applications on my Ubuntu 1=
2.04 and I noticed that the health check on sessiond and consumerd failed s=
oon after starting the session.</p><p class=3D"MsoNormal" style=3D"font-siz=
e:12.8000001907349px"><br></p><p class=3D"MsoNormal" style=3D"font-size:12.=
8000001907349px">On investigating, I found that thread_manage_consumer() ha=
d exited causing an overall health check failure.</p><p class=3D"MsoNormal"=
 style=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNormal" styl=
e=3D"font-size:12.8000001907349px">Here are the sequence of steps that I fo=
und contributed to=C2=A0<b>thread_manage_consumer()</b>=C2=A0exiting.</p><p=
 class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"></p><p class=3D=
"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p style=3D"font=
-size:12.8000001907349px">1.<span style=3D"font-stretch:normal;font-size:7p=
t;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0</span>In=C2=A0<b>thread_manage_apps() : 1558 , ust_app_unregister=
(pollfd)</b>=C2=A0is being called. This happens when there is an error dete=
cted by=C2=A0<b>revents =3D LTTNG_POLL_GETEV(&amp;events, i)</b></p><p styl=
e=3D"font-size:12.8000001907349px">My initial guess here is that as one of =
my apps has crashed, producing a=C2=A0<b>LPOLLERR | LPOLLHUP | LPOLLRDHUP=
=C2=A0</b>to be generated for=C2=A0<b>epoll()</b>=C2=A0causing=C2=A0<b>ust_=
app_unregister()</b>=C2=A0to be called for that app.</p><p style=3D"font-si=
ze:12.8000001907349px">=C2=A0</p><p style=3D"font-size:12.8000001907349px">=
2.<span style=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times N=
ew Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>=
ust_app_unregister():3154 , close_metadata(registry, ua_sess-&gt;consumer)=
=C2=A0=C2=A0</b>in which<b>=C2=A0registry-&gt;metadata_closed =3D 1=C2=A0</=
b>is set<b>.</b></p><p style=3D"font-size:12.8000001907349px;text-indent:0.=
5in">=C2=A0</p><p style=3D"font-size:12.8000001907349px;text-indent:0.5in">=
(2.a) Note:<b>=C2=A0close_metadata()=C2=A0</b>also calls<b>=C2=A0consumer_c=
lose_metadata()=C2=A0</b>which sends<b>=C2=A0LTTNG_CONSUMER_CLOSE_METADATA=
=C2=A0</b>and<b>=C2=A0metadata_key=C2=A0</b>to the consumerd to stop it fro=
m further dealing with the concerned app. Somehow this doesn=E2=80=99t seem=
 to help<b>.</b></p><p style=3D"font-size:12.8000001907349px"><b>=C2=A0</b>=
</p><p style=3D"font-size:12.8000001907349px">3.<span style=3D"font-stretch=
:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>Next, I see that the=C2=A0<b>thread_ma=
nage_consumer():1353</b>=C2=A0for some reason has ignored the above 2.a and=
 gets to do request/reply for that app by calling<b>ust_consumer_metadata_r=
equest():491 -&gt; ust_app_push_metadat(ust_reg, socket,1)=C2=A0</b>which a=
t line 460 checks for=C2=A0<b>registry-&gt;metadata_closed</b>=C2=A0and ret=
urns an=C2=A0<b>=E2=80=93EPIPE</b></p><p class=3D"MsoNormal" style=3D"font-=
size:12.8000001907349px">=C2=A0</p><p style=3D"font-size:12.8000001907349px=
">4.<span style=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times=
 New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>This=C2=
=A0<b>=E2=80=93EPIPE</b>=C2=A0error cascades all the way back up to=C2=A0<b=
>thread_manage_consumer():1353</b>=C2=A0at which point=C2=A0<b>thread_manag=
e_consumer()</b>=C2=A0decides to exit causing health_check() to fail.</p><p=
 style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" st=
yle=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=
=3D"font-size:12.8000001907349px">So it looks like under some scenario, an =
application crash could cause the lttng some problems.</p><p class=3D"MsoNo=
rmal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNorma=
l" style=3D"font-size:12.8000001907349px">I think a possible fix for this s=
cenario, is to instead of 4, send an=C2=A0<b>ERROR</b>=C2=A0message back to=
=C2=A0<b>consumerd()</b>=C2=A0. This could be done from=C2=A0<b>ust_consume=
r_metadata_request()</b>=C2=A0call. Can someone please let me know if this =
is correct and shed more light on the issue ?</p><p class=3D"MsoNormal" sty=
le=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=
=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D=
"font-size:12.8000001907349px">Please forgive if there are any guideline om=
issions for posting here from my part. This is my first post.</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p class=3D"M=
soNormal" style=3D"font-size:12.8000001907349px">Regards,</p><p class=3D"Ms=
oNormal" style=3D"font-size:12.8000001907349px">Aravind.</p></div>
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

--089e0160bdaa170215051a5571fa--


--===============1742676736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1742676736==--
