From: Anand Neeli <anand.neeli@gmail.com>
Subject: Re: Warning: HOME environment variable not set.
Date: Sat, 11 Apr 2015 04:42:17 +0530
Message-ID: <CAM5kDqwuyWS4KvAHXXmFf0aBvRD=3c3uZdrUVH0H+dP8H1H1rA__22593.8525320545$1428707615$gmane$org@mail.gmail.com>
References: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q@mail.gmail.com>
 <CAL1ZhOM+RTpz2iiqYEM2RHTCK+PxBAXk54q8ykmnsac0-w4WoA@mail.gmail.com>
 <CAM5kDqxMTOj0TqZQjT0i+0MHmPxfvPUocgV0_erw4_7+pBtSDA@mail.gmail.com>
 <218306271.74676.1427117803698.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1666248541=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1Ygi62-0006kI-Qi
 for lttng-dev@lists.lttng.org; Fri, 10 Apr 2015 19:12:31 -0400
Received: by wgsk9 with SMTP id k9so30972381wgs.3
 for <lttng-dev@lists.lttng.org>; Fri, 10 Apr 2015 16:12:17 -0700 (PDT)
In-Reply-To: <218306271.74676.1427117803698.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1666248541==
Content-Type: multipart/alternative; boundary=e89a8f3baed93f3d89051366e50f

--e89a8f3baed93f3d89051366e50f
Content-Type: text/plain; charset=UTF-8

What will be the effect of HOME env var not being set?
cant the app log without this env var? or can we ignore this warning?

Thanks,
Anand Neeli


On Mon, Mar 23, 2015 at 7:06 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> Perhaps your program is clearing its environment
> variables ? Or launched by a wrapper that clears
> the env. var. ?
>
> Can you try with a simple demo program to find our
> what is clearing those ?
>
> Thanks,
>
> Mathieu
>
>
> ------------------------------
>
> Hi All,
> I'm sorry to bump on this thread again.
>
> Is there any way to overcome this issue?
>
> Thanks,
> Anand Neeli
>
> On Wed, Mar 18, 2015 at 10:01 PM, Chidhu R <chid1989@gmail.com> wrote:
>
>> I too am getting the same errors. Inspite of setting LTTNG_HOME in my
>> program.
>>
>> On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli <anand.neeli@gmail.com>
>> wrote:
>>
>>> Hi All,
>>>
>>> any idea when do we get this error?
>>>
>>> app: libust[4745/4745]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4751/4751]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4760/4760]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>> app: libust[4780/4780]: Warning: HOME environment variable not set.
>>> Disabling LTTng-UST per-user tracing. (in setup_local_apps() at
>>> lttng-ust-comm.c:385)
>>>
>>> i have set LTTNG_HOME=HOME=/home/root
>>> using 2.6
>>>
>>> Thanks,
>>> Anand Neeli
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>>>
>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--e89a8f3baed93f3d89051366e50f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">What will be the effect of HOME env var not being set?<div=
>cant the app log without this env var? or can we ignore this warning?</div=
><div><br></div><div>Thanks,</div><div>Anand Neeli</div><div><br></div></di=
v><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Mar 23,=
 2015 at 7:06 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto=
:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@effici=
os.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div st=
yle=3D"font-family:times new roman,new york,times,serif;font-size:12pt;colo=
r:#000000"><div>Perhaps your program is clearing its environment<br></div><=
div>variables ? Or launched by a wrapper that clears<br></div><div>the env.=
 var. ?<br></div><div><br></div><div>Can you try with a simple demo program=
 to find our<br></div><div>what is clearing those ?<br></div><div><br></div=
><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div>=
<div><br></div><hr><div><div class=3D"h5"><blockquote style=3D"border-left:=
2px solid #1010ff;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt"><div dir=3D"ltr">Hi All,<div>I&#39;m sorry to bump=
 on this thread again.</div><div><br></div><div>Is there any way to overcom=
e this issue?</div><div><br></div><div>Thanks,</div><div>Anand Neeli</div><=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Mar =
18, 2015 at 10:01 PM, Chidhu R <span dir=3D"ltr">&lt;<a href=3D"mailto:chid=
1989@gmail.com" target=3D"_blank">chid1989@gmail.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">I too am getting the sam=
e errors. Inspite of setting LTTNG_HOME in my program.=C2=A0</div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div>On Tue, Mar 17, =
2015 at 2:18 PM, Anand Neeli <span dir=3D"ltr">&lt;<a href=3D"mailto:anand.=
neeli@gmail.com" target=3D"_blank">anand.neeli@gmail.com</a>&gt;</span> wro=
te:<br></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div><div dir=3D"ltr=
">Hi All,<div><br></div><div>any idea when do we get this error?</div><div>=
<br></div><div><div>app: libust[4745/4745]: Warning: HOME environment varia=
ble not set. Disabling LTTng-UST per-user tracing. (in setup_local_apps() a=
t lttng-ust-comm.c:385)</div><div>app: libust[4751/4751]: Warning: HOME env=
ironment variable not set. Disabling LTTng-UST per-user tracing. (in setup_=
local_apps() at lttng-ust-comm.c:385)</div><div>app: libust[4760/4760]: War=
ning: HOME environment variable not set. Disabling LTTng-UST per-user traci=
ng. (in setup_local_apps() at lttng-ust-comm.c:385)</div><div>app: libust[4=
780/4780]: Warning: HOME environment variable not set. Disabling LTTng-UST =
per-user tracing. (in setup_local_apps() at lttng-ust-comm.c:385)</div></di=
v><div><br></div><div>i have set LTTNG_HOME=3DHOME=3D/home/root</div><div>u=
sing 2.6</div><div><br></div><div>Thanks,</div><div>Anand Neeli</div><div><=
br></div></div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
</blockquote></div><br></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br><a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-=
dev@lists.lttng.org</a><br><a href=3D"http://lists.lttng.org/cgi-bin/mailma=
n/listinfo/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev</a><br></blockquote><div><br><br></div><div><br></di=
v></div></div><span class=3D"HOEnZb"><font color=3D"#888888"><div>-- <br></=
div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br><a h=
ref=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</=
a><span name=3D"x"></span><br></div></font></span></div></div></blockquote>=
</div><br></div>

--e89a8f3baed93f3d89051366e50f--


--===============1666248541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1666248541==--
