From: Aravind HT <aravind.ht@gmail.com>
Subject: Re: Lttng Soft Hang issue
Date: Wed, 27 May 2015 15:49:51 +0530
Message-ID: <CACd+_b4MtdbAVjHCeQ6EnK5J3KRYzMK7Niq_c18pcKcdpnq07w__34766.8207170956$1432741230$gmane$org@mail.gmail.com>
References: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1955381986=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f46.google.com ([209.85.215.46])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <aravind.ht@gmail.com>) id 1YxYRK-0002xc-1G
 for lttng-dev@lists.lttng.org; Wed, 27 May 2015 06:20:00 -0400
Received: by laat2 with SMTP id t2so3789797laa.1
 for <lttng-dev@lists.lttng.org>; Wed, 27 May 2015 03:19:52 -0700 (PDT)
In-Reply-To: <CACd+_b7pakrUPzfzj=kXYYtkezpwxOLUgGs_Hy7yMYOh-f-PqQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, jdesfossez@efficios.com
List-Id: lttng-dev@lists.lttng.org

--===============1955381986==
Content-Type: multipart/alternative; boundary=001a113496f2658d2805170d95be

--001a113496f2658d2805170d95be
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Request someone to kindly help with this. Blocked at this point, unable to
continue as any application crash leads to lttng not working.

Thanks,
Aravind.

On Thu, May 21, 2015 at 12:18 AM, Aravind HT <aravind.ht@gmail.com> wrote:

> Hi,
>
>
>
> I have recently started trying lttng 2.6 for a few applications on my
> Ubuntu 12.04 and I noticed that the health check on sessiond and consumer=
d
> failed soon after starting the session.
>
>
> On investigating, I found that thread_manage_consumer() had exited causin=
g
> an overall health check failure.
>
>
> Here are the sequence of steps that I found contributed to
> *thread_manage_consumer()* exiting.
>
>
> 1.       In *thread_manage_apps() : 1558 , ust_app_unregister(pollfd)* is
> being called. This happens when there is an error detected by *revents =
=3D
> LTTNG_POLL_GETEV(&events, i)*
>
> My initial guess here is that as one of my apps has crashed, producing a =
*LPOLLERR
> | LPOLLHUP | LPOLLRDHUP *to be generated for *epoll()* causing
> *ust_app_unregister()* to be called for that app.
>
>
>
> 2.       In *ust_app_unregister():3154 , close_metadata(registry,
> ua_sess->consumer)  *in which* registry->metadata_closed =3D 1 *is set*.*
>
>
>
> (2.a) Note:* close_metadata() *also calls* consumer_close_metadata() *whi=
ch
> sends* LTTNG_CONSUMER_CLOSE_METADATA *and* metadata_key *to the consumerd
> to stop it from further dealing with the concerned app. Somehow this
> doesn=E2=80=99t seem to help*.*
>
>
>
> 3.       Next, I see that the *thread_manage_consumer():1353* for some
> reason has ignored the above 2.a and gets to do request/reply for that ap=
p
> by calling*ust_consumer_metadata_request():491 ->
> ust_app_push_metadat(ust_reg, socket,1) *which at line 460 checks for
> *registry->metadata_closed* and returns an *=E2=80=93EPIPE*
>
>
>
> 4.       This *=E2=80=93EPIPE* error cascades all the way back up to
> *thread_manage_consumer():1353* at which point *thread_manage_consumer()*=
 decides
> to exit causing health_check() to fail.
>
>
>
>
>
> So it looks like under some scenario, an application crash could cause th=
e
> lttng some problems.
>
>
>
> I think a possible fix for this scenario, is to instead of 4, send an
> *ERROR* message back to *consumerd()* . This could be done from
> *ust_consumer_metadata_request()* call. Can someone please let me know if
> this is correct and shed more light on the issue ?
>
>
>
>
>
> Please forgive if there are any guideline omissions for posting here from
> my part. This is my first post.
>
>
> Regards,
>
> Aravind.
>

--001a113496f2658d2805170d95be
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Request someone to kindly help with this. Blocked at this =
point, unable to continue as any application crash leads to lttng not worki=
ng.<div><br></div><div>Thanks,</div><div>Aravind.</div></div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 21, 2015 at 12:18 A=
M, Aravind HT <span dir=3D"ltr">&lt;<a href=3D"mailto:aravind.ht@gmail.com"=
 target=3D"_blank">aravind.ht@gmail.com</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div dir=3D"ltr"><p class=3D"MsoNormal" style=3D"font-=
size:12.8000001907349px">Hi,</p><p class=3D"MsoNormal" style=3D"font-size:1=
2.8000001907349px">=C2=A0</p><p class=3D"MsoNormal" style=3D"font-size:12.8=
000001907349px">I have recently started trying lttng 2.6 for a few applicat=
ions on my Ubuntu 12.04 and I noticed that the health check on sessiond and=
 consumerd failed soon after starting the session.</p><p class=3D"MsoNormal=
