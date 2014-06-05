From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng kretprobe issue
Date: Thu, 5 Jun 2014 18:57:56 +0000 (UTC)
Message-ID: <1590663737.27468.1401994676463.JavaMail.zimbra__25470.7212829546$1401996791$gmane$org@efficios.com>
References: <CAP7TvLcyae2tvJQCmE00=QfmteB4byyKRY+SDkeYaVjF3z5GeA@mail.gmail.com>
 <301896191.27236.1401988111285.JavaMail.zimbra@efficios.com>
 <CAP7TvLeOkPm-cLKQ4oQjix=SrHpYcgC=-if+bE8-05C4TR4U9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1808561666=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1WscrP-0003P3-02
 for lttng-dev@lists.lttng.org; Thu, 05 Jun 2014 14:58:05 -0400
In-Reply-To: <CAP7TvLeOkPm-cLKQ4oQjix=SrHpYcgC=-if+bE8-05C4TR4U9g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: tarek slaymia <tarek.slaymia@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1808561666==
Content-Type: multipart/alternative;
	boundary="----=_Part_27467_2141572951.1401994676462"

------=_Part_27467_2141572951.1401994676462
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Please reply to the list. 

I don't know, this is _your_ research :) 

Thanks, 

Mathieu 

----- Original Message -----

> From: "tarek slaymia" <tarek.slaymia@gmail.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Thursday, June 5, 2014 2:50:50 PM
> Subject: Re: [lttng-dev] lttng kretprobe issue

> thanks Mathiew.
> what i'm trying to do exacltly is changing the address of sys_write in the
> sys_call_table by a new function.
> i wanna check if the sys_call_table[__NR_write] contains the address of my
> new function instead of the address of sys_write after loading my module.
> How can i check this change using lttng ?
> Thanks in advance !

> 2014-06-05 13:08 GMT-04:00 Mathieu Desnoyers < mathieu.desnoyers@efficios.com
> > :

> > > From: "tarek slaymia" < tarek.slaymia@gmail.com >
> > 
> 
> > > To: lttng-dev@lists.lttng.org , lttng-dev-request@lists.lttng.org
> > 
> 
> > > Sent: Thursday, May 29, 2014 3:53:10 PM
> > 
> 
> > > Subject: [lttng-dev] lttng kretprobe issue
> > 
> 

> > > Hi all
> > 
> 

> > > when i replace a syscall function address for example sys_write using
> > > this
> > > function in my LKM module :
> > 
> 

> > > xchg(&sys_call_table[__NR_write],my_own_write);
> > 
> 

> > > In the normal case the content of sys_call_table[__NR_write] address
> > > changes
> > > and it displays the address of my_own_write using debug technique .
> > 
> 

> > > I have an issue when tracing this change using lttng kretprobe :
> > 
> 

> > > lttng enable-event sys_write -k --function sys_write
> > 
> 

> > > The ip value of sys_write ( the same address of
> > > sys_call_table[__NR_write]
> > > )
> > > remains the same even after changing it by the new function address
> > > (address
> > > of my_own_write)
> > 
> 
> > > Why the ip value of sys_write syscall displayed in lttng traces remains
> > > the
> > > same even after changing it ?
> > 
> 

> > sys_write is a symbol, and its address does not change. You place the
> 
> > kretprobe on the symbol.
> 

> > What you are overwriting is the content of the sys_call_table array, not
> 
> > the address of the sys_write symbol.
> 

> > So the resulting behavior is very much expected.
> 

> > Thanks,
> 

> > Mathieu
> 

> > > Best regards.
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

> > --
> 
> > Mathieu Desnoyers
> 
> > EfficiOS Inc.
> 
> > http://www.efficios.com
> 

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_27467_2141572951.1401994676462
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div>Please reply to the list.</div><=
div><br></div><div>I don't know, this is _your_ research :)<br></div><div><=
br></div><div>Thanks,<br></div><div><br></div><div>Mathieu<br></div><div><b=
r></div><hr id=3D"zwchr"><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><b>From: </b>"tarek slaymia" &lt;tarek.slaymia@gmail.com&gt;<br><b=
>To: </b>"Mathieu Desnoyers" &lt;mathieu.desnoyers@efficios.com&gt;<br><b>S=
ent: </b>Thursday, June 5, 2014 2:50:50 PM<br><b>Subject: </b>Re: [lttng-de=
v] lttng kretprobe issue<br><div><br></div><div dir=3D"ltr"><div><div>thank=
s Mathiew.<br>what i'm trying to do exacltly is changing the address of sys=
_write in the sys_call_table by a new function. <br>i wanna check if the sy=
s_call_table[__NR_write] contains the address of my new function instead of=
 the address of sys_write after loading my module.<br>
