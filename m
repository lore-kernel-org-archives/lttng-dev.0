From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Warning: HOME environment variable not set.
Date: Mon, 23 Mar 2015 13:36:43 +0000 (UTC)
Message-ID: <218306271.74676.1427117803698.JavaMail.zimbra__38983.7501258173$1427117892$gmane$org@efficios.com>
References: <CAM5kDqw2R5+xy9t+sjet_PWt2+2fPh5ijbkKB_15NUJQUoKU5Q@mail.gmail.com>
 <CAL1ZhOM+RTpz2iiqYEM2RHTCK+PxBAXk54q8ykmnsac0-w4WoA@mail.gmail.com>
 <CAM5kDqxMTOj0TqZQjT0i+0MHmPxfvPUocgV0_erw4_7+pBtSDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1630016039=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ya2XA-0007Zn-R0
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 09:36:52 -0400
In-Reply-To: <CAM5kDqxMTOj0TqZQjT0i+0MHmPxfvPUocgV0_erw4_7+pBtSDA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1630016039==
Content-Type: multipart/alternative;
	boundary="----=_Part_74675_30295230.1427117803697"

------=_Part_74675_30295230.1427117803697
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Perhaps your program is clearing its environment 
variables ? Or launched by a wrapper that clears 
the env. var. ? 

Can you try with a simple demo program to find our 
what is clearing those ? 

Thanks, 

Mathieu 

----- Original Message -----

> Hi All,
> I'm sorry to bump on this thread again.

> Is there any way to overcome this issue?

> Thanks,
> Anand Neeli

> On Wed, Mar 18, 2015 at 10:01 PM, Chidhu R < chid1989@gmail.com > wrote:

> > I too am getting the same errors. Inspite of setting LTTNG_HOME in my
> > program.
> 

> > On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli < anand.neeli@gmail.com >
> > wrote:
> 

> > > Hi All,
> > 
> 

> > > any idea when do we get this error?
> > 
> 

> > > app: libust[4745/4745]: Warning: HOME environment variable not set.
> > > Disabling
> > > LTTng-UST per-user tracing. (in setup_local_apps() at
> > > lttng-ust-comm.c:385)
> > 
> 
> > > app: libust[4751/4751]: Warning: HOME environment variable not set.
> > > Disabling
> > > LTTng-UST per-user tracing. (in setup_local_apps() at
> > > lttng-ust-comm.c:385)
> > 
> 
> > > app: libust[4760/4760]: Warning: HOME environment variable not set.
> > > Disabling
> > > LTTng-UST per-user tracing. (in setup_local_apps() at
> > > lttng-ust-comm.c:385)
> > 
> 
> > > app: libust[4780/4780]: Warning: HOME environment variable not set.
> > > Disabling
> > > LTTng-UST per-user tracing. (in setup_local_apps() at
> > > lttng-ust-comm.c:385)
> > 
> 

> > > i have set LTTNG_HOME=HOME=/home/root
> > 
> 
> > > using 2.6
> > 
> 

> > > Thanks,
> > 
> 
> > > Anand Neeli
> > 
> 

> > > _______________________________________________
> > 
> 
> > > lttng-dev mailing list
> > 
> 
> > > lttng-dev@lists.lttng.org
> > 
> 
> > > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_74675_30295230.1427117803697
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Perhaps your program is clearing=
 its environment<br></div><div>variables ? Or launched by a wrapper that cl=
ears<br></div><div>the env. var. ?<br></div><div><br></div><div>Can you try=
 with a simple demo program to find our<br></div><div>what is clearing thos=
e ?<br></div><div><br></div><div>Thanks,<br></div><div><br></div><div>Mathi=
eu<br></div><div><br></div><div><br></div><hr id=3D"zwchr"><blockquote styl=
e=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#=
000;font-weight:normal;font-style:normal;text-decoration:none;font-family:H=
elvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi All,<div>I'm=
 sorry to bump on this thread again.</div><div><br></div><div>Is there any =
way to overcome this issue?</div><div><br></div><div>Thanks,</div><div>Anan=
d Neeli</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote=
">On Wed, Mar 18, 2015 at 10:01 PM, Chidhu R <span dir=3D"ltr">&lt;<a href=
=3D"mailto:chid1989@gmail.com" target=3D"_blank">chid1989@gmail.com</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">I too am =
getting the same errors. Inspite of setting LTTNG_HOME in my program.&nbsp;=
</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div c=
lass=3D"h5">On Tue, Mar 17, 2015 at 2:18 PM, Anand Neeli <span dir=3D"ltr">=
&lt;<a href=3D"mailto:anand.neeli@gmail.com" target=3D"_blank">anand.neeli@=
gmail.com</a>&gt;</span> wrote:<br></div></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><div><div class=3D"h5"><div dir=3D"ltr">Hi All,<div><br></div><div>any i=
dea when do we get this error?</div><div><br></div><div><div>app: libust[47=
45/4745]: Warning: HOME environment variable not set. Disabling LTTng-UST p=
er-user tracing. (in setup_local_apps() at lttng-ust-comm.c:385)</div><div>=
app: libust[4751/4751]: Warning: HOME environment variable not set. Disabli=
ng LTTng-UST per-user tracing. (in setup_local_apps() at lttng-ust-comm.c:3=
85)</div><div>app: libust[4760/4760]: Warning: HOME environment variable no=
t set. Disabling LTTng-UST per-user tracing. (in setup_local_apps() at lttn=
g-ust-comm.c:385)</div><div>app: libust[4780/4780]: Warning: HOME environme=
nt variable not set. Disabling LTTng-UST per-user tracing. (in setup_local_=
apps() at lttng-ust-comm.c:385)</div></div><div><br></div><div>i have set L=
TTNG_HOME=3DHOME=3D/home/root</div><div>using 2.6</div><div><br></div><div>=
Thanks,</div><div>Anand Neeli</div><div><br></div></div>
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
st<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev<br></blockquote><div><br><br></div><div><br></div><div>--=
 <br></div><div><span name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<=
br>http://www.efficios.com<span name=3D"x"></span><br></div></div></body></=
html>
------=_Part_74675_30295230.1427117803697--


--===============1630016039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1630016039==--