" style=3D"font-size:12.8000001907349px"><br></p><p class=3D"MsoNormal" sty=
le=3D"font-size:12.8000001907349px">On investigating, I found that thread_m=
anage_consumer() had exited causing an overall health check failure.</p><p =
class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br></p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Here are the sequence=
 of steps that I found contributed to=C2=A0<b>thread_manage_consumer()</b>=
=C2=A0exiting.</p><p class=3D"MsoNormal" style=3D"font-size:12.800000190734=
9px"></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br>=
</p><p style=3D"font-size:12.8000001907349px">1.<span style=3D"font-stretch=
:normal;font-size:7pt;font-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>In=C2=A0<b>thread_manage_apps() : 1558=
 , ust_app_unregister(pollfd)</b>=C2=A0is being called. This happens when t=
here is an error detected by=C2=A0<b>revents =3D LTTNG_POLL_GETEV(&amp;even=
ts, i)</b></p><p style=3D"font-size:12.8000001907349px">My initial guess he=
re is that as one of my apps has crashed, producing a=C2=A0<b>LPOLLERR | LP=
OLLHUP | LPOLLRDHUP=C2=A0</b>to be generated for=C2=A0<b>epoll()</b>=C2=A0c=
ausing=C2=A0<b>ust_app_unregister()</b>=C2=A0to be called for that app.</p>=
<p style=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font-size:1=
2.8000001907349px">2.<span style=3D"font-stretch:normal;font-size:7pt;font-=
family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0</span>In=C2=A0<b>ust_app_unregister():3154 , close_metadata(registry, u=
a_sess-&gt;consumer)=C2=A0=C2=A0</b>in which<b>=C2=A0registry-&gt;metadata_=
closed =3D 1=C2=A0</b>is set<b>.</b></p><p style=3D"font-size:12.8000001907=
349px;text-indent:0.5in">=C2=A0</p><p style=3D"font-size:12.8000001907349px=
;text-indent:0.5in">(2.a) Note:<b>=C2=A0close_metadata()=C2=A0</b>also call=
s<b>=C2=A0consumer_close_metadata()=C2=A0</b>which sends<b>=C2=A0LTTNG_CONS=
UMER_CLOSE_METADATA=C2=A0</b>and<b>=C2=A0metadata_key=C2=A0</b>to the consu=
merd to stop it from further dealing with the concerned app. Somehow this d=
oesn=E2=80=99t seem to help<b>.</b></p><p style=3D"font-size:12.80000019073=
49px"><b>=C2=A0</b></p><p style=3D"font-size:12.8000001907349px">3.<span st=
yle=3D"font-stretch:normal;font-size:7pt;font-family:&#39;Times New Roman&#=
39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0</span>Next, I see that the=
=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0for some reason has ignored=
 the above 2.a and gets to do request/reply for that app by calling<b>ust_c=
onsumer_metadata_request():491 -&gt; ust_app_push_metadat(ust_reg, socket,1=
)=C2=A0</b>which at line 460 checks for=C2=A0<b>registry-&gt;metadata_close=
d</b>=C2=A0and returns an=C2=A0<b>=E2=80=93EPIPE</b></p><p class=3D"MsoNorm=
al" style=3D"font-size:12.8000001907349px">=C2=A0</p><p style=3D"font-size:=
12.8000001907349px">4.<span style=3D"font-stretch:normal;font-size:7pt;font=
-family:&#39;Times New Roman&#39;">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0</span>This=C2=A0<b>=E2=80=93EPIPE</b>=C2=A0error cascades all the way b=
ack up to=C2=A0<b>thread_manage_consumer():1353</b>=C2=A0at which point=C2=
=A0<b>thread_manage_consumer()</b>=C2=A0decides to exit causing health_chec=
k() to fail.</p><p style=3D"font-size:12.8000001907349px">=C2=A0</p><p clas=
s=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">So it looks like unde=
r some scenario, an application crash could cause the lttng some problems.<=
/p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p>=
<p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">I think a pos=
sible fix for this scenario, is to instead of 4, send an=C2=A0<b>ERROR</b>=
=C2=A0message back to=C2=A0<b>consumerd()</b>=C2=A0. This could be done fro=
m=C2=A0<b>ust_consumer_metadata_request()</b>=C2=A0call. Can someone please=
 let me know if this is correct and shed more light on the issue ?</p><p cl=
ass=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=
=3D"MsoNormal" style=3D"font-size:12.8000001907349px">=C2=A0</p><p class=3D=
"MsoNormal" style=3D"font-size:12.8000001907349px">Please forgive if there =
are any guideline omissions for posting here from my part. This is my first=
 post.</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px"><br=
></p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Regards,=
</p><p class=3D"MsoNormal" style=3D"font-size:12.8000001907349px">Aravind.<=
/p></div>
</blockquote></div><br></div>

--001a113496f2658d2805170d95be--


--===============1955381986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1955381986==--