</div>How can i check this change using lttng ?<br></div>Thanks in advance =
!<br></div><div class=3D"gmail_extra"><br><div><br></div><div class=3D"gmai=
l_quote">2014-06-05 13:08 GMT-04:00 Mathieu Desnoyers <span dir=3D"ltr">&lt=
;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathie=
u.desnoyers@efficios.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div style=3D"font-family:times new rom=
an,new york,times,serif;font-size:12pt;color:#000000"><div><br></div><hr><b=
lockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt">
<b>From: </b>"tarek slaymia" &lt;<a href=3D"mailto:tarek.slaymia@gmail.com"=
 target=3D"_blank">tarek.slaymia@gmail.com</a>&gt;<br><b>To: </b><a href=3D=
"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.=
org</a>, <a href=3D"mailto:lttng-dev-request@lists.lttng.org" target=3D"_bl=
ank">lttng-dev-request@lists.lttng.org</a><br>
<b>Sent: </b>Thursday, May 29, 2014 3:53:10 PM<br><b>Subject: </b>[lttng-de=
v] lttng kretprobe issue<div><div class=3D"h5"><br><div><br></div><div dir=
=3D"ltr"><div><div><div><div><div>Hi all<br><div><br></div></div>when i rep=
lace a syscall function address for example sys_write using this function i=
n my LKM module :<br>
<div><br></div>xchg(&amp;sys_call_table[__NR_write],my_own_write);<br><div>=
<br></div></div>In the normal case the content of sys_call_table[__NR_write=
]=20
address changes and it displays the address of my_own_write using debug=20
technique .<br><div><br></div></div>I have an issue when tracing this chang=
e using lttng kretprobe :<br><div><br></div>
lttng enable-event sys_write -k --function sys_write<br><div><br></div>&nbs=
p;The ip value of sys_write ( the same address of=20
sys_call_table[__NR_write] ) remains the same even after changing it by=20
the new function address (address of my_own_write) <br></div>Why the ip val=
ue of sys_write syscall displayed in lttng traces remains the same even aft=
er changing it ? &nbsp; </div></div></div></div></blockquote><div><br></div=
>
<div>sys_write is a symbol, and its address does not change. You place the<=
br></div><div>kretprobe on the symbol.<br></div><div><br></div><div>What yo=
u are overwriting is the content of the sys_call_table array, not<br></div>
<div>the address of the sys_write symbol.<br></div><div><br></div><div>So t=
he resulting behavior is very much expected.<br></div><div><br></div><div>T=
hanks,<br></div><div><br></div><div>Mathieu<br></div><div><br></div><blockq=
uote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-left:5p=
x;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font=
-family:Helvetica,Arial,sans-serif;font-size:12pt">
<div dir=3D"ltr"><div><br></div>Best regards.</div><br>____________________=
___________________________<br>lttng-dev mailing list<br><a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
span class=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"col=
or: #888888;" color=3D"#888888"><br></span></span></blockquote><span class=
=3D"HOEnZb"><span style=3D"color: #888888;" data-mce-style=3D"color: #88888=
8;" color=3D"#888888"><div>
<br><div><br></div></div><div><br></div><div>-- <br></div><div><span></span=
>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" =
target=3D"_blank">http://www.efficios.com</a><span></span><br></div>
</span></span></div></div></blockquote></div><br></div>
</blockquote><div><br><br></div><div><br></div><div>-- <br></div><div><span=
 name=3D"x"></span>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficio=
s.com<span name=3D"x"></span><br></div></div></body></html>
------=_Part_27467_2141572951.1401994676462--


--===============1808561666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1808561666==--
